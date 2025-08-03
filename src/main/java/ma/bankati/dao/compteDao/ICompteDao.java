package ma.bankati.dao.compteDao;

import java.util.List;

public interface ICompteDao <T, ID>
{
    T findByClientId(ID identity);
    List<T> findAll();
    T save(T newElement);
    void deposer(T element , Double montant);
    void retirer(T element , Double montant);
    void deleteById(ID identity);
    void delete(T element);


}
