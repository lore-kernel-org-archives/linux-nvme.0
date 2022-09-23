Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C781ECAAD8
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 15:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kAMD3qBUN64etNIzJs1Tv5jHCLzbrZBozntb4zQ2QWI=; b=1LJNljlMw+BC8oazZWWa3OEEKj
	KZ7z5OhUZlGM4RdlKDF+XEgXMIfeRwfPeQOIDM8o/dTfXtZaQrUV1wjJkh7ukqLu2JYPJLSp5QJM6
	GmyVbgcIF2ljmvalxX2Kg4ibPjhkXr0ST/fqwE30n2xX7ztRlzymoEnPksz3acfHMSefjfnlOziJp
	fZcFSegVVO3t3G2Rtyr/g6PaT0athRtPIY1ejMr56bVOCCS4yrzUc/xJ4qX4SS+oEt1nlCLbFlCx8
	X0WufKA+eEFeabXIuHuR7e8XDGg7kajhgNo3WcNGDybayEQ4SJctft9TItxd+zHxesC7mNDxSxBtZ
	M4RZYuDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obkd5-004ooQ-Kc; Fri, 23 Sep 2022 15:30:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obkd2-004one-VG
	for linux-nvme@lists.infradead.org; Fri, 23 Sep 2022 15:30:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 45EA267373; Fri, 23 Sep 2022 17:30:10 +0200 (CEST)
Date: Fri, 23 Sep 2022 17:30:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH for-next v8 4/5] block: add helper to map bvec iterator
 for passthrough
Message-ID: <20220923153009.GB21275@lst.de>
References: <20220923092854.5116-1-joshi.k@samsung.com> <CGME20220923093919epcas5p3d019fa1db990101478b8d6673ac0eaa6@epcas5p3.samsung.com> <20220923092854.5116-5-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220923092854.5116-5-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_083013_166497_DA402B43 
X-CRM114-Status: GOOD (  12.34  )
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

On Fri, Sep 23, 2022 at 02:58:53PM +0530, Kanchan Joshi wrote:
> Add blk_rq_map_user_bvec which maps the bvec iterator into a bio and
> places that into the request. This helper will be used in nvme for
> uring-passthrough with fixed-buffer.
> While at it, create another helper bio_map_get to reduce the code
> duplication.

As per discussion on the last round - this needs to into
blk_rq_map_user_iov.

