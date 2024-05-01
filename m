Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A61FCC10F1A
	for <linux-nvme@archiver.kernel.org>; Wed,  1 May 2024 04:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xoIV2mQTHbajPGB3sh4qydWXhcBmusrzNT/mS9c4Zao=; b=OSLzP4OXhMWeLw0SnnTxsO/O44
	S0pPo1+jWUhvigrrXsxzoYwQytKW4dlgZeoWXWMpzMPlj0UIiBaVtlIVh0c5oaBjIC6Vos2Uhqr0P
	0faGYrp51atX9Vn4gyiY1L+AGaoBkZThkye6FjTC++U1d6i6QRFObDVrWvCPNwbNK8ZA55DC5e1DT
	pt5mYWwehNTzsQAfW8jSumf732FQBetKP3jvSZOaBEeL12Y1A6zq6c4coApuWoAYLuCnjI1cEBonp
	Y2AMRCSVqZyJRW7jP3cmL1o+JtujBWibIx6+qiA3HeaICzbk/dmcv8n0l2t/6KTI0wUhPIDdZQV2q
	X4qiH7HQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s21wg-00000008ZPV-2t9n;
	Wed, 01 May 2024 04:51:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s21wd-00000008ZOL-0OoR
	for linux-nvme@lists.infradead.org;
	Wed, 01 May 2024 04:51:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8206168AFE; Wed,  1 May 2024 06:51:45 +0200 (CEST)
Date: Wed, 1 May 2024 06:51:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: `nvme_disable_ctrl()` takes 411 ms on a Dell XPS 13 with SK
 hynix PC300 NVMEe
Message-ID: <20240501045145.GA32110@lst.de>
References: <19a6071a-7fb8-4e0f-8050-6f3ba5ee4774@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19a6071a-7fb8-4e0f-8050-6f3ba5ee4774@molgen.mpg.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240430_215151_297610_49954E3A 
X-CRM114-Status: GOOD (  13.52  )
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

On Wed, May 01, 2024 at 06:29:12AM +0200, Paul Menzel wrote:
> Could a warning be logged, when this takes more than 50 ms with a hint that 
> the disk vendor should improve their firmware?

Not sure why we'd warn about it.  A clean shutdown can definitively take
some time and there's nothing tha forbids it.  I don't think a linux
message is going to have any effect on firmware engineering..


