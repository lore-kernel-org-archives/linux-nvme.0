From: james.smart@broadcom.com (James Smart)
Date: Tue, 12 Jun 2018 15:22:47 -0700
Subject: [PATCH 4/4] nvme-fabrics: reverse polarity in __nvmf_check_ready
In-Reply-To: <20180612130837.47a16bd2@pentland.suse.de>
References: <20180611154647.32558-1-hch@lst.de>
 <20180611154647.32558-5-hch@lst.de>
 <20180612130837.47a16bd2@pentland.suse.de>
Message-ID: <7f7490b7-d177-152e-dadf-b284f118d4b6@broadcom.com>



On 6/12/2018 4:08 AM, Hannes Reinecke wrote:
> On Mon, 11 Jun 2018 17:46:47 +0200
> Christoph Hellwig <hch@lst.de> wrote:
>
>> All non-live, non-dead states have the same command filters.  So just
>> check for the dead state first, and then apply out filters to catch
>> all other "special" states automatically.
>>
>> Signed-off-by: Christoph Hellwig <hch at lst.de>
>> ---
>>   drivers/nvme/host/fabrics.c | 42
>> ++++++++++++++----------------------- 1 file changed, 16
>> insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index 6b4e253b9347..dc87719a5c9e 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -556,34 +556,24 @@ EXPORT_SYMBOL_GPL(nvmf_fail_nonready_command);
>>   bool __nvmf_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
>>   		bool queue_live)
>>   {
>> -	struct nvme_command *cmd = nvme_req(rq)->cmd;
>> -
>> -	switch (ctrl->state) {
>> -	case NVME_CTRL_NEW:
>> -	case NVME_CTRL_CONNECTING:
>> -	case NVME_CTRL_DELETING:
>> -		/*
>> -		 * If queue is live, allow only commands that are
>> internally
>> -		 * generated pass through.  These are commands on
>> the admin
>> -		 * queue to initialize the controller. This will
>> reject any
>> -		 * ioctl admin cmds received while initializing.
>> -		 */
>> -		if (queue_live && !(nvme_req(rq)->flags &
>> NVME_REQ_USERCMD))
>> -			return true;
>> -
>> -		/*
>> -		 * If the queue is not live, allow only a connect
>> command.  This
>> -		 * will reject any ioctl admin cmd as well as
>> initialization
>> -		 * commands if the controller reverted the queue to
>> non-live.
>> -		 */
>> -		if (!queue_live && blk_rq_is_passthrough(rq) &&
>> -		     cmd->common.opcode == nvme_fabrics_command &&
>> -		     cmd->fabrics.fctype ==
>> nvme_fabrics_type_connect)
>> -			return true;
>> +	if (ctrl->state == NVME_CTRL_DEAD)
>>   		return false;
>> -	default:
>> +
>> +	/*
>> +	 * If the queue is not live the only thing allowed is a
>> connect
>> +	 * command to actually set the queue live.
>> +	 */
>> +	if (!queue_live &&
>> +	    (nvme_req(rq)->cmd->common.opcode !=
>> nvme_fabrics_command ||
>> +	     nvme_req(rq)->cmd->fabrics.fctype !=
>> nvme_fabrics_type_connect)) return false;
>> -	}
>> +
>> +	/*
>> +	 * If we are in some state of setup or teardown only allow
>> +	 * internally generated commands.
>> +	 */
>> +	return blk_rq_is_passthrough(rq) &&
>> +		!(nvme_req(rq)->flags & NVME_REQ_USERCMD);
>>   }
>>   EXPORT_SYMBOL_GPL(__nvmf_check_ready);
>>   
> Is that really correct?
> We're squashing the 'queue_live' check with the check for the 'connect'
> command, meaning we will be submitting non-connect commands even on a
> non-live queue.

I think it is.? the queue_live=true check isn't necessarily valid. When 
it is valid, is when the controller state is also LIVE/ADMIN_ONLY, and 
that should have been picked off/allowed prior to reaching this point. 
So, to be in this section, you are something other than LIVE.?? The 
queue_live=false will always be a valid case, so using that check with 
the connect type is good.? If it was the admin queue that had an 
invalid=true case, then it's highly unlikely anything is going to be 
generated via the core code without being an ioctl command and the ioctl 
commands should fail the ! NVME_REQ_USERCMD check.? So if any other 
admin command, given the serialized nature of controller init, then it 
should be post the admin queue having a connect being done, so it is 
live, and any command other than an ioctl would be one generated to init 
the controller (or to do the property_set on a reset/delete).

-- james
