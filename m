From: hch@lst.de (Christoph Hellwig)
Date: Thu, 13 Jul 2017 17:16:33 +0200
Subject: [PATCH] nvmet: preserve controller serial number between reboots
In-Reply-To: <1499958505.6432.8.camel@suse.de>
References: <20170713104806.12353-1-jthumshirn@suse.de>
 <1499958505.6432.8.camel@suse.de>
Message-ID: <20170713151633.GA993@lst.de>

On Thu, Jul 13, 2017@05:08:25PM +0200, Martin Wilck wrote:
> I'm wondering if this should be a write-once attribute. Also,
> Once the serial number has been passed on to some host (or maybe only:
> while the device is in use by some host), the attribute should probably
> be read-only.

In practive it should.  But I don't think it's worth the extra code
just to prevent people from shooting themselves into the foot.
