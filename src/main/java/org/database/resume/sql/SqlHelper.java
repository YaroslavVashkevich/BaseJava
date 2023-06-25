package org.database.resume.sql;

import org.database.resume.exception.StorageException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class SqlHelper {
    public void execute(String sql) {
        execute(sql, PreparedStatement::execute);
    }

    public <T> T execute(String sql, SqlExecutor<T> executor) {
        try (Connection connection = ConnectionManager.get()) {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            return executor.execute(preparedStatement);
        } catch (SQLException e) {
            throw ExceptionUtil.convertException(e);
        }
    }

    public <T> T transactionalExecute(SqlTransaction<T> executor) {
        try (Connection connection = ConnectionManager.get()) {
            try {
                connection.setAutoCommit(false);
                T result = executor.execute(connection);
                connection.commit();
                return result;
            } catch (SQLException e) {
                connection.rollback();
                throw ExceptionUtil.convertException(e);
            }
        } catch (SQLException e) {
            throw new StorageException(e);
        }
    }
}
