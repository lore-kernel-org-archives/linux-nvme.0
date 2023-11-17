Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12109C072A2
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Nov 2023 13:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m9SIh6UJCRZvsLT6SHHptbjVqGOS8n/FvnvaeADtKSQ=; b=pPYJAmy+cF/A5C5TDob4GSTGpS
	/r6Z+P8MErGKqH1fIgjbkmUxUl1cy5iki2n7b42kJRoAR8hWYM6hIYvCTXNKfacVeIitDlvGNzlh/
	HWBYUOja94NkGR4a75+ZbWNP2CDx//kHshiMGVLn2wvGnzA6/w0Xoy0URc3hfXQyhqIaBvjJEcJVI
	GngbGgQzRBWaCOgqZXsTo7Tcrjm0AsFXYmQmwXuOH90HPfTbEzXreWLntZxzgdcWrWcHCLXj4Mh02
	ASevAPcKiapqhR9aaNLB3R7znTX+OuJO2VKb66gC0Kfvn64bDIkZt8NsBcwLaUi1opQhrXeE1CVBZ
	UEwAOi9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3yu0-006ePc-1g;
	Fri, 17 Nov 2023 13:28:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3ytt-006ePB-2q
	for linux-nvme@lists.infradead.org;
	Fri, 17 Nov 2023 13:28:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 39D486732D; Fri, 17 Nov 2023 14:28:46 +0100 (CET)
Date: Fri, 17 Nov 2023 14:28:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Yuanyuan Zhong <yzhong@purestorage.com>, Jens Axboe <axboe@kernel.dk>,
	hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, randyj@purestorage.com,
	hcoutinho@purestorage.com
Subject: Re: [PATCH] nvme-core: remove head->effects to fix use-after-free
Message-ID: <20231117132846.GB7867@lst.de>
References: <20231115185439.2616073-1-yzhong@purestorage.com> <69218380-45f0-41cc-8a65-50878d44219e@kernel.dk> <CA+AMecFkR0k9ofJt0_iHrPOvfMQ_ePv8QCPYy9m=U7xEjsNCKg@mail.gmail.com> <ZVUiLr3g1_i5YmRQ@kbusch-mbp.dhcp.thefacebook.com> <CA+AMecH1TZc3zVm0OF1VwwTBCrLp9mZnOa5zw59yr_W0WbH_uw@mail.gmail.com> <ZVWR4Rtr1N7IF6iQ@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVWR4Rtr1N7IF6iQ@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231117_052850_086526_7FE52CB4 
X-CRM114-Status: GOOD (  17.46  )
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

On Wed, Nov 15, 2023 at 10:52:01PM -0500, Keith Busch wrote:
> 
> Yes, in section 5.16.1.6, "Commands Supported and Effects":
> 
>   This log page is used to describe the commands that the controller
>   supports and the effects of those commands on the state of the NVM
>   subsystem.
> 
> Oddly enough, Figure 202 says the scope of the log page is "Controller"
> rather than "Subsystem". Sounds like ECN potential. You can memcmp the
> effects log from each controller for a sanity check if you think some
> subsystem controllers messed that up.

If we really want to be 111% sure we could read the effects for all
controllers and do a logical OR of them, but I think the reason for the
per-controller scope is that for odd subsystems where different
controllers don't actually access the same namespaces these flags
could be different, i.e. one that only does KV, one that does ZNS,
one that does NVM and one that is just an administrative controller.


