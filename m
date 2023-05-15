Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A294C7EE24
	for <linux-nvme@archiver.kernel.org>; Mon, 15 May 2023 09:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JdFE09vTNwkrPRvCHF1G5MMkzmT3kTnChmoO2DAYmGY=; b=KHAIPNmi6M2Wz1UhznUWgeT9yd
	7ZGwGSEyjnaTv1berbDioZ6LDmjdI6d3tBi6EgpSYUr3xYv/wy5y4/d51ZEhPGsww51XWPIOWdUZB
	rFRVaVklUtwYW8ZPo5/Z1jgntMGObEqWI7FcolL5JoENnfrD9A1gHi42634WgwyltUlRtHHOP0J5B
	1qi1OqpqdBMBj569AGMfgLBggHgCsymKIMlwwpRkmAwGnQaWFbR7YCVe12FZAGCjVxrs1HSukS4LH
	Xz9hDu5P23Yp+NYHtZ9bYlEeZJaNo+2PvmQM7Fnm9z9fB0JzQJ24k9WaqFQrtJGsB3tEBvOT0/s3B
	J6VPR6SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pyUuR-001eH7-20;
	Mon, 15 May 2023 09:54:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pyUuO-001eFL-0O
	for linux-nvme@lists.infradead.org;
	Mon, 15 May 2023 09:54:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8789568C4E; Mon, 15 May 2023 11:54:20 +0200 (CEST)
Date: Mon, 15 May 2023 11:54:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Irvin Cote <irvincoteg@gmail.com>
Cc: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: cleaning up nvme_pci_init_request
Message-ID: <20230515095420.GA24355@lst.de>
References: <20230512060537.70097-1-irvincoteg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512060537.70097-1-irvincoteg@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230515_025424_305683_BEF6C1D4 
X-CRM114-Status: GOOD (  10.32  )
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

On Fri, May 12, 2023 at 03:05:37AM -0300, Irvin Cote wrote:
> Erase the superfluous line that retrieves the nvme_dev.
> 
> Signed-off-by: Irvin Cote <irvincoteg@gmail.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

