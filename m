From: m@bjorling.me (Matias Bjorling)
Date: Fri, 30 May 2014 21:33:13 +0200
Subject: [PATCH v4] NVMe: basic conversion to blk-mq
In-Reply-To: <alpine.LRH.2.03.1405301027350.11244@AMR>
References: <1401400285-25003-1-git-send-email-m@bjorling.me>
 <1401400285-25003-2-git-send-email-m@bjorling.me>
 <alpine.LRH.2.03.1405301027350.11244@AMR>
Message-ID: <5388DCF9.9000204@bjorling.me>

On 05/30/2014 06:48 PM, Keith Busch wrote:
> On Thu, 29 May 2014, Matias Bj?rling wrote:
>> This converts the current NVMe driver to utilize the blk-mq layer.
> 
> I'm pretty darn sure this new nvme_remove can cause a process
> with an open reference to use queues after they're freed in the
> nvme_submit_sync_command path, maybe even the admin tags too.
> 

You're right. I'll put a fix in v5.

>> @@ -2802,7 +2574,7 @@ static void nvme_remove(struct pci_dev *pdev)
>>     nvme_dev_remove(dev);
>>     nvme_dev_shutdown(dev);
>>     nvme_free_queues(dev, 0);
>> -    rcu_barrier();
>> +    nvme_free_admin_tags(dev);
>>     nvme_release_instance(dev);
>>     nvme_release_prp_pools(dev);
>>     kref_put(&dev->kref, nvme_free_dev);
