From: ks0204.kim@samsung.com (=?ks_c_5601-1987?B?seiw5rvq?=)
Date: Thu, 10 Sep 2015 19:25:54 +0900
Subject: setting nvme irq per cpu affinity in device driver
References: <003c01d0e569$dd9a7b40$98cf71c0$@samsung.com>
 <20150902140517.GA9787@infradead.org>
 <000001d0e87a$ec9905d0$c5cb1170$@samsung.com>
 <20150907175423.GA27381@infradead.org>
Message-ID: <00bb01d0ebb3$1310b600$39322200$@samsung.com>

I've confirmed that current irq_set_affinity_hint() implementation has
already been fixed to set affinity internally.
When the patch that Keith Busch has summited merged, I believe we can close
this  issue with no more modification in device driver.
Only suggestion is we need to remain somewhere in kernel document, to guide
system administrator to control irqbalance not to overwrite nvme affinity. 



/* irq_set_affinity_hint() : manage.c */ 
int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m) {
        unsigned long flags;
        struct irq_desc *desc = irq_get_desc_lock(irq, &flags,
IRQ_GET_DESC_CHECK_GLOBAL);

        if (!desc)
                return -EINVAL;
        desc->affinity_hint = m;
        irq_put_desc_unlock(desc, flags);
        /* set the initial affinity to prevent every interrupt being on
CPU0 */
        if (m)
                __irq_set_affinity(irq, m, false);
        return 0;
}

commit e2e64a932556cdfae455497dbe94a8db151fc9fa
Author: Jesse Brandeburg <jesse.brandeburg at intel.com>
Date:   Thu Dec 18 17:22:06 2014 -0800

    genirq: Set initial affinity in irq_set_affinity_hint()

    Problem:
    The default behavior of the kernel is somewhat undesirable as all
    requested interrupts end up on CPU0 after registration.  A user can
    run irqbalance daemon, or can manually configure smp_affinity via the
    proc filesystem, but the default affinity of the interrupts for all
    devices is always CPU zero, this can cause performance problems or
    very heavy cpu use of only one core if not noticed and fixed by the
    user.

    Solution:
    Enable the setting of the initial affinity directly when the driver
    sets a hint.

    This enabling means that kernel drivers can include an initial
    affinity setting for the interrupt, instead of all interrupts starting
    out life on CPU0. Of course if irqbalance is still running then the
    interrupts will get moved as before.

    This function is currently called by drivers in block, crypto,
    infiniband, ethernet and scsi trees, but only a handful, so these will
    be the devices affected by this change.


-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf
Of 'Christoph Hellwig'
Sent: Tuesday, September 08, 2015 2:54 AM
To: ??????
Cc: 'Christoph Hellwig'; Linux-nvme at lists.infradead.org
Subject: Re: setting nvme irq per cpu affinity in device driver

On Sun, Sep 06, 2015@05:06:24PM +0900, ?????? wrote:
> Hi Christoph Hellwig,
> 
> I'd like to know the plan to provide the API from irq sybsystem.
> Let me kindly ask you to how can I get to know the status.
> Do you think should I need to contact to the irq maintainer? 

The plan in still vague.  I'd suggest you kick start the discussion by
submitting a patch that adds the code you suggest into a helper in
kernel/irq/manage.c.

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
