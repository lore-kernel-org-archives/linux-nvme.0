From: keith.busch@intel.com (Keith Busch)
Date: Thu, 12 Feb 2015 15:25:26 +0000 (UTC)
Subject: [PATCH] NVMe: Async probe
In-Reply-To: <005001d046d3$7f94b400$7ebe1c00$@samsung.com>
References: <1423703475-21794-1-git-send-email-keith.busch@intel.com>
 <1423703475-21794-2-git-send-email-keith.busch@intel.com>
 <005001d046d3$7f94b400$7ebe1c00$@samsung.com>
Message-ID: <alpine.LNX.2.00.1502121509040.15481@localhost.lm.intel.com>

On Thu, 12 Feb 2015, Indraneel Mukherjee wrote:
>>  static void nvme_reset_notify(struct pci_dev *pdev, bool prepare) @@
> -2902,6
>> +2906,7 @@ static void nvme_remove(struct pci_dev *pdev)
>>  	spin_unlock(&dev_list_lock);
>>
>>  	pci_set_drvdata(pdev, NULL);
>> +	async_synchronize_cookie(dev->probe_cookie);
>
> Keith, I think this may not work. All asynchronous functions called prior to
> the one identified by cookie
> are guaranteed to have completed. The current one is not.

Huh, so it is. That rules out asynchronous_schedule as being useful
here. Workqueues FTW, then.

> And I just remembered Matthew's feedback on one of the previous attempts at
> asynchronous probe.
> We should be able to rmmod the driver during probe if suppose there are a
> million namespaces.
> Is there any plan to address such scenarios?

This idea would have allowed that if sync cookie worked like I'd
thought. The rmmod would just synchronize with the namespace discovery
first. I think we can use the global work queue and flush individual
work items in the remove path.
