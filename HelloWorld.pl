#!/usr/bin/perl
  
# Modules used
use strict;
use warnings;
  
open(FIL1,"<file1");
my @mass;
my %result;
my $line;
my $str;
while( $str = <FIL1>  ){
    @mass= split /, /, $str; #Делю строку по запятым
    foreach $line (@mass){ 
        if($line =~ /user:\s(\w{1,}|\d|{1,})/){ #выбираю все значения после 'user: ' до запятой
            $result{$1}=1; #записываю в хеш чтобы имена не повторялись
        }
    }
}
close(FIL1);
open(FIL2,"<file2");
while( $str = <FIL2>  ){
    @mass= split /, /, $str;
    foreach $line (@mass){
        if($line =~ /user:\s(\w{1,}|\d|{1,})/){ #аналогичные действия
            undef $result{$1}; #убираю значение по ключу чтобы не выводить повторы
        }
    }
}
close(FIL2);
undef @mass;
undef $str;
undef $line;
open(FIL3,">result.txt"); #записываю результат в файл
my @Res;
while (@Res = each %result){
        if($Res[1]){
            print FIL3 "$Res[0]\n";
        }
}
close(FIL3);