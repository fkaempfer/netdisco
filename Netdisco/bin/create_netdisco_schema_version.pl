#!/usr/bin/env perl

use strict;
use warnings FATAL => 'all';

use Dancer ':script';
use Dancer::Plugin::DBIC 'schema';

use Netdisco::DB;
use Getopt::Long;

my $sql_dir = $Netdisco::DB::schema_versions_dir;
my $version = schema->schema_version();

my ( $preversion, $help );
GetOptions(
  'p|preversion:s'  => \$preversion,
) or do {
  print <<ENDHELP;
    $0 [-p <version>]

    This script creates SQL DDL files of the Netdisco database schema.

    If called without any CLI options, it makes one SQL DDL file which will
    initialize the complete schema to the current DBIx::Class specification.

    If called with the "-p <version>" option, upgrade SQL DDL command files
    are created between the specified version and the current DBIx::Class
    specification.

    SQL DDL files are stored in:
$sql_dir
ENDHELP
  exit(1);
};
 
schema->create_ddl_dir( 'PostgreSQL', $version, $sql_dir, $preversion );
