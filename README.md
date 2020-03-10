# NAME

DBIx::Class::ParseError - Extensible database error handler

# SYNOPSIS

From:

    DBIx::Class::Storage::DBI::_dbh_execute(): DBI Exception: DBD::mysql::st execute failed: Duplicate entry \'1\' for key \'PRIMARY\' [for Statement "INSERT INTO foo ( bar_id, id, is_foo, name) VALUES ( ?, ?, ?, ? )" with ParamValues: 0=1, 1=1, 2=1, 3=\'Foo1571434801\'] at ...

To:

    use Data::Dumper;
    my $parser = DBIx::Class::ParseError->new(schema => $dbic_schema);
    print Dumper( $parser->process($error) );

    # bless({
    #    'table' => 'foo',
    #    'columns' => [
    #        'id'
    #    ],
    #    'message' => 'DBIx::Class::Storage::DBI::_dbh_execute(): DBI Exception: DBD::mysql::st execute failed: Duplicate entry \'1\' for key \'PRIMARY\' [for Statement "INSERT INTO foo ( bar_id, id, is_foo, name) VALUES ( ?, ?, ?, ? )" with ParamValues: 0=1, 1=1, 2=1, 3=\'Foo1571434801\'] at ...',
    #    'operation' => 'insert',
    #    'column_data' => {
    #        'name' => 'Foo1571434801',
    #        'bar_id' => '1',
    #        'id' => '1',
    #        'is_foo' => '1'
    #    },
    #    'source_name' => 'Foo',
    #    'type' => 'primary_key'
    # }, 'DBIx::Class::ParseError::Error' );

# DESCRIPTION

This a tool to extend DB errors from [DBIx::Class](https://metacpan.org/pod/DBIx%3A%3AClass) (basically, database error
strings wrapped into a [DBIx::Class::Exception](https://metacpan.org/pod/DBIx%3A%3AClass%3A%3AException) obj) into an API to provide
useful details of the error, allowing app's business layer or helper scripts
interfacing with database models to instrospect and better handle errors from
multiple DBMS.

## ERROR CASES

This is a non-exausted list of common errors which should be handled by this
tool:

- primary key
- foreign key(s)
- unique key(s)
- not null column(s)
- data type
- missing column
- missing table

# DRIVERS

Initial fully support for errors from the following DBMS:

- SQLite

    See [DBIx::Class::ParseError::Parser::SQLite](https://metacpan.org/pod/DBIx%3A%3AClass%3A%3AParseError%3A%3AParser%3A%3ASQLite).

- MySQL

    See [DBIx::Class::ParseError::Parser::MySQL](https://metacpan.org/pod/DBIx%3A%3AClass%3A%3AParseError%3A%3AParser%3A%3AMySQL).

# AUTHOR

wreis - Wallace reis <wreis@cpan.org>

# COPYRIGHT

Copyright (c) the ["AUTHOR"](#author).

# LICENSE

This library is free software and may be distributed under the same terms
as perl itself.
