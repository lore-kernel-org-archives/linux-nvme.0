From: keith.busch@intel.com (Keith Busch)
Date: Mon, 8 Dec 2014 19:03:19 +0000 (UTC)
Subject: NVM Express 1.2 - Controller Memory Buffer Functionality.
In-Reply-To: <36F6EBABA23FEF4391AF72944D2289016EC901E8@BBYEXM01.pmc-sierra.internal>
References: <36F6EBABA23FEF4391AF72944D2289016EC8C680@BBYEXM01.pmc-sierra.internal>,
 <alpine.LNX.2.00.1412042256430.4225@localhost.lm.intel.com>
 <75526C13-EF09-4050-855B-CA71DD60A290@pmcs.com>
 <alpine.LNX.2.00.1412050022300.4225@localhost.lm.intel.com>
 <36F6EBABA23FEF4391AF72944D2289016EC8CFE6@BBYEXM01.pmc-sierra.internal>
 <5481B13D.6050805@itu.dk>
 <alpine.LNX.2.00.1412052312100.4225@localhost.lm.intel.com>
 <36F6EBABA23FEF4391AF72944D2289016EC901E8@BBYEXM01.pmc-sierra.internal>
Message-ID: <alpine.LNX.2.00.1412081847030.3973@localhost.lm.intel.com>

On Mon, 8 Dec 2014, Stephen Bates wrote:
> Keith
>
> Fun distractions can be a good thing ;-). Thanks for making that update to QEMU and for sending on your initial driver changes. I cloned your version of the QEMU tree and have it up and running on a local server. Are you OK with my adding some flexibility to the size of the CMB (for testing purposes)?

Make whatever changes you like. I was going for a hastily thrown together
proof-of-concept than actually making it universally useful, so feel
free to send me a patch if you've got an enhancment.

> Also would you mind sending me an example of how you call QEMU when testing NVMe, (there seems to be a lot of QEMU options)?

There are a lot of options. Here's a basic command I can run for nvme
with the CMB feature enabled:

   # ./x86_64-softmmu/qemu-system-x86_64 -m 2048 --enable-kvm /vms/linux.img \
     -drive file=/vms/nvme.img,if=none,id=foo -device nvme,drive=foo,serial=foobar,cmb=1

Above, I have a linux distro installed in the "linux.img" file, which
qemu will use as my boot drive.

The "nvme" device is tied to the "drive" identified as "foo", which is
associated to the "nvme.img" file. The nvme device carves that image
into namespaces.

The "cmb=1" option enables the feature by allocating an exlusive BAR for
general purpose controller side memory.

Clear as mud?

> Also is there any open-source code for regression testing of the NVMe driver? I would hate to make some proposed changes only to find I have broken something simple that could have been caught via a simple regression test.

Nothing public that I know of. If you can successfully run xfstests,
you're probably okay.

