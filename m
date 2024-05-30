Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500E1C25B74
	for <linux-nvme@archiver.kernel.org>; Thu, 30 May 2024 17:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=riYy3ZF/DXZSvnaDClQemQIZqCA/ak0shSpxL0rjed0=; b=nzn8KJaUxgtaRAydWEkiUykmaB
	8ZqcD1VjMKaRmOlzgWxnPQahfaTsIVSiUxRa5hP2YqVt2p9h8C0FgUB3vYNqLrU3ybOApEWZjS6zV
	0om6E7mtbB2gVZM8WnopNKPo9RTyf8L1psPSGTfJ/WxaBj2sGWWawRqI46CDBwM7/MumlPf21qqqf
	O0bLHZd8Amy/FqiHMMfuIiqbpev2OR4n3aGZtRMP+5lVYKGEqNXxE6i2u+VkHWgSaY8vrNCMt5XnK
	4DzFzpYsPlV01B+YJuKXKodiZ/6G3w554zrp7JHqWyzoxOdSeR79MvXk6KCLUgvTWn8nQu7N6gaOw
	U7npP+bQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCjVP-00000007yx8-0N28;
	Thu, 30 May 2024 17:23:59 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCjVM-00000007yuu-33WC
	for linux-nvme@lists.infradead.org;
	Thu, 30 May 2024 17:23:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C8D8D628C6;
	Thu, 30 May 2024 17:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD41C2BBFC;
	Thu, 30 May 2024 17:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717089835;
	bh=cYB6EiiLkNAxIFoAwxrhbsyUrl0rJ+/K6flQe9CKBAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tf0BEYNBi5ASvvcfPg4jBosiNwawOtumYHwK8AUfABputiwHAXCURv5C+S/+t7YcQ
	 POgxjmJQzBHO+27iGpTKZrWnXF8LNo683o83O4qJQ7yt68KYZEQ/YUjmEz840YvzKr
	 77Lj/i5+Qq9EHpH/FQGJRuj1jIJ9x9+wP33gwNQYUPmxQtsnSSzmBTUqDOe5K3opRh
	 Wg+/6wu3yE0JPIwNE8He/favJwqjD/dLZxDWSYMeJsT3NPksLjuRmdi6k0rWOi32SI
	 4tYRMfkDngtG+yuopgM44P/7++ItpELtuqzsYhVa+KR0px0l3E/CuzYunu8r1jUtAl
	 xzYcw0yNCMwbg==
Date: Thu, 30 May 2024 10:23:53 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-fc: Remove __counted_by from
 nvmet_fc_tgt_queue.fod[]
Message-ID: <20240530172353.GA3018978@thelio-3990X>
References: <20240529-drop-counted-by-fod-nvmet-fc-tgt-queue-v1-1-286adbc25943@kernel.org>
 <0b2b4a2a-83df-4b79-a295-4da91c841587@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b2b4a2a-83df-4b79-a295-4da91c841587@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_102357_037377_4D7CA9E9 
X-CRM114-Status: GOOD (  26.45  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Jiri,

On Thu, May 30, 2024 at 08:41:18AM +0200, Jiri Slaby wrote:
> On 29. 05. 24, 23:42, Nathan Chancellor wrote:
> >    drivers/nvme/target/fc.c:151:2: error: 'counted_by' should not be applied to an array with element of unknown size because 'struct nvmet_fc_fcp_iod' is a struct type with a flexible array member.
> 
> The same as for mxser_port:
> 
> struct nvmet_fc_fcp_iod {
>         struct nvmefc_tgt_fcp_req       *fcpreq;
> 
>         struct nvme_fc_cmd_iu           cmdiubuf;
>         struct nvme_fc_ersp_iu          rspiubuf;
>         dma_addr_t                      rspdma;
>         struct scatterlist              *next_sg;
>         struct scatterlist              *data_sg;
>         int                             data_sg_cnt;
>         u32                             offset;
>         enum nvmet_fcp_datadir          io_dir;
>         bool                            active;
>         bool                            abort;
>         bool                            aborted;
>         bool                            writedataactive;
>         spinlock_t                      flock;
> 
>         struct nvmet_req                req;
>         struct work_struct              defer_work;
> 
>         struct nvmet_fc_tgtport         *tgtport;
>         struct nvmet_fc_tgt_queue       *queue;
> 
>         struct list_head                fcp_list;       /* tgtport->fcp_list
> */
> };
> 
> The error appears to be invalid.
> 
> > This will be an error in a future compiler version [-Werror,-Wbounds-safety-counted-by-elt-type-unknown-size]
> >      151 |         struct nvmet_fc_fcp_iod         fod[] __counted_by(sqsize);
> >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    1 error generated.

My apologies, I should have done the work to fully uncover the flexible
array member within 'struct nvmet_fc_fcp_iod' from the beginning and put
it in the commit message. I did not think of using pahole to make my
life easier until just now and I knew from the other examples that I had
and clang's code that it was not incorrect. Sure enough, it comes from
'struct bio' within 'struct nvmet_req'.

struct nvmet_fc_fcp_iod {
...
	struct nvmet_req		req;
...
};

struct nvmet_req {
...
	struct bio_vec		inline_bvec[NVMET_MAX_INLINE_BIOVEC];
	union {
		struct {
			struct bio      inline_bio;
		} b;
		struct {
			bool			mpool_alloc;
			struct kiocb            iocb;
			struct bio_vec          *bvec;
			struct work_struct      work;
		} f;
		struct {
			struct bio		inline_bio;
			struct request		*rq;
			struct work_struct      work;
			bool			use_workqueue;
		} p;
#ifdef CONFIG_BLK_DEV_ZONED
		struct {
			struct bio		inline_bio;
			struct work_struct	zmgmt_work;
		} z;
#endif /* CONFIG_BLK_DEV_ZONED */
	};
	int			sg_cnt;
...
};

struct bio {
...
	struct bio_set		*bi_pool;

	/*
	 * We can inline a number of vecs at the end of the bio, to avoid
	 * double allocations for a small number of bio_vecs. This member
	 * MUST obviously be kept at the very end of the bio.
	 */
	struct bio_vec		bi_inline_vecs[];
};

It sounds like it is already on Gustavo's radar to look into for
-Wflexible-array-member-not-at-end, so he said he would take a look. It
may not be a quick fix though (I'll let him comment on it further if he
is so inclined). It will be needed in stable because the patch that
added __counted_by to this structure is there, so considering this patch
for that sake may still be worthwhile, then it could be reverted with
Gustavo's changes.

I would really like to avoid leaving the build with tip of tree Clang
broken for a long period of time, as we qualify it against the kernel
continously so that any fixes needed on the kernel side are merged and
ready by the time the toolchain is actually releases (such as this one).
I am fine with waiting some time to see how this plays out but I don't
want it to be forgotten about.

Cheers,
Nathan

