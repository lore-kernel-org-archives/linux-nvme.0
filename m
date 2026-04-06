Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A557EF4EAE
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2026 06:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pc9vbImn4CtvOflywsnq4PoTH5Yj0zoYEc5yjB2C9Dc=; b=Bkzm2G4EBWFrWWqcZYVKXhWOL5
	lY1UNIp/FsY0OU5JVbvAXKl5nMVwtwGY5Oms7P/kIfmk6TDttgpIRl8I0fRpI/lQ/fc5HQ+lmdOHU
	XjcMb82jttyTmEVQ2v4xYTZeacJNAbYy1T2HpuvzdfKZxmKrXhEFGlrw6YZS8i1bn0jX9O9/P/HND
	KHmPSWxTKfosbfN9o3ZskYw3sfX28AxIGAepGj4wdw992EfHJUmGF49nA9z3A4MgrPz6GWoxE932M
	ZWu3D1KSwsrHM58iUznG0V6lzqmPM1F8x5oTh9bZ60+wrBO6rT70mPTia4z+mbF/QehTIRe6CfWtJ
	QUutgJ7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9dY5-00000004qlB-2UEi;
	Mon, 06 Apr 2026 06:35:01 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9dY3-00000004qke-3jr6;
	Mon, 06 Apr 2026 06:34:59 +0000
Date: Sun, 5 Apr 2026 23:34:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org
Subject: Re: [PATCH 2/6] block: use integrity interval instead of sector as
 seed
Message-ID: <adNUE67FpIGF_x7Q@infradead.org>
References: <20260403194109.2255933-1-csander@purestorage.com>
 <20260403194109.2255933-3-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403194109.2255933-3-csander@purestorage.com>
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

On Fri, Apr 03, 2026 at 01:41:05PM -0600, Caleb Sander Mateos wrote:
>  void bio_integrity_setup_default(struct bio *bio)
>  {
>  	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
>  	struct bio_integrity_payload *bip = bio_integrity(bio);
>  
> -	bip_set_seed(bip, bio->bi_iter.bi_sector);
> +	bip_set_seed(bip, bio_integrity_intervals(bi, bio->bi_iter.bi_sector));

Should we simply switch bip_set_seed to take a bio bvec_iter argument and
lift all this logic into it?  That feels a lot less fragile.

Bonus points for writing useful documentation for the new bip_set_seed.


