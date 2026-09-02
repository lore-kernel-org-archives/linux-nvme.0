Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6CBC624D3
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 13:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4M//c1pxEGkkG7xyiqUFbSWrB4p8VkWOh3hlGp0vRuI=; b=psXVAiOVfh1K1u54jtBw0HNpyI
	CaM6gb+5uIiiqmYUjC0sTikuK+x74xjRKAiVCST9u6BCEC6AZm9aC6JPpMI8zaCRQ5Np8b8PtLzTm
	s/NG2LGhEAHJQAWLiIE4L7ysH6UUJxwMuMgvvqpCMX/TXvzoP0l4RmevtEXvzoWvxkL966kaaPDwc
	610GRtQ5XvMfnYuVvtk9KfdrOeL+1F++A4zQTAIzuJM/hiXAs8DEVrZhNfCAj50Mm2rFO/4chWCi/
	lLXDb9biAzwUp3Xb49X7wnfTJlw7/c0r8GSgMpjcZk0VUfjcyfLN6L4pwm/iDIPmM1Cuvok18nph5
	hbVgv7+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1lF4-0000000Eq04-0awS;
	Wed, 02 Sep 2026 13:43:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1lF1-0000000EpzG-3EBs
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 13:43:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6982368BEB; Wed,  2 Sep 2026 15:43:00 +0200 (CEST)
Date: Wed, 2 Sep 2026 15:43:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 4/6] nvme-mpath: support controller crd when failing
 over request
Message-ID: <20260902134300.GD21649@lst.de>
References: <20260823084903.193188-1-sagi@grimberg.me> <20260823084903.193188-5-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823084903.193188-5-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_064303_960303_E0EADE67 
X-CRM114-Status: GOOD (  19.15  )
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

On Sun, Aug 23, 2026 at 11:49:00AM +0300, Sagi Grimberg wrote:
> When failing over a request (due to a path based status) we should
> repect controller crd returned in the nvme completion as much as
> possible. Hence we want to delay the failover command execution by
> the controller crdt.
> 
> We allocate a new nvme_mpath_failover_timer referencing the request
> stolen bios in a staging list, and when the command retry delay expires,
> and only then the bios are moved to the mpath head requeue list which is
> immediately kicked to re-submit these bios. If we failed to allocate
> a fot, we fallback to the existing behavior.
> 
> Given that we now have a new staging list for mpath devices, we drain
> them when removing the device.

Given that we only have a few potential CRD levels, what about having
the "container" for the requing statically preallocated for each?


