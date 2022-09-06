Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB17C38145
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 06:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a2AF0aQEQSwAHqXnLm7de9orYzFVgRlo4m4m3BkOK5Y=; b=HcCiui2T9C4SDCrwOFg3OOJgUL
	Qdowk9bnQRdVCEt2E6Zugmj1xKKDEd206s6XgVPlJ0Xzgj89nsFoEpjVgs4KYjpHJKOllMOyqPvZD
	olZNpteA7DpcEAcnqrrdhc9JKK+V7Z73reA3heQ21ob9XfOAd1KQVgtOQaLMGgIEuxFqjGAOV8x6V
	CAE9rpdHVBtflT2emiS0ZAZJTJbpxi3C9H/TlNzM6Syj9ls7TnYws1ejvze7veMuwbKflDgGEOu/0
	W7NERvvuUUIAsi+U9idPxUgBUni7Xd4wQccccWXa179maHWLrinkNlVHRsJn6B6IJTI2/hU68+5Dt
	w6v48a4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVS1j-00ANyp-N8; Tue, 06 Sep 2022 06:25:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVS1c-00ANsD-KX
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 06:25:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 096F468AA6; Tue,  6 Sep 2022 08:25:22 +0200 (CEST)
Date: Tue, 6 Sep 2022 08:25:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH for-next v4 3/4] block: add helper to map bvec iterator
 for passthrough
Message-ID: <20220906062522.GA1566@lst.de>
References: <20220905134833.6387-1-joshi.k@samsung.com> <CGME20220905135851epcas5p3d107b140fd6cba1feb338c1a31c4feb1@epcas5p3.samsung.com> <20220905134833.6387-4-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905134833.6387-4-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_232532_840116_FE291737 
X-CRM114-Status: GOOD (  11.77  )
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

On Mon, Sep 05, 2022 at 07:18:32PM +0530, Kanchan Joshi wrote:
> +static struct bio *bio_map_get(struct request *rq, unsigned int nr_vecs,
>  		gfp_t gfp_mask)
>  {
> @@ -259,13 +252,31 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>  		bio = bio_alloc_bioset(NULL, nr_vecs, opf, gfp_mask,
>  					&fs_bio_set);
>  		if (!bio)
> -			return -ENOMEM;
> +			return NULL;

This context looks weird?  That bio_alloc_bioset should not be there,
as biosets are only used for file system I/O, which this is not.

