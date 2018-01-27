From: ming.lei@redhat.com (Ming Lei)
Date: Sat, 27 Jan 2018 23:44:01 +0800
Subject: [PATCH] nvme: don't retry request marked as NVME_REQ_CANCELLED
In-Reply-To: <e9456baf-a112-b340-378a-71eeab28f97b@oracle.com>
References: <20180125081023.13303-1-ming.lei@redhat.com>
 <db07601a-e298-3194-9b02-e7077d57e0a3@oracle.com>
 <20180125101503.GA13375@ming.t460p>
 <6749d736-ffdd-7f8d-c50c-58453b054ef8@oracle.com>
 <20180127133127.GA19560@ming.t460p>
 <e9456baf-a112-b340-378a-71eeab28f97b@oracle.com>
Message-ID: <20180127154356.GA20712@ming.t460p>

Hi jianchao,

On Sat, Jan 27, 2018@10:29:30PM +0800, jianchao.wang wrote:
> Hi ming 
> 
> Thanks for your detailed response.
> That's really appreciated.
> 
> On 01/27/2018 09:31 PM, Ming Lei wrote:
> >> But nvme_dev_disable may run with nvme_timeout in parallel or race with it.
> > But that doesn't mean it is a race, blk_mq_complete_request() can avoid race
> > between timeout and other completions, such as cancel.
> > Yes, I know blk_mq_complete_request could avoid the a request is accessed by timeout
> path and other completion path concurrently. :)
> What's I worry about is the timeout path could hold the expired request, so when
> nvme_dev_disable return, we cannot ensure all the previous outstanding requests has been
> handled. That's really bad. 
> 
> >> The best way to fix this is to ensure the timeout path has been completed before cancel the
> >> previously outstanding requests. (Just ignore the case where the nvme_timeout will invoke nvme_dev_disable,
> >> it has to be fixed by other way.)
> > Maybe your approach looks a bit clean and simplify the implementation, but seems
> > it isn't necessary.
> > 
> > So could you explain a bit what the exact issue you are worrying about? deadlock?
> > or others?
> There is indeed potential issue. But it is in very narrow window.
> Please refer to https://lkml.org/lkml/2018/1/19/68

OK, follows description from the above link:

>Yes, once controller disabling completes, any started requests will be
>handled and cannot expire. But before the _boundary_, there could be a
>nvme_timeout context runs with nvme_dev_disable in parallel. If a timeout
>path grabs a request, then nvme_dev_disable cannot get and cancel it.
>
>So even though the nvme_dev_disable completes, there still could be a request in nvme_timeout context.
>
>The worst case is :
>nvme_timeout                              nvme_reset_work
>if (ctrl->state == RESETTING )              nvme_dev_disable
>    nvme_dev_disable                        initializing procedure
>
>the nvme_dev_disable run with reinit procedure in nvme_reset_work in parallel.

OK, that is the issue, the nvme_dev_disable() in nvme_timeout() may
disable queues again, and cause hang in nvme_reset_work().

Looks Keith's suggestion of introducing nvme_sync_queues() should be
enough to kill the race, but seems nvme_sync_queues() should have been
called at the entry of nvme_reset_work() unconditionally.


Thanks,
Ming
