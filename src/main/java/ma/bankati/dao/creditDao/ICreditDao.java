package ma.bankati.dao.creditDao;

import ma.bankati.model.credit.Credit;

import java.util.List;

public interface ICreditDao <T, ID>
{
    T findById(ID identity);
    List<T> findByClientId(ID identity);

    List<Credit> creditsEnAttente();

    List<Credit> creditsApprouve();

    List<Credit> creditsRefuse();

    List<T> findAll();
    T save(T newElement);
    void deleteById(ID identity);
    void delete(T element);
    void deleteCredits(ID newValuesElement);
    void ApprouverOuRefuserDemande(T element);

}
