From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 8 Nov 2016 12:26:58 +0200
Subject: [PATCH v2] nvmet: Don't queue fatal error work if csts.cfs is set
In-Reply-To: <1478544077.3350.26.camel@linux.intel.com>
References: <1478453200-16762-1-git-send-email-sagi@grimberg.me>
 <1478544077.3350.26.camel@linux.intel.com>
Message-ID: <601a736b-6167-1630-c170-e98dc26112d9@grimberg.me>


>>  void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl)
>>  {
>> -	ctrl->csts |= NVME_CSTS_CFS;
>> -	INIT_WORK(&ctrl->fatal_err_work, nvmet_fatal_error_handler);
>> -	schedule_work(&ctrl->fatal_err_work);
>> +	mutex_lock(&ctrl->lock);
>> +	if (!(ctrl->csts & NVME_CSTS_CFS)) {
>> +		ctrl->csts |= NVME_CSTS_CFS;
>> +		INIT_WORK(&ctrl->fatal_err_work,
>> nvmet_fatal_error_handler);
>> +		schedule_work(&ctrl->fatal_err_work);
>> +	}
>> +	mutex_unlock(&ctrl->lock);
>
> Surrounding the mutex_lock()/unlock() around the if() is definitely
> safer and a more conservative, but I would think it would be OK to
> stick the mutex_lock/unlock() within the if() statement (mutex_lock()
> as the first line after the if() check, mutex_unlock() as the last line
> of the if()), as trying to acquire a lock before checking the condition
> to see if CFS needs to be set is sub-optimal.

I don't think this is worth optimizing, it is error flow after all..
