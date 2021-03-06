# June 13, 2017
# Get list of proteins containing domain of interest

#! /usr/perl/bin -w
use strict;
#use Getopt::Long;

my $folderin="/home/mnguyen/Research/Symbiomics/AA3/AA3_2/AA3_2_manuscript/hmmscan/Best_domains";
my $domain_interest="AA3_2";
my $fileout="/home/mnguyen/Research/Symbiomics/AA3/AA3_2/AA3_2_manuscript/hmmscan/AA3_2.txt";
#GetOptions('folderin=s'=>\$folderin, 'fileout=s'=>\$fileout, 'domain=s'=>\$domain_interest);

open(Out,">$fileout") || die "Cannot open file $fileout";
print Out "#Species\tProtID\tCAZy_module\tDomain_location\n";
opendir(DIR,"$folderin") || die "Cannot open folder $folderin";
my @files=readdir(DIR);
foreach my $file (@files)
{
	my $species=$file;
	#$species=substr($species,0,8);

	open(In,"<$folderin/$file") || die "Cannot open file $file";
	while (<In>)
	{
		$_=~s/\s*$//;
		if ($_!~/^\#/)
		{
			my @cols=split(/\t/,$_);
			my $protid=$cols[0];
			my $cazy_module=$cols[1];
			my $domain_location=$cols[2];
			$cazy_module=~s/\s*//g;
			my @domains=split(/-/,$cazy_module);
			my $print_flag=0;
			foreach my $domain (@domains)
			{
				if ($domain eq $domain_interest){$print_flag=1;}
			}
			if ($print_flag)
			{
				print Out "$species\t$protid\t$cazy_module\t$domain_location\n";
				#print Out "$species\t$protid\t$cazy_module\n";
			}
		}
	}
	close(In);
}
closedir(DIR);
close(Out);