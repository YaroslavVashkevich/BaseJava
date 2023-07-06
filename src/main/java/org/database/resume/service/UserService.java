package org.database.resume.service;

import lombok.SneakyThrows;
import org.database.resume.dao.UserDao;
import org.database.resume.dto.CreateUserDto;
import org.database.resume.dto.UserDto;
import org.database.resume.mapper.CreateUserMapper;
import org.database.resume.mapper.UserMapper;
import org.database.resume.model.User;

import java.util.Optional;

public class UserService {
    private static final UserService INSTANCE = new UserService();
    private final UserDao userDao = UserDao.getInstance();
    private final CreateUserMapper createUserMapper = CreateUserMapper.getInstance();
    private final UserMapper userMapper = UserMapper.getInstance();

    private UserService() {
    }

    public Optional<UserDto> login(String email, String password) {
        return userDao.findByEmailAndPassword(email, password).map(userMapper::mapFrom);

    }

    public Optional<UserDto> checkEmail(String email) {
        return userDao.findByEmail(email).map(userMapper::mapFrom);
    }

    @SneakyThrows
    public Integer create(CreateUserDto userDto) {
        User userEntity = createUserMapper.mapFrom(userDto);
        userDao.save(userEntity);
        return userEntity.getId();
    }

    public static UserService getInstance() {
        return INSTANCE;
    }
}
