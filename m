From: hch@lst.de (Christoph Hellwig)
Date: Thu, 19 Jul 2018 16:43:55 +0200
Subject: [PATCH 4/5] nvme-multipath: disable ANA support if parsing fails
In-Reply-To: <20180716105837.101125-5-hare@suse.de>
References: <20180716105837.101125-1-hare@suse.de>
 <20180716105837.101125-5-hare@suse.de>
Message-ID: <20180719144355.GA20422@lst.de>

On Mon, Jul 16, 2018@12:58:36PM +0200, Hannes Reinecke wrote:
> If we cannot parse the ANA log page we should just disable ANA
> support altogether, otherwise we fail to connect to the controller
> and we have no way of figuring out what went wrong.
> And we should kill the WARN_ON() statements as we now have a valid
> recovery strategy.

I don't like this.  There is a lot magic now where we need to
check if we have a buffer independent of wheter the controller
supports ANA to start with.

If we really have a that buggy controller we'll need to quirk it.
