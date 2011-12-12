From: Kwok.Kong@idt.com (Kong, Kwok)
Date: Mon, 12 Dec 2011 11:25:49 -0800
Subject: TODO list 2011-12-09
In-Reply-To: <20111209213740.GJ14291@linux.intel.com>
References: <20111209213740.GJ14291@linux.intel.com>
Message-ID: <5AC4D6A45304E048A30F105EB302760902DD87FC@CORPEXCH1.na.ads.idt.com>

Matthew,

I have a proposal on the module parameters. Please let me know what you
think. We at IDT can implement this.

The following module parameters should be configurable:

Name				min/max/default		NVMe spec
reference
Admin_sub_queue_size	2/4096/128			AQA.ASQS
Admin_cpl_queue_size	2/4096/128			AQA.ACQS
Io_sub_queue_size		2/64K/1K			Create
I/O submission Queue
Io_cpl_queue_size		2/64K/1K			Create
I/O Completion Queue
Max_transfer_size		4K/1M/128K			ECN12 -
Maximum Data Transfer Size
- Actual Max transfer size = min(max_transfer_size, ECN12.MDTS)
Intr_coalescing_threshold	1/256/8		Set Features - Interrupt
Coalescing
Intr_coalescing_time	0/255/10 (in 100us)	Set Features - Interrupt
coalescing
Io_command_ID_size	2/64K/io_sub_queue_size	(Number of Command ID
entries per io sub queue.)
Max_io_request		1/io_sub_queue_size/io_sub_queue_size (max
outstanding io request per io queue)


Are there any parameters that we should add ?

Thanks

-Kwok



-----Original Message-----
From: linux-nvme-bounces@lists.infradead.org
[mailto:linux-nvme-bounces at lists.infradead.org] On Behalf Of Matthew
Wilcox
Sent: Friday, December 09, 2011 1:38 PM
To: linux-nvme at lists.infradead.org
Subject: TODO list 2011-12-09


Here's the current TODO list that I have.  Thuoght it might be useful
for people who are wonder what still needs doing.  If you have anything
else (public) that you'd like to see changed in the driver, let me know
and I'll add it to the list.

Also, if you happen to be working on any of these features, feel free to
let me know so I can make a note.  Keith's working on #2, which prompted
me to actually post this list.

While these items are numbered ... it's not a strict priority list.

 1. Write an error handler
 2. Add a character device for /dev/nvmeN for devices with no visible
    namespaces (Keith Busch)
 3. Submit Async Event Request commands
 4. Better CPU -> queue mapping
 5. Submit multiple partial I/Os with a single doorbell write  6. Handle
block/VM queue congestion  7. Make kthread per CPU  8. Use the async
mechanism for namespaces  9. MODULE_PARM_DESC for module parameters
(Reported-by: Randy Dunlap) 10. Handle ioremap returning NULL 11. Add
support for SCSI ioctls 12. Decide on a sysfs representation for NVMe
devices 13. Figure out how to support the Range Type partitioning scheme
14. Use a mempool for nvme requests 15. Call completion handlers at
submission time 16. Experiment with interrupt mitigation settings 17.
Let user tune interrupt mitigation through sysfs 18. Use an ida for the
'instance' code 19. Implement DSM Deallocate (ie trim) 20. Get a bi_rw
incompressible bit, set it in ecryptfs & dm_crypt 21. Write PCI error
handling code 22. PCI Suspend/Resume 23. Handle CPU hotplug
(allocate/free queues) 24. Add support for data integrity (DIX) 25.
Investigate amortising SQ and CQ doorbell writes 26. Experiment with
NUMA locality (SQ / CQ local to CPU or to device) 27. Sanity check for
namespace count?
28. make_request may sleep -- should the NVMe driver's do that?
29. Allow the Arbitration feature to be adjusted 30. Implement Security
Send / Receive 31. Investigate other DSM fields 32. Implement NVMe Power
Management 33. Allow for controlling Volatile Write Cache 34. Expose
Write Atomicity to block layer 35. Implement Software Progress 36.
Remove 'process_cq did something' message 37. Add tracepoint support 38.
Allow maximum transfer size and queue depth to be controlled


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://merlin.infradead.org/mailman/listinfo/linux-nvme
