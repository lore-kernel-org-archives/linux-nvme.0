Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65E8C624D3
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 13:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=16PEi9jd0ixs1aeh2LsRZMr/41j6KntSQFCIYpVLbRY=; b=GYWCIIfUnBHzUHqo/vXMAe/YbJ
	zYQPiWiD+6FqzxSzod2Xen72xmFzJKPA6Sza51wWh1FMW1gKk2EYmi9F0Qt8QpvH4kZ3uYcFCoAnB
	WCiqxXz8ZdZs/A5BqZRxPppky2Iq5jfyV0d0BH3vSrDIWLUMotc9MRngri/oPTmzwK21OFjTOLzN1
	i2xtRmUrEIJa2YMND9QiRblANfFdMZtSRhdPxtD80hz0E1cqApprIyA3E2KryZ0I9BdvV6vSbGi1c
	rWaRMaeps69L8wAkbnPxlHOcnrssC3Y8/Y9JcOi1HADHTEmu9SJ8w8citLa9J9wz6oj4x/q7NH/Jm
	oXcDEkSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1lJP-0000000EqbJ-464C;
	Wed, 02 Sep 2026 13:47:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1lJO-0000000EqaW-0tfs
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 13:47:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A6F1B6732A; Wed,  2 Sep 2026 15:47:29 +0200 (CEST)
Date: Wed, 2 Sep 2026 15:47:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: fix cntlid uniqueness check for different hosts
Message-ID: <20260902134729.GA22248@lst.de>
References: <20260823001509.119740-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823001509.119740-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_064734_401163_9704B9A9 
X-CRM114-Status: GOOD (  16.07  )
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

On Sun, Aug 23, 2026 at 03:15:09AM +0300, Sagi Grimberg wrote:
> A single physical host may use a separate {hostnqn, hostid} identifiers
> when connecting to a controller.

Not really.  As the hostid defines a host.  Linux just might be able to
implement multiple hosts when it say hosts multiple containers.

> It is possible that the a distributed
> nvmf controller may generate unique cntlid per hostnqn and not globally
> unique. Hence, validate the cntlid is unique per nvmf host.

If it does so it is not spec compliant, and we should not support it.


