use starknet::{ContractAddress, get_block_timestamp, get_caller_address};

#[derive(Serde, Copy, Drop, Introspect, PartialEq)]
#[dojo::model]
pub struct FishCounter {
    #[key]
    pub id: felt252,
    pub current_val: u256,
}

#[derive(Serde, Copy, Introspect, Drop, PartialEq)]
enum Species {
    #[default]
    AngelFish,
    GoldFish,
    Betta,
    NeonTetra,
    Corydoras,
    Hybrid,
}

#[derive(Serde, Copy, Introspect, Drop, PartialEq)]
enum Pattern {
    #[default]
    Plain,
    Spotted,
    Stripes,
}


#[derive(Copy, Drop, Introspect, Serde)]
#[dojo::model]
pub struct Fish {
    #[key]
    pub id: u64,
    pub fish_type: u8,
    pub age: u32, // in days
    pub hunger_level: u8, // 0-100 scale
    pub health: u8, // 0-100 scale
    pub growth: u8, // 0-100 scale
    pub owner: ContractAddress,
    pub species: Species,
    pub generation: u8,
    pub color: felt252,
    pub pattern: Pattern,
    pub size: u8,
    pub speed: u32,
    pub birth_time: u64,
    pub parent_ids: (u64, u64),
    pub mutation_rate: u8,
}

pub trait FishTrait {
    fn is_dead(fish: Fish) -> bool;
    fn is_hungry(fish: Fish) -> bool;
    fn is_fully_grown(fish: Fish) -> bool;
    fn can_eat(fish: Fish) -> bool;
    fn create_fish_by_species(fish: Fish, owner: ContractAddress, species: Species) -> Fish;

    fn create_offspring(
        offspring: Fish, owner: ContractAddress, parent1: Fish, parent2: Fish,
    ) -> Fish;
    fn create_random_fish(fish: Fish, owner: ContractAddress) -> Fish;
    fn feed(fish: Fish, amount: u8) -> Fish;
    fn grow(fish: Fish, amount: u8) -> Fish;
    fn heal(fish: Fish, amount: u8) -> Fish;
    fn damage(fish: Fish, species: Species, amount: u8) -> Fish;
    fn regenerate_health(fish: Fish, aquarium_cleanliness: u8) -> Fish;
    fn update_hunger(fish: Fish, hours_passed: u8) -> Fish;
    fn update_age(fish: Fish, days_passed: u32) -> Fish;
    fn get_hunger_level(fish: Fish) -> u8;
    fn get_growth_rate(fish: Fish) -> u8;
    fn get_health(fish: Fish) -> u8;
}

impl FishImpl of FishTrait {
    fn get_health(fish: Fish) -> u8 {
        fish.health
    }

    fn get_growth_rate(fish: Fish) -> u8 {
        fish.growth
    }

    fn get_hunger_level(fish: Fish) -> u8 {
        fish.hunger_level
    }
    fn update_age(mut fish: Fish, days_passed: u32) -> Fish {
        // Update age
        fish.age += days_passed;

        fish
    }
    fn update_hunger(mut fish: Fish, hours_passed: u8) -> Fish {
        // Calculate hunger decrease
        let hunger_decrease = hours_passed * 2;

        // Update hunger
        let new_hunger = if hunger_decrease > fish.hunger_level {
            0
        } else {
            fish.hunger_level - hunger_decrease
        };

        fish.hunger_level = new_hunger;

        fish
    }
    fn regenerate_health(mut fish: Fish, aquarium_cleanliness: u8) -> Fish {
        let caller = get_caller_address();

        // Check ownership
        assert(fish.owner == caller, 'Not your Fish');

        // Calculate regeneration amount based on cleanliness
        let regen_amount = (aquarium_cleanliness - 80) / 4;

        // Update health
        let new_health = if fish.health + regen_amount > 100 {
            100
        } else {
            fish.health + regen_amount
        };

        fish.health = new_health;

        fish
    }


    fn damage(mut fish: Fish, species: Species, amount: u8) -> Fish {
        let caller = get_caller_address();

        // Check ownership
        assert(fish.owner == caller, 'Not your Fish');

        // Update health
        let new_health = if amount >= fish.health {
            0
        } else {
            fish.health - amount
        };

        fish.health = new_health;
        fish
    }

    fn heal(mut fish: Fish, amount: u8) -> Fish {
        let caller = get_caller_address();

        // Check ownership
        assert(fish.owner == caller, 'Not your Fish');

        // Update health
        let new_health = if fish.health + amount > 100 {
            100
        } else {
            fish.health + amount
        };

        fish.health = new_health;
        fish
    }

    fn grow(mut fish: Fish, amount: u8) -> Fish {
        let caller = get_caller_address();
        // Check ownership
        assert(fish.owner == caller, 'Not your Fish');

        // Update growth
        let new_growth = if fish.growth + amount > 100 {
            100
        } else {
            fish.growth + amount
        };

        fish.growth = new_growth;
        fish
    }

