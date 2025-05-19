use starknet::{ContractAddress};
use dojo_starter::models::player_model::{Player};
use dojo_starter::models::aquarium_model::{Aquarium};
use dojo_starter::models::fish_model::{Fish, Species};
// define the interface
#[starknet::interface]
pub trait IAquaStark<T> {
    fn get_username_from_address(self: @T, address: ContractAddress) -> felt252;
    fn register(ref self: T, username: felt252, species: Species);
    fn create_new_player_id(ref self: T) -> u256;
    fn create_aquarium_id(ref self: T) -> u256;
    fn create_fish_id(ref self: T) -> u256;
    fn new_aquarium(ref self: T, owner: ContractAddress, max_capacity: u32) -> Aquarium;
    fn new_fish(ref self: T, owner: ContractAddress, species: Species) -> Fish;
    fn get_player(ref self: T, address: ContractAddress) -> Player;
}
