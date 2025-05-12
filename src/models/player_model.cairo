use starknet::{ContractAddress, get_block_timestamp, get_caller_address};


#[derive(Serde, Copy, Drop, Introspect, PartialEq)]
#[dojo::model]
pub struct PlayerCounter {
    #[key]
    pub id: felt252,
    pub current_val: u256,
}


#[derive(Clone, Drop, Serde, Debug)]
#[dojo::model]
pub struct Player {
    #[key]
    pub wallet: ContractAddress,
    pub id: u256,
    pub inventory_ref: ContractAddress,
    pub is_verified: bool,
    pub aquariums: Array<u64>,
    pub fishes: Array<u64>,
    pub registered_at: u64,
}

pub trait PlayerTrait {
    fn register_player(
        id: u256, inventory_ref: ContractAddress, aquariums: Array<u64>, fishes: Array<u64>,
    ) -> Player;
}
impl PlayerImpl of PlayerTrait {
    fn register_player(
        id: u256, inventory_ref: ContractAddress, aquariums: Array<u64>, fishes: Array<u64>,
    ) -> Player {
        let timestamp = get_block_timestamp();
        let caller = get_caller_address();

        let player = Player {
            wallet: caller,
            id: id,
            inventory_ref: inventory_ref,
            is_verified: false,
            registered_at: timestamp,
            aquariums: aquariums,
            fishes: fishes,
        };
        player
    }
}

#[cfg(test)]
mod tests {
    use super::Player;
    use super::*;
    use starknet::{contract_address_const, get_block_timestamp};

    fn zero_address() -> ContractAddress {
        contract_address_const::<0>()
    }

    #[test]
    fn test_player_creation() {
        let time = get_block_timestamp();
        let player = Player {
            wallet: zero_address(),
            id: 1,
            inventory_ref: zero_address(),
            is_verified: false,
            registered_at: time,
        };
        assert(player.id == 1, 'Player ID should match');
    }
}
