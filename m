From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 19 Jun 2018 12:49:13 +0300
Subject: [PATCH 1/1] nvme-rdma: fix error flow during controller reset
In-Reply-To: <20180619051504.GA22076@lst.de>
References: <1529247426-13303-1-git-send-email-maxg@mellanox.com>
 <20180619051504.GA22076@lst.de>
Message-ID: <7a93ad5b-2331-953b-1e23-25c50372be81@mellanox.com>



On 6/19/2018 8:15 AM, Christoph Hellwig wrote:
>>   		ret = nvme_rdma_configure_io_queues(ctrl, false);
>>   		if (ret)
>> -			goto out_fail;
>> +			goto destroy_admin;
>>   	}
>>   
>>   	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
>> @@ -1795,6 +1795,8 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
>>   
>>   	return;
>>   
>> +destroy_admin:
>> +	nvme_rdma_destroy_admin_queue(ctrl, false);
>>   out_fail:
>>   	++ctrl->ctrl.nr_reconnects;
>>   	nvme_rdma_reconnect_or_remove(ctrl);
> 
> What about:
> 
> nvme_rdma_reconnect_or_remove
>   -> nvme_delete_ctrl
>    -> nvme_rdma_delete_ctrl
>     -> nvme_rdma_shutdown_ctrl
>      -> nvme_rdma_destroy_admin_queue
> 
> ?
> 

if you worry about calling nvme_rdma_destroy_admin_queue twice so it's 
fine since we check test_and_clear_bit in nvme_rdma_stop_queue and 
nvme_rdma_free_queue
