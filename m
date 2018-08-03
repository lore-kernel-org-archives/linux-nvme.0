From: Alex_Gagniuc@Dellteam.com (Alex_Gagniuc@Dellteam.com)
Date: Fri, 3 Aug 2018 16:16:16 +0000
Subject: How /dev/nvme numbers are allocated/mapped to BDF
References: <073447516980487e950bbc428225ae02@ausx13mps321.AMER.DELL.COM>
 <20180803071820.GA22003@infradead.org>
 <20180803144025.GA4381@localhost.localdomain>
Message-ID: <097442158bb64b9cbf07cc6e6c25ef1a@ausx13mps321.AMER.DELL.COM>

On 08/03/2018 09:40 AM, Keith Busch wrote:
> On Fri, Aug 03, 2018@12:18:20AM -0700, Christoph Hellwig wrote:
>> On Thu, Aug 02, 2018@10:09:50PM +0000, Alex_Gagniuc@Dellteam.com wrote:
>>> Hi,
>>>
>>> Recently some confusion came up about how the /dev/nvme numbers are
>>> allocated, and how much one can expect the to be consistent across
>>> reboots. I was fairly convinced that it was about as random as a coin
>>> flip, but some people have pointed out that these numbers were very
>>> deterministic in older kernels, dating back to the 3.10 era.
>>
>> They are allocated using an ida allocator and are not stable at all.
>> For any stable enumeration you have to rely on the EUI64/NGUID/UUID.
> 
> Yeah, the were always allocated through an ida and were never stable in
> any kernel version.

That's why I suspected. We had some people that were very convinced 
something must have changed, and wanted to verify. Thanks for confirming.

>>> Also, separate but related question. Samsung M1725a drives don't
>>> generate entries under /dev/disk/by-path. Any idea why that might be?
>>
>> Please send a dump of the nvme-cli id-ctrl subcommand.

Please see dump attached at bottom (Appendix A)

> The 'by-path' should actually only depend on the PCI BDf and the 'nsid'
> attribute. The bdf is not necessarilly stable.
> 
> If using systemd, you'd need thsi commit to get the by-path links:
> 
>    https://github.com/systemd/systemd/commit/b4c6f71b827d41a4af8007b735edf21ef7609f99

Thanks. I'm fairly convinced I have that patch. I can see by-path links 
for Intel drives, but not the Samasungs.

[root at g-prime mrnuke]# ls /dev/disk/by-path/ |grep nvme
pci-0000:3f:00.0-nvme-1
pci-0000:3f:00.0-nvme-1-part1
pci-0000:b1:00.0-nvme-1
pci-0000:b1:00.0-nvme-1-part1

[root at g-prime mrnuke]# lspci |grep NVM
3f:00.0 Non-Volatile memory controller: Intel Corporation Express Flash 
NVMe P4500
40:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe 
SSD Controller 172Xa/172Xb (rev 01)
b1:00.0 Non-Volatile memory controller: Intel Corporation Express Flash 
NVMe P4600
b2:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe 
SSD Controller 172Xa/172Xb (rev 01)


[root at g-prime mrnuke]# nvme list
Node             SN                   Model 
       Namespace Usage                      Format           FW Rev
---------------- -------------------- 
---------------------------------------- --------- 
-------------------------- ---------------- --------
/dev/nvme0n1     PHLF7363029G1P0GGN   Dell Express Flash NVMe P4500 
1.0TB SFF  1           1.00  TB /   1.00  TB    512   B +  0 B   QDV1DP12
/dev/nvme1n1     PHLE7260008Z3P2EGN   Dell Express Flash NVMe P4600 
3.2TB SFF  1           3.20  TB /   3.20  TB    512   B +  0 B   QDV1DP12
/dev/nvme2n1           S39YNX0HB00195 Dell Express Flash PM1725a 800GB 
SFF     1         800.17  GB / 800.17  GB    512   B +  0 B   1.0.4
/dev/nvme3n1           S39YNX0HB00293 Dell Express Flash PM1725a 800GB 
SFF     1         800.17  GB / 800.17  GB    512   B +  0 B   1.0.4


### Appendix A:

[root at g-prime mrnuke]# nvme id-ctrl /dev/nvme2n1
NVME Identify Controller:
vid     : 0x144d
ssvid   : 0x1028
sn      :       S39YNX0HB00195
mn      : Dell Express Flash PM1725a 800GB SFF
fr      : 1.0.4
rab     : 8
ieee    : 002538
cmic    : 0x3
mdts    : 5
cntlid  : 21
ver     : 10200
rtd3r   : e4e1c0
rtd3e   : 989680
oaes    : 0x200
ctratt  : 0
oacs    : 0x6
acl     : 7
aerl    : 15
frmw    : 0x17
lpa     : 0x2
elpe    : 63
npss    : 0
avscc   : 0x1
apsta   : 0
wctemp  : 343
cctemp  : 350
mtfa    : 120
hmpre   : 0
hmmin   : 0
tnvmcap : 800166076416
unvmcap : 0
rpmbs   : 0
edstt   : 0
dsto    : 0
fwug    : 0
kas     : 0
hctma   : 0
mntmt   : 0
mxtmt   : 0
sanicap : 0
sqes    : 0x66
cqes    : 0x44
maxcmd  : 0
nn      : 1
oncs    : 0x16
fuses   : 0
fna     : 0x4
vwc     : 0
awun    : 65535
awupf   : 0
nvscc   : 1
acwu    : 0
sgls    : 0
subnqn  :
ioccsz  : 0
iorcsz  : 0
icdoff  : 0
ctrattr : 0
msdbd   : 0
ps    0 : mp:25.00W operational enlat:100 exlat:100 rrt:0 rrl:0
           rwt:0 rwl:0 idle_power:- active_power:-
