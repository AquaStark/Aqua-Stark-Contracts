// dojo decorator
#[dojo::contract]
pub mod AquaStark {
    use dojo_starter::interfaces::IAquaStark::{IAquaStark};
    use starknet::{
        ContractAddress, get_caller_address, get_block_timestamp, contract_address_const,
    };
    use dojo_starter::models::player_model::{
        Player, PlayerTrait, PlayerCounter, UsernameToAddress, AddressToUsername,
    };
    use dojo_starter::models::aquarium_model::{Aquarium, AquariumCounter, AquariumOwner};
    use dojo_starter::models::fish_model::{Fish, FishCounter, Species, FishTrait, FishOwner};

    use dojo::model::{ModelStorage};
    use dojo::event::EventStorage;

    #[derive(Copy, Drop, Serde)]
    #[dojo::event]
    pub struct PlayerCreated {
        #[key]
        pub username: felt252,
        #[key]
        pub player: ContractAddress,
        pub timestamp: u64,
    }

    #[abi(embed_v0)]
    impl AquaStarkImpl of IAquaStark<ContractState> {
        fn get_username_from_address(self: @ContractState, address: ContractAddress) -> felt252 {
            let mut world = self.world_default();

            let address_map: AddressToUsername = world.read_model(address);

            address_map.username
        }
        fn create_new_player_id(ref self: ContractState) -> u256 {
            let mut world = self.world_default();
            let mut game_counter: PlayerCounter = world.read_model('v0');
            let new_val = game_counter.current_val + 1;
            game_counter.current_val = new_val;
            world.write_model(@game_counter);
            new_val
        }

        fn create_aquarium_id(ref self: ContractState) -> u256 {
            let mut world = self.world_default();
            let mut aquarium_counter: AquariumCounter = world.read_model('v0');
            let new_val = aquarium_counter.current_val + 1;
            aquarium_counter.current_val = new_val;
            world.write_model(@aquarium_counter);
            new_val
        }

        fn create_fish_id(ref self: ContractState) -> u256 {
            let mut world = self.world_default();
            let mut fish_counter: FishCounter = world.read_model('v0');
            let new_val = fish_counter.current_val + 1;
            fish_counter.current_val = new_val;
            world.write_model(@fish_counter);
            new_val
        }

        fn new_aquarium(
            ref self: ContractState, owner: ContractAddress, max_capacity: u32,
        ) -> Aquarium {
            let mut world = self.world_default();
            let caller = get_caller_address();
            let aquarium_id = self.create_aquarium_id();
            let mut aquarium: Aquarium = world.read_model(aquarium_id);
            aquarium.id = aquarium_id;
            aquarium.owner = owner;
            aquarium.max_capacity = max_capacity;
            aquarium.cleanliness = 100;

            let mut aquarium_owner: AquariumOwner = world.read_model(aquarium_id);
            aquarium_owner.owner = caller;

            world.write_model(@aquarium_owner);
            world.write_model(@aquarium);

            aquarium
        }

        fn new_fish(ref self: ContractState, owner: ContractAddress, species: Species) -> Fish {
            let mut world = self.world_default();
            let caller = get_caller_address();
            let fish_id = self.create_fish_id();
            let mut fish: Fish = world.read_model(fish_id);

            fish = FishTrait::create_fish_by_species(fish, caller, species);

            let mut fish_owner: FishOwner = world.read_model(fish_id);
            fish_owner.owner = caller;

            world.write_model(@fish_owner);
            world.write_model(@fish);
            fish
        }

        fn register(ref self: ContractState, username: felt252, species: Species) {
            let mut world = self.world_default();
            let caller = get_caller_address();

            // Constants
            let zero_address: ContractAddress = contract_address_const::<0x0>();

            // --- Validations ---

            // Username should not be zero
            assert(username != 0, 'USERNAME CANNOT BE ZERO');

            // Username must be unique (not already registered)
            let existing_player: UsernameToAddress = world.read_model(username);
            assert(existing_player.address == zero_address, 'USERNAME ALREADY TAKEN');

            // Address must not already be registered
            let existing_username = self.get_username_from_address(caller);
            assert(existing_username == 0, 'USERNAME ALREADY CREATED');
            // --- Player Registration ---

            let id = self.create_new_player_id();

            let mut new_player = PlayerTrait::register_player(id, username, caller, 0, 0);

            // --- Username ↔ Address Mappings ---

            let username_to_address = UsernameToAddress { username, address: caller };
            let address_to_username = AddressToUsername { address: caller, username };

            // --- Aquarium Setup ---

            self.new_aquarium(caller, 10);
            new_player.aquarium_count += 1;

            self.new_fish(caller, species);
            new_player.fish_count += 1;

            // --- Persist to Storage ---

            world.write_model(@new_player);
            world.write_model(@username_to_address);
            world.write_model(@address_to_username);

            // --- Emit Event ---
            world
                .emit_event(
                    @PlayerCreated { username, player: caller, timestamp: get_block_timestamp() },
                );
        }


        fn get_player(ref self: ContractState, address: ContractAddress) -> Player {
            let mut world = self.world_default();
            let player: Player = world.read_model(address);
            player
        }
    }

    #[generate_trait]
    impl InternalImpl of InternalTrait {
        /// Use the default namespace "dojo_starter". This function is handy since the ByteArray
        /// can't be const.
        fn world_default(self: @ContractState) -> dojo::world::WorldStorage {
            self.world(@"dojo_starter")
        }
    }
}
// Define function like this:
// fn next_position(mut position: Position, direction: Option<Direction>) -> Position {
//     match direction {
//         Option::None => { return position; },
//         Option::Some(d) => match d {
//             Direction::Left => { position.vec.x -= 1; },
//             Direction::Right => { position.vec.x += 1; },
//             Direction::Up => { position.vec.y -= 1; },
//             Direction::Down => { position.vec.y += 1; },
//         },
//     };
//     position
// }


