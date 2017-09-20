From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 20 Sep 2017 14:29:18 +0300
Subject: [PATCH 2/2] nvme-rdma: give up reconnect if state change fails
In-Reply-To: <20170920112717.qi4txbrbwefw74gx@linux-x5ow.site>
References: <1505905573-25371-1-git-send-email-sagi@grimberg.me>
 <1505905573-25371-2-git-send-email-sagi@grimberg.me>
 <20170920112717.qi4txbrbwefw74gx@linux-x5ow.site>
Message-ID: <f1725d24-e8b5-8fcc-255e-58630074aac5@grimberg.me>


>>   	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
>> -	WARN_ON_ONCE(!changed);
>> +	if (!changed) {
>> +		/* We are probably in DELETING state */
> 
> Shouldn't we check if we're really in DELETING instead of just speculating we
> are?

I can add a WARN_ONCE.
