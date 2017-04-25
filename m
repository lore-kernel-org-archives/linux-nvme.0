From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 25 Apr 2017 10:57:44 -0700
Subject: [PATCH 1/1] nvme-fc: avoid memory corruption caused by calling
 nvmf_free_options() twice
In-Reply-To: <20170425175402.GA24999@infradead.org>
References: <1493054656-18296-1-git-send-email-emilne@redhat.com>
 <1493054656-18296-2-git-send-email-emilne@redhat.com>
 <20170425175402.GA24999@infradead.org>
Message-ID: <20170425175744.GA3575@infradead.org>

On Tue, Apr 25, 2017@10:54:02AM -0700, Christoph Hellwig wrote:
> On Mon, Apr 24, 2017@01:24:16PM -0400, Ewan D. Milne wrote:
> > From: "Ewan D. Milne" <emilne at redhat.com>
> > 
> > Do not call nvmf_free_options() from the nvme_fc_ctlr destructor if
> > nvme_fc_create_ctrl() returns an error, because nvmf_create_ctrl()
> > frees the options when an error is returned.
> > 
> > Signed-off-by: Ewan D. Milne <emilne at redhat.com>
> 
> Looks good, applied to nvme-4.12.

Actually, it doesn't apply at all.  Can you respin it?
