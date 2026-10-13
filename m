Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0290CC6B08
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 14:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=TYrlUSxXTc5fLpevvM319umnqD
	Z2I/96SEe1Gip2lS+7XlBUH/lcha8NrjXIHocMv6UXszc/sL5R/yPvzYXcH/PmMpNxVBx0Bw4aPUp
	9XA8GQIsFW0fKXqM5WXgBngplQX87Wa/rNcTPKqy9X3j+Rmo4ewWPVSwZnP8Aci4pm1pfhgCwFjxG
	QKpVWoe7rNQk32bt/n8nyoikbDkuz9x7p8EWgcVa3jlBPNK65m9/CwMI/WPm7ZowOZ895PlgbBLEB
	Cl8xkscVTns5tCtTki/2cpYpSm7HXWKpeT/PuLaaGr+ZU8cwdLurgxOhTqgBilFc+Q6aCXM1xfTJ2
	u2hm3XCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdeH-0000000D8pw-1Q9J;
	Tue, 13 Oct 2026 14:38:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdeE-0000000D8oB-1lat
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 14:38:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1BD9D227A8E; Tue, 13 Oct 2026 16:38:31 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:38:29 +0200
From: "hch@lst.de" <hch@lst.de>
To: Daejun Park <daejun7.park@samsung.com>
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"kch@nvidia.com" <kch@nvidia.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"kanie@linux.alibaba.com" <kanie@linux.alibaba.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] nvmet: fix use-after-free of the old registrant in
 nvmet_pr_preempt()
Message-ID: <20261013143829.GA15964@lst.de>
References: <20261002065931epcms2p1cb2c16f98cf3b05f8c859ad92b0ad465@epcms2p1> <CGME20261002065931epcms2p1cb2c16f98cf3b05f8c859ad92b0ad465@epcms2p5> <20261002070200epcms2p593a0aa8ac482e776e8f1de89d9f212ae@epcms2p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002070200epcms2p593a0aa8ac482e776e8f1de89d9f212ae@epcms2p5>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_073834_600524_4783CE55 
X-CRM114-Status: UNSURE (   8.07  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


