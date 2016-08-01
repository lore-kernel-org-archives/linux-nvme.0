From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 1 Aug 2016 04:19:55 -0700
Subject: [PATCH 1/3] nvme-fabrics: rework nvmf_get_address() for variable
 options
In-Reply-To: <579a9c99.RE/wCYn5/6zl6dPY%james.smart@broadcom.com>
References: <579a9c99.RE/wCYn5/6zl6dPY%james.smart@broadcom.com>
Message-ID: <20160801111955.GB28246@infradead.org>

On Thu, Jul 28, 2016@05:00:25PM -0700, James Smart wrote:
> 
> Revise nvmf_get_address() string to account for not all options being
> present.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
