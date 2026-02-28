using { ao.cds.test as t} from '../db/schema';


service AdminService {
    entity Books as projection on t.Books;
    entity OrgBooks as projection on t.OrgBooks;
}
