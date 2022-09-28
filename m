Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AA9C04A95
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 17:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rYY1DM8XOUmTVXSrwfIMCimhhxRtsp3w4Gionlqkq9Y=; b=3wEdKLQJsG9wF4QexGgwdk4VCx
	yWNeRdQkRzL0q1vAaR79QdgYHVaC2aVEHkRM7gIP7kP+YRamSWglbY/A/JA61Vy4O//GWmVV2ghKC
	FYNIf/D+cuRBXNWfaxHRrkEeSXLOM8mTozQuRfZxHFch1Fm7hZhwuorKlhtVQ1wva5Mjga0tQpWot
	galeX0emzPOTDS8iDntKSjqymUDQfgCKdxiPUbzsOfXr5J58dLVud3A6fllRGOKZxoJm4RfrUgOny
	/CQyO5A48R+m9R+MVNAegpaF/KzRpez4CehAQKhbNJ3Q4W6Q4g4DWrd5VqVn+Q+fLph6PK97RXYYg
	vjivzwdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odau7-00HOKU-8v; Wed, 28 Sep 2022 17:31:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odau4-00HOJB-SY
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 17:31:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3B89D68BEB; Wed, 28 Sep 2022 19:31:21 +0200 (CEST)
Date: Wed, 28 Sep 2022 19:31:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH for-next v10 5/7] block: factor out bio_map_get helper
Message-ID: <20220928173121.GC17153@lst.de>
References: <20220927173610.7794-1-joshi.k@samsung.com> <CGME20220927174636epcas5p49008baa36dcbf2f61c25ba89c4707c0c@epcas5p4.samsung.com> <20220927173610.7794-6-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927173610.7794-6-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_103125_087703_5A3C20B4 
X-CRM114-Status: GOOD (  14.33  )
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

On Tue, Sep 27, 2022 at 11:06:08PM +0530, Kanchan Joshi wrote:
> Move bio allocation logic from bio_map_user_iov to a new helper
> bio_map_get. It is named so because functionality is opposite of what is
> done inside bio_map_put. This is a prep patch.

I'm still not a fan of using bio_sets for passthrough and would be
much happier if we could drill down what the problems with the
slab per-cpu allocator are, but it seems like I've lost that fight
against Jens..

> +static struct bio *bio_map_get(struct request *rq, unsigned int nr_vecs,
>  		gfp_t gfp_mask)

But these names just seems rather misleading.  Why not someting
like blk_rq_map_bio_alloc and blk_mq_map_bio_put?

Not really new in this code but a question to Jens:  The existing
bio_map_user_iov has no real upper bounds on the number of bios
allocated, how does that fit with the very limited pool size of
fs_bio_set?


