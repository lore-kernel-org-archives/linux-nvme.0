From: keith.busch@intel.com (Keith Busch)
Date: Thu, 20 Jul 2017 16:11:40 -0400
Subject: [PATCH v3 3/3] nvme: wwid_show: strip trailing 0-bytes
In-Reply-To: <20170720163402.17793-4-mwilck@suse.com>
References: <20170720163402.17793-1-mwilck@suse.com>
 <20170720163402.17793-4-mwilck@suse.com>
Message-ID: <20170720201140.GE1202@localhost.localdomain>

On Thu, Jul 20, 2017@06:34:02PM +0200, Martin Wilck wrote:
> Some broken targets (such as the current Linux target) pad
> model or serial fields with 0-bytes rather than spaces. The
> NVME spec disallows 0 bytes in "ASCII" fields.
> Thus strip trailing 0-bytes, too. Also make sure that we get no
> underflow for pathological input.
> 
> Signed-off-by: Martin Wilck <mwilck at suse.com>
> Reviewed-by: Hannes Reinecke <hare at suse.de>
> Acked-by: Christoph Hellwig <hch at lst.de>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
