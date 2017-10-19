From: jsmart2021@gmail.com (James Smart)
Date: Thu, 19 Oct 2017 08:59:06 -0700
Subject: [PATCH 2/3] nvme_fc: add support for duplicate_connect option
In-Reply-To: <20171019152317.GB4239@infradead.org>
References: <20171011003512.5946-1-jsmart2021@gmail.com>
 <20171011003512.5946-3-jsmart2021@gmail.com>
 <20171019152317.GB4239@infradead.org>
Message-ID: <89d38cc7-0a6e-d374-4005-96a178a18c78@gmail.com>

On 10/19/2017 8:23 AM, Christoph Hellwig wrote:
>> +static inline bool
>> +__nvme_fc_options_match(struct nvmf_ctrl_options *opts,
>> +			struct nvme_fc_ctrl *ctrl)
>> +{
>> +	if (strcmp(opts->subsysnqn, ctrl->ctrl.opts->subsysnqn) ||
>> +	    strcmp(opts->host->nqn, ctrl->ctrl.opts->host->nqn) ||
>> +	    memcmp(&opts->host->id, &ctrl->ctrl.opts->host->id,
>> +				sizeof(uuid_t)))
>> +		return false;
> 
> This just checks generic options and isn't FC specific.  As a properly
> named helper it might make sense in common code.
> 

Agree, I can make a short helper

-- james
