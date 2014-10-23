From: asb@cin.ufpe.br (Angelo Brito)
Date: Thu, 23 Oct 2014 10:30:13 -0300
Subject: Questions on Interruption handling
In-Reply-To: <alpine.LNX.2.00.1410221753160.4040@jkbottox-desk>
References: <CAMjVwgThWfs4M0pQy0QpfNONV_hv4rLQGXOPvh-OC9xkyvrHPA@mail.gmail.com>
 <alpine.LNX.2.00.1410221753160.4040@jkbottox-desk>
Message-ID: <CAMjVwgSfRHPQKt0+rh94cmFEfEB1gXR+sv01aHNPxaFDryJUoQ@mail.gmail.com>

Ok Keith,
I presume you meant this:
static irqreturn_t nvme_irq(int irq, void *data)
{
       irqreturn_t result;
       struct nvme_queue *nvmeq = data;
+        u32 maskvec;
+
+        /* We calculate which mask vector we use. */
+        maskvec = 1 << nvmeq->cq_vector;
+
       spin_lock(&nvmeq->q_lock);
+
+       /* We mask interrupts to this vector but not for MSI-X */
+       if(!nvmeq->dev->pci_dev->msix_enabled)
+           writel(maskvec, &nvmeq->dev->bar->intms);
+
       nvme_process_cq(nvmeq);
       result = nvmeq->cqe_seen ? IRQ_HANDLED : IRQ_NONE;
       nvmeq->cqe_seen = 0;
+
+       /* And we unmask interrupt to this vector but not for MSI-X. */
+       if(!nvmeq->dev->pci_dev->msix_enabled)
+           writel(maskvec, &nvmeq->dev->bar->intmc);
+
       spin_unlock(&nvmeq->q_lock);
       return result;
}

Ps: I don't have and MSI-X device to check if that doesn't affect it.
Could you check?


Regards,
Angelo Silva Brito.
Graduate in Engenharia da Computa??o - UFPE
http://about.me/angelobrito
_________________________________________________


On Wed, Oct 22, 2014@3:10 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Wed, 22 Oct 2014, Angelo Brito wrote:
>>
>> Hello all!
>>
>> I had some issues with the Interruption handling. The scenario is as
>> follows:
>> We have a NVMe Device with single MSI enabled and some of its
>> transfers took about 1000 jiffies (ms) to execute. We saw this when we
>> used IOMeter to benchmark a NVMe controller and we noticed that about
>> 1 in 10 commands took much longer than expected. When we traced
>> through the kernel code we tracked the issue to come from the nvme_irq
>> function. In most cases, it is triggered by the interrupts and all
>> CQEs in the queue are processed correctly. In some cases, though, we
>> found out that a new CQE arrived while the nvme_irq function was
>> processing previous entries or just after the CQ doorbell has been
>> sent. These entries were overlooked by the driver and picked up later
>> by the nvme_kthread function, which reexecutes the nvme_process_cq
>> function once every second.
>>
>> We read the NVMe specification 1.1 section 7.5.1.1 and noticed that it
>> defined a procedure to not loose any interrupts in a Legacy or MSI
>> system. The Host Software Interrupt Handling should mask and clear the
>> interruptions by using the INTMS and INTMC registers. We are proposing
>> a change to the nvme_irq function as described below. This is probably
>> not needed on MSI-X enabled devices but it is harmless to leave it in
>> for them as well.
>
>
> I don't think you can't really assume it's harmless. It adds two
> unnecessary MMIO writes on every interrupt, and the spec says undefined
> results if you touch those registers when configured with MSI-x, so
> please change this to affect only MSI and INTx.
>
>
>> So we modified the nvme_irq function and tested it on our controller
>> and the problem was fixed. Below annexed is the modified code, since
>> we don't know how to submit it. Sorry about that.
>>
>> static irqreturn_t nvme_irq(int irq, void *data)
>> {
>>        irqreturn_t result;
>>        struct nvme_queue *nvmeq = data;
>> +        u32 maskvec;
>> +
>> +        /* We calculate which mask vector we use. */
>> +        maskvec = 1 << nvmeq->cq_vector;
>> +
>>        spin_lock(&nvmeq->q_lock);
>> +
>> +       /* We mask interrupts to this vector. */
>> +        writel(maskvec, &nvmeq->dev->bar->intms);
>> +
>>        nvme_process_cq(nvmeq);
>>        result = nvmeq->cqe_seen ? IRQ_HANDLED : IRQ_NONE;
>>        nvmeq->cqe_seen = 0;
>> +
>> +       /* And we unmask interrupt to this vector. */
>> +        writel(maskvec, &nvmeq->dev->bar->intmc);
>> +
>>        spin_unlock(&nvmeq->q_lock);
>>        return result;
>> }
