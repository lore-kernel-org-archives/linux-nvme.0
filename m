From: keith.busch@intel.com (Keith Busch)
Date: Wed, 7 Mar 2018 08:46:41 -0700
Subject: [PATCH] nvme_fc: minor fixes on sqsize
In-Reply-To: <20180306045524.3474-1-jsmart2021@gmail.com>
References: <20180306045524.3474-1-jsmart2021@gmail.com>
Message-ID: <20180307154640.GF30975@localhost.localdomain>

On Mon, Mar 05, 2018@08:55:24PM -0800, James Smart wrote:
>  	ret = __nvme_fc_create_hw_queue(ctrl, &ctrl->queues[0], 0,
> -				NVME_AQ_BLK_MQ_DEPTH);
> +				NVME_AQ_BLK_MQ_DEPTH + 1);

A bit of a nit, but I think you'd prefer to use NVME_AQ_DEPTH here
instead of assuming the +1.
