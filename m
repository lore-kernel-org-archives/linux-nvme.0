Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A35EB64DD
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jul 2023 11:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Ld+oL2sUScywtAQu0Q4rb6yazN
	XnI8vxOF7mTd4+WxvdA0Gc/y47RJLr3EN5tq/NjmKVXTSSd2ClpFRx4EJXXZbIyBZS39+2adUznjL
	g5J3i9Bdz4f3S+mgq20J21aDtYYR2u/cHZ7+XP9+JPhK77YfBdBHH2NsSJv5p7GNPb3yFcFc9X9fr
	LroTVG75iJ1ac07ZW7SLdwm/rZ046tnuZu1av0Jlr25UFcM8LEk1ohIbkV0v9Bu+Q8DaS29eINH3Y
	WdGws6lBWX9L91C5JDJK6CQG0RzqP8/OGu4A93IIxwFhXy8NBTXUtyzTmXRH2REYeEzgnbKRoA9Ve
	CW2GNiFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJudV-0036CV-0M;
	Thu, 13 Jul 2023 11:37:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJudP-0036A3-1m
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jul 2023 11:37:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F3FDF6732D; Thu, 13 Jul 2023 13:37:16 +0200 (CEST)
Date: Thu, 13 Jul 2023 13:37:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org, Guangwu Zhang <guazhang@redhat.com>
Subject: Re: [PATCH] nvme-pci: fix DMA direction of unmapping integrity data
Message-ID: <20230713113716.GA23306@lst.de>
References: <20230713092620.2076742-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713092620.2076742-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230713_043723_736112_CCE6AB1C 
X-CRM114-Status: GOOD (  10.78  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