> Cheers
> Stephen
>
> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On Behalf Of Keith Busch
> Sent: Friday, December 5, 2014 4:29 PM
> To: Matias Bj?rling
> Cc: linux-nvme at lists.infradead.org
> Subject: Re: NVM Express 1.2 - Controller Memory Buffer Functionality.
>
> I'm probably going to get yelled at for doing this instead of what I'm supposed to be doing, but sometimes fun distractions are fun!
>
> The QEMU part of CMB is applied in the my tree, as well as a few fixes for other merges I messed up. This is the CMB feature:
>
> http://git.infradead.org/users/kbusch/qemu-nvme.git/commitdiff/aee710c5ce4acb11583b85bc7f1c6ba8bea155d5
>
> I was a bit lazy with it, using an exlusive BAR for controller memory fixed at 128M. I'm also led to believe I'm violating proper MemoryRegion usage by reading "private" values, but I don't see how else to do it!
>
> Here's an qemu example parameters to set up your device for CMB:
>
>   -drive file=<nvme.img>,if=none,id=foo -device nvme,drive=foo,serial=baz,cmb=1
>
> I did have to write some driver bits to test (copied below), but again, I was lazy and didn't do it the "right" way. Everything's hard-coded to match the hard-coded values on the controller side. The only CMB use below is allocating the Admin SQ and CQ out of the CMB. This is definitely going to be slower on QEMU, so don't even try to do performance comparisons. :)
>
> ---
> diff -ur /drivers/block/nvme-core.c /drivers/block/nvme-core.c
> --- /drivers/block/nvme-core.c	2014-12-05 15:28:53.662943237 -0700
> +++ /drivers/block/nvme-core.c	2014-12-05 15:41:15.760944823 -0700
> @@ -1154,10 +1154,12 @@
>  	}
>  	spin_unlock_irq(&nvmeq->q_lock);
>
> -	dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
> +	if (nvmeq->qid || !nvmeq->dev->ctrl_mem) {
> +		dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
>  				(void *)nvmeq->cqes, nvmeq->cq_dma_addr);
> -	dma_free_coherent(nvmeq->q_dmadev, SQ_SIZE(nvmeq->q_depth),
> +		dma_free_coherent(nvmeq->q_dmadev, SQ_SIZE(nvmeq->q_depth),
>  					nvmeq->sq_cmds, nvmeq->sq_dma_addr);
> +	}
>  	kfree(nvmeq);
>  }
>
> @@ -1209,16 +1211,23 @@
>  	if (!nvmeq)
>  		return NULL;
>
> -	nvmeq->cqes = dma_alloc_coherent(dmadev, CQ_SIZE(depth),
> -					&nvmeq->cq_dma_addr, GFP_KERNEL);
> -	if (!nvmeq->cqes)
> -		goto free_nvmeq;
> -	memset((void *)nvmeq->cqes, 0, CQ_SIZE(depth));
> +	if (qid || !dev->ctrl_mem) {
> +		nvmeq->cqes = dma_alloc_coherent(dmadev, CQ_SIZE(depth),
> +				&nvmeq->cq_dma_addr, GFP_KERNEL);
> +		if (!nvmeq->cqes)
> +			goto free_nvmeq;
>
> -	nvmeq->sq_cmds = dma_alloc_coherent(dmadev, SQ_SIZE(depth),
> +		nvmeq->sq_cmds = dma_alloc_coherent(dmadev, SQ_SIZE(depth),
>  					&nvmeq->sq_dma_addr, GFP_KERNEL);
> -	if (!nvmeq->sq_cmds)
> -		goto free_cqdma;
> +		if (!nvmeq->sq_cmds)
> +			goto free_cqdma;
> +	} else {
> +		nvmeq->sq_dma_addr = pci_resource_start(dev->pci_dev, 2);
> +		nvmeq->sq_cmds = dev->ctrl_mem;
> +		nvmeq->cq_dma_addr = pci_resource_start(dev->pci_dev, 2) + 0x1000;
> +		nvmeq->cqes = dev->ctrl_mem + 0x1000;
> +	}
> +	memset((void *)nvmeq->cqes, 0, CQ_SIZE(depth));
>
>  	nvmeq->q_dmadev = dmadev;
>  	nvmeq->dev = dev;
> @@ -2085,6 +2094,8 @@
>  	dev->db_stride = NVME_CAP_STRIDE(readq(&dev->bar->cap));
>  	dev->dbs = ((void __iomem *)dev->bar) + 4096;
>
> +	if (readl(&dev->bar->cmbsz) || 0)
> +		dev->ctrl_mem = ioremap(pci_resource_start(pdev, 2), 0x8000000);
>  	return 0;
>
>   disable:
> diff -ur /include/linux/nvme.h /include/linux/nvme.h
> --- /include/linux/nvme.h	2014-01-14 11:05:25.000000000 -0700
> +++ /include/linux/nvme.h	2014-12-05 10:35:10.059748463 -0700
> @@ -36,6 +36,8 @@
>  	__u32			aqa;	/* Admin Queue Attributes */
>  	__u64			asq;	/* Admin SQ Base Address */
>  	__u64			acq;	/* Admin CQ Base Address */
> +	__u32			cmbloc;	/* Controller memory buffer location */
> +	__u32			cmbsz;	/* Controller memory buffer size */
>  };
>
>  #define NVME_CAP_MQES(cap)	((cap) & 0xffff)
> @@ -84,6 +86,7 @@
>  	u32 ctrl_config;
>  	struct msix_entry *entry;
>  	struct nvme_bar __iomem *bar;
> +	volatile void __iomem *ctrl_mem;
>  	struct list_head namespaces;
>  	struct kref kref;
> --
>
> On Fri, 5 Dec 2014, Matias Bj?rling wrote:
>> Hi Stephen,
>>
>> The tree is here:
>>
>>  http://git.infradead.org/users/kbusch/qemu-nvme.git
>>
>> Cheers,
>> Matias
>>
>> On 12/05/2014 10:02 AM, Stephen Bates wrote:
>>> Keith
>>>
>>> " I often implement h/w features on a virtual device if real h/w is
>>> not available. If you're interested, I'll add CMB to my QEMU tree
>>> sometime in the next week."
>>>
>>> That would be great. Can you send a link to that tree?
>>>
>>> Cheers
>>>
>>> Stephen
>>>
>>> -----Original Message-----
>>> From: Keith Busch [mailto:keith.busch at intel.com]
>>> Sent: Friday, December 5, 2014 8:31 AM
>>> To: Stephen Bates
>>> Cc: Keith Busch; linux-nvme at lists.infradead.org
>>> Subject: Re: NVM Express 1.2 - Controller Memory Buffer Functionality.
>>>
>>> On Thu, 4 Dec 2014, Stephen Bates wrote:
>>>> Keith
>>>>
>>>> Ah, very much a case of "be careful what you ask for" ;-). OK I will
>>>> start to look at this soon.  One issue I can forsee is lack of 1.2
>>>> compliant drives to do testing on. Does anyone have any ideas how
>>>> best to handle that?
>>>
>>> I often implement h/w features on a virtual device if real h/w is not
>>> available. If you're interested, I'll add CMB to my QEMU tree
>>> sometime in the next week.
>>>
>>>> Cheers
>>>> Stephen
>>>
>>> _______________________________________________
>>> Linux-nvme mailing list
>>> Linux-nvme at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-nvme
>>>
>>
>> _______________________________________________
>> Linux-nvme mailing list
>> Linux-nvme at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-nvme
>>
>
