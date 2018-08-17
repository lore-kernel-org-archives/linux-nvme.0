From: hch@lst.de (Christoph Hellwig)
Date: Fri, 17 Aug 2018 10:10:36 +0200
Subject: [PATCH 3/6] nvme-discover: sanitize options
In-Reply-To: <20180817072908.56784-4-hare@suse.de>
References: <20180817072908.56784-1-hare@suse.de>
 <20180817072908.56784-4-hare@suse.de>
Message-ID: <20180817081036.GC13230@lst.de>

On Fri, Aug 17, 2018@09:29:05AM +0200, Hannes Reinecke wrote:
> The discovery controller doesn't accept any KATO or number of I/O
> queue changes, but we do want to change the reconnect delay and
> the controller loss timeout.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>

Patch and description don't seem to match, this mostly seems to add
new documentation.
