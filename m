From: keith.busch@intel.com (Keith Busch)
Date: Thu, 4 Feb 2016 16:00:44 +0000
Subject: [PATCH 2/4] NVMe: Sync stopped queues with block layer
In-Reply-To: <56B374D3.9010003@dev.mellanox.co.il>
References: <1454515543-21683-1-git-send-email-keith.busch@intel.com>
 <1454515543-21683-3-git-send-email-keith.busch@intel.com>
 <56B374D3.9010003@dev.mellanox.co.il>
Message-ID: <20160204160044.GD28747@localhost.localdomain>

On Thu, Feb 04, 2016@05:57:07PM +0200, Sagi Grimberg wrote:
> 
> >Make sure no work will submit requests to a stopped h/w queue.
> 
> Not sure what that buys us, and it's not documented. But
> I don't mind having it. Can you provide a better explanation
> why it's added?

This was trying to close that gap with requests queueing on stopped h/w
queues and writing the queue doorbell. It works for requests through
the kblock_workqueue, but that's not always the case, so it's only a
partial solution.
