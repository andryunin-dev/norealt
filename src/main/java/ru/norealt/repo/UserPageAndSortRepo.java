package ru.norealt.repo;

import com.querydsl.core.types.Predicate;
import com.querydsl.core.types.dsl.StringPath;
import org.springframework.data.domain.Sort;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.data.querydsl.binding.QuerydslBinderCustomizer;
import org.springframework.data.querydsl.binding.QuerydslBindings;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;
import ru.norealt.domain.QUser;
import ru.norealt.domain.User;

@Repository
public interface UserPageAndSortRepo
        extends PagingAndSortingRepository<User, Long>, QuerydslPredicateExecutor<User>, QuerydslBinderCustomizer<QUser> {

    @Override
    Iterable<User> findAll(Predicate predicate, Sort sort);

    @Override
    default void customize(QuerydslBindings bindings, QUser user) {

        bindings.bind(user.username).first((path, value) -> path.contains(value));
        bindings.bind(user.registrationDate).first((path, value) -> path.contains(value));
        bindings.bind(user.email).first((path, value) -> path.containsIgnoreCase(value));
        bindings.bind(String.class)
                .first((StringPath path, String value) -> path.containsIgnoreCase(value));
        bindings.excluding(user.password);

    }


}
