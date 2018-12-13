From: hch@lst.de (Christoph Hellwig)
Date: Thu, 13 Dec 2018 15:32:18 +0100
Subject: [PATCH 4/4] block: expose devt for GENHD_FL_HIDDEN disks
In-Reply-To: <b3ef062d-3bc3-fdf8-f395-31d1822a3192@suse.de>
References: <20181206164812.30925-1-cascardo@canonical.com>
 <20181206164812.30925-5-cascardo@canonical.com>
 <b3ef062d-3bc3-fdf8-f395-31d1822a3192@suse.de>
Message-ID: <20181213143218.GA8723@lst.de>

On Thu, Dec 13, 2018@10:18:40AM +0100, Hannes Reinecke wrote:
> Welll ... this is not just 'lsblk', but more importantly this will force 
> udev to create _block_ device nodes for the hidden devices, essentially 
> 'unhide' them.
>
> Is this what we want?
> Christoph?
> I thought the entire _point_ of having hidden devices is that the are ... 
> well ... hidden ...

Yes, that is why I really don't like the last two patches.

And I've checked back - lsblk actually works just fine at the moment.
But it turns out once we create the slave links it stops working,
which is a really good argument against the first two patches, which
would otherwise seem nice..
