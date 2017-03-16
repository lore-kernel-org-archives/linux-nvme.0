From: joseph.r.gruher@intel.com (Gruher, Joseph R)
Date: Thu, 16 Mar 2017 00:03:41 +0000
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <DE927C68B458BE418D582EC97927A9285466D139@ORSMSX112.amr.corp.intel.com>
References: <08131a05-1f56-ef61-990a-7fff04eea095@gmail.com>
 <de1a559a-bf24-0d73-5fc7-148d6cd4d4e0@grimberg.me>
 <1848296658.37025722.1487782361271.JavaMail.zimbra@redhat.com>
 <1554c1d1-6bf4-9ca2-12d4-a0125d8c5715@gmail.com>
 <DE927C68B458BE418D582EC97927A92854655137@ORSMSX112.amr.corp.intel.com>
 <3eb5814f-14cb-2b94-adf8-335d4b2eb7e9@grimberg.me>
 <26912d0c-578f-26e9-490d-94fc95bdf259@mellanox.com>
 <DE927C68B458BE418D582EC97927A9285466CCB6@ORSMSX112.amr.corp.intel.com>
 <DE927C68B458BE418D582EC97927A9285466D139@ORSMSX112.amr.corp.intel.com>
Message-ID: <DE927C68B458BE418D582EC97927A9285466E2F0@ORSMSX112.amr.corp.intel.com>

> > We tested the patches
> > with a single target system and a single initiator system connected
> > via CX4s at 25Gb through an Arista 7060X switch with regular Ethernet
> > flow control enabled (no PFC/DCB - but the switch has no other traffic
> > on it).  We connected
> > 8 Intel P3520 1.2 TB SSDs from the target to the initiator with 16 IO
> > queues per disk.  Then we ran FIO with a 4KB workload, random IO
> > pattern, 4 jobs per disk, queue depth 32 per job, testing 100% read,
> > 70/30 read/write, and 100% write workloads.  We used the default
> > 4.10-RC8 kernel, then patched the same kernel with Sagi's patch, and
> > then separately with Max's patch, and then both patches at the same
> > time (just for fun).  The patches were applied on both target and
> > initiator.  In general we do see to see a performance hit on small
> > block read workloads but it is not massive, looks like about 10%.  We also
> tested some large block transfers and didn't see any impact.  Results here are
> in 4KB IOPS:
> >
> > Read/Write	4.10-RC8	Patch 1 (Sagi)	Patch 2 (Max)	Both Patches
> > 100/0		667,158		611,737		619,586
> > 		607,080
> > 70/30		941,352		890,962		884,222
> > 		876,926
> > 0/100		667,379		666,000		666,093
> > 		666,144
> >
> 
> One additional result from our 25Gb testing - we did do an additional test with
> the same configuration as above but we ran just a single disk, and a single FIO
> job with queue depth 8.  This is a light workload designed to examine latency
> under lower load, when not bottlenecked on network or disk throughput, as
> opposed to driving the system to max IOPS.  Here we see about a 30usec (20%)
> increase to latency on 4KB random reads when we apply Sagi's patch and a
> corresponding dip in IOPS (only about a 2% hit to latency was seen with Max's
> patch):
> 
> 4.10-RC8	Patch 1		4.10-RC8 Kernel		Patch 1
> IOPS		IOPS		Latency (usec)		Latency (usec)
> 49,304		40,490		160.3			192.9

After moving back to 50Gb CX4 NICs we tested the patches from Sagi and Max.  With Sagi's patch we seem to see a reduced frequency of errors, especially on the target, but errors still definitely occur.  We ran 48 different two-minute workloads and saw roughly 30 errors on the initiator and exactly two on the target.

Target error example:

[ 4336.224633] mlx5_0:dump_cqe:262:(pid 12397): dump error cqe
[ 4336.224636] 00000000 00000000 00000000 00000000
[ 4336.224636] 00000000 00000000 00000000 00000000
[ 4336.224637] 00000000 00000000 00000000 00000000
[ 4336.224637] 00000000 00008813 080000ca 3fb97fd3

Initiator error example:

[ 3134.447002] mlx5_0:dump_cqe:262:(pid 0): dump error cqe
[ 3134.447006] 00000000 00000000 00000000 00000000
[ 3134.447007] 00000000 00000000 00000000 00000000
[ 3134.447008] 00000000 00000000 00000000 00000000
[ 3134.447010] 00000000 08007806 250001a1 55a128d3
[ 3134.447032] nvme nvme0: MEMREG for CQE 0xffff91458a81a650 failed with status memory management operation error (6)
[ 3134.460612] nvme nvme0: reconnecting in 10 seconds
[ 3144.733988] nvme nvme0: Successfully reconnected

Full dmesg output from both systems is attached (it has a few annotations in it about what workload were running at the time of the errors - please just ignore those).

With Max's patch we have so far not produced any errors!  We will continue testing it.  We are also still working to assess the performance impact of Max's patch on the 50Gb configuration.  Since we get the errors without the patch (which then cause the initiator to disconnect and reconnect and thus affect performance) we cannot just run our automated test with and without the patch and compare the two results.  We will do some targeted testing to see if we can capture some unpatched runs that don't have errors and use those to assess the performance impact of Max's patch on the same workloads.

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: patch-test-01-50g-patch1-i03-dmesg.txt
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170316/6ef575ae/attachment-0002.txt>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: patch-test-01-50g-patch1-t01-dmesg.txt
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170316/6ef575ae/attachment-0003.txt>
