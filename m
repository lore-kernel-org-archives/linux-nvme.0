From: hch@lst.de (Christoph Hellwig)
Date: Thu, 26 Jul 2018 17:12:21 +0200
Subject: [PATCH] nvme: Register for ANA AEN
In-Reply-To: <763ec760-8651-ff20-fe01-00ab43f29337@suse.de>
References: <20180726105554.80437-1-hare@suse.de>
 <9a5908f1-92fe-e338-47e0-ad51837b3212@suse.de> <20180726115913.GA2187@lst.de>
 <20180726120113.GA2289@lst.de> <06a3d125-0dd6-d288-bedd-8462d96c3b9d@suse.de>
 <20180726120711.GA2684@lst.de> <763ec760-8651-ff20-fe01-00ab43f29337@suse.de>
Message-ID: <20180726151221.GA7791@lst.de>

On Thu, Jul 26, 2018@03:37:48PM +0200, Hannes Reinecke wrote:
> > I'll send out another round later today.
> > 
> Would it make sense to read back the features after we've tried to
> enable them?
> It might be that the target doesn't enable ANA AENs (or doesn't support
> them), at which point we have to disable ANA on the host as we rely on
> ANA AENs for correct operations ...

If it doesn't support the AEN it won't be in OAES..
