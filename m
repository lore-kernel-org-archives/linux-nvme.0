From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 14 Sep 2017 10:05:28 -0700
Subject: [PATCH] nvme: stop aer posting if controller state not live
In-Reply-To: <20170912191413.9343-1-jsmart2021@gmail.com>
References: <20170912191413.9343-1-jsmart2021@gmail.com>
Message-ID: <20170914170528.GA4024@infradead.org>

>  	spin_lock_irq(&ctrl->lock);
> +	if (ctrl->state != NVME_CTRL_LIVE)
> +		goto skip_aer;
>  	while (ctrl->event_limit > 0) {

How about:

	while (ctrl->state == NVME_CTRL_LIVE && ctrl->event_limit > 0) {

That takes care of the case where the controller goes bad during
the loop (except of cours that currently there's only ever one AER)
and also is a lot more readable.
