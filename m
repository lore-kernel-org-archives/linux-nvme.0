Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FFBC83F12
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Aug 2023 09:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AhcFCt9O5ij+ppQOCcnINlWLGcs56fy7EpBM1g/w+BA=; b=UmjyLiavxTu2x2iojcsogKfRFl
	3efl53VSgaCTVG+v+jKRMRKphUXlYexmP/GCJ1l/Gdot208og03xKkJEBhcwn5QzZ3rVjyNTGQXmy
	nBajLK9quYxWKKuIlzxXYsXve0G99MjaFWCWZB5BEPXIjnxOdOPq7XAzo5Zv2nGN4kI3ctG4B07pL
	88QSXgQjpWpINuvg9k8wSQ9wsSg7E+yrnwUJU0mNIiYcfWTJ8EgIAFPJ1qfL5U0LyOEqaVLb2Ey7H
	o7dRz5bdSLu81/BsYT8cLzWg2et4Wd5SeEo27IrKqyRTZqQkfnq0LrZwYF7QoO2r0PL3WgiVsOHF2
	dNU19hfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qaYRc-009DhX-2D;
	Mon, 28 Aug 2023 09:22:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qaYRa-009Dgr-0r
	for linux-nvme@lists.infradead.org;
	Mon, 28 Aug 2023 09:21:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8CE236732D; Mon, 28 Aug 2023 11:21:55 +0200 (CEST)
Date: Mon, 28 Aug 2023 11:21:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Guangwu Zhang <guazhang@redhat.com>, Ming Lei <ming.lei@redhat.com>,
	Oleg Solovyov <mcpain@altlinux.org>
Subject: Re: stack smashing detected with 'nvme sanitize-log /dev/nvme0'
Message-ID: <20230828092155.GC30603@lst.de>
References: <dckvq3ohgqdkxg7wz4vslf36gaivgldl742vew67oyh2buj5nr@7ypn5ydt6kss> <20230726131643.GA16186@lst.de> <zopmb3355u2vorlkvas3gqb53azp7qtb7yq2kyc3reezlyqtcy@iev3wkvzumsq> <ZON+qrAwuO3eQB6G@kbusch-mbp.dhcp.thefacebook.com> <4ub43j2q4glt42cwgmaf4cohswt4xaz3lna5nquvb5lavjitvv@tctmuwftqil6> <ZOYnzFSgWAwnkWqs@kbusch-mbp> <j4azjg6k4cg3tynmvyl3qqcd7imcoaisy35ssqob34cw3ox32g@qk7dmqt72vbx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <j4azjg6k4cg3tynmvyl3qqcd7imcoaisy35ssqob34cw3ox32g@qk7dmqt72vbx>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230828_022158_448380_D276D54B 
X-CRM114-Status: GOOD (  13.05  )
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

On Fri, Aug 25, 2023 at 08:36:50AM +0200, Daniel Wagner wrote:
> Okay, let's ignore the regression argument then. But what about the fact
> we are asking for 512 bytes via the kernels API and get too much data?
> Isn't this something we should address? I mean this forces all users of
> this kernel API allocate enough large buffers to handle this device.

There isn't really much the kernel can do except for using an IOMMU
when available to protect itself from this, but that will mean we're
shutting down the device when it does that.

The device just seems completely broken unfortunately.

