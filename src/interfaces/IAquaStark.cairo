use starknet::{ContractAddress};
use dojo_starter::models::player_model::{Player};
// define the interface
#[starknet::interface]
pub trait IAquaStark<T> {
    fn get_username_from_address(self: @T, address: ContractAddress) -> felt252;
    fn register(ref self: T, username: felt252);
    fn create_new_player_id(ref self: T) -> u256;
    fn get_player(ref self: T, address: ContractAddress) -> Player;
}
