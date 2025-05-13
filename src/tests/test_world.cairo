#[cfg(test)]
mod tests {
    use dojo_cairo_test::WorldStorageTestTrait;
    use dojo::model::{ModelStorage, ModelStorageTest};
    use dojo::world::WorldStorageTrait;
    use dojo_cairo_test::{
        spawn_test_world, NamespaceDef, TestResource, ContractDefTrait, ContractDef,
    };
    use starknet::{testing, get_caller_address, contract_address_const};
    use dojo_starter::systems::AquaStark::{AquaStark};
    use dojo_starter::interfaces::IAquaStark::{
        IAquaStark, IAquaStarkDispatcher, IAquaStarkDispatcherTrait,
    };
    use dojo_starter::models::player_model::{
        Player, m_Player, PlayerCounter, m_PlayerCounter, UsernameToAddress, m_UsernameToAddress,
        AddressToUsername, m_AddressToUsername,
    };

    fn namespace_def() -> NamespaceDef {
        let ndef = NamespaceDef {
            namespace: "dojo_starter",
            resources: [
                TestResource::Model(m_Player::TEST_CLASS_HASH),
                TestResource::Model(m_PlayerCounter::TEST_CLASS_HASH),
                TestResource::Model(m_UsernameToAddress::TEST_CLASS_HASH),
                TestResource::Model(m_AddressToUsername::TEST_CLASS_HASH),
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

    #[test]
    fn test_register_player() {
        // Initialize test environment
        // let caller = starknet::contract_address_const::<0x0>();
        let caller_1 = contract_address_const::<'aji'>();
        let caller_2 = contract_address_const::<'ajiii'>();
        let ndef = namespace_def();

        // Register the resources.
        let mut world = spawn_test_world([ndef].span());

        // Ensures permissions and initializations are synced.
        world.sync_perms_and_inits(contract_defs());

        let username = 'Aji';
        let username1 = 'Ajii';

        let ndef = namespace_def();
        let mut world = spawn_test_world([ndef].span());
        world.sync_perms_and_inits(contract_defs());

        let (contract_address, _) = world.dns(@"AquaStark").unwrap();
        let actions_system = IAquaStarkDispatcher { contract_address };

        testing::set_contract_address(caller_1);
        actions_system.register(username);

        let player = actions_system.get_player(caller_1);
        assert(player.id == 1, 'Incorrect id');
        assert(player.username == 'Aji', 'incorrect username');
        assert(player.wallet == caller_1, 'invalid address');

        testing::set_contract_address(caller_2);
        actions_system.register(username1);

        let player1 = actions_system.get_player(caller_2);
        assert(player1.id == 2, 'Incorrect id');
        assert(player1.username == 'Ajii', 'incorrect username');
        assert(player1.wallet == caller_2, 'invalid address');
    }
}
