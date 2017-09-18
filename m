From: jsmart2021@gmail.com (James Smart)
Date: Mon, 18 Sep 2017 09:00:32 -0700
Subject: [PATCH v2] nvmet: implement valid sqhd values in completions
In-Reply-To: <e554b8fc-4045-eef0-44fe-ef707955bff7@mellanox.com>
References: <20170914175810.13011-1-jsmart2021@gmail.com>
 <e554b8fc-4045-eef0-44fe-ef707955bff7@mellanox.com>
Message-ID: <14692960-9fed-2d6a-28bb-16e98f28fce6@gmail.com>

On 9/16/2017 3:04 AM, Max Gurtovoy wrote:
>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>> index 7c23eaf8e563..764d46698b03 100644
>> --- a/drivers/nvme/target/core.c
>> +++ b/drivers/nvme/target/core.c
>> @@ -390,8 +390,8 @@ static void __nvmet_req_complete(struct nvmet_req 
>> *req, u16 status)
>> ????? if (status)
>> ????????? nvmet_set_status(req, status);
>> -??? /* XXX: need to fill in something useful for sq_head */
>> -??? req->rsp->sq_head = 0;
>> +??? req->sq->sqhd = (req->sq->sqhd + 1) % req->sq->size;
>> +??? req->rsp->sq_head = cpu_to_le16(req->sq->sqhd);
>> ????? if (likely(req->sq)) /* may happen during early failure */
>> ????????? req->rsp->sq_id = cpu_to_le16(req->sq->qid);
>> ????? req->rsp->command_id = req->cmd->common.command_id;
> 
> According to the "if (likely(req->sq)) /* may happen during early 
> failure */" condition, we can get null deref here 2 lines above that...


I think the likely statement is erroneous. In order to get to this point 
the transport has to call nvmet_req_init(), and the first thing it does 
is assign the sq and there's never an unset. So any completion of the 
routine, even if failure to nvmet_req_init() has sq set.  There's also 
several other cases in nvmet_req_init() where if the transport set it to 
NULL an oops would occur.

I'll send a revised patch that also removes the "if (likely())" test.

-- james
