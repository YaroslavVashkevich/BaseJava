package org.database.resume.mapper;

import lombok.AccessLevel;
import lombok.NoArgsConstructor;
import org.database.resume.dto.UserDto;
import org.database.resume.model.User;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class UserMapper implements Mapper<User, UserDto> {
    private static final UserMapper INSTANCE = new UserMapper();

    @Override
    public UserDto mapFrom(User object) {
        return UserDto.builder()
                .id(object.getId())
                .name(object.getName())
                .email(object.getEmail())
                .build();
    }

    public static UserMapper getInstance() {
        return INSTANCE;
    }
}
