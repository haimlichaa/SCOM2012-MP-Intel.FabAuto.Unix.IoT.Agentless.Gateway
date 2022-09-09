
## Collect all disk performance metrics
day=`date "+%d"`;c="PhysicalDisk";e=`date +%s`;((s=e-1190));e=`date -d @$e +%H:%M:%S`;s=`date -d @$s +%H:%M:%S`;case $c in "Processor") opt="" ;; "Network") opt="-n DEV" ;; "NetworkErr") opt="-n EDEV" ;; "Memory") opt="-r" ;; "Swap") opt="-S" ;; "Paging") opt="-W" ;; "PhysicalDisk") opt="-d" ;; "Load") opt="-q" ;; *) opt="NONE" ;; esac; if [[ $opt != "NONE" ]];then LC_ALL=en_US /usr/bin/sadf -d /var/log/sa/sa$day -- -s $s -e $e $opt;fi > /tmp/devperf.out

## Get list of flash devices
flash=`lsscsi | grep ATA | awk '{print $NF " "}' | tr -d '\n'|sed "s/\/dev\///g"`

## Get dev id translation to device file
devmap=`find  /dev/ -type b -exec ls -l {} \;|awk '{print "dev"$5,$6,$10}'|sed "s/, /-/"|sed "s/\/dev\///"|sed "s/ /,/g"`

## Now Substitute dev ids for device file name
for i in $devmap;do d=`echo $i|cut -f1 -d","`;e=`echo $i|cut -f2 -d","`;sed -i "s/;$d;/;$e;/g" /tmp/devperf.out;done

## Finally append the prefix flash to flash devices.
for i in $flash;do sed -i "s/;$i;/;${i}-flash;/g" /tmp/devperf.out ;done
cat /tmp/devperf.out
/bin/rm -f /tmp/devperf.out





#day=`date "+%d"`;c="PhysicalDisk";e=`date +%s`;((s=e-1190));e=`date -d @$e +%H:%M:%S`;s=`date -d @$s +%H:%M:%S`;case $c in "Processor") opt="" ;; "Network") opt="-n DEV" ;; "NetworkErr") opt="-n EDEV" ;; "Memory") opt="-r" ;; "Swap") opt="-S" ;; "Paging") opt="-W" ;; "PhysicalDisk") opt="-d" ;; "Load") opt="-q" ;; *) opt="NONE" ;; esac; if [[ $opt != "NONE" ]];then LC_ALL=en_US /usr/bin/sadf -d /var/log/sa/sa$day -- -s $s -e $e $opt;fi > /tmp/devperf.out; if [ $c = "PhysicalDisk" ];then   flash=`lsscsi | grep ATA | awk '{print $NF " "}' | tr -d '\n'|sed "s/\/dev\///g"`;devmap=`find  /dev/ -maxdepth 1 -type b -exec ls -l {} \;|awk '{print "dev"$5,$6,$10}'|sed "s/, /-/"|sed "s/\/dev\///"|sed "s/ /,/g"`;for i in $devmap;do d=`echo $i|cut -f1 -d","`;e=`echo $i|cut -f2 -d","`;sed -i "s/;$d;/;$e;/g" /tmp/devperf.out;done;for i in $flash;do sed -i "s/;$i;/;${i}-flash;/g" /tmp/devperf.out ;done;fi;cat /tmp/devperf.out;/bin/rm -f /tmp/devperf.out


