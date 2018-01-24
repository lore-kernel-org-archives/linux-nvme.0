From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Wed, 24 Jan 2018 17:54:05 +0800
Subject: do_IRQ: 5.33 No irq handler for vector
In-Reply-To: <20180123221632.GB14790@localhost.localdomain>
References: <06696605-9696-b906-02ca-9ac426722318@oracle.com>
 <20180123221632.GB14790@localhost.localdomain>
Message-ID: <198c6941-5eb8-aca4-e1d1-84d983b39f72@oracle.com>

Hi Keith

Thanks for your kindly response.

On 01/24/2018 06:16 AM, Keith Busch wrote:
> On Tue, Jan 23, 2018@04:16:48PM +0800, jianchao.wang wrote:
>> Hi all
>>
>> I got the log following:
>> [  446.908030] do_IRQ: 5.33 No irq handler for vector
>>
>> When did the following test:
>> loop fio job
>> size=256m
>> rw=randread
>> bs=4k
>> ioengine=libaio
>> iodepth=64
>> direct=1
>> numjobs=16
>> filename=/dev/nvme0n1
>>
>> and
>>  
>> while true
>> do
>>     echo 1 > /sys/block/nvme0n1/device/reset_controller 
>>     sleep 1
>> done
>>
>> The 33 is the vector used by nvmeq2~nvme8 (8 cpus on my machine)
>>
>> When the error log is printed out,  the reset_work is sleeping at
>> nvme_dev_disable
>>   ->nvme_disable_io_queues
>>     -> wait_for_completion_io_timeout
>>
>> In theory, the irq should have been masked by 
>> nvme_suspend_queue
>>   -> pci_free_irq
>>     -> __free_irq //if no other irq_action
>>       -> irq_shutdown
>>         -> __irq_disable
>>           -> mask_irq
>>             -> pci_msi_mask_irq
>>
>> Why it is still there ?
> 
> The message most likely indicates there is no struct irq_desc associated
> with the vector on this CPU.
> 
> Even if the device happens to emit an MSI after we call pci_free_irq, we
> haven't disabled MSI at this point, so the struct irq_desc should still
> exist, even if disabled. Now it looks like this calls stack will get to:
> 
>   __irq_domain_deactivate_irq
>     x86_vector_deactivate
>       clear_irq_vector
Yes.
pci_free_irq will both mask the irq and clear the irq vector.
pci_free_irq
  -> __free_irq //if no other irq_action
    -> irq_shutdown
      -> __irq_disable
        -> mask_irq
          -> pci_msi_mask_irq
      -> irq_domain_deactive_irq
        -> __irq_domain_deactivate_irq
          -> x86_vector_deactivate
            -> clear_irq_vector

Has the MSI been sent out before mask the irq, and interrupted the cpu after
clear the vector ?

> Which sets the vectors desc to VECTOR_UNUSED, or NULL. Maybe we should
> disable the controller before freeing the irqs. 

Yes, this could give the irqs chances to be handled.
And the outstanding requests will be aborted and handled in nvme_irq path.

I tested it and the log was gone.

> We free the irq's first
> because we were tying that to mean a quiesced queue, but that was before
> we had a way to quiesce blk-mq.

Thanks
Jianchao
