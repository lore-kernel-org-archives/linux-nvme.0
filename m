From: hch@lst.de (Christoph Hellwig)
Date: Thu, 13 Dec 2018 21:20:16 +0100
Subject: [PATCH 4/4] block: expose devt for GENHD_FL_HIDDEN disks
In-Reply-To: <20181213152532.GA5321@calabresa>
References: <20181206164812.30925-1-cascardo@canonical.com>
 <20181206164812.30925-5-cascardo@canonical.com>
 <b3ef062d-3bc3-fdf8-f395-31d1822a3192@suse.de> <20181213143218.GA8723@lst.de>
 <20181213152532.GA5321@calabresa>
Message-ID: <20181213202016.GA15992@lst.de>

On Thu, Dec 13, 2018@01:25:33PM -0200, Thadeu Lima de Souza Cascardo wrote:
> > And I've checked back - lsblk actually works just fine at the moment.
> > But it turns out once we create the slave links it stops working,
> > which is a really good argument against the first two patches, which
> > would otherwise seem nice..
> 
> Which is why I have sent the "paths/" patchset in the first place. Because I
> did some homework and read the previous discussion about this, and how lsblk
> failure to behave with slave links led to the revert of the slaves/holders
> patch by Dr. Hannes.

Sorry, I did not actually notice that Hannes patch manually created
the same slaves/holders link we otherwise create using the block layer
APIs.  Had I realized those actually were the same that had saved
me some work.

So I guess the v2 paths/ link patch from you is the least of all evils.
Hannes, can you look over that one?
