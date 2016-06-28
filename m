From: james.p.freyensee@intel.com (Freyensee, James P)
Date: Tue, 28 Jun 2016 19:55:15 +0000
Subject: [PATCH] nvme-fabrics: change NQN UUID to big-endian format
In-Reply-To: <1467138023-41671-1-git-send-email-daniel.verkamp@intel.com>
References: <20160628084547.GA31465@infradead.org>
 <1467138023-41671-1-git-send-email-daniel.verkamp@intel.com>
Message-ID: <1467143715.18295.4.camel@intel.com>

On Tue, 2016-06-28@11:20 -0700, Daniel Verkamp wrote:
> NVM Express 1.2.1 section 7.9, NVMe Qualified Names, specifies that
> the
> UUID format of NQN uses a UUID based on RFC 4122.
> 
> RFC 4122 specifies that the UUID is encoded in big-endian byte order.
> 
> Switch the NVMe over Fabrics host ID field from little-endian UUID to
> big-endian UUID to match the specification.

Good catch.

Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>

> 
> Signed-off-by: Daniel Verkamp <daniel.verkamp at intel.com>
