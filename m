Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77E4CED270
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 06:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2drC/JlOlHJJmKZwP3FO7E3jcvPLbxtA1R82nXgTQ6I=; b=QPDRsBs7N9JRm9a7gtOW/u1hOJ
	aEfthZOMllv7gRy6AwMpOS6I2vK5tURCHMWkDDnjVxejYrvX5/lT+wCVGJJC2GNwTZtN3JXctJrgt
	heF6dr23eKpeNdagZjciwFPUD9lNNfRK8/k3GXaBhsJCw2MUsyEta0mcIbD1EgmxdtKgZvxdrC7oD
	4/RcN2bEpSKzPPj8btz6KiYQQx7l5QjRa4SyDjgw8FbuXTmsHTz1LWs/oO90VhOt5OXg3bTzp6Ov1
	zCi46+1mLifOvRRiPVA+x+ZUfl0NhV1/jvE68vHC+eif/eniccFVu8pNl5/1cVizD/BdUjP2fcHjG
	a3BqaLjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy3tr-00000004gF1-49yo;
	Tue, 08 Oct 2024 06:40:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sy3sW-00000004g3m-1Q8G
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 06:39:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F2A9C227A88; Tue,  8 Oct 2024 08:39:17 +0200 (CEST)
Date: Tue, 8 Oct 2024 08:39:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] nvme-multipath: simplify loop in
 nvme_update_ana_state()
Message-ID: <20241008063917.GA22424@lst.de>
References: <20241007100134.21104-1-hare@kernel.org> <20241007100134.21104-2-hare@kernel.org> <ZwQCSHIuoXgF9su3@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwQCSHIuoXgF9su3@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_233928_549455_B0A0DB0B 
X-CRM114-Status: GOOD (  14.91  )
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

On Mon, Oct 07, 2024 at 09:46:16AM -0600, Keith Busch wrote:
> This patch looks good to me.
> 
> Your commit log is word wrapping a bit short, though. We standardize on
> 72 characters.

The for loop is also missing a space before the opening brace while
we're nitpicking.

The reason the code was written this way is that when there are a lot
of namespace in an update we now need to a full list scan for each
one, which can add a lot of overhead.  So I guess we'll need to see
why it is important to change it to counter that tradeoff.