    fn feed(mut fish: Fish, amount: u8) -> Fish {
        let caller = get_caller_address();
        assert(caller == fish.owner, 'Not your Fish');

        // Update hunger
        let new_hunger = if fish.hunger_level - amount < 0 {
            0
        } else {
            fish.hunger_level - amount
        };

        fish.hunger_level = new_hunger;

        fish
    }
    fn create_fish_by_species(mut fish: Fish, owner: ContractAddress, species: Species) -> Fish {
        let timestamp = get_block_timestamp();

        // Set base properties
        fish.owner = owner;
        fish.age = 0;
        fish.health = 100;
        fish.hunger_level = 100;
        fish.growth = 0;
        fish.generation = 1;
        fish.birth_time = timestamp;
        fish.parent_ids = (0, 0);
        fish.species = species;

        // Assign species-specific traits
        match species {
            Species::AngelFish => {
                fish.color = 'blue';
                fish.pattern = Pattern::Plain;
                fish.size = 5;
                fish.speed = 4;
                fish.mutation_rate = 5;
            },
            Species::GoldFish => {
                fish.color = 'gold';
                fish.pattern = Pattern::Spotted;
                fish.size = 4;
                fish.speed = 3;
                fish.mutation_rate = 3;
            },
            Species::Betta => {
                fish.color = 'red';
                fish.pattern = Pattern::Stripes;
                fish.size = 3;
                fish.speed = 5;
                fish.mutation_rate = 4;
            },
            Species::NeonTetra => {
                fish.color = 'neon';
                fish.pattern = Pattern::Plain;
                fish.size = 2;
                fish.speed = 5;
                fish.mutation_rate = 2;
            },
            Species::Corydoras => {
                fish.color = 'silver';
                fish.pattern = Pattern::Spotted;
                fish.size = 4;
                fish.speed = 3;
                fish.mutation_rate = 3;
            },
            _ => {
                // For safety, fallback values (won't apply for Hybrid if it's blocked)
                fish.color = 'gray';
                fish.pattern = Pattern::Plain;
                fish.size = 3;
                fish.speed = 3;
                fish.mutation_rate = 3;
            },
        }

        fish
    }


    fn create_offspring(
        mut offspring: Fish, owner: ContractAddress, parent1: Fish, parent2: Fish,
    ) -> Fish {
        let timestamp = get_block_timestamp();
        let g: bool = timestamp % 2 == 0;

        if parent1.species == parent2.species {
            offspring.fish_type = parent1.fish_type;
            offspring.species = parent1.species;

            // Inherit color & pattern randomly
            if g {
                offspring.color = parent1.color;
                offspring.pattern = parent2.pattern;
            } else {
                offspring.color = parent2.color;
                offspring.pattern = parent1.pattern;
            }
        } else {
            offspring.species = Species::Hybrid;
            // Inherit color & pattern randomly
            if !g {
                offspring.color = parent1.color;
                offspring.pattern = parent2.pattern;
            } else {
                offspring.color = parent2.color;
                offspring.pattern = parent1.pattern;
            }
        }
        offspring.speed = (parent1.speed + parent2.speed) / 2;
        offspring.size = ((parent1.size + parent2.size) / 2);
        offspring.mutation_rate = (parent1.mutation_rate + parent2.mutation_rate) / 2;
        offspring.generation = parent1.generation + 1;

        // Set inherited/general fields
        offspring.owner = owner;
        offspring.age = 0;
        offspring.health = 100;
        offspring.hunger_level = 100;
        offspring.growth = 0;
        offspring.birth_time = timestamp;
        offspring.parent_ids = (parent1.id, parent2.id);

        offspring
    }

    fn create_random_fish(mut fish: Fish, owner: ContractAddress) -> Fish {
        let timestamp = get_block_timestamp();
        let species_index = timestamp % 5;

        // Set base properties
        fish.owner = owner;
        fish.age = 0;
        fish.health = 100;
        fish.hunger_level = 100;
        fish.growth = 0;
        fish.generation = 1;
        fish.birth_time = timestamp;
        fish.parent_ids = (0, 0);

        // Assign species-specific traits
        if species_index == 0 {
            fish.species = Species::AngelFish;
            fish.color = 'blue';
            fish.pattern = Pattern::Plain;
            fish.size = 5;
            fish.speed = 4;
            fish.mutation_rate = 5;
        } else if species_index == 1 {
            fish.species = Species::GoldFish;
            fish.color = 'gold';
            fish.pattern = Pattern::Spotted;
            fish.size = 4;
            fish.speed = 3;
            fish.mutation_rate = 3;
        } else if species_index == 2 {
            fish.species = Species::Betta;
            fish.color = 'red';
            fish.pattern = Pattern::Stripes;
            fish.size = 3;
            fish.speed = 5;
            fish.mutation_rate = 4;
        } else if species_index == 3 {
            fish.species = Species::NeonTetra;
            fish.color = 'neon';
            fish.pattern = Pattern::Plain;
            fish.size = 2;
            fish.speed = 5;
            fish.mutation_rate = 2;
        } else if species_index == 4 {
            fish.species = Species::Corydoras;
            fish.color = 'silver';
            fish.pattern = Pattern::Spotted;
            fish.size = 4;
            fish.speed = 3;
            fish.mutation_rate = 3;
        }

        fish
    }


    fn is_dead(fish: Fish) -> bool {
        fish.health == 0
    }

    fn is_hungry(fish: Fish) -> bool {
        fish.hunger_level < 20
    }

    fn is_fully_grown(fish: Fish) -> bool {
        fish.growth >= 100
    }

    fn can_eat(fish: Fish) -> bool {
        fish.hunger_level < 100
    }
}


#[cfg(test)]
mod tests {
    use super::Fish;
    use super::*;
    use starknet::contract_address_const;

    fn zero_address() -> ContractAddress {
        contract_address_const::<0>()
    }
    // #[test]
// fn test_fish_creation() {
//     let fish = Fish {
//         id: 1_u64,
//         fish_type: 1_u32,
//         age: 0,
//         hunger_level: 0,
//         health: 100,
//         growth: 0,
//         owner: zero_address(),
//     };
//     assert(fish.fish_type == 1, 'Fish type should match');
// }
}
