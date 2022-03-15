Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2E2C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 13:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KhOqNwhXH9qPVTmsEa9LpViaMD4BRIEJ0+BqnlSvlho=; b=OIOJn4z7Ew0cA1ZJcQw8oenyZn
	ab/zKx++vUZ3l76QD5ogNEONAFXMJB62KJPrFrQAbPdaIk8uYNdPNVOF3XJcSLm5Y0NUMlXp7XLB6
	tDAH9iWeTWJRGZqLwRVP0ipmb7Y8PXYG+9XfbOOKFpzYeyUPBpPKS5lzv7+5UKcSRR8D4eCM9kJow
	tmrb48hyNndxmb2nu2n21obs+iGdcumvyfyd9fvkmCNxKaximhncrgZ6yW8ARfepQJlGyMOkZjuzU
	JbedU8WiRLYQCCmRIZaG5Y6dqks90/ivMROmmBT6DWeoSfSEQrBgEFaN0dgh5voetAKLVupY32Nc2
	g1jY09Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU7C2-009BVA-0f; Tue, 15 Mar 2022 13:26:30 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU77o-0099cz-V7
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 13:22:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 796F568AA6; Tue, 15 Mar 2022 14:22:02 +0100 (CET)
Date: Tue, 15 Mar 2022 14:22:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mark Hsieh <mark_hsieh@wistron.corp-partner.google.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, hch@lst.de, axboe@fb.com, kbusch@kernel.org,
 alsa-devel@alsa-project.org, Mark_Hsieh@wistron.com
Subject: Re: [PATCH] [v2] nvme-pci: disable write zeros support on specific
 SSDs
Message-ID: <20220315132202.GA12452@lst.de>
References: <20220315132059.12747-1-mark_hsieh@wistron.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315132059.12747-1-mark_hsieh@wistron.corp-partner.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_062209_239784_B2998D71 
X-CRM114-Status: UNSURE (   9.99  )
X-CRM114-Notice: Please train this message.
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

On Tue, Mar 15, 2022 at 09:20:59PM +0800, Mark Hsieh wrote:
> Like commit 5611ec2b9814 ("nvme-pci: prevent SK hynix PC400 from using
> Write Zeroes command"), Micron has the same issue:
> [ 6305.633887] blk_update_request: operation not supported error, dev
> nvme0n1, sector 340812032 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
> 
> So also disable Write Zeroes command on Micron.

This still ignores all the questions I've asked.

