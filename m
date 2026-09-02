Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E8DC624D3
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 13:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kavBiDTUNhLbe0WkAn/RoUrynCsWwJgCvvolGGiGIAY=; b=HkQ348S42sZldVt75JXJnGMIyT
	CZdru/AibvfipA/eGgyvMLm/8R/5jvCunyjwZJ2441FGdBip0Adbopn6lAbNbbwpx7izgPrX5b5x6
	QgKD/522/Hny0ToIU15D0qv3yMUDLMdGhwP+p7fxvhRCPnyCS87GGD4nAkwyYH+gSZOiufr3T++Gu
	EBKuBLwZU3UB8nnWjlZQkuBJz1q5ZDu2eUDuKCl25+9nYl377uLsEjaNlBBP1ztQmHg5On0LNQ8Hm
	HOlX1Dx12ejBWIXiB/bAHJTVv4BnehmNjzkxj+ferRjbSYjIjje95SLLxmUgRbOceCqI3sp3n3fA2
	jgQUINDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1lGE-0000000EqEJ-1mqu;
	Wed, 02 Sep 2026 13:44:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1lGB-0000000EqDH-11LE
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 13:44:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E2D2B6732A; Wed,  2 Sep 2026 15:44:11 +0200 (CEST)
Date: Wed, 2 Sep 2026 15:44:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 5/6] nvmet: Add support for configurable crdt (command
 retry delay) attributes
Message-ID: <20260902134411.GA22112@lst.de>
References: <20260823084903.193188-1-sagi@grimberg.me> <20260823084903.193188-6-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260823084903.193188-6-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260902_064415_427559_DCD930C8 
X-CRM114-Status: GOOD (  12.89  )
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

On Sun, Aug 23, 2026 at 11:49:01AM +0300, Sagi Grimberg wrote:
> Paired with host side error injection, allows us to exercise host retry delay

Overly long line.

> behavior.

... and overall an exremely sparse commit message.  І don't really
think we should add code just for injecting errors into the host,
and it seems like that is what this is doing?


