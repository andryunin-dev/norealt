create sequence hibernate_sequence start 5000001 increment 1;

create table message (
                         id int8 not null,
                         filename varchar(255),
                         text varchar(2048),
                         city varchar(255),
                         street varchar(255),
                         house varchar(255),
                         object_type varchar(255),
                         count_rooms varchar(255),
                         square varchar(255),
                         floor varchar(255),
                         num_storeys varchar(255),
                         price int8,
                         post_date varchar(255),
                         user_id int8,
                         primary key (id)
);

create table user_role (
                           user_id int8 not null,
                           roles varchar(255)
);

create table usr (
                     id int8 not null,
                     email varchar(255) not null,
                     username varchar(255) not null,
                     phone varchar(255) not null,
                     last_visit varchar(255),
                     registration_date varchar(255),
                     active boolean not null,
                     activation_code varchar(255),
                     restore_code varchar(255),
                     password varchar(255) not null,
                     primary key (id)
);

alter table if exists message
    add constraint message_user_fk
        foreign key (user_id) references usr;

alter table if exists user_role
    add constraint user_role_user_fk
        foreign key (user_id) references usr;