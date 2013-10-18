From: m@bjorling.me (=?ISO-8859-1?Q?Matias_Bj=F8rling?=)
Date: Fri, 18 Oct 2013 21:10:22 +0200
Subject: [PATCH 0/3] Convert from bio-based to blk-mq v2
In-Reply-To: <20131018154801.GQ16716@linux.intel.com>
References: <1382102062-22270-1-git-send-email-m@bjorling.me>
 <20131018154801.GQ16716@linux.intel.com>
Message-ID: <5261879E.2020309@bjorling.me>

On 10/18/2013 05:48 PM, Matthew Wilcox wrote:
> On Fri, Oct 18, 2013@03:14:19PM +0200, Matias Bjorling wrote:
>> Performance study:
>>
>> System: HGST Research NVMe prototype, Haswell i7-4770 3.4Ghz, 32GB 1333Mhz
>
> I don't have one of these.  Can you provide more details about it,
> such as:
>   - How many I/O queues does it have?
>   - Are the interrupts correctly bound to the CPUs (for both sets of tests)?
>     The driver isn't allowed to set the irq affinity correctly itself;
>     it can only set a hint and userspace (eg irqbalance) has to set the
>     affinity correctly
>   - Does it support interrupt coalescing?  If so, have you managed to do any
>     testing using that feature?
>

Current impletation is an PCI-e Gen2x4 interface, two I/O queues. One 
for admin and one for all other I/Os. I'll check up on IRQ affinity when 
multiple queues are available. I haven't yet tested interrupt coalescing.
