From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Mon, 03 Oct 2016 09:10:15 -0700
Subject: [PATCH 2/5] nvme.h: don't use uuid_be
In-Reply-To: <1475236270-18329-3-git-send-email-hch@lst.de>
References: <1475236270-18329-1-git-send-email-hch@lst.de>
 <1475236270-18329-3-git-send-email-hch@lst.de>
Message-ID: <1475511015.2510.10.camel@linux.intel.com>

On Fri, 2016-09-30@13:51 +0200, Christoph Hellwig wrote:
> This makes life easier for nvme-cli and we don't really need the uuid
> type anyway to start with.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Looks good,

Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
