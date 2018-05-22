From: hare@suse.de (Hannes Reinecke)
Date: Tue, 22 May 2018 12:56:36 +0200
Subject: [PATCHv2 04/11] nvmet: Add AEN configuration support
In-Reply-To: <20180522100158.GB11894@lst.de>
References: <20180522091004.39620-1-hare@suse.de>
 <20180522091004.39620-5-hare@suse.de> <20180522100158.GB11894@lst.de>
Message-ID: <5d172f33-ee57-746c-f0d1-ce183a80d7be@suse.de>

On 05/22/2018 12:01 PM, Christoph Hellwig wrote:
>> +	case NVME_FEAT_ASYNC_EVENT:
>> +		val32 = le32_to_cpu(req->cmd->common.cdw10[1]);
>> +		req->sq->ctrl->aen_cfg = val32 & NVME_AEN_CFG_NS_ATTR;
> 
> This needs a validity check, and either be under a lock or very
> carefully accessed using WRITE_ONCE/READ_ONCE.
>
Okay; a controller lock would be good here. Let's see what we have.

Cheers,

Hannes
