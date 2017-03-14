From: joseph.r.gruher@intel.com (Gruher, Joseph R)
Date: Tue, 14 Mar 2017 23:42:15 +0000
Subject: Unexpected issues with 2 NVME initiators using the same target
In-Reply-To: <DE927C68B458BE418D582EC97927A9285466CCB6@ORSMSX112.amr.corp.intel.com>
References: <08131a05-1f56-ef61-990a-7fff04eea095@gmail.com>
 <de1a559a-bf24-0d73-5fc7-148d6cd4d4e0@grimberg.me>
 <1848296658.37025722.1487782361271.JavaMail.zimbra@redhat.com>
 <1554c1d1-6bf4-9ca2-12d4-a0125d8c5715@gmail.com>
 <DE927C68B458BE418D582EC97927A92854655137@ORSMSX112.amr.corp.intel.com>
 <3eb5814f-14cb-2b94-adf8-335d4b2eb7e9@grimberg.me>
 <26912d0c-578f-26e9-490d-94fc95bdf259@mellanox.com>
 <DE927C68B458BE418D582EC97927A9285466CCB6@ORSMSX112.amr.corp.intel.com>
Message-ID: <DE927C68B458BE418D582EC97927A9285466D139@ORSMSX112.amr.corp.intel.com>

> We tested the patches
> with a single target system and a single initiator system connected via CX4s at
> 25Gb through an Arista 7060X switch with regular Ethernet flow control
> enabled (no PFC/DCB - but the switch has no other traffic on it).  We connected
> 8 Intel P3520 1.2 TB SSDs from the target to the initiator with 16 IO queues per
> disk.  Then we ran FIO with a 4KB workload, random IO pattern, 4 jobs per disk,
> queue depth 32 per job, testing 100% read, 70/30 read/write, and 100% write
> workloads.  We used the default 4.10-RC8 kernel, then patched the same kernel
> with Sagi's patch, and then separately with Max's patch, and then both patches
> at the same time (just for fun).  The patches were applied on both target and
> initiator.  In general we do see to see a performance hit on small block read
> workloads but it is not massive, looks like about 10%.  We also tested some
> large block transfers and didn't see any impact.  Results here are in 4KB IOPS:
> 
> Read/Write	4.10-RC8	Patch 1 (Sagi)	Patch 2 (Max)	Both Patches
> 100/0		667,158		611,737		619,586
> 		607,080
> 70/30		941,352		890,962		884,222
> 		876,926
> 0/100		667,379		666,000		666,093
> 		666,144
> 

One additional result from our 25Gb testing - we did do an additional test with the same configuration as above but we ran just a single disk, and a single FIO job with queue depth 8.  This is a light workload designed to examine latency under lower load, when not bottlenecked on network or disk throughput, as opposed to driving the system to max IOPS.  Here we see about a 30usec (20%) increase to latency on 4KB random reads when we apply Sagi's patch and a corresponding dip in IOPS (only about a 2% hit to latency was seen with Max's patch):

4.10-RC8	Patch 1		4.10-RC8 Kernel		Patch 1
IOPS		IOPS		Latency (usec)		Latency (usec)
49,304		40,490		160.3			192.9 
