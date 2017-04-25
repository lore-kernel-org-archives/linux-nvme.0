From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 25 Apr 2017 11:00:25 -0700
Subject: [PATCH 1/1] nvme-fc: avoid memory corruption caused by calling
 nvmf_free_options() twice
In-Reply-To: <20170425175744.GA3575@infradead.org>
References: <1493054656-18296-1-git-send-email-emilne@redhat.com>
 <1493054656-18296-2-git-send-email-emilne@redhat.com>
 <20170425175402.GA24999@infradead.org>
 <20170425175744.GA3575@infradead.org>
Message-ID: <20170425180025.GD3575@infradead.org>

On Tue, Apr 25, 2017@10:57:44AM -0700, Christoph Hellwig wrote:
> > > Do not call nvmf_free_options() from the nvme_fc_ctlr destructor if
> > > nvme_fc_create_ctrl() returns an error, because nvmf_create_ctrl()
> > > frees the options when an error is returned.
> > > 
> > > Signed-off-by: Ewan D. Milne <emilne at redhat.com>
> > 
> > Looks good, applied to nvme-4.12.
> 
> Actually, it doesn't apply at all.  Can you respin it?

Meh, wrong tree.  Everything is fine and it's applied.
