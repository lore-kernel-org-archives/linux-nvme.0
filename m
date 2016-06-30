From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 29 Jun 2016 23:41:53 -0700
Subject: [PATCH] nvme-fabrics: change NQN UUID to big-endian format
In-Reply-To: <1467138023-41671-1-git-send-email-daniel.verkamp@intel.com>
References: <20160628084547.GA31465@infradead.org>
 <1467138023-41671-1-git-send-email-daniel.verkamp@intel.com>
Message-ID: <20160630064153.GA27456@infradead.org>

On Tue, Jun 28, 2016@11:20:23AM -0700, Daniel Verkamp wrote:
> NVM Express 1.2.1 section 7.9, NVMe Qualified Names, specifies that the
> UUID format of NQN uses a UUID based on RFC 4122.
> 
> RFC 4122 specifies that the UUID is encoded in big-endian byte order.
> 
> Switch the NVMe over Fabrics host ID field from little-endian UUID to
> big-endian UUID to match the specification.
> 
> Signed-off-by: Daniel Verkamp <daniel.verkamp at intel.com>

Thanks a lot Daniel, I'll send this on to Jens.
