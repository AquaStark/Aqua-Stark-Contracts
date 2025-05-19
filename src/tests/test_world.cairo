#[cfg(test)]
mod tests {
    use dojo_cairo_test::WorldStorageTestTrait;
    use dojo::model::{ModelStorage, ModelStorageTest};
    use dojo::world::WorldStorageTrait;
    use dojo_cairo_test::{
        spawn_test_world, NamespaceDef, TestResource, ContractDefTrait, ContractDef,
    };
    use starknet::{testing, get_caller_address, ContractAddress, contract_address_const};
    use dojo_starter::systems::AquaStark::{AquaStark};
    use dojo_starter::interfaces::IAquaStark::{
        IAquaStark, IAquaStarkDispatcher, IAquaStarkDispatcherTrait,
    };
    use dojo_starter::contracts::usdc::{IExternalDispatcher, IExternalDispatcherTrait};
    use dojo_starter::models::player_model::{
        Player, m_Player, PlayerCounter, m_PlayerCounter, UsernameToAddress, m_UsernameToAddress,
        AddressToUsername, m_AddressToUsername,
    };
    use dojo_starter::models::aquarium_model::{
        Aquarium, m_Aquarium, AquariumCounter, m_AquariumCounter, AquariumOwner, m_AquariumOwner,
    };
    use dojo_starter::models::fish_model::{
        Fish, m_Fish, FishTrait, FishCounter, m_FishCounter, Species, Pattern, FishOwner,
        m_FishOwner,
    };

    // use snforge_std::{
    //     ContractClassTrait, DeclareResultTrait, EventSpy, EventSpyAssertionsTrait, declare,
    //     spy_events, start_cheat_caller_address, stop_cheat_caller_address, test_address,
    // };

    fn namespace_def() -> NamespaceDef {
        let ndef = NamespaceDef {
            namespace: "dojo_starter",
            resources: [
                TestResource::Model(m_Player::TEST_CLASS_HASH),
                TestResource::Model(m_PlayerCounter::TEST_CLASS_HASH),
                TestResource::Model(m_UsernameToAddress::TEST_CLASS_HASH),
                TestResource::Model(m_AddressToUsername::TEST_CLASS_HASH),
                TestResource::Model(m_Aquarium::TEST_CLASS_HASH),
                TestResource::Model(m_AquariumCounter::TEST_CLASS_HASH),
                TestResource::Model(m_AquariumOwner::TEST_CLASS_HASH),
                TestResource::Model(m_Fish::TEST_CLASS_HASH),
                TestResource::Model(m_FishCounter::TEST_CLASS_HASH),
                TestResource::Model(m_FishOwner::TEST_CLASS_HASH),
                TestResource::Event(AquaStark::e_PlayerCreated::TEST_CLASS_HASH),
                TestResource::Contract(AquaStark::TEST_CLASS_HASH),
            ]
                .span(),
        };

        ndef
    }

    fn contract_defs() -> Span<ContractDef> {
        [
            ContractDefTrait::new(@"dojo_starter", @"AquaStark")
                .with_writer_of([dojo::utils::bytearray_hash(@"dojo_starter")].span())
        ]
            .span()
    }


    // fn setup() -> (ContractAddress, ContractAddress, IAquaStarkDispatcher, IExternalDispatcher) {
    //     let sender: ContractAddress = contract_address_const::<'sender'>();
    //     // Deploy mock ERC20
    //     let erc20_class = declare("MockUsdc").unwrap().contract_class();
    //     let mut calldata = array![sender.into(), sender.into(), 6];
    //     let (erc20_address, _) = erc20_class.deploy(@calldata).unwrap();

    //     // Deploy Aqua-coin contract
    //     // let contract_owner: ContractAddress = contract_address_const::<'contract_owner'>();
    //     let aqua_coin_class = declare("AquaCoin").unwrap().contract_class();
    //     let mut calldata = array![sender.into(), sender.into(), 6, erc20_address.into()];
    //     let (aqua_coin_class_address, _) = aqua_coin_class.deploy(@calldata).unwrap();

    //     (
    //         erc20_address,
    //         sender,
    //         IAquaStarkDispatcher { contract_address: aqua_coin_class_address },
    //         IExternalDispatcher { contract_address: erc20_address },
    //     )
    // }

    #[test]
    fn test_register_player() {
        // Initialize test environment
        // let caller = starknet::contract_address_const::<0x0>();
        let caller_1 = contract_address_const::<'aji'>();
        // let caller_2 = contract_address_const::<'ajiii'>();
        let ndef = namespace_def();

        // Register the resources.
        let mut world = spawn_test_world([ndef].span());

        // Ensures permissions and initializations are synced.
        world.sync_perms_and_inits(contract_defs());

        let username = 'Aji';
        // let username1 = 'Ajii';

        let ndef = namespace_def();
        let mut world = spawn_test_world([ndef].span());
        world.sync_perms_and_inits(contract_defs());

        let (contract_address, _) = world.dns(@"AquaStark").unwrap();
        let actions_system = IAquaStarkDispatcher { contract_address };

        testing::set_contract_address(caller_1);
        actions_system.register(username, Species::Betta);

        let player = actions_system.get_player(caller_1);
        assert(player.id == 1, 'Incorrect id');
        assert(player.username == 'Aji', 'incorrect username');
        assert(player.wallet == caller_1, 'invalid address');
        assert(player.fish_count == 1, 'invalid fish count');
        assert(player.aquarium_count == 1, 'invalid aquarium count');
    }
}
