From: m@bjorling.me (=?UTF-8?Q?Matias_Bj=c3=b8rling?=)
Date: Mon, 2 Jan 2017 22:06:14 +0100
Subject: [LSF/MM TOPIC][LSF/MM ATTEND] OCSSDs - SMR, Hierarchical Interface,
 and Vector I/Os
Message-ID: <05204e9d-ed4d-f97a-88f0-41b5e008af43@bjorling.me>

Hi,

The open-channel SSD subsystem is maturing, and drives are beginning to 
become available on the market. The open-channel SSD interface is very 
similar to the one exposed by SMR hard-drives. They both have a set of 
chunks (zones) exposed, and zones are managed using open/close logic. 
The main difference on open-channel SSDs is that it additionally exposes 
multiple sets of zones through a hierarchical interface, which covers a 
numbers levels (X channels, Y LUNs per channel, Z zones per LUN).

Given that the SMR interface is similar to OCSSDs interface, I like to 
propose to discuss this at LSF/MM to align the efforts and make a clear 
path forward:

1. SMR Compatibility

Can the SMR host interface be adapted to Open-Channel SSDs? For example, 
the interface may be exposed as a single-level set of zones, which 
ignore the channel and lun concept for simplicity. Another approach 
might be to extend the SMR implementation sysfs entries to expose the 
hierarchy of the device (channels with X LUNs and each luns have a set 
of zones).

2. How to expose the tens of LUNs that OCSSDs have?

An open-channel SSDs typically has 64-256 LUNs that each acts as a 
parallel unit. How can these be efficiently exposed?

One may expose these as separate namespaces/partitions. For a DAS with 
24 drives, that will be 1536-6144 separate LUNs to manage. That many 
LUNs will blow up the host with gendisk instances. While if we do, then 
we have an excellent 1:1 mapping between the SMR interface and the OCSSD 
interface.

On the other hand, one could expose the device LUNs within a single LBA 
address space and lay the LUNs out linearly. In that case, the block 
layer may expose a variable that enables applications to understand this 
hierarchy. Mainly the channels with LUNs. Any warm feelings towards this?

Currently, a shortcut is taken with the geometry and hierarchy, which 
expose it through the /lightnvm sysfs entries. These (or a type thereof) 
can be moved to the block layer /queue directory.

If keeping the LUNs exposed on the same gendisk, vector I/Os becomes a 
viable path:

3. Vector I/Os

To derive parallelism from an open-channel SSD (and SSDs in parallel), 
one need to access them in parallel. Parallelism is achieved either by 
issuing I/Os for each LUN (similar to driving multiple SSDs today) or 
using a vector interface (encapsulating a list of LBAs, length, and data 
buffer) into the kernel. The latter approach allows I/Os to be 
vectorized and sent as a single unit to hardware.

Implementing this in generic block layer code might be overkill if only 
open-channel SSDs use it. I like to hear other use-cases (e.g., 
preadv/pwritev, file-systems, virtio?) that can take advantage of 
vectored I/Os. If it makes sense, then which level to implement: 
bio/request level, SGLs, or a new structure?

Device drivers that support vectored I/Os should be able to opt into the 
interface, while the block layer may automatically roll out for device 
drivers that don't have the support.

What has the history been in the Linux kernel about vector I/Os? What 
have reasons in the past been that such an interface was not adopted?

I will post RFC SMR patches before LSF/MM, such that we have a firm 
ground to discuss how it may be integrated.

-- Besides OCSSDs, I also like to participate in the discussions of 
XCOPY, NVMe, multipath, multi-queue interrupt management as well.

-Matias
