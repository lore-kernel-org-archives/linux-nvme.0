From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 25 Apr 2017 10:54:02 -0700
Subject: [PATCH 1/1] nvme-fc: avoid memory corruption caused by calling
 nvmf_free_options() twice
In-Reply-To: <1493054656-18296-2-git-send-email-emilne@redhat.com>
References: <1493054656-18296-1-git-send-email-emilne@redhat.com>
 <1493054656-18296-2-git-send-email-emilne@redhat.com>
Message-ID: <20170425175402.GA24999@infradead.org>

On Mon, Apr 24, 2017@01:24:16PM -0400, Ewan D. Milne wrote:
> From: "Ewan D. Milne" <emilne at redhat.com>
> 
> Do not call nvmf_free_options() from the nvme_fc_ctlr destructor if
> nvme_fc_create_ctrl() returns an error, because nvmf_create_ctrl()
> frees the options when an error is returned.
> 
> Signed-off-by: Ewan D. Milne <emilne at redhat.com>

Looks good, applied to nvme-4.12.
