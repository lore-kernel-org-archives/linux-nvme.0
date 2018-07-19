From: hch@lst.de (Christoph Hellwig)
Date: Thu, 19 Jul 2018 16:31:13 +0200
Subject: [PATCH 1/5] nvme: count all ANA groups for ANA Log page
In-Reply-To: <20180716105837.101125-2-hare@suse.de>
References: <20180716105837.101125-1-hare@suse.de>
 <20180716105837.101125-2-hare@suse.de>
Message-ID: <20180719143113.GB19339@lst.de>

On Mon, Jul 16, 2018@12:58:33PM +0200, Hannes Reinecke wrote:
> When issuing a short read on the ANA log page the number of groups
> should not change, even though the final returned data might contain
> less groups than that number.

This is based on a "clarification" to the spec that Fred posted a few
days ago, which honestly looks entirely bogus.  I'll wait until that
is sorted out in the WG.
