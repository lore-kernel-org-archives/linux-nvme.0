From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 23 Oct 2017 12:04:18 +0300
Subject: [PATCH] nvme-rdma: fix possible hang when issuing commands during
 ctrl removal
In-Reply-To: <20171023082345.GA19156@lst.de>
References: <1508697771-3552-1-git-send-email-sagi@grimberg.me>
 <20171023082345.GA19156@lst.de>
Message-ID: <230d99f3-7f35-5c8d-41b9-5c4867c7f2bb@grimberg.me>


>>   			/*
>> +			 * deleting state means that the ctrl will never accept
>> +			 * commands again, fail it permanently.
>> +			 */
>> +			if (queue->ctrl->ctrl.state == NVME_CTRL_DELETING) {
>> +				nvme_req(rq)->status = NVME_SC_ABORT_REQ;
>> +				return BLK_STS_IOERR;
> 
> What does the NVME_SC_ABORT_REQ buy us here compared to just returning
> BLK_STS_IOERR as in the reconnecting case?

reg_write32() issues a sync command, which returns
nvme_req(req)->status (blk_execute_request error detection is caller
specific). without it nvme_shutdown_ctrl thinks reg_write32() succeeded
and polls with reg_read32() for no good reason.

And its needed for the reconnecting case too, we just never noticed
it for that case.

> Why can't we just merge the two cases?

Because we fail for slightly different reasons so I thought two
distinct conditionals looks cleaner, but we can merge the two.
