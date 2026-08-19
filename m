Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A34C5B572
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 05:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fd/JXgft0cuKE/JVXLauvQPBI5Mxi9eKU7Sqyb0gPLk=; b=CGis37agyNJT6izaZc11zwi9jJ
	/2VOdfU5ZHVKyheDijs+MEzfT6r2/10JobyOcrjoigt1Vpq3Pb1YkukcREq5lWbN18dDC3lYLTGJW
	c3nQKN30N6nUJvR+QYl5bObRXv2gXrxxz2PvcJoDvk3lFZlPNTZloTM/lPA/RqlsJe8HxvLhZ2jBk
	85zjclwzFSwMLorb20Tp7xJABbDq4y47rJ3xWTfAOrf4N3bQy2WWKWkDX8UQTvuLhYunMNW2qfTE9
	FCgk9qynOP8VHUe8pwNEU6T7k6cswBH3V7RvGK+ipMaS1ULZOuvSugPgqq+EDGMx3S+2EQblTszxl
	2FvJmAig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwZDN-000000092mT-2fAV;
	Wed, 19 Aug 2026 05:51:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwZDK-000000092lu-3HuM
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 05:51:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 715B168C7B; Wed, 19 Aug 2026 07:51:46 +0200 (CEST)
Date: Wed, 19 Aug 2026 07:51:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chuyf26 <Chuyf26@linux.alibaba.com>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: verify the hostid when looking up a controller
Message-ID: <20260819055146.GB326@lst.de>
References: <20260818162551.1AFD768CFE@verein.lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818162551.1AFD768CFE@verein.lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260818_225150_979961_052E2881 
X-CRM114-Status: GOOD (  14.44  )
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

On Tue, Aug 18, 2026 at 06:25:51PM +0200, Chuyf26 wrote:
> nvmet_ctrl_find_get() matches controllers by cntlid and hostnqn only.
> The hostnqn is not a secret: any host that can reach the subsystem can
> put an arbitrary NQN into its connect data.  A malicious host knowing
> or guessing the NQN and controller ID of another host (controller IDs
> are allocated sequentially) can therefore attach its queues to that
> host's controller, issue commands on its behalf, or disturb its I/O by
> tearing down the shared controller state.

Yes.

> Also require the hostid from the connect data to match the controller's
> hostid.  The hostid identifies the host installation and is generated
> locally, so it cannot be chosen by an attacker to impersonate another
> host.  Controllers that were created without a hostid keep the old
> behaviour.

Of course it can.  Please don't send completely useless LLM garbage,
thank you!


