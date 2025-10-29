Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36563CCF9E9
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 09:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dK8LGSa5kh9cHqVmJnFVTUQx6cHEV5ngEF0WnG14bJs=; b=ovWxHOK/tRAQcEdpoEfu2S1eck
	D9yGR82373r162MQaftfsvpRBIgS5zIB6xKwlaFi2NYb9WjpYWkCmywgrI9JBJH6OW+E8B3AMnKyP
	y8btoagR8GbnFpTc8M+A3p3ydtZYuuTvyZkl4sPRsc6mcP97GvnQrSsJU7FKTIgXCpXlz1HSdBQA6
	UpIW38p3pmLsUHqxvEfZ0agUqIvUN1jF7FtO51ZLlFADOiYWlV/1TAv8hC2nV9ZirxepuQUmh+kgq
	WOM1dRdiEVaPv2oQOf/ql/gYwe+V9KZC5puiMC8xpzOGpvzrUKB/WWWMHliqYat4Rgdvlex1XBKMd
	8RNd7VJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE2ec-00000000WrG-0nuz;
	Wed, 29 Oct 2025 09:39:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE2ea-00000000WqA-1fhZ
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 09:39:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 64A13227A8E; Wed, 29 Oct 2025 10:39:35 +0100 (CET)
Date: Wed, 29 Oct 2025 10:39:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hare@suse.de, kbusch@kernel.org,
	hch@lst.de, sagi@grimberg.me, dwagner@suse.de, axboe@kernel.dk,
	gjoyce@ibm.com
Subject: Re: [RFC PATCHv3 1/6] block: expose
 blk_stat_{enable,disable}_accounting() to drivers
Message-ID: <20251029093934.GB1066@lst.de>
References: <20251027092949.961287-1-nilay@linux.ibm.com> <20251027092949.961287-2-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027092949.961287-2-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_023940_596232_0567D5A7 
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

On Mon, Oct 27, 2025 at 02:59:35PM +0530, Nilay Shroff wrote:
> The functions blk_stat_enable_accounting() and
> blk_stat_disable_accounting() are currently exported, but their
> prototypes are only defined in a private header. Move these prototypes
> into a common header so that block drivers can directly use these APIs.

That's because they are only used by I/O scheduler, which are the only
valid users.  I don't think drivers should touch this, but I'll stay
tuned..


