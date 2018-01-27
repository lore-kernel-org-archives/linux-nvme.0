From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Sat, 27 Jan 2018 22:29:30 +0800
Subject: [PATCH] nvme: don't retry request marked as NVME_REQ_CANCELLED
In-Reply-To: <20180127133127.GA19560@ming.t460p>
References: <20180125081023.13303-1-ming.lei@redhat.com>
 <db07601a-e298-3194-9b02-e7077d57e0a3@oracle.com>
 <20180125101503.GA13375@ming.t460p>
 <6749d736-ffdd-7f8d-c50c-58453b054ef8@oracle.com>
 <20180127133127.GA19560@ming.t460p>
Message-ID: <e9456baf-a112-b340-378a-71eeab28f97b@oracle.com>

Hi ming 

Thanks for your detailed response.
That's really appreciated.

On 01/27/2018 09:31 PM, Ming Lei wrote:
>> But nvme_dev_disable may run with nvme_timeout in parallel or race with it.
> But that doesn't mean it is a race, blk_mq_complete_request() can avoid race
> between timeout and other completions, such as cancel.
> Yes, I know blk_mq_complete_request could avoid the a request is accessed by timeout
path and other completion path concurrently. :)
What's I worry about is the timeout path could hold the expired request, so when
nvme_dev_disable return, we cannot ensure all the previous outstanding requests has been
handled. That's really bad. 

>> The best way to fix this is to ensure the timeout path has been completed before cancel the
>> previously outstanding requests. (Just ignore the case where the nvme_timeout will invoke nvme_dev_disable,
>> it has to be fixed by other way.)
> Maybe your approach looks a bit clean and simplify the implementation, but seems
> it isn't necessary.
> 
> So could you explain a bit what the exact issue you are worrying about? deadlock?
> or others?
There is indeed potential issue. But it is in very narrow window.
Please refer to https://lkml.org/lkml/2018/1/19/68

As you said, the approach looks a bit clean and simplify the implementation.
That's what I really want, break the complicated relationship between 
nvme_timeout and nvme_dev_diable. 

Thanks
Jianchao
