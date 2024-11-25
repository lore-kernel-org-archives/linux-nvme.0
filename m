Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5A6D3B7E3
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2024 07:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bSrxVhbf3qJdSnitEWmnCipxPm4M24oOB1EM3NKrgnw=; b=r4OSr02xWT8UZl2wg85dtthcQZ
	k6+GIkVpiuvVnLJnSF7EztuWSx6H7NrmrCM8Vy336X9i9w3I4lkf3wgr9/GEF2IsGIp7YmkURCGAm
	squ1ANXyruDWYfsI1Nggty048kh/cHOc0Hs4b/nlRYIyH0Ayp3QRBISPjQjdCxypQOdtRJgHzB0a7
	jRQ3IsH8BsQCP5L1hrlm96VDrw+wSD3QIHd/jxM37RUmBi0+vOiTBeoF/rtPVaJ6VpvG6jQk46acd
	VrZjJa0PXlga4ngU3a72VnupgaPLkJ8NVvvn5Tbw4p+hfxMRR+u2+B9YAvxV2tCRb2JlqwQGPLPCb
	ys/H8WYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFTQl-00000007EZ3-2mWe;
	Mon, 25 Nov 2024 07:22:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFTQj-00000007EYe-1Rkv
	for linux-nvme@lists.infradead.org;
	Mon, 25 Nov 2024 07:22:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 34A3568D09; Mon, 25 Nov 2024 08:22:41 +0100 (CET)
Date: Mon, 25 Nov 2024 08:22:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] nvme-tcp: no need to quiesec admin_q in
 nvme_tcp_teardown_io_queues()
Message-ID: <20241125072240.GB15647@lst.de>
References: <cover.1732368538.git.chunguang.xu@shopee.com> <e7c1d7b531cef5fdd2764719e4ca824477579083.1732368538.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7c1d7b531cef5fdd2764719e4ca824477579083.1732368538.git.chunguang.xu@shopee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241124_232245_519397_38EEC2FD 
X-CRM114-Status: GOOD (  12.11  )
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

On Sat, Nov 23, 2024 at 09:37:38PM +0800, brookxu.cn wrote:
> From: "Chunguang.xu" <chunguang.xu@shopee.com>
> 
> As we quiesec admin_q in nvme_tcp_teardown_admin_queue(), so we should no
> need to quiesec it in nvme_tcp_reaardown_io_queues(), make things simple.

Yes.  And this matches what RDMA is doing.  We really need to go
back to the attempt to consolidaste this code..

Reviewed-by: Christoph Hellwig <hch@lst.de>

