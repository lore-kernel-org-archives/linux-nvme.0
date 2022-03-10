Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928B5C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 08:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2NRMjd8XgbdbTJRGlkBeThO+jox1fvNkWACWV3l5SY8=; b=nM1FhffGLSl8xlwkHT9TVY8iDy
	mJ+i+g3yRf7V2A5cGMm3J+s8jnm1so4HbAgG+SL6izlu/gfdI919I63fwVqzs4ShJyooxymdtx6Ug
	9UXfOUspAE1p2QDX1N06dmCs10C7eJwFZ8/iFaHGibmTC/XAiRqsjRfVCg10x00UQaZrVlXhCTxNW
	dK7450sH/1MMyaZaIUI3LYiQX2yg97YSQPDOhBYaHbvMt847njIRte5KDzhqkVYaFkbhvTgkRgP06
	7KQgdtpieHRqmNSYwn/tpuRZD9r/YMUn/+quonMKAOiCieBMUtrMeqXJf3J0sEgUyO3US4+priV5A
	eRc7iKtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSEDy-00BupF-VT; Thu, 10 Mar 2022 08:32:43 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSEDu-00Bund-V5
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 08:32:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3EFC468BFE; Thu, 10 Mar 2022 09:32:34 +0100 (CET)
Date: Thu, 10 Mar 2022 09:32:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, sbates@raithlin.com,
 logang@deltatee.com, pankydev8@gmail.com, javier@javigon.com,
 mcgrof@kernel.org, a.manzanares@samsung.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com
Subject: Re: [PATCH 08/17] nvme: enable passthrough with fixed-buffer
Message-ID: <20220310083233.GB26614@lst.de>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152709epcas5p1f9d274a0214dc462c22c278a72d8697c@epcas5p1.samsung.com>
 <20220308152105.309618-9-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308152105.309618-9-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_003239_182805_7F8310DA 
X-CRM114-Status: GOOD (  14.68  )
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

On Tue, Mar 08, 2022 at 08:50:56PM +0530, Kanchan Joshi wrote:
> +/* Unlike blk_rq_map_user () this is only for fixed-buffer async passthrough. */
> +int blk_rq_map_user_fixedb(struct request_queue *q, struct request *rq,
> +		     u64 ubuf, unsigned long len, gfp_t gfp_mask,
> +		     struct io_uring_cmd *ioucmd)
> +{

This doesn't belong into a patch title nvme.  Also please add a proper
kernel-doc comment.

> +EXPORT_SYMBOL(blk_rq_map_user_fixedb);

EXPORT_SYMBOL_GPL, please.

> +static inline bool nvme_is_fixedb_passthru(struct io_uring_cmd *ioucmd)
> +{
> +	return ((ioucmd) && (ioucmd->flags & IO_URING_F_UCMD_FIXEDBUFS));
> +}

No need for the outer and first set of inner braces.

> +
>  static int nvme_submit_user_cmd(struct request_queue *q,
> -		struct nvme_command *cmd, void __user *ubuffer,
> +		struct nvme_command *cmd, u64 ubuffer,
>  		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
>  		u32 meta_seed, u64 *result, unsigned timeout,
>  		struct io_uring_cmd *ioucmd)
> @@ -152,8 +157,12 @@ static int nvme_submit_user_cmd(struct request_queue *q,
>  	nvme_req(req)->flags |= NVME_REQ_USERCMD;
>  
>  	if (ubuffer && bufflen) {
> -		ret = blk_rq_map_user(q, req, NULL, ubuffer, bufflen,
> -				GFP_KERNEL);
> +		if (likely(nvme_is_fixedb_passthru(ioucmd)))
> +			ret = blk_rq_map_user_fixedb(q, req, ubuffer, bufflen,
> +					GFP_KERNEL, ioucmd);
> +		else
> +			ret = blk_rq_map_user(q, req, NULL, nvme_to_user_ptr(ubuffer),

Overly long line.

