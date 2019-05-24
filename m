From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 23 May 2019 23:46:50 -0700
Subject: [PATCH 1/4] nvme: separate out nvme_ctrl_state_name()
In-Reply-To: <20190520063624.50338-2-hare@suse.de>
References: <20190520063624.50338-1-hare@suse.de>
 <20190520063624.50338-2-hare@suse.de>
Message-ID: <58613917-e96b-a325-7de4-75eaf8a2a138@grimberg.me>


> +const char *nvme_ctrl_state_name(struct nvme_ctrl *ctrl)
> +{
> +	if ((unsigned)ctrl->state < ARRAY_SIZE(nvme_ctrl_state_names) &&
> +	    nvme_ctrl_state_names[ctrl->state])
> +		return nvme_ctrl_state_names[ctrl->state];
> +	return "unknown state";

Maybe just "unknown"?

Otherwise looks fine..
