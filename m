From: azher@hep.caltech.edu (Azher Mughal)
Date: Wed, 25 Jun 2014 11:15:23 -0700
Subject: Kernel 3.10.0  with nvme-compatibility driver
In-Reply-To: <alpine.LRH.2.03.1406250826390.4699@AMR>
References: <53AADAE5.4050401@hep.caltech.edu>
 <alpine.LRH.2.03.1406250826390.4699@AMR>
Message-ID: <53AB11BB.1040808@hep.caltech.edu>

Thanks for the tips. Yes all drives are in the Gen3 slots.

Much better and steady throughput per drive. Less CPU usage this time.
http://www.ultralight.org/~azher/nvme/2ddperdrive-withoflag.png

-Azher


On 6/25/2014 8:39 AM, Keith Busch wrote:
> Hi Azher,
>
> On Wed, 25 Jun 2014, Azher Mughal wrote:
>> I just started playing with Intel NVME PCIe cards and trying to optimize
>> system performance. I am using RHEL7, kernel 3.10 and the
>> nvme-compatibility drivers due to the fact that Mellanox software
>> distribution don't support kernel 3.15 at the moment.
>
> RHEL 7.0 has an included nvme driver that is a bit ahead of the
> nvme-compatibility version. I'd recommend using that one.
>
>> Server has dual E5-2690 v2 processors and 64GB RAM. The aim is to
>> design a server which can match WAN transfer at 100Gbps by writing on
>> the nvme drives.
>
> Looks like you're pushing 80% of the way there already!
>
> Depending on what capacity drive and series you're using, you may be able
> to get up to 1900MB/s according to the product brief on intel.com for
> sustainted write performance, so I think there is some room to improve
> your numbers.
>
>> The maximum performance I have seen is about 1.4GB/sec per drive running
>> in parallel over 6 drives. I plan to add a total of 10 drives. In these
>> tests, dd is used  "dd if=/dev/zero of=/nvme$i/$file.dump count=700000
>> bs=4096k". Graphs in below URLS are created from output by dstat:
>
> You're running single depth sequential writes through the page cache
> and a filesystem. You should get more stable performance if you add
> "oflag=direct". You may get even better if you use higher depths. Maybe
> try fio instead.
>
> Also, can you verify what PCI-e link speed you're devices are running?
>
>> Since the idle CPU is already at 40%, so I wonder what will happen when
>> adding 4 more drives. So my questions are:
>
> Adding more drives should scale performance fairly linearly until you
> have multiple devices behind the same PCI-e switch.
>
>> 1. How to force drivers and kernel to keep nvme driver on just one
>> socket and let the kernel use the other processor for WAN transfer using
>> Mellanox and TCP overheads ?
>
> You can pin processes to cores using 'taskset' and pin interrupts using
> 'irqbalance' (or you can do that manually).
>
>> 2. Kernel optimizations to reduce the nvme CPU usage ? With current
>> driver, I cannot change scheduler and nr_requests.
>
> This block driver hooks into a layer where those options are not
> available.
>
>> 3. Data write per drive is not steady, what could be the reason ?
>
> At least part of this is that you're not using O_DIRECT.
>
>> Any suggestions / help would be appreciated.
>
> Feel free to contact me directly if you need more details on any thing
> above or otherwise.
>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 2ddperdrive-withoflag.png
Type: image/png
Size: 22958 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20140625/d464b087/attachment-0001.png>
