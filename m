From: kim1158@gmail.com (Kim Kyungsan)
Date: Thu, 4 Feb 2016 01:14:29 +0900
Subject: NVMe and IRQ Affinity
In-Reply-To: <CACo6K_Zry4303xcvjoqMCCnzmxAVrWgT1+JPWGqXObGu9LnU1g@mail.gmail.com>
References: <CACo6K_bSDJwt61mnKDpYvcXjCVA9UKGO17pythzcJ8Rnjh19sA@mail.gmail.com>
 <20160202234540.GA21046@localhost.localdomain>
 <CACo6K_YGiH2ER4s21OzmD69LDL+ES0PO54jJ_efcSFw7pHADvQ@mail.gmail.com>
 <20160202235818.GB21046@localhost.localdomain>
 <CACo6K_Zry4303xcvjoqMCCnzmxAVrWgT1+JPWGqXObGu9LnU1g@mail.gmail.com>
Message-ID: <CAARenASB5+vdwBGq7iwrYLur6MzGSdvK0xX81K3GUU0dmtMYCg@mail.gmail.com>

Hi, I had a similar experience from nvme interrupts.
As you said, kernel basically allocates cpu0 for interrupt handling.
Without setting irq affinity or irqbalance daemon, it could cause the
decrease in performance and soft-lock CPU bug.
The symptom was noticed on systems under high workload with multiple
nvme devices.

How we solved was that setting irq affinity to evenly distribute cpus
to handle interrupts from an IRQ like below.

       Cpu0 - nvme irq0
       Cpu1 - nvme irq1
       Cpu2 - nvme irq2
       Cpu3 - nvme irq3
       Cpu4 - nvme irq4
       Cpu5 - nvme irq5
       Cpu6 - nvme irq6
       Cpu7 - nvme irq7
       ....

And there are two ways to set irq affinity. First one is using proc
interface as you mentioned, another one is using inbox driver higher
than kernel 4.3 . In fact, nvme driver under 4.3 kernel also tried to
set irq affinity hint during device initialization, however, it hadn't
worked due to a bug which is fixed by Keith Busch on 4.3 kernel.
>From kernel 4.3, nvme driver sets irq affinity as well as
affinity_hint during device initialization by calling
irq_set_affinity_hint()

Please refer below.

/* kernel 4.3 nvme-core.c */
nvme_dev_scan()
     + nvme_set_irq_hints()
         +irq_set_affinity_hint(dev->entry[nvmeq->cq_vector].vector,
blk_mq_tags_cpumask(*nvmeq->tags));


/* kernel/irq/manage.c */
int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m)
{
        unsigned long flags;
        struct irq_desc *desc = irq_get_desc_lock(irq, &flags,
IRQ_GET_DESC_CHECK_GLOBAL);

         if (!desc)
                return -EINVAL;
        desc->affinity_hint = m;
        irq_put_desc_unlock(desc, flags);
        /* set the initial affinity to prevent every interrupt being on CPU0 */
        if (m)
               __irq_set_affinity(irq, m, false);
        return 0;
}
EXPORT_SYMBOL_GPL(irq_set_affinity_hint);

The last thing i want to note is you better disable irqbalance daemon
after setting irq affinity by yourself because the daemon adjust irq
affinity again which can cause unbalanced interrupts handling again.


On Wed, Feb 3, 2016 at 9:13 AM, Mark Jacobson
<mark_jacobson@stackvelocity.com> wrote:
> In that case, please forgive the silly questions, as I am not an
> experienced kernel developer by any means...  (I'm just looking for
> enough information go Googling. I won't ask much more down that line
> of questioning, as I know this list is not for that purpose.)
>
> 1. When you say out-of-tree, do you mean a loadable kernel module?
> (My understanding is that the NVMe driver is now part of the mainline
> Linux kernel source tree, so I'm a bit confused as to where to nab
> that from.)
> 2. Does the upstream 4.4.1 kernel have any of these fixes if I were to
> build it myself with the appropriate support ticked off?
>
> Also, thank you very much for the quick response and assistance. I
> really appreciate the help. :)
> Thank you,
>
> Mark Jacobson
> Software Test Engineer
> Stack Velocity
>
>
> On Wed, Feb 3, 2016@12:58 AM, Keith Busch <keith.busch@intel.com> wrote:
>> On Wed, Feb 03, 2016@12:50:06AM +0100, Mark Jacobson wrote:
>>> Output is below. I'm aware the distro hints are fairly invalid.
>>
>> They're all invalid. This kernel must have forked before the affinity
>> hints were fixed for a blk-mq nvme driver. A more optimal affinity hint
>> would match the mq's cpu_list, which is how it looks upstream.
>>
>> I guess your platform strongly prefers CPU 0 when allowed. You can
>> either manually override the smp_affinity, use an out-of-tree driver
>> with a fix and let irqbalance handle it.
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme



-- 
------------------------------------------------------------
the person who practices a truth goes toward light.
