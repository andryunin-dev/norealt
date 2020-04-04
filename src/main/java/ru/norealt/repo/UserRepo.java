package ru.norealt.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import ru.norealt.domain.User;

public interface UserRepo extends JpaRepository<User, Long> {
    User findByUsername(String username);

    User findByEmail(String email);

    User findByActivationCode(String code);

    User findByRestoreCode(String code);

    @Query(value = "select max(id) from usr", nativeQuery = true)
    Long findMaxId();
}