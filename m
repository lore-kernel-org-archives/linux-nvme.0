From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Wed, 28 Feb 2018 10:53:31 +0800
Subject: [PATCH] nvme-pci: assign separate irq vectors for adminq and ioq0
In-Reply-To: <20180227151311.GD10832@localhost.localdomain>
References: <1519721177-2099-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180227151311.GD10832@localhost.localdomain>
Message-ID: <9252f0a1-f3e5-414b-db49-e8053dfa48a6@oracle.com>

Hi Keith

Thanks for your precious time to review this.

On 02/27/2018 11:13 PM, Keith Busch wrote:
> On Tue, Feb 27, 2018@04:46:17PM +0800, Jianchao Wang wrote:
>> Currently, adminq and ioq0 share the same irq vector. This is
>> unfair for both amdinq and ioq0.
>>  - For adminq, its completion irq has to be bound on cpu0.
>>  - For ioq0, when the irq fires for io completion, the adminq irq
>>    action has to be checked also.
> 
> This change log could use some improvements. Why is it bad if admin
> interrupts affinity is with cpu0?

adminq interrupts should be able to fire everywhere.
do we have any reason to bound it on cpu0 ?

> 
> Are you able to measure _any_ performance difference on IO queue 1 vs IO
> queue 2 that you can attribute to IO queue 1's sharing vector 0?

Actually, I didn't get any performance improving on my own NVMe card.
But it may be needed on some enterprise card, especially the media is persist memory.
nvme_irq will be invoked twice when ioq0 irq fires, this will introduce another unnecessary DMA
accessing on cq entry.

>  
>> @@ -1945,11 +1947,11 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
>>  	 * setting up the full range we need.
>>  	 */
>>  	pci_free_irq_vectors(pdev);
>> -	nr_io_queues = pci_alloc_irq_vectors(pdev, 1, nr_io_queues,
>> -			PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY);
>> -	if (nr_io_queues <= 0)
>> +	ret = pci_alloc_irq_vectors_affinity(pdev, 1, (nr_io_queues + 1),
>> +			PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
>> +	if (ret <= 0)
>>  		return -EIO;
>> -	dev->max_qid = nr_io_queues;
>> +	dev->max_qid = ret - 1;
> 
> So controllers that have only legacy or single-message MSI don't get any
> IO queues?
> 

Yes. At the moment, we have to share the only one irq vector.

Thanks for your directive. :)
Jianchao
