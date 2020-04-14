package ru.norealt.repo;

import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.Predicate;
import com.querydsl.core.types.dsl.StringPath;
import org.springframework.data.domain.Sort;
import org.springframework.data.querydsl.QuerydslPredicateExecutor;
import org.springframework.data.querydsl.binding.MultiValueBinding;
import org.springframework.data.querydsl.binding.QuerydslBinderCustomizer;
import org.springframework.data.querydsl.binding.QuerydslBindings;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;
import ru.norealt.domain.Message;
import ru.norealt.domain.QMessage;

import java.util.Optional;

@Repository
public interface MessagePageAndSortRepo
        extends PagingAndSortingRepository<Message, Long>, QuerydslPredicateExecutor<Message>, QuerydslBinderCustomizer<QMessage> {

    @Override
    Iterable<Message> findAll(Predicate predicate, Sort sort);

    @Override
    default void customize(QuerydslBindings bindings, QMessage message) {

        bindings.bind(String.class).all((MultiValueBinding<StringPath, String>) (path, values) -> {
            BooleanBuilder predicate = new BooleanBuilder();
            values.forEach( value -> predicate.or(path.containsIgnoreCase(value)));
            return Optional.of(predicate);
        });

    }

}
