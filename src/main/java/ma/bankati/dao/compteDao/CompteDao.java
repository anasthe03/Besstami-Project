package ma.bankati.dao.compteDao;

import ma.bankati.model.compte.Compte;
import ma.bankati.model.credit.Credit;
import ma.bankati.model.credit.Etat;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class CompteDao implements ICompteDao <Compte,Long>{



    Path path ;

    public CompteDao()  {
        try {
            this.path = Paths
                    .get(
                            getClass()
                                    .getClassLoader()
                                    .getResource("FileBase/comptes.txt")
                                    .toURI()
                    );
        }catch (Exception e){
            System.err.println("FileBase not found");
        }

    }

    private Compte map(String fileLine){
        String[] fields     = fileLine.split("-");
        Long    id          = Long.parseLong(fields[0]);
        Long    clientId   = Long.parseLong(fields[1]);
        Double  solde     =  Double.parseDouble(fields[2]);

        return new Compte(id,clientId,solde);

    }


    private String mapToFileLine(Compte compte){

        Long    id          = compte.getId();
        Long    id_Client   = compte.getClientId();
        Double  solde   = compte.getSolde();

        return id+"-"+id_Client+"-"+solde+"\n";

    }

    private long newMaxId(){
        return findAll().stream().mapToLong(Compte::getId).max().orElse(0) + 1;
    }




    @Override
    public Compte findByClientId(Long identity) {

        return findAll().stream()
                .filter(c -> c.getClientId().equals(identity))
                .findFirst()
                .orElse(null);
    }

    @Override
    public List<Compte> findAll() {
        try {
            return
                    Files.readAllLines(path)
                            .stream()
                            .skip(1)
                            .map(line -> map(line))
                            .toList() ;
        }
        catch (IOException e) {
            return new ArrayList<>();
        }
    }

    @Override
    public Compte save(Compte newElement) {
        try {
            newElement.setId(newMaxId());
            Files.writeString(path, mapToFileLine(newElement), StandardOpenOption.APPEND);


            return newElement;
        } catch (IOException e) {
            return null;
        }
    }

    @Override
    public void deposer(Compte element , Double montant) {

        element.setSolde(element.getSolde()+montant);
        List<Compte> updatedList = findAll().stream()
                .map(c -> c.getId().equals(element.getId()) ? element: c )
                .toList();

        rewriteFile(updatedList);
    }

    @Override
    public void retirer(Compte element , Double montant) {
        element.setSolde(element.getSolde()-montant);
        List<Compte> updatedList = findAll().stream()
                .map(c -> c.getId().equals(element.getId()) ? element: c )
                .toList();

        rewriteFile(updatedList);
    }

    @Override
    public void deleteById(Long identity) {

        List<Compte> updatedList = findAll().stream()
                .filter(c -> !c.getId().equals(identity))
                .toList();

        rewriteFile(updatedList);
    }

    @Override
    public void delete(Compte element) {

        deleteById(element.getId());
    }



    private void rewriteFile(List<Compte> comptes) {
        try {
            List<String> lines = new ArrayList<>();
            lines.add("ID-clientId-solde"); // header
            for (Compte compte: comptes) {
                lines.add(mapToFileLine(compte).trim());
            }
            Files.write(path, lines);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
