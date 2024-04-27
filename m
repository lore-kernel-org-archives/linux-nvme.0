Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A41BC4345F
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Apr 2024 07:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wbLezkeIj45Fo8zDt6qlHpOE87ZWcnFIEEiKhZa27BM=; b=CcRfMJxXgYBp47aPQ9cXRzIugr
	bS/tsTPa4EdCmqMraasHuEbBBtDChu+I8jvM6DdpcIQ8U1EYTIiVYucn02JRR4a9HV4XxjPeH4E5F
	BeNSa8ByI/ioPDhxanPnAaXr6LV5tHSrjrXUQ43ujKcFLLpNXzzUWLZNdoX3EX5VASZTEEhzQ01Zr
	vs3OVqFgGziF2nICyLPMrdNPH6m5CGEBLFTJpOiMGzyffXWFu46VuCl5DlAY+TJmGmKC83Ci0eWoZ
	+RxdU4wXeMjBGaqZ9khwov1f112wJL2C/skOXbR1ZhgTHvlvLvWLpEEGkZXL2Kkh+Ffs55XJFYZXh
	0BEEItXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0cKX-0000000F2mN-09ed;
	Sat, 27 Apr 2024 07:18:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0cKU-0000000F2lP-3QuF
	for linux-nvme@lists.infradead.org;
	Sat, 27 Apr 2024 07:18:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AEA2E227AA8; Sat, 27 Apr 2024 09:18:34 +0200 (CEST)
Date: Sat, 27 Apr 2024 09:18:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, kbusch@kernel.org,
	hch@lst.de, brauner@kernel.org, asml.silence@gmail.com,
	dw@davidwei.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 05/10] block, nvme: modify rq_integrity_vec function
Message-ID: <20240427071834.GE3873@lst.de>
References: <20240425183943.6319-1-joshi.k@samsung.com> <CGME20240425184700epcas5p1687590f7e4a3f3c3620ac27af514f0ca@epcas5p1.samsung.com> <20240425183943.6319-6-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425183943.6319-6-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240427_001839_027170_747A486D 
X-CRM114-Status: GOOD (  13.20  )
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

The subjet is about as useless as it gets :)

The essence is that it should take the iter into account, so name that.

> --- a/include/linux/blk-integrity.h
> +++ b/include/linux/blk-integrity.h
> @@ -109,11 +109,12 @@ static inline bool blk_integrity_rq(struct request *rq)
>   * Return the first bvec that contains integrity data.  Only drivers that are
>   * limited to a single integrity segment should use this helper.
>   */

The comment really needs an update.  With this rq_integrity_vec now
is a "normal" iter based operation, that can actually be used by
drivers with multiple integrity segments if it is properly advanced.

> +static inline struct bio_vec rq_integrity_vec(struct request *rq)
>  {
> -	return NULL;
> +	return (struct bio_vec){0};

No need for the 0 here.