day=`date "+%d"`;c="PhysicalDisk";e=`date +%s`;((s=e-1190));e=`date -d @$e +%H:%M:%S`;s=`date -d @$s +%H:%M:%S`;case $c in "Processor") opt="" ;; "Network") opt="-n DEV" ;; "NetworkErr") opt="-n EDEV" ;; "Memory") opt="-r" ;; "Swap") opt="-S" ;; "Paging") opt="-W" ;; "PhysicalDisk") opt="-d" ;; "Load") opt="-q" ;; *) opt="NONE" ;; esac; if [[ $opt != "NONE" ]];then LC_ALL=en_US /usr/bin/sadf -d /var/log/sa/sa$day -- -s $s -e $e $opt;fi > /tmp/devperf.out; if [ $c = "PhysicalDisk" ];then   flash=`lsscsi | grep ATA | awk '{print $NF " "}' | tr -d '\n'|sed "s/\/dev\///g"`;devmap=`find  /dev/ -type b -exec ls -l {} \;|awk '{print "dev"$5,$6,$10}'|sed "s/, /-/"|sed "s/\/dev\///"|sed "s/ /,/g"`;for i in $devmap;do d=`echo $i|cut -f1 -d","`;e=`echo $i|cut -f2 -d","`;sed -i "s/;$d;/;$e;/g" /tmp/devperf.out;done;fi;cat /tmp/devperf.out;/bin/rm -f /tmp/devperf.out









day=`date "+%d"`;for c in PhysicalDisk Processor Memory Paging Load Swap Network NetworkErr;do e=`date +%s`;((s=e-1400));e=`date -d @$e +%H:%M:%S`;s=`date -d @$s +%H:%M:%S`;case $c in "Processor") opt="" ;; "Network") opt="-n DEV" ;; "NetworkErr") opt="-n EDEV" ;; "Memory") opt="-r" ;; "Swap") opt="-S" ;; "Paging") opt="-W" ;; "PhysicalDisk") opt="-d" ;; "Load") opt="-q" ;; *) opt="NONE" ;; esac;  if [[ $opt != "NONE" ]];then LC_ALL=en_US /usr/bin/sadf -d /var/log/sa/sa$day -- -s $s -e $e $opt;fi > /tmp/devperf.out; if [ $c = "PhysicalDisk" ];then   flash=`lsscsi | grep ATA | awk '{print $NF " "}' | tr -d '\n'|sed "s/\/dev\///g"`;devmap=`find  /dev/ -maxdepth 1 -type b -exec ls -l {} \;|awk '{print "dev"$5,$6,$10}'|sed "s/, /-/"|sed "s/\/dev\///"|sed "s/ /,/g"`;for i in $devmap;do d=`echo $i|cut -f1 -d","`;e=`echo $i|cut -f2 -d","`;sed -i "s/;$d;/;$e;/g" /tmp/devperf.out;done;for i in $flash;do sed -i "s/;$i;/;${i}-flash;/g" /tmp/devperf.out ;done;fi;sed -i "s/^/$c;/" /tmp/devperf.out ;cat /tmp/devperf.out;done;/bin/rm -f /tmp/devperf.out



