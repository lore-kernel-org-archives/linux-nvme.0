From: israelr@mellanox.com (Israel Rukshin)
Date: Mon, 8 Jan 2018 16:43:07 +0200
Subject: [PATCH 2/2] nvme: Fix subsystem multiple controllers support check
In-Reply-To: <20180108101626.GA5383@lst.de>
References: <1515081374-22328-1-git-send-email-maxg@mellanox.com>
 <1515081374-22328-2-git-send-email-maxg@mellanox.com>
 <20180108101626.GA5383@lst.de>
Message-ID: <2d089c20-47f1-c9fc-3eab-53bc668d943f@mellanox.com>

On 1/8/2018 12:16 PM, Christoph Hellwig wrote:
> Btw, I suspect we'll need to to do something interesting here for
> the multipath case as well.  Can you investigate that?
Sure :-)
