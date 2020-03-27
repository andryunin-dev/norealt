package ru.norealt.repo;

import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;
import ru.norealt.domain.User;

@Repository
public interface UserPageAndSortRepo
        extends PagingAndSortingRepository<User, Long> {

}
