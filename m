From: hch@lst.de (Christoph Hellwig)
Date: Wed, 9 May 2018 09:08:58 +0200
Subject: [PATCH 1/5] nvmet: EUI64 support
In-Reply-To: <20180504112845.38820-2-hare@suse.de>
References: <20180504112845.38820-1-hare@suse.de>
 <20180504112845.38820-2-hare@suse.de>
Message-ID: <20180509070858.GA20363@lst.de>

On Fri, May 04, 2018@01:28:41PM +0200, Hannes Reinecke wrote:
> Allow the setting of an IEEE Extended Unique Identifier (EUI64) for
> each namespace. As the OUI is per subsystem ensure that the OUI
> part of the EUI64 value (ie the top 3 bytes) are matching for each
> namespace.

I don't think we should support the EUI64 value.  It doesn't have
a lot of uniqueness, and it requires and IEEE OID to be properly
implemented.  Please use the UUID identifier always, unless you actually
doe havean IEEE OID and really want to use it, in which case you should
use the NGUID.
