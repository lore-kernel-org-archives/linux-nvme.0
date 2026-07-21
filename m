Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5806C4451C
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2026 12:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OV27g3RrMSDD/33GKiBvboum/LxBfxvjNbEEz31xIGU=; b=ow3XvROK5BSEgF1FZZ+sY/KGhU
	M2q0lDpcVi0fYE+4OX8MqRw3ZDtgMcrzpdugGFvZsQhmzQv0jg91nrJ1AcS5xK6/so/2YW/LZLalI
	g7W0FnY4U3fkBGS6UmtSRMRXeLeoXy/ZTnn6c4JObnJTGZXR2igBGUgAMqiMEBtJz5yYkZHJRaXou
	AUQoWHeoubuuOxcF4ADxDbUtKGb+N9ehBuiRAsILSL5iLiTSMGZDCYYTYIpu4VZlh7guEXKB5046g
	HG8PLa9IRngEo4FERCqnG5zJWE6+6Ne/+yyxI74zO9oNNGraDoA7YdxUGulFSh9Vonr+6A8lB/Twr
	KNNwLL5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmA3P-00000009TFP-3TSJ;
	Tue, 21 Jul 2026 12:58:35 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmA3M-00000009TBg-1I1u
	for linux-nvme@lists.infradead.org;
	Tue, 21 Jul 2026 12:58:34 +0000
X-UUID: c0f78e24850311f1aa26b74ffac11d73-20260721
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:4d9ee047-bc8d-4d67-81e7-3787af46d65d,IP:10,
	URL:0,TC:0,Content:7,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:17
X-CID-INFO: VERSION:1.3.12,REQID:4d9ee047-bc8d-4d67-81e7-3787af46d65d,IP:10,UR
	L:0,TC:0,Content:7,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:17
X-CID-META: VersionHash:e7bac3a,CLOUDID:f78ff7ca3a42265b6d3fdcecbb22ee5b,BulkI
	D:2607202247250Q01JUM8,BulkQuantity:1,Recheck:0,SF:10|64|66|78|80|81|82|83
	|102|127|136|841|865|898,TC:nil,Content:4|15|50,EDM:-3,IP:-2,URL:0,File:ni
	l,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,
	DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c0f78e24850311f1aa26b74ffac11d73-20260721
X-User: sangyao@kylinos.cn
Received: from sang-pc [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 353180495; Tue, 21 Jul 2026 20:57:39 +0800
Date: Tue, 21 Jul 2026 20:57:35 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v1 2/2] nvme: stop using queue_limits_stack_bdev for
 namespace heads
Message-ID: <20260721125735.6kcnu4vuysbj6ali@sang-pc>
References: <20260720022205.1798805-1-sangyao@kylinos.cn>
 <20260720022205.1798805-3-sangyao@kylinos.cn>
 <20260720144649.GC16699@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720144649.GC16699@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_055832_665088_2D2B0CE9 
X-CRM114-Status: GOOD (  24.90  )
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

On Mon, Jul 20, 2026 at 04:46:49PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 20, 2026 at 10:22:05AM +0800, Yao Sang wrote:
> > NVMe namespace heads are not generic stacked block devices.
> 
> Not many things actually are, which leads to every recurring problems
> with the stacking scheme..
> 
> > Execution features and request limits continue to accumulate
> > conservatively as paths are refreshed.
> 
> What is this supposed to mean?

Sorry, that wording was unclear. This means that the common fields continue
to use the existing block-layer merge rules as paths are refreshed

> > Keep the helper local to NVMe so its field ownership remains explicit and
> 
> What is "field ownership" supposed to mean?

What I meant was grouping fields by how they are updated: Identify-derived,
head-owned, feature, and path fields.

> > does not impose NVMe namespace-head policy on mapped devices.
> 
> I think you need to clearly state in what way we'll want to diverge
> here.

The key difference is that NVMe paths address the same LBA space, so they do
not need component offsets, mapped alignment, or generic topology merging.

> > +static void nvme_apply_ns_head_identify_limits(struct queue_limits *lim,
> > +					       const struct queue_limits *ns_lim)
> 
> Two tab indents, please.

Yes, I'll fix the indentation.

> >  {
> > -	t->max_open_zones = min_not_zero(t->max_open_zones, b->max_open_zones);
> > -	t->max_active_zones =
> > -		min_not_zero(t->max_active_zones, b->max_active_zones);
> > +	/*
> > +	 * Identify-derived namespace/head attributes come from the refreshed
> > +	 * NVMe namespace limits, not from generic mapped-device stacking.
> > +	 */
> > +	lim->features &= ~(BLK_FEAT_ZONED | BLK_FEAT_ATOMIC_WRITES);
> > +	lim->features |= ns_lim->features & BLK_FEAT_ZONED;
> > +	lim->logical_block_size = ns_lim->logical_block_size;
> > +	lim->physical_block_size = ns_lim->physical_block_size;
> 
> A lot of this still duplicates the core code and creates a nightmare
> when we add new fields.
> 
> Can you try to refactor the core code into lower level building
> blocks and reuse as much as possible while also making the policy
> differences clear?

The initial NVMe-local change was meant to limit block-layer changes and
preserve the established blk_stack_limits() behavior for existing callers
while the common field semantics were unclear.

I agree that the common rules should not be duplicated. I understand "the
core code" to mean the block-layer stacking code in blk_stack_limits(). Based
on that, I would first add a behavior-preserving block-layer refactoring and
factor out the fields that have identical composition rules for generic
stacking and same-LBA paths. In pseudo-code, the helper and its call sites are:

/*
 * Combine constraints required by every underlying queue that may execute
 * an I/O, independent of mapping, topology, operation, user or resource
 * policy.
 */
void blk_stack_io_limits(struct queue_limits *t,
			 const struct queue_limits *b)
{
	/* clear unsupported NOWAIT/POLL/PCI_P2PDMA bits */

	/*
	 * Apply min_not_zero(t->field, b->field) to:
	 * max_hw_sectors, max_dev_sectors,
	 * seg_boundary_mask, virt_boundary_mask,
	 * max_segments, max_integrity_segments, max_segment_size.
	 */
	 
	/* apply max(t->field, b->field) to dma_alignment */
}

blk_stack_limits(t, b, start)
{
	/* existing inherited-feature handling */
	blk_stack_io_limits(t, b);
	/* all remaining existing code stays in its current order */
}

nvme_apply_ns_head_limits(lim, ns_lim)
{
	/* existing Identify/head and inherited-feature handling */
	blk_stack_io_limits(lim, ns_lim);
	/* all remaining NVMe-local code stays in its current order */
}

Existing DM, MD/RAID, DRBD and Btrfs callers keep using blk_stack_limits()
without a behavior change, while NVMe calls the lower-level helper directly.

The key distinction is the composition relationship: NVMe native paths
address the same LBA space, while generic stacking may remap LBAs and compose
topology. This version therefore factors out only the mapping-independent
rules shared by both cases into blk_stack_io_limits(), and leaves the remaining
handling in its existing paths. I would split further only when another common
composition rule is identified.

Does this match the block-layer boundary you had in mind, or should this
series factor out additional composition rules from blk_stack_limits()?

Thanks,
Yao

