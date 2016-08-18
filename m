From: daniel.verkamp@intel.com (Verkamp, Daniel)
Date: Thu, 18 Aug 2016 19:48:07 +0000
Subject: [PATCH] nvme-fabrics: change NQN UUID to big-endian format
In-Reply-To: <20160630064153.GA27456@infradead.org>
References: <20160628084547.GA31465@infradead.org>
 <1467138023-41671-1-git-send-email-daniel.verkamp@intel.com>
 <20160630064153.GA27456@infradead.org>
Message-ID: <1471549684.3070.13.camel@intel.com>

On Wed, 2016-06-29@23:41 -0700, Christoph Hellwig wrote:
> On Tue, Jun 28, 2016@11:20:23AM -0700, Daniel Verkamp wrote:
> > 
> > NVM Express 1.2.1 section 7.9, NVMe Qualified Names, specifies that
> > the
> > UUID format of NQN uses a UUID based on RFC 4122.
> > 
> > RFC 4122 specifies that the UUID is encoded in big-endian byte
> > order.
> > 
> > Switch the NVMe over Fabrics host ID field from little-endian UUID
> > to
> > big-endian UUID to match the specification.
> > 
> > Signed-off-by: Daniel Verkamp <daniel.verkamp at intel.com>
> 
> Thanks a lot Daniel, I'll send this on to Jens.

Hi,

Just wanted to check on this and make sure it didn't get dropped.
It doesn't appear to be in Linus's tree or in any branches of nvme-
fabrics.git yet.

Thanks,
-- Daniel
