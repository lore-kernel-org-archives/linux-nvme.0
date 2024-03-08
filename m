Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582D5C54E4A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 16:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ErpHc1wY2DdF0bf6Q9UhJU+DPezctKIzUn/CC0SyCKA=; b=rNavb8vGnR+tBaRkIcHsj7lQ/q
	nc18ztXcSlYrRYYoKV14erMna+LSD00oI1EbIUb36ZOPeViwEUWdnGC8C55MDjevmeSuBCEFJqYAO
	hRIhNxrqfJSp9iLLoKxx0nc86juevQyO/OVNSp7YfivK7vpzLKdfa7fiqOZXYTEcS184tfuWkb82J
	uUy+aJvXd9c0xIouRATf9MFi2a9R2+nhiuxAHshOHO4/GgCPWazFojgyjpsfzATVLIOaZDQJTrmdd
	+v7x4J+R6nKTJj5DXC0PSIpKUOWzqjQ8M/z95qIfRJTqhIhWospFDrH71NVmE/cmObv2c6mwb2sv4
	EDOWfCfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ricxu-0000000A8Ff-4AgE;
	Fri, 08 Mar 2024 16:20:58 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ricxs-0000000A8EZ-3tSd
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 16:20:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1A4D760BBF;
	Fri,  8 Mar 2024 16:20:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60436C433C7;
	Fri,  8 Mar 2024 16:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709914855;
	bh=ErpHc1wY2DdF0bf6Q9UhJU+DPezctKIzUn/CC0SyCKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oOqIRNKYQyBSgDKchr1dqeMPkSnzXpkU/Pndku+d4RC/Ionp+ZzufiJpMyy0MyZaL
	 G+iSApMsPgJr6i891Kry8xxccLnTqIhGxvKhCuyfgwh1EZCzIhujDmppYkMFtvounW
	 psGSAkJBdFqvB2xH3d1MmroZGFqtzmEfCXJmZbll00VaIMwhRGjcWHFrdMxZJgTaX3
	 QXtz8CZK4u71Bg/gGrtnpVnlvizGf2RuFLevJ4IPvBULbGnHV6BZJL5RHhPs7nh8BT
	 Rb/1cE3j7WPpz5XHa1n8GFmhh00lBTiob3htw33nhjKTP/0oOt02GNOeCcRVlUrXsp
	 v4cTnQm9WFDkw==
Date: Fri, 8 Mar 2024 09:20:53 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvmet-tcp: do not continue for invalid icreq
Message-ID: <Zes65U5rNfzWLJ9U@kbusch-mbp>
References: <20240308071105.6175-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308071105.6175-1-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_082057_277816_6CE87CC0 
X-CRM114-Status: UNSURE (   5.94  )
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

Thanks, applied to nvme-6.9.

