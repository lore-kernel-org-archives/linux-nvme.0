Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66CC4C8302D
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jun 2025 13:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4APg6yVz6kgCDi8Roxi56DKotyt2hsl1mO8Xu/bEAlI=; b=CiKgfrWpTUY4bzAyTMgF6PKdCL
	KO7sJFHVnBvwmNuaHw0MZMBW6bjQqnngM1+UptkZV8xlvYsNGGePzBmAH+tn//df7EYuOxsDfQ1sT
	U0rdLTMQiVgaZyWscYsieGjTNETU00SWW3jXLNfg8vz6O1ZxMBJ9sAvEICPwqm/YGaizUzG4J7iBx
	ccP7S+q0mLYVquiK6Uz+JxfCJHV6YDZGMeP4UrUQaNuApD4tdq4KyWpHHvMA9K4D9uG6VoLO0v1RS
	WK3m26YePygXEJ2Uv2tCg3yoXzwTE10D9U0zkQLgmf/EsethdVJH7K0XmBvq1nJ7St1OHES4sTg2L
	GWsxUzmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWEw3-00000002RmA-3pwa;
	Mon, 30 Jun 2025 13:52:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWEoE-00000002PxW-0G9V
	for linux-nvme@lists.infradead.org;
	Mon, 30 Jun 2025 13:44:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 531C9227AAD; Mon, 30 Jun 2025 15:44:24 +0200 (CEST)
Date: Mon, 30 Jun 2025 15:44:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Geliang Tang <geliang@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-multipath: fix suspicious RCU usage warning
Message-ID: <20250630134423.GA27544@lst.de>
References: <bf6d5783deb070c5d238a6fb6b0d2b5c9367841c.1751269314.git.tanggeliang@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf6d5783deb070c5d238a6fb6b0d2b5c9367841c.1751269314.git.tanggeliang@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250630_064434_243647_8D5D8D28 
X-CRM114-Status: UNSURE (   9.28  )
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

Thanks,

applied to nvme-6.16.

