From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 19 Apr 2017 12:33:30 -0700
Subject: [PATCH] nvmet_fc: Change traddr field separator to a colon
In-Reply-To: <20170412221518.23473-1-jsmart2021@gmail.com>
References: <20170412221518.23473-1-jsmart2021@gmail.com>
Message-ID: <20170419193330.GA18191@infradead.org>

On Wed, Apr 12, 2017@03:15:18PM -0700, jsmart2021@gmail.com wrote:
> From: James Smart <jsmart2021 at gmail.com>
> 
> The FC-NVME spec revised syntax to avoid comma separators.
> Sync with the change in the parser for traddr on port attachments.

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
