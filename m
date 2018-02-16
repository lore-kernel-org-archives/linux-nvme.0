From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 16 Feb 2018 08:35:38 +0100
Subject: [PATCH] nvme: Use __func__ macro in place of function name
In-Reply-To: <1518727378-23194-1-git-send-email-jpittman@redhat.com>
References: <1518727378-23194-1-git-send-email-jpittman@redhat.com>
Message-ID: <20180216073537.7fk56d2q3fv4pvfk@linux-x5ow.site>

On Thu, Feb 15, 2018@03:42:58PM -0500, John Pittman wrote:
>  		dev_err(ctrl->device,
> -			"failed nvme_keep_alive_end_io error=%d\n",
> -				status);
> +			"failed %s error=%d\n", __func__, status);

how about:
		dev_err(ctrl->device, "failed to send nvme keepalive %d\n",
			status);

as the function name isn't really needed for the error description at all and
barely transports any information to the user.

Byte,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
