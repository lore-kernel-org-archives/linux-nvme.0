From: joseph.r.gruher@intel.com (Gruher, Joseph R)
Date: Thu, 20 Apr 2017 16:23:01 +0000
Subject: cqe dump errors on target while running nvme-of large block
 read IO
In-Reply-To: <52c550c1-849b-7ea5-ab34-56543cb9069d@mellanox.com>
References: <DE927C68B458BE418D582EC97927A9285505C9EA@ORSMSX113.amr.corp.intel.com>
 <47f19583-1882-09d4-ce1c-534b8e59068b@mellanox.com>
 <DE927C68B458BE418D582EC97927A9285505F0C9@ORSMSX113.amr.corp.intel.com>
 <52c550c1-849b-7ea5-ab34-56543cb9069d@mellanox.com>
Message-ID: <DE927C68B458BE418D582EC97927A92855067BFE@ORSMSX113.amr.corp.intel.com>

> you should set also the irqmode=2 (timer) and run local fio with
> iodepth=1 and numjobs=1 to verify the latency (worked for me).
> Let's try to repro again with the new configuration, to be sure that this is not a
> transport issue.

Adding irqmode=2 definitely corrected the latency behavior.  Now for 1 job with QD=1 on 4K random reads I get average latency 74usec and writes are 67usec.  I set the null_blk devices to 50000nsec so adding in some latency for NVMf this seems reasonable.

I believe I was able to reproduce an instance of the problem using the null_blk devices as the backend.  We configured 16 null_blk devices an attached four to initiator 1 and four to initiator 2.  Initiators are each using both ports of a dual-ported 25Gb CX4 and target is using both ports of a dual-ported 100Gb CX5 (dual ports are on separate subnets).  Then we ran a variety of workloads overnight.  The dmesg logs are attached.  We see "dump error cqe" at various points in the target dmesg and we see IO errors and reconnects on both initiators.

Thanks,
Joe
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: init1.txt
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170420/6e4e0538/attachment-0003.txt>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: init2.txt
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170420/6e4e0538/attachment-0004.txt>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: target.txt
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170420/6e4e0538/attachment-0005.txt>
