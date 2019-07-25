From: john.p.donnelly@oracle.com (John Donnelly)
Date: Thu, 25 Jul 2019 16:04:49 -0500
Subject: nvme statistics :  iostat vs  sar 
In-Reply-To: <20190724151200.GA5379@localhost.localdomain>
References: <D4F9A3CB-489A-4946-ADF2-C7C17A21E076@oracle.com>
 <20190724151200.GA5379@localhost.localdomain>
Message-ID: <FF1261FA-2653-4049-9999-90FEADB328D5@oracle.com>



> On Jul 24, 2019,@10:12 AM, Keith Busch <kbusch@kernel.org> wrote:
> 
> On Wed, Jul 24, 2019@09:51:36AM -0500, John Donnelly wrote:
>> Hi,
>> 
>> I noticed  nvme I/O  does not appear  in sar disk data (-d ) ,  but it does appear with  sar block (-b)  and iostat.
>> 
>> Is this expected ?
> 
> 'sar -d' should show activity. It does work as expected on my test machine:
> 
> # ls -l /dev/nvme*n*
> brw-rw----. 1 root disk 259, 0 May 23 09:07 /dev/nvme0n1
> brw-rw----. 1 root disk 259, 1 May 23 09:07 /dev/nvme1n1
> brw-rw----. 1 root disk 259, 2 May 23 09:07 /dev/nvme2n1
> brw-rw----. 1 root disk 259, 3 May 23 09:07 /dev/nvme3n1
> 
> # sar -d 2 10
> Linux 5.2.0-rc1+ (localhost.localdomain)        07/24/2019      _x86_64_        (112 CPU)
> 
> 09:03:06 AM       DEV       tps     rkB/s     wkB/s   areq-sz    aqu-sz     await     svctm     %util
> 09:03:08 AM    dev8-0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
> 09:03:08 AM  dev253-0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
> 09:03:08 AM  dev253-1      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
> 09:03:08 AM  dev259-1      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
> 09:03:08 AM  dev259-0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
> 09:03:08 AM  dev259-2      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
> 09:03:08 AM  dev259-3      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
> 
> 09:03:08 AM       DEV       tps     rkB/s     wkB/s   areq-sz    aqu-sz     await     svctm     %util
> 09:03:10 AM    dev8-0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
> 09:03:10 AM  dev253-0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
> 09:03:10 AM  dev253-1      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
> 09:03:10 AM  dev259-1  26370.50 105482.00      0.00      4.00      0.00      0.02      0.00     12.75
> 09:03:10 AM  dev259-0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
> 09:03:10 AM  dev259-2  26384.00 105532.00      0.00      4.00      0.00      0.03      0.00     12.75
> 09:03:10 AM  dev259-3  26389.50 105556.00      0.00      4.00      0.00      0.02      0.00     12.75
> 
> 09:03:10 AM       DEV       tps     rkB/s     wkB/s   areq-sz    aqu-sz     await     svctm     %util
> 09:03:12 AM    dev8-0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
> 09:03:12 AM  dev253-0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
> 09:03:12 AM  dev253-1      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
> 09:03:12 AM  dev259-1 225306.00 901224.00      0.00      4.00      0.00      0.02      0.00    100.00
> 09:03:12 AM  dev259-0      0.00      0.00      0.00      0.00      0.00      0.00      0.00      0.00
> 09:03:12 AM  dev259-2 225304.50 901220.00      0.00      4.00      0.00      0.03      0.00    100.00
> 09:03:12 AM  dev259-3 225306.50 901228.00      0.00      4.00      0.00      0.02      0.00    100.00
> 


Ok -   I see sar -d when there is filesystem activity on the devices   ;   There is no activity when raw I/O is done  ;
