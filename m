From: hch@lst.de (hch@lst.de)
Date: Fri, 29 Jun 2018 11:16:45 +0200
Subject: [4.18-rc2 regression] WARNING: CPU: 0 PID: 1 at
 drivers/nvme/host/pci.c:2570 nvme_probe+0x212/0x440
In-Reply-To: <21f7e774-0be6-f314-b531-b1772dff90fd@kernel.dk>
References: <Y7NwNf_cB9KfO8DYYkrQt_o4SQ6oFpyHC4ALTdU8K-1rKTpeY7zlAkEhN8mWm30q7cJTVBGDVqfJ65JvkV14hbUFcXQkwQ7CsrloyrFvglw=@protonmail.ch>
 <20180624211520.GA16559@sbauer-Z170X-UD5>
 <tRUGFtw_8KFYLF98YCf0vYYQagRWk-ZNXonQVla7xXvTgMCb7Z2kDM0ocI1O8Nhhbqn-oBlVNM8ue3TABpo3PqIA-_B_lhhceT4dPFGrSd0=@protonmail.ch>
 <703993f1-31a2-c175-f4cb-541713fac14e@kernel.dk>
 <SD8jBn-I8XgsF2B_aXrAPtIvG5xW3rTqE9qLrv-XWe3856vgUkFTUIRKtp2JmJ3oYgOpbXvw1pKtQalOTloi1DfrWcQQJXi-AzRDh-o4VtQ=@protonmail.ch>
 <21f7e774-0be6-f314-b531-b1772dff90fd@kernel.dk>
Message-ID: <20180629091645.GA16878@lst.de>

>  static inline struct scatterlist *__sg_next(struct scatterlist *sg)
>  {
> -#ifdef CONFIG_DEBUG_SG
> -	BUG_ON(sg->sg_magic != SG_MAGIC);
> -#endif
>  	return sg_is_last(sg) ? NULL : ____sg_next(sg);
>  }

All that sg mess in i915 really needs to switch to using the generic
helpers instead of being opencoded..

But except for that the sg_magic removal looks good to me:

Acked-by: Christoph Hellwig <hch at lst.de>
