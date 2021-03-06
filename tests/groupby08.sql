select
       c.constraint_name
       -- max(a.constraint_name) as constraint_name
       -- , c.constraint_name
       , max(r.constraint_name) as r_constraint_name
       , max(c.owner)           as owner
       , max(c.table_name)      as table_name
       , c.column_name          as column_name
       , max(r.owner)           as r_owner
       , max(r.table_name)      as r_table_name
       , max(r.column_name)     as r_column_name
       , max(a.constraint_type)
 from sys.all_constraints a
 join sys.all_cons_columns c on (c.constraint_name = a.constraint_name and c.owner = a.owner)
 join sys.all_cons_columns r on (r.constraint_name = a.r_constraint_name and r.owner = a.r_owner and r.position = c.position)
 where
          a.r_owner =                   :f1
      and a.constraint_type = 'r'
 group by c.constraint_name, rollup (c.column_name)
	  