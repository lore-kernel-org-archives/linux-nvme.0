Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41048D12671
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 09:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cfi+xB+JzVEDxR/jxeTriZP8EGaX3Hf1gsHFEWZmCQQ=; b=CAULYAmTuWmrjVa0OzuENmz+4f
	GAMrtpwFbbqFuMOwdYfe/U1bnZHUy94m8kP/mRtMhkHs2sgfv4XbuN3HT53yrfpoNL++GYNHPj2Gc
	cOLcCDooEuR17E3DBzbSbQYIvgG409LWvzl4aAEeViY6jYz/5U6dEVQ6/BkSm9tYiOzLIk5plQmwN
	0OU8GHC5ricY3M/6U1ANLxWnFK7Z2ZaPPwjA/gT0x6tP86gVmhizMlgks+4NLgfMO0zbvxOc18KqM
	0tKiqVCVC69i1yPmx4ddjPX88UMHr3EdxcmcE9l5VfVYNqjOE0L6y6xtIdi3x8oObLKup5x+B+u9s
	VW/iALpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8GHu-0000000GadJ-3oLk;
	Tue, 05 Nov 2024 09:55:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8GHr-0000000Gacg-0YpW
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 09:55:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6D5D568C4E; Tue,  5 Nov 2024 10:55:38 +0100 (CET)
Date: Tue, 5 Nov 2024 10:55:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	anuj1072538@gmail.com, brauner@kernel.org, jack@suse.cz,
	viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com, linux-fsdevel@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v7 04/10] fs, iov_iter: define meta io descriptor
Message-ID: <20241105095538.GA597@lst.de>
References: <20241104140601.12239-1-anuj20.g@samsung.com> <CGME20241104141453epcas5p201e4aabfa7aa1f4af1cdf07228f8d4e7@epcas5p2.samsung.com> <20241104140601.12239-5-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104140601.12239-5-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_015547_620970_3D8E0B82 
X-CRM114-Status: GOOD (  11.05  )
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

On Mon, Nov 04, 2024 at 07:35:55PM +0530, Anuj Gupta wrote:
> Add flags to describe checks for integrity meta buffer. Also, introduce
> a  new 'uio_meta' structure that upper layer can use to pass the
> meta/integrity information.
> 
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>

I'm pretty sure I reviewed this already last time, but here we go
again in case I'm misremembering:

Reviewed-by: Christoph Hellwig <hch@lst.de>


