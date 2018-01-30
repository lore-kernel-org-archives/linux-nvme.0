From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Tue, 30 Jan 2018 11:41:07 +0800
Subject: [PATCH] nvme-pci: use NOWAIT flag for nvme_set_host_mem
In-Reply-To: <20180129201716.GB25515@localhost.localdomain>
References: <1517195255-21832-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180129160145.GA25515@localhost.localdomain>
 <1b7d3700-945f-9272-b6aa-d2ebeaf0cb1e@grimberg.me>
 <20180129201716.GB25515@localhost.localdomain>
Message-ID: <c3116e1b-481a-1b3f-b29c-7de95929ecb8@oracle.com>

Hi Keith and Sagi

Thanks for your kindly response. :)

On 01/30/2018 04:17 AM, Keith Busch wrote:
> On Mon, Jan 29, 2018@09:55:41PM +0200, Sagi Grimberg wrote:
>>> Thanks for the fix. It looks like we still have a problem, though.
>>> Commands submitted with the "shutdown_lock" held need to be able to make
>>> forward progress without relying on a completion, but this one could
>>> block indefinitely.
>>
>> Can you explain to me why is the shutdown_lock needed to synchronize
>> nvme_dev_disable? More concretely, how is nvme_dev_disable different
>> from other places where we rely on the ctrl state to serialize stuff?
>>
>> The only reason I see would be to protect against completion-after-abort
>> scenario but I think the block layer should protect against it (checks
>> if the request timeout timer fired).
> 
> We can probably find a way to use the state machine for this. Disabling
> the controller pre-dates the state machine, and the mutex is there to
> protect against two actors shutting the controller down at the same
> time, like a hot removal at the same time as a timeout handling reset.
> 

Another point that confuses me is that whether nvme_set_host_mem is necessary
in nvme_dev_disable ?
As the comment:
----
		/*
		 * If the controller is still alive tell it to stop using the
		 * host memory buffer.  In theory the shutdown / reset should
		 * make sure that it doesn't access the host memoery anymore,
		 * but I'd rather be safe than sorry..
		 */
		if (dev->host_mem_descs)
			nvme_set_host_mem(dev, 0);
----
It is to avoid accessing to host memory from controller. But the host memory is just
freed when nvme_remove. It looks like we just need to do this in nvme_remove.
For example:
-----
@@ -2553,6 +2545,14 @@ static void nvme_remove(struct pci_dev *pdev)
        flush_work(&dev->ctrl.reset_work);
        nvme_stop_ctrl(&dev->ctrl);
        nvme_remove_namespaces(&dev->ctrl);
+       /*
+        * If the controller is still alive tell it to stop using the
+        * host memory buffer.  In theory the shutdown / reset should
+        * make sure that it doesn't access the host memoery anymore,
+        * but I'd rather be safe than sorry..
+        */
+       if (dev->host_mem_descs)
+               nvme_set_host_mem(dev, 0);
        nvme_dev_disable(dev, true);
        nvme_free_host_mem(dev);
----

If anything missed, please point out.
That's really appreciated.

Sincerely
Jianchao
