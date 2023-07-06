package org.database.resume.mapper;

public interface Mapper<F, T> {
    T mapFrom(F object);
}
