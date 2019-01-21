From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 21 Jan 2019 01:12:22 -0800
Subject: [PATCH v2] nvme-rdma: fix timeout handler
In-Reply-To: <20190119133601.GA24763@lst.de>
References: <20190108085734.9681-1-sagi@grimberg.me>
 <20190119133601.GA24763@lst.de>
Message-ID: <c12cfbed-6da7-fe9d-278d-88b80166febe@grimberg.me>


>> +	if (ctrl->ctrl.state != NVME_CTRL_LIVE) {
>> +		/*
>> +		 * teardown immediately if controller times out while starting
>> +		 * or we are already started error recovery. all outstanding
>> +		 * requests are completed on shutdown, so we return BLK_EH_DONE.
> 
> Nitpick: please start sentences with upper case letters.
> 
> Otherwise this looks fine:
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>

Applied to nvme-5.0 with the comment fix. Thanks!
