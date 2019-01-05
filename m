From: shan.hai@oracle.com (Shan Hai)
Date: Sat, 5 Jan 2019 08:18:55 +0800
Subject: [PATCH 1/2] nvme-pci: add module param for io queue number
In-Reply-To: <20190104180958.GB4642@infradead.org>
References: <1545372253-28025-1-git-send-email-shan.hai@oracle.com>
 <677bfb90-c328-c707-a042-156f17cb426f@acm.org>
 <19ee67dd-c805-f174-94af-bca3aa498677@oracle.com>
 <20190104180958.GB4642@infradead.org>
Message-ID: <b624a0f8-518c-031d-f46d-9582fa992acd@oracle.com>



On 2019/1/5 ??2:09, Christoph Hellwig wrote:
> On Mon, Dec 24, 2018@09:10:41AM +0800, Shan Hai wrote:
>> The problem occurs when offlining CPUs aggressively on a system with large
>> number of cores,
>>
>> for instance offlining 368? out of 384 total cores, the failure of hotplug
>> is caused by device irq migration
>>
>> on cpu hotplugging, the situation becomes worse when there are multiple NVME
>> devices are available
> 
> NVMe uses managed interrupts, which should never be migrated.  What
> exact kernel version do you see this on?
> 

Yes the NVMe itself is not a problem, but there are NIC drivers which have not
adopted the managed interrupts feature and the IRQs will be migrated on hotplug.

The CPU-hotplug failure is because of failed NIC IRQ migration, we can tolerate
smaller NVMe queues which do not harm the performance too much to keep the NIC
intact, but didn't find other ways to set the affinity of the NVMe IRQs.

Thanks
Shan Hai
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 
