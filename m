From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 14 Nov 2018 08:29:28 -0800
Subject: [PATCH v2 1/4] nvmet: support fabrics sq flow control
In-Reply-To: <20181114141958.GA27204@infradead.org>
References: <20181003081323.7504-1-sagi@grimberg.me>
 <20181003081323.7504-2-sagi@grimberg.me>
 <20181114141958.GA27204@infradead.org>
Message-ID: <d3f27028-1da9-9224-e98b-a7d3e31b3d43@grimberg.me>


>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>> index 7084704b468d..df2af5e3e4d6 100644
>> --- a/drivers/nvme/target/core.c
>> +++ b/drivers/nvme/target/core.c
>> @@ -503,26 +503,35 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
>>   	return ns;
>>   }
>>   
>> -static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
>> +static void nvmet_update_sq_head(struct nvmet_req *req)
>>   {
>>   	u32 old_sqhd, new_sqhd;
>>   	u16 sqhd;
>>   
>> +	if (!req->sq->sqhd_disabled) {
>> +		if (req->sq->size) {
> 
> This should be (!req->sq->sqhd_disabled && req->sq->size))

No problem.

>> +			do {
>> +				old_sqhd = req->sq->sqhd;
>> +				new_sqhd = (old_sqhd + 1) % req->sq->size;
>> +			} while (cmpxchg(&req->sq->sqhd, old_sqhd, new_sqhd) !=
>> +						old_sqhd);
>> +		}
>>   	}
>> +
>>   	sqhd = req->sq->sqhd & 0x0000FFFF;
>>   	req->rsp->sq_head = cpu_to_le16(sqhd);
> 
> sq_head is a const 0xffff if flow control is disabled isn't it?

Unfortunately no, sqhd is supposed to be 0xffff only for the connect
response, otherwise its reserved.

> Based on that I'd just move the sqhd_disabled check in the
> caller and assign the constant value there.
> 
>> @@ -173,6 +175,8 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
>>   	kfree(d);
>>   complete:
>>   	nvmet_req_complete(req, status);
>> +	if (req->sq->sqhd_disabled)
>> +		req->sq->sqhd = 0;
> 
> Huh, why?

Because its reserved after the connect response.
