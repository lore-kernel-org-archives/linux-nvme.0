From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 6 Jun 2017 21:30:53 +0300
Subject: [PATCH v5 7/9] nvme: get list of namespace descriptors
In-Reply-To: <20170606143617.32143-8-jthumshirn@suse.de>
References: <20170606143617.32143-1-jthumshirn@suse.de>
 <20170606143617.32143-8-jthumshirn@suse.de>
Message-ID: <deea2259-e2df-189d-f299-7ec915406570@grimberg.me>


> +	if (ns->ctrl->vs >= NVME_VS(1, 3, 0)) {
> +		 /* Don't treat error as fatal we potentially
> +		  * already have a NGUID or EUI-64
> +		  */
> +		if (nvme_identify_ns_descs(ns, ns->ns_id))
> +			dev_warn(ns->ctrl->dev,

ctrl->device
