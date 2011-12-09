From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 9 Dec 2011 16:37:40 -0500
Subject: TODO list 2011-12-09
Message-ID: <20111209213740.GJ14291@linux.intel.com>


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
 5. Submit multiple partial I/Os with a single doorbell write
 6. Handle block/VM queue congestion
 7. Make kthread per CPU
 8. Use the async mechanism for namespaces
 9. MODULE_PARM_DESC for module parameters (Reported-by: Randy Dunlap)
10. Handle ioremap returning NULL
11. Add support for SCSI ioctls
12. Decide on a sysfs representation for NVMe devices
13. Figure out how to support the Range Type partitioning scheme
14. Use a mempool for nvme requests
15. Call completion handlers at submission time
16. Experiment with interrupt mitigation settings
17. Let user tune interrupt mitigation through sysfs
18. Use an ida for the 'instance' code
19. Implement DSM Deallocate (ie trim)
20. Get a bi_rw incompressible bit, set it in ecryptfs & dm_crypt
21. Write PCI error handling code
22. PCI Suspend/Resume
23. Handle CPU hotplug (allocate/free queues)
24. Add support for data integrity (DIX)
25. Investigate amortising SQ and CQ doorbell writes
26. Experiment with NUMA locality (SQ / CQ local to CPU or to device)
27. Sanity check for namespace count?
28. make_request may sleep -- should the NVMe driver's do that?
29. Allow the Arbitration feature to be adjusted
30. Implement Security Send / Receive
31. Investigate other DSM fields
32. Implement NVMe Power Management
33. Allow for controlling Volatile Write Cache
34. Expose Write Atomicity to block layer
35. Implement Software Progress
36. Remove 'process_cq did something' message
37. Add tracepoint support
38. Allow maximum transfer size and queue depth to be controlled
