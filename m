From: hch@lst.de (Christoph Hellwig)
Date: Mon, 2 Oct 2017 18:15:32 +0200
Subject: [PATCH 1/6] nvme: display 'CMIC' controller attribute
In-Reply-To: <1506952559-1588-2-git-send-email-hare@suse.de>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
 <1506952559-1588-2-git-send-email-hare@suse.de>
Message-ID: <20171002161532.GA11048@lst.de>

On Mon, Oct 02, 2017@03:55:54PM +0200, Hannes Reinecke wrote:
> To figure out if a controller is multipath capable (ie if the
> controller supports namespace sharing) we need to expose the CMIC
> value to sysfs.

If you care about the multipath-capability of a controller you can
get it using nvme-cli.  Especially given that there is no good reason
to query it except for curiosity.
