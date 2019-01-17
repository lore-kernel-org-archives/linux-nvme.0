From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 16 Jan 2019 17:31:10 -0800
Subject: [PATCH] nvme: handle static ANA groups correctly
In-Reply-To: <20190116080003.3643-1-hare@suse.de>
References: <20190116080003.3643-1-hare@suse.de>
Message-ID: <773f0ebc-402d-1350-792f-703a4d19f169@grimberg.me>


> @@ -393,8 +411,15 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
>   	if (desc->state == NVME_ANA_CHANGE)
>   		(*nr_change_groups)++;
>   
> -	if (!nr_nsids)
> +	if (!nr_nsids) {
> +		if (ctrl->anacap & (1 << 6)) {

Maybe nvme_static_ana_grps(ctrl) macro? This is checked in more than
one place.
