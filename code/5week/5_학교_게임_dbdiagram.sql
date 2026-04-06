Table UsersAccount {
  user_id int [pk]
  email varchar(100)
  password varchar(100)
  created_at timestamp [default: `CURRENT_TIMESTAMP`]
}

Table GameCharacter {
  character_id int [pk]
  name varchar(100)
  level int
  class_type varchar(50)
  user_id int
}

Table Item {
  item_id int [pk]
  name varchar(50)
  type varchar(50)
}

Table Inventory {
  character_id int
  item_id int
  quantity int [default: 1]

  Indexes {
    (character_id, item_id) [pk]
  }
}

Ref: GameCharacter.user_id > UsersAccount.user_id
Ref: Inventory.character_id > GameCharacter.character_id
Ref: Inventory.item_id > Item.item_id