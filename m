From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 16 Nov 2018 00:31:24 -0800
Subject: [PATCH] nvme: validate controller state before rescheduling keep
 alive
In-Reply-To: <20181114231204.5996-1-jsmart2021@gmail.com>
References: <20181114231204.5996-1-jsmart2021@gmail.com>
Message-ID: <20181116083123.GA10350@infradead.org>

[adding Sagi for keep alive issues]

On Wed, Nov 14, 2018@03:12:04PM -0800, James Smart wrote:
>  	ctrl->comp_seen = false;
> -	schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
> +	if (ctrl->state == NVME_CTRL_LIVE ||
> +	    ctrl->state == NVME_CTRL_CONNECTING)
> +		schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
>  }

As we move into a different state before calling nvme_stop_keep_alive
this should be fine, even if open code state checks always worry me
a bit..
