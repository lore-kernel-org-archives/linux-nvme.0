From: hch@lst.de (Christoph Hellwig)
Date: Thu, 16 May 2019 16:51:07 +0200
Subject: [PATCH RFC] nvme: Common subsys and controller instances IDA
In-Reply-To: <20190516144452.GB23372@localhost.localdomain>
References: <20190515213351.22190-1-keith.busch@intel.com>
 <20190516064651.GA30234@lst.de>
 <1f0e7049-c926-98e0-3624-0d24eb45cd87@suse.de>
 <20190516144452.GB23372@localhost.localdomain>
Message-ID: <20190516145107.GA23989@lst.de>

On Thu, May 16, 2019@08:44:52AM -0600, Keith Busch wrote:
> > /dev/disk/by-id/nvme-subsys-$NQN-ns-$NS
> 
> Hm, the current by-id rules use the namespace's nguid or eui if it exists,
> and serial + nsid if not. We can add susbsys too.

Anything that supports the subsystem NQN must support euid, nguid or
uuid, so I'm not sure it is worth it.

We still need good human readable names for the character devices,
though.
