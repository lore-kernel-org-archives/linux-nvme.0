Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4DEC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Feb 2022 12:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2K7nJRX81/HSPT8LGvluKHeErBqUoTabB6ivMKCFUfg=; b=sKvU3B4r1fUN4UNHMrgP0OYro/
	aXQtLuk0WE0n3KiWhR4EEjpNFCGsAKGsxrRaD78/WmE01dVlr32G68SJL5zCl1Fv6ro0H6iQfa6Ub
	kWjBON0fI10WgtR+tNx0wmyLpm437ibBwMGjA8thtg7mK+Xo9QBfHbxo5mrcWJpc1JMKxXZQbzq+7
	NYx45WZ3iFjk8iYBa0W3VWGmciRQBZuII4pKowHGiwc4RLBVrL+1Nj3LGvHEWTr4YKq6RzWzSgA2A
	yTvOzhibMSqgy2gLxFJ7NMnWQtss8cNhnIyjpbJ/r+wwXoR48KipdQlHyLxis+7jaEhQraOlyyOIP
	5eXjyPtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nOf4w-00CB8M-Di; Mon, 28 Feb 2022 12:24:38 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nOeW2-00Bz1U-N9
 for linux-nvme@lists.infradead.org; Mon, 28 Feb 2022 11:48:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id CCCDF68AFE; Mon, 28 Feb 2022 12:48:30 +0100 (CET)
Date: Mon, 28 Feb 2022 12:48:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, kch@nvidia.com, sagi@grimberg.me,
 joshiiitr@gmail.com
Subject: Re: [PATCH v4] nvme: add vectored-io support for user-passthru
Message-ID: <20220228114830.GA10899@lst.de>
References: <CGME20220210054304epcas5p14aa9d83205f74b2e4942ed9b4e43fc23@epcas5p1.samsung.com>
 <20220210053755.451855-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210053755.451855-1-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220228_034834_951406_9A1AA9C7 
X-CRM114-Status: UNSURE (   9.53  )
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

Btw, I noticed this is not wired up for the /dev/ngX character device.
Can you send a follow on patch for that?

