// clean data
MATCH (n) DETACH DELETE n

// load data with career
LOAD CSV WITH HEADERS FROM 'https://github.com/user-attachments/files/17481791/sushi-relation2.csv' AS row
WITH row WHERE row.career <> ''
CALL apoc.create.node(["People", row.career], {name: row.name, relation: row.relation}) YIELD node
RETURN *

// load data without career
LOAD CSV WITH HEADERS FROM 'https://github.com/user-attachments/files/17481791/sushi-relation2.csv' AS row
WITH row where row.career = ''
CALL apoc.create.node(["People"], {name: row.name, relation: row.relation}) YIELD node
RETURN *

// add relation
MATCH (a:People) where a.relation <> '' and a.name <> '苏轼'
MATCH (o:People) where o.name = '苏轼'
CALL apoc.create.relationship(a, a.relation, {}, o) YIELD rel
RETURN *

// show all
MATCH (n) RETURN n
