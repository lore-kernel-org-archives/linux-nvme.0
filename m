From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 24 Apr 2017 00:12:58 -0700
Subject: [PATCH 3/3] nvme_fc: add controller reset support
In-Reply-To: <ef1354c7-d1df-a90f-e67f-063159c5959a@grimberg.me>
References: <20170423153008.22795-1-jsmart2021@gmail.com>
 <20170423153008.22795-4-jsmart2021@gmail.com>
 <ef1354c7-d1df-a90f-e67f-063159c5959a@grimberg.me>
Message-ID: <20170424071258.GA17381@infradead.org>

On Sun, Apr 23, 2017@08:43:53PM +0300, Sagi Grimberg wrote:
> 
> > +
> > +	ctrl->ctrl.sqsize =
> > +		min_t(int, NVME_CAP_MQES(ctrl->cap) + 1, ctrl->ctrl.sqsize);
> 
> This will conflict with 4.11 fixes...

I don't think we have much of a chance to avoid that.  Should be easy
enough to merge, though.
