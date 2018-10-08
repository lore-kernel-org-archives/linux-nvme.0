From: hch@lst.de (Christoph Hellwig)
Date: Mon, 8 Oct 2018 12:05:07 +0200
Subject: [PATCH 2/2] nvme-multipath: manual NUMA configuration
In-Reply-To: <20181005092915.126636-3-hare@suse.de>
References: <20181005092915.126636-1-hare@suse.de>
 <20181005092915.126636-3-hare@suse.de>
Message-ID: <20181008100507.GB6686@lst.de>

On Fri, Oct 05, 2018@11:29:15AM +0200, Hannes Reinecke wrote:
> Not every NUMA configuration allows for an automatic setup via
> the distance between nodes, or even the admin might have some
> specific ideas on how things should be setup.
> This patch adds a new sysfs attribute 'node_map' to allow to
> specify the NUMA mapping for each controller.

This is a rather vagaue rational for a lot of anoying boilerplate
code.  I'd like to see better arguments for even looking into adding
magic knobs.
