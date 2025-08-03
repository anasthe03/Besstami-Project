package ma.bankati.dao.creditDao;


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
import java.util.stream.Collectors;

public class CreditDao implements ICreditDao<Credit,Long>{


    Path path ;

    public CreditDao()  {
        try {
            this.path = Paths
                    .get(
                            getClass()
                                    .getClassLoader()
                                    .getResource("FileBase/credits.txt")
                                    .toURI()
                    );
        }catch (Exception e){
            System.err.println("FileBase not found");
        }

    }

    private Credit map(String fileLine){
        String[] fields     = fileLine.split("-");
        Long    id          = Long.parseLong(fields[0]);
        Long    id_Client   = Long.parseLong(fields[1]);
        Double  montant     = fields[2].equals("null") ? null : Double.parseDouble(fields[2]);
        String  motif             = fields[3].equals("null") ? null : fields[3];
        LocalDate dateDemande     = fields[4].equals("null") ? null : LocalDate.parse(fields[4], DateTimeFormatter.ofPattern("dd/MM/yyyy"));

        //traiter etat demande
        Etat statut = fields[5].equals("null") ? null :
                     (fields[5].equalsIgnoreCase("EN_ATTENTE") ? Etat.EN_ATTENTE :
                     (fields[5].equalsIgnoreCase("APPROUVE") ? Etat.APPROUVE :
                     (fields[5].equalsIgnoreCase("REFUSE") ? Etat.REFUSE : null)));

        LocalDate dateTraitement  = fields[6].equals("null") ? null : LocalDate.parse(fields[6], DateTimeFormatter.ofPattern("dd/MM/yyyy"));

        return new Credit(id,id_Client,montant,motif,dateDemande,statut,dateTraitement);

    }


    private String mapToFileLine(Credit credit){

        Long    id          = credit.getId();
        Long    id_Client   = credit.getClientId();
        Double  montant     = credit.getMontant();
        String  motif             = credit.getMotif() == null || credit.getMotif().trim().isEmpty() ? "null" : credit.getMotif();
        String dateDemande     = credit.getDateDemande() == null ? "null" : credit.getDateDemande().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")).toString();
        Etat statut = credit.getStatut() == null ? null : credit.getStatut();
        String dateTraitement  = credit.getDateTraitement() == null ? "null" : credit.getDateTraitement().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")).toString();

        return id+"-"+id_Client+"-"+montant+"-"+motif+"-"+dateDemande+"-"+statut+"-"+dateTraitement+"\n";

    }

    private long newMaxId(){
        return findAll().stream().mapToLong(Credit::getId).max().orElse(0) + 1;
    }

    @Override
    public Credit findById(Long identity) {

        return findAll().stream()
                .filter(c -> c.getId().equals(identity))
                .findFirst()
                .orElse(null);

    }

    @Override
    public List<Credit> findByClientId(Long identity) {
        try {
            return Files.readAllLines(path)
                    .stream()
                    .skip(1)
                    .map(this::map) // transforme chaque ligne en objet Credit
                    .filter(credit -> credit.getClientId().equals(identity)) // filtre par ID du client
                    .toList();
        } catch (IOException e) {
            return new ArrayList<>();
        }
    }

    @Override
    public List<Credit> creditsEnAttente() {

        try {
            return Files.readAllLines(path)
                    .stream()
                    .skip(1) // Ignore l’en-tête
                    .map(this::map)
                    .filter(credit -> Etat.EN_ATTENTE.equals(credit.getStatut())) // <-- Filtrage ici
                    .collect(Collectors.toList());
        } catch (IOException e) {
            e.printStackTrace(); // Pour diagnostiquer l’erreur si besoin
            return new ArrayList<>();
        }

    }

    @Override
    public List<Credit> creditsApprouve() {

        try {
            return Files.readAllLines(path)
                    .stream()
                    .skip(1) // Ignore l’en-tête
                    .map(this::map)
                    .filter(credit -> Etat.APPROUVE.equals(credit.getStatut())) // <-- Filtrage ici
                    .collect(Collectors.toList());
        } catch (IOException e) {
            e.printStackTrace(); // Pour diagnostiquer l’erreur si besoin
            return new ArrayList<>();
        }

    }

    @Override
    public List<Credit> creditsRefuse() {

        try {
            return Files.readAllLines(path)
                    .stream()
                    .skip(1) // Ignore l’en-tête
                    .map(this::map)
                    .filter(credit -> Etat.REFUSE.equals(credit.getStatut())) // <-- Filtrage ici
                    .collect(Collectors.toList());
        } catch (IOException e) {
            e.printStackTrace(); // Pour diagnostiquer l’erreur si besoin
            return new ArrayList<>();
        }

    }


    @Override
    public List<Credit> findAll() {
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
    public Credit save(Credit newElement) {
        try {
            newElement.setId(newMaxId());
            newElement.setDateDemande(LocalDate.now());
            newElement.setDateTraitement(null);
            newElement.setStatut(Etat.EN_ATTENTE);

           Files.writeString(path, mapToFileLine(newElement), StandardOpenOption.APPEND);


            return newElement;
        } catch (IOException e) {
            return null;
        }
    }

    @Override
    public void deleteById(Long identity) {
        List<Credit> updatedList = findAll().stream()
                .filter(c -> !c.getId().equals(identity))
                .toList();

        rewriteFile(updatedList);
    }


    @Override
    public void delete(Credit element) {
        deleteById(element.getId());
    }

    @Override
    public void deleteCredits(Long element) {
        // On récupère la liste des crédits
        List<Credit> credits = findAll().stream().toList();

        // On filtre pour ne garder que les crédits dont le clientId n'est PAS égal à 'element'
        List<Credit> updatedCredits = credits.stream()
                .filter(credit -> !credit.getClientId().equals(element))
                .collect(Collectors.toList());

        // On réécrit le fichier avec la nouvelle liste
        rewriteFile(updatedCredits);
    }

    @Override
    public void ApprouverOuRefuserDemande(Credit element) {

           List<Credit> updatedList = findAll().stream()
                .map(credit -> credit.getId().equals(element.getId()) ? element: credit )
                .toList();

           rewriteFile(updatedList);

    }


    private void rewriteFile(List<Credit> credits) {
        try {
            List<String> lines = new ArrayList<>();
            lines.add("ID-clientId-montant-motif-dateDemande-statut-dateTraitement"); // header
            for (Credit credit : credits) {
                lines.add(mapToFileLine(credit).trim());
            }
            Files.write(path, lines);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
