using {cap_app_pg as cpg} from '../db/Schema';

@path: 'Student'
service StudentService {


    entity Student @(restrict: [
        {
            grant: ['READ'],
            to   : ['StudentViewer']
        },
        {
            grant: ['*'],
            to   : ['StudentAdmin']
        }
    ]) as projection on cpg.Student;

    annotate Student with @odata.draft.enabled;
}