From: hch@lst.de (Christoph Hellwig)
Date: Wed, 3 Apr 2019 20:11:36 +0200
Subject: [PATCH 2/2] nvmet: make CNTLID range configurable
In-Reply-To: <20190329120404.55637-3-hare@suse.de>
References: <20190329120404.55637-1-hare@suse.de>
 <20190329120404.55637-3-hare@suse.de>
Message-ID: <20190403181136.GF28682@lst.de>

On Fri, Mar 29, 2019@01:04:04PM +0100, Hannes Reinecke wrote:
> When trying to run in a clustered environment we need to keep the
> controller ID values unique. So this patch add to additional config
> attributes 'cntlid_min' and 'cntlid_max' to only allow specific ranges
> for the controller ID.

Err, can you explain the use case a little better?  This sounds like
running two different nvmet instances and preting they are a single
subsystem.  Which sounds pretty dangerous without additional
communication layers.
