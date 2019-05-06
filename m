From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Tue, 7 May 2019 00:07:47 +0900
Subject: [PATCH] nvme-loop: Fix race between completions and shutdown
In-Reply-To: <20190506145327.GA2164@localhost.localdomain>
References: <20190506145203.2851-1-minwoo.im.dev@gmail.com>
 <20190506145327.GA2164@localhost.localdomain>
Message-ID: <0db7e312-0ff2-45f2-8ee1-7ad7b6fd3e5a@gmail.com>

On 5/6/19 11:53 PM, Keith Busch wrote:
> On Mon, May 06, 2019@11:52:03PM +0900, Minwoo Im wrote:
>>   static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
>>   {
>>   	if (ctrl->ctrl.queue_count > 1) {
>> +		nvme_start_freeze(&ctrl->ctrl);
>> +		nvme_wait_freeze(&ctrl->ctrl);
>> +
>>   		nvme_stop_queues(&ctrl->ctrl);
>>   		blk_mq_tagset_busy_iter(&ctrl->tag_set,
>>   					nvme_cancel_request, &ctrl->ctrl);
>>   		nvme_loop_destroy_io_queues(ctrl);
>> +
>> +		nvme_unfreeze(&ctrl->ctrl);
>>   	}
> 
> nvme_stop_queues() and blk_mq_tagset_busy_iter() really don't make sense
> to call on frozen queues.
> 

Hi Keith,
Thanks for your reply on this.

Actually the OOPS has occurred because blk_mq_tagset_busy_iter() 
iterates over a request which is now being completed by other CPU.

If don't mind, can I ask how can blk_mq_tagset_busy_iter() make sure 
that no more requests are coming into this request_queue during this 
iteration ?

Thanks,
