package persistence;

import java.sql.SQLException;
import java.util.List;
import exception.GenericException;
/**
 * 
 * @author hury
 *
 * @param <T>
 */
public abstract interface GenericCRUD <T> {

	 void inclui(T obj) throws GenericException, SQLException;
	 
	 List<?>pesquisa(T obj) throws GenericException, SQLException;
	 
	 void altera (T obj) throws GenericException, SQLException;
	 
	 void exclui (T obj) throws GenericException, SQLException;

	
}
