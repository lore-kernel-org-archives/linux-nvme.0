From: hch@lst.de (Christoph Hellwig)
Date: Tue, 29 May 2018 14:49:25 +0200
Subject: [PATCH 06/10] nvme: simplify check for ANA in
 nvme_ns_id_attrs_are_visible()
In-Reply-To: <20180529101431.62271-7-hare@suse.de>
References: <20180529101431.62271-1-hare@suse.de>
 <20180529101431.62271-7-hare@suse.de>
Message-ID: <20180529124925.GF7376@lst.de>

On Tue, May 29, 2018@12:14:27PM +0200, Hannes Reinecke wrote:
> Instead of adding another indirection to the controller we can
> as well check the ANA group id of the namespace to figure out
> if ANA is supported.

Not sure why this is so much better, but it does look correct to me.