[root@orsox1cm06 ~]# cat /tmp/out
#+PhysicalDisk
# hostname;interval;timestamp;DEV;tps;rd_sec/s;wr_sec/s;avgrq-sz;avgqu-sz;await;svctm;%util
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;sds;0.09;150.98;0.51;1669.74;0.00;14.81;9.56;0.09
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;sdz;0.08;137.43;0.05;1704.79;0.00;9.75;8.77;0.07
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;sdab;0.11;206.25;0.00;1859.97;0.00;12.48;11.02;0.12
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;sdaa;0.47;192.70;10.03;429.41;0.00;2.58;2.55;0.12
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;sdv;0.76;133.08;3.48;179.82;0.00;1.25;0.96;0.07
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;sdx;0.24;220.23;13.82;987.96;0.00;6.79;5.64;0.13
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;sdw;0.30;103.13;25.88;428.96;0.00;1.69;1.68;0.05
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;sdu;0.10;178.94;0.03;1805.39;0.00;12.97;11.97;0.12
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;sdt;0.21;103.13;14.41;568.76;0.00;2.40;2.40;0.05
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;sdy;0.11;192.49;0.03;1818.76;0.00;14.46;14.05;0.15
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;sdq;6.21;297.07;166.82;74.70;0.00;0.51;0.39;0.24
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;sdac;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;sdo-flash;0.14;0.05;2.80;20.68;0.00;0.06;0.06;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;sdc-flash;0.18;0.00;3.36;18.18;0.00;0.01;0.01;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;sdk-flash;0.15;0.00;3.15;21.03;0.00;0.08;0.08;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;sdb-flash;0.15;0.00;3.52;23.82;0.00;0.08;0.08;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;sdl-flash;0.14;0.00;2.77;19.39;0.00;0.07;0.07;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;sde-flash;0.18;0.00;6.77;37.33;0.00;0.09;0.06;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;sdg-flash;0.38;6.67;3.27;26.39;0.00;0.06;0.06;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;sdj-flash;0.14;0.00;2.84;20.59;0.00;0.04;0.04;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;sdi-flash;0.13;0.00;2.72;20.46;0.00;0.08;0.08;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;sdp-flash;0.14;0.08;6.51;45.58;0.00;0.12;0.08;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;sdn-flash;0.14;0.03;2.59;18.57;0.00;0.05;0.05;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;sdm-flash;0.14;0.00;2.88;20.88;0.00;0.10;0.10;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;sda-flash;0.20;0.00;4.93;24.07;0.00;0.09;0.09;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;sdf-flash;0.15;0.00;3.86;25.23;0.00;0.04;0.04;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;sdd-flash;0.15;0.00;6.71;43.87;0.00;0.14;0.11;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;sdh-flash;0.97;26.18;3.70;30.72;0.00;0.10;0.10;0.01
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;sdr;5.48;180.51;161.49;62.40;0.00;0.38;0.29;0.16
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;md11;1.73;0.00;13.80;8.00;0.00;0.00;0.00;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;md6;6.49;2.96;113.63;17.97;0.00;0.00;0.00;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;md1;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;md2;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;md8;1.80;0.00;20.97;11.62;0.00;0.00;0.00;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;md7;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;md5;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;md4;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00
#+Processor
# hostname;interval;timestamp;CPU;%user;%nice;%system;%iowait;%steal;%idle
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;-1;0.60;0.26;0.96;0.05;0.00;98.14
#+Memory
# hostname;interval;timestamp;kbmemfree;kbmemused;%memused;kbbuffers;kbcached;kbcommit;%commit
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;42928460;22663464;34.55;382432;3493016;24123988;35.64
#+Paging
# hostname;interval;timestamp;pswpin/s;pswpout/s
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;0.00;0.00
#+Load
# hostname;interval;timestamp;runq-sz;plist-sz;ldavg-1;ldavg-5;ldavg-15
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;0;559;1.06;1.41;1.57
#+Swap
# hostname;interval;timestamp;kbswpfree;kbswpused;%swpused;kbswpcad;%swpcad
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;2097084;0;0.00;0;0.00
#+Network
# hostname;interval;timestamp;IFACE;rxpck/s;txpck/s;rxkB/s;txkB/s;rxcmp/s;txcmp/s;rxmcst/s
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;lo;3.55;3.55;1.41;1.41;0.00;0.00;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;eth0;5.92;9.00;0.46;2.06;0.00;0.00;0.01
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;eth1;0.00;0.00;0.00;0.00;0.00;0.00;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;eth2;0.00;0.00;0.00;0.00;0.00;0.00;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;eth3;0.00;0.00;0.00;0.00;0.00;0.00;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;ib0;57.95;0.31;3.21;0.06;0.00;0.00;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;ib1;57.60;0.00;3.15;0.00;0.00;0.00;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;bond0;0.00;0.00;0.00;0.00;0.00;0.00;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;bondib0;115.55;0.31;6.36;0.06;0.00;0.00;0.00
#+NetworkErr
# hostname;interval;timestamp;IFACE;rxerr/s;txerr/s;coll/s;rxdrop/s;txdrop/s;txcarr/s;rxfram/s;rxfifo/s;txfifo/s
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;lo;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;eth0;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;eth1;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;eth2;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;eth3;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;ib0;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;ib1;0.00;0.00;0.00;57.60;0.00;0.00;0.00;0.00;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;bond0;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00;0.00
orsox1cm06.rf3stg.mfgint.intel.com;595;2016-02-08 15:20:01 UTC;bondib0;0.00;0.00;0.00;57.60;0.00;0.00;0.00;0.00;0.00
















