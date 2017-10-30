From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 30 Oct 2017 08:29:31 -0600
Subject: [PATCH] nvme: freeze IO accesses around format
In-Reply-To: <20171027230756.GA17245@localhost.localdomain>
References: <6951d74c-e765-1b5d-6e39-d88d261bf9b9@kernel.dk>
 <20171027230756.GA17245@localhost.localdomain>
Message-ID: <459d7b58-c5b6-44a9-280e-ce8661673b18@kernel.dk>

On 10/27/2017 05:07 PM, Keith Busch wrote:
> On Fri, Oct 27, 2017@10:35:58AM -0600, Jens Axboe wrote:
>> @@ -1013,10 +1013,23 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>>  	if (cmd.timeout_ms)
>>  		timeout = msecs_to_jiffies(cmd.timeout_ms);
>>  
>> +	/*
>> +	 * Freeze current access to the device, and prevent new ones, around
>> +	 * a format operation.
>> +	 */
>> +	if (cmd.opcode == nvme_admin_format_nvm) {
>> +		nvme_start_freeze(ctrl);
>> +		nvme_wait_freeze(ctrl);
>> +	}
>> +
>>  	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
>>  			(void __user *)(uintptr_t)cmd.addr, cmd.data_len,
>>  			(void __user *)(uintptr_t)cmd.metadata, cmd.metadata,
>>  			0, &cmd.result, timeout);
>> +
>> +	if (cmd.opcode == nvme_admin_format_nvm)
>> +		nvme_unfreeze(ctrl);
>> +
> 
> Testing some obscure vendor specific IO commands, I noticed this
> will deadlock if an IO command opcode happens to be the same as an
> nvme_admin_format_nvm command since the IO queues are all frozen.
> 
> You can check 'ns == NULL' before checking the opcode.

Yeah good point, it should have checked for this being the admin
queue target.

> I also have this patch that's more generic and will perform actions
> based on the controller's command effects:

Looks fine to me, one minor comment below.


> +static void nvme_get_admin_effects(struct nvme_ctrl *ctrl, u8 opcode, u32 *effects)
> +{
> +	if (ctrl->effects)
> +		*effects = le32_to_cpu(ctrl->effects->acs[opcode]);
> +
> +	if (*effects != 0)
> +		return;
> +
> +	/*
> +	 * Set known effects for opcodes if the controller doesn't support
> +	 * reporting the command's effects.
> +	 */
> +	switch (opcode) {
> +	case nvme_admin_format_nvm:
> +		*effects = NVME_CMD_FX_CSUPP | NVME_CMD_FX_LBCC |
> +					NVME_CMD_FX_CSE_MASK;
> +		break;
> +	default:
> +		break;
> +	}
> +}

Returning the value in a passed in pointer is pretty ugly, I only
generally think it's acceptable if you have to pass back some error as
well. And it's still nasty in that case. How about just returning an u32
from this function?


-- 
Jens Axboe
