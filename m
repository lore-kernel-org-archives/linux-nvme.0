From: azher@hep.caltech.edu (Azher Mughal)
Date: Mon, 01 Jun 2015 16:28:44 -0700
Subject: NVMe scalability issue
In-Reply-To: <alpine.LNX.2.00.1506012254500.15930@localhost.lm.intel.com>
References: <1433199171.7699.22.camel@ssi>
 <alpine.LNX.2.00.1506012254500.15930@localhost.lm.intel.com>
Message-ID: <556CEAAC.6040206@hep.caltech.edu>

I ran some tests last year before SC using 8 drives in a SuperMicro
server. Please see attached. OS was CentOS 6.5 I think.

-Azher

On 6/1/2015 4:02 PM, Keith Busch wrote:
> On Mon, 1 Jun 2015, Ming Lin wrote:
>> Hi list,
>>
>> I'm playing with 8 high performance NVMe devices on a 4 sockets server.
>> Each device can get 730K 4k read IOPS.
>>
>> Kernel: 4.1-rc3
>> fio test shows it doesn't scale well with 4 or more devices.
>> I wonder any possible direction to improve it.
>
> There was a demo at SC'14 with a heck of a lot more NVMe drives than
> that,
> and performance scaled quite linearly. Are your devices sharing PCI-e
> lanes?
>
> You could try setting "cpus_allowed" on each job to the CPU's on the
> socket local to the nvme device. That should get a measurable
> improvement,
> and if your irq's are appropriately affinitized.
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: 8drives-dd-SC9.PNG
Type: image/png
Size: 83980 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20150601/814c0441/attachment-0001.png>
