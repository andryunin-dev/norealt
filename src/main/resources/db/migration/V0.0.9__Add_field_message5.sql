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
                         price varchar(255),
                         post_date varchar(255),
                         user_id int8,
                         primary key (id)
);

alter table if exists message
    add constraint message_user_fk
        foreign key (user_id) references usr;






