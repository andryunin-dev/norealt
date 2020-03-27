insert into usr (id, email, username, phone, active, password)
values (2, 'admin@admin.com', 'admin', '+7 987 654-32-10', true, '123');

insert into user_role (user_id, roles)
values (2, 'USER'), (2, 'ADMIN');