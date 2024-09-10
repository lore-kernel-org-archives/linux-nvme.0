Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048E8EDE99A
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Sep 2024 15:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ttSFQqif/royemXRHZNLLk8HgLuRnSJzNxjnj4ZBt2w=; b=k0ifnF+t6Dccf6ur/P59lYekbQ
	EgZlWhs0qpbXEZh9D+3BioqPrcblrB/4zZ5UcDKeFzEY/6osm49WsrMH6BXO4fw2dstIYrGp/Ce5a
	C7UtOE58gGjxntV7Vxqd+mX3JXOeiDg5D51lDfvPFcS8afRT6nyXN+/AasIxDF8zE77+DGLYYTmp6
	oUIu+9lKOQpCY0olz3t64tjdzUa4JZokSMNxgqKq5yly0q/VB3XyfTPYMgGagIaKXDxzilvYAKg3c
	XXGAkXaA1bf0kdJeqmiZGxkDQiFWSp6N8GBeVRcykIBKJzzvuxzWHYd5c59KJz6gWUXNG7m+ocx/x
	F20RR4Vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so31g-00000006Bgj-1wnY;
	Tue, 10 Sep 2024 15:43:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so2pO-000000067k9-2T0K
	for linux-nvme@lists.infradead.org;
	Tue, 10 Sep 2024 15:30:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2688E227AAE; Tue, 10 Sep 2024 17:30:47 +0200 (CEST)
Date: Tue, 10 Sep 2024 17:30:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 02/10] block: provide helper for nr_integrity_segments
Message-ID: <20240910153046.GB23805@lst.de>
References: <20240904152605.4055570-1-kbusch@meta.com> <20240904152605.4055570-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904152605.4055570-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_083050_790235_F5FF8BF1 
X-CRM114-Status: GOOD (  11.32  )
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

On Wed, Sep 04, 2024 at 08:25:57AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> This way drivers that want this value don't need to concern themselves
> with the CONFIG_BLK_DEV_INTEGRITY setting.

Looks ok:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Although I wonder if we should simply define the field unconditionally
given that it is only 2 bytes wide and packs nicely.


