From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 11 Feb 2016 07:20:02 -0800
Subject: [PATCH] block: Initialize max_dev_sectors to 0
In-Reply-To: <1455148367-25208-1-git-send-email-keith.busch@intel.com>
References: <1455148367-25208-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160211152002.GB3072@infradead.org>

On Wed, Feb 10, 2016@04:52:47PM -0700, Keith Busch wrote:
> The new queue limit is not used by the majority of block drivers, and
> should be initialized to 0 for the driver's requested settings to be used.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> Cc: Christoph Hellwig <hch at infradead.org>
> Acked-by: Martin K. Petersen <martin.petersen at oracle.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
