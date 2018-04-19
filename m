From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Thu, 19 Apr 2018 09:51:16 +0800
Subject: PATCH V4 0/5 nvme-pci: fixes on nvme_timeout and nvme_dev_disable
In-Reply-To: <20180418154032.GA22533@ming.t460p>
References: <1520489971-31174-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180417151700.GC16286@ming.t460p>
 <a6e1de6d-6086-d467-d9ce-641bcd07b983@oracle.com>
 <20180418154032.GA22533@ming.t460p>
Message-ID: <2b985ef5-223f-6a11-45b4-e570c8a93bb3@oracle.com>

Hi Ming

Thanks for your kindly response.

On 04/18/2018 11:40 PM, Ming Lei wrote:
>> Regarding to this patchset, it is mainly to fix the dependency between
>> nvme_timeout and nvme_dev_disable, as your can see:
>> nvme_timeout will invoke nvme_dev_disable, and nvme_dev_disable have to
>> depend on nvme_timeout when controller no response.
> Do you mean nvme_disable_io_queues()? If yes, this one has been handled
> by wait_for_completion_io_timeout() already, and looks the block timeout
> can be disabled simply. Or are there others?
> 
Here is one possible scenario currently

nvme_dev_disable // hold shutdown_lock             nvme_timeout
  -> nvme_set_host_mem                               -> nvme_dev_disable
    -> nvme_submit_sync_cmd                            -> try to require shutdown_lock 
      -> __nvme_submit_sync_cmd
        -> blk_execute_rq
          //if sysctl_hung_task_timeout_secs == 0
          -> wait_for_completion_io
And maybe nvme_dev_disable need to issue other commands in the future.

Even if we could fix these kind of issues as nvme_disable_io_queues, 
it is still a risk I think.

Thanks
Jianchao
