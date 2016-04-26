From: jonathan.derrick@intel.com (Jon Derrick)
Date: Tue, 26 Apr 2016 10:40:44 -0600
Subject: [PATCH 3/5] nvme: tighten up state check for namespace scanning
In-Reply-To: <1461671520-4758-4-git-send-email-hch@lst.de>
References: <1461671520-4758-1-git-send-email-hch@lst.de>
 <1461671520-4758-4-git-send-email-hch@lst.de>
Message-ID: <20160426164043.GA13369@localhost.localdomain>

> +
> +	if (dev->online_queues > 1)
> +		nvme_queue_scan(dev);
>  	return;
>  
Above this we do 'if (dev->online_queues < 2)'.
Maybe we should change one or the other to make it consistent



Otherwise looks fine

Acked-by Jon Derrick: <jonathan.derrick at intel.com>
