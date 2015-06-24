From: jonathan.derrick@intel.com (Derrick, Jonathan)
Date: Wed, 24 Jun 2015 14:52:08 +0000
Subject: [PATCH] NVMe: Make nvme_meta_noop to supress Sparse warning
In-Reply-To: <20150624121941.GA14590@infradead.org>
References: <1435006888-13851-1-git-send-email-jonathan.derrick@intel.com>
 <20150624121941.GA14590@infradead.org>
Message-ID: <8D943B239464E04C9184454D8B3F5CFF0A8473F4@ORSMSX105.amr.corp.intel.com>

Drats! Good catch

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Christoph Hellwig
Sent: Wednesday, June 24, 2015 6:20 AM
To: Derrick, Jonathan
Cc: linux-nvme at lists.infradead.org
Subject: Re: [PATCH] NVMe: Make nvme_meta_noop to supress Sparse warning

On Mon, Jun 22, 2015@03:01:28PM -0600, Jon Derrick wrote:
> Supresses warning emitted by Sparse.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>

Looks good, but the subject line seems be be missing a "static"
somewhere :)

Reviewed-by: Christoph Hellwig <hch at lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
