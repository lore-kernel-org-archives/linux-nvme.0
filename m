From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 22 Oct 2017 13:05:19 +0300
Subject: [PATCH] nvme_fc: avoid workqueue flush stalls
In-Reply-To: <327c6f13-0bd3-5e95-a9e5-d104c561680d@broadcom.com>
References: <20170928165631.16097-1-jsmart2021@gmail.com>
 <01c52881-b172-0d86-5db2-596acf6394db@grimberg.me>
 <327c6f13-0bd3-5e95-a9e5-d104c561680d@broadcom.com>
Message-ID: <56c72dfe-132f-f219-3d50-c7775a84a209@grimberg.me>


>>> There's no need to wait for the full nvme_wq, which is now shared,
>>> to flush. flush only the delete_work item.
>>
>> The patch looks correct, but can you explain what stalled that this
>> patch fixes?
> 
> I don't have an explicit failure case. While reviewing the code for the 
> other stall issue with fatal_err_work, I realized that this flush is now 
> waiting on a work queue shared by everything nvmf.? It used to be solely 
> a nvme-fc transport workqueue. There's no need for waiting on anything 
> more than the delete work item. And having it raise in scope of the nvmf 
> thread perhaps makes it wait for a lot of other unnecessary things - 
> slowing it down.
> 
> If you're ok with it - can you Ack/Review it ?

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
