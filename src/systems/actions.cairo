// define the interface
#[starknet::interface]
pub trait IActions<T> {}

// dojo decorator
#[dojo::contract]
pub mod actions {
    use super::{IActions};
    // use starknet::{ContractAddress, get_caller_address};
    // use dojo_starter::models::{Vec2, Moves};

    // use dojo::model::{ModelStorage};
    // use dojo::event::EventStorage;

    // #[derive(Copy, Drop, Serde)]
    // #[dojo::event]
    // pub struct Moved {
    //     #[key]
    //     pub player: ContractAddress,
    //     pub direction: Direction,
    // }

    #[abi(embed_v0)]
    impl ActionsImpl of IActions<ContractState> {}

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


