From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 13 Apr 2017 01:58:22 +0300
Subject: [PATCH 2/2] nvme-rdma: add support for arbitrary sg lists mapping
In-Reply-To: <20170412171759.GC8639@lst.de>
References: <1491948109-9224-1-git-send-email-maxg@mellanox.com>
 <1491948109-9224-2-git-send-email-maxg@mellanox.com>
 <20170412171759.GC8639@lst.de>
Message-ID: <62d3a9be-58c8-4b24-8f6a-4a4d70b8fe9f@mellanox.com>



On 4/12/2017 8:17 PM, Christoph Hellwig wrote:
>> -	req->mr = ib_alloc_mr(dev->pd, IB_MR_TYPE_MEM_REG,
>> +	req->mr = ib_alloc_mr(dev->pd, req->mr_type,
>>  			ctrl->max_fr_pages);
>>  	if (IS_ERR(req->mr)) {
>>  		ret = PTR_ERR(req->mr);
>> @@ -348,8 +349,12 @@ static int __nvme_rdma_init_request(struct nvme_rdma_ctrl *ctrl,
>>  	if (ret)
>>  		return ret;
>>
>> -	req->mr = ib_alloc_mr(dev->pd, IB_MR_TYPE_MEM_REG,
>> -			ctrl->max_fr_pages);
>> +	if (ibdev->attrs.device_cap_flags & IB_DEVICE_SG_GAPS_REG)
>> +		req->mr_type = IB_MR_TYPE_SG_GAPS;
>> +	else
>> +		req->mr_type = IB_MR_TYPE_MEM_REG;
>
> Why do we need the req->mr_type member?  Can't we just check the device
> aps in the reinit path as well?
>

I guess we can. Is it better to use an helper func to avoid code 
duplication ? if so, maybe we can do a general fuctions in verbs.h so 
iser can use it too ?
