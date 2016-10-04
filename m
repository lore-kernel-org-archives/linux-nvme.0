From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 4 Oct 2016 06:57:07 -0700
Subject: [PATCH 2/7] nvme-fabrics: sync FC-NVME header with standard
 updates
In-Reply-To: <57f34bb2.yNdu+Ipyn59s5QRk%james.smart@broadcom.com>
References: <57f34bb2.yNdu+Ipyn59s5QRk%james.smart@broadcom.com>
Message-ID: <20161004135707.GA23761@infradead.org>

On Mon, Oct 03, 2016@11:26:58PM -0700, James Smart wrote:
> 
> Sync FC-NVME header with standard updates
> 
> This patch contains the following 2 mods:
> - Since the prior patch posting, transports were assigned a status
>   code range to use (0xB0-0xBF). Updated codes to be in the range
> - cmd_iu changed in T11. The 2 reserved words, previous at words
>   2 and 3, were moved to after the sqe.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>

As Hannes already mentioned: please squash the spec updated into the
original patches.

>  enum {
>  	/* Generic FC failure - catchall */
> -	NVME_SC_FC_TRANSPORT_ERROR	= 0x00A0,
> +	NVME_SC_FC_TRANSPORT_ERROR	= 0x00B0,

Please add the error values to nvme.h itself so they are in the
same place as the other error codes.
