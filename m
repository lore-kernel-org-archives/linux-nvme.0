Return-Path: <SRS0=X9H7=XW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B60C4360C
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 21:22:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 810BD205F4
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 21:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I1Mijxpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810BD205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=54p/h0kzmQKUdPVwX5IZeh3zFWPGMFNGYJBXxdllGCI=; b=I1MijxpcUjJ/JZ
	Y7KbtBU8Slk85/+frG9oRbIRoLJyn4f4obWzB0ndRo5tjLHug74uEgOefR7L+uPW17I7SpK/rQECM
	aQfgDwGcOj7V1LYfZqCmowx+0HBF5f5uSrTpU4Bs8RM3hh16fJzzlmZ/iE+kT2vpnD/VhONjO45XH
	EaInrh8rM10c+yCf5bpUAqKXnnimXOryagnF7TiWBy2VjGTQEAma+qyLRSVqEZGnmxAFyS5UZy/Ma
	zFXtAB0P5k4gIc6vBjFv+Gmf1L4nvmFj63A/31iyfY8zSybRs+85wAjix9+WECyIozMA9VW3iFoRQ
	qqT3HWPddqbmJrExkLNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iDxgw-0004p2-D6; Fri, 27 Sep 2019 21:22:18 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDxgt-0004o5-Gg
 for linux-nvme@lists.infradead.org; Fri, 27 Sep 2019 21:22:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B0B9668B05; Fri, 27 Sep 2019 23:22:12 +0200 (CEST)
Date: Fri, 27 Sep 2019 23:22:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH v2 1/1] nvme-rdma: Fix max_hw_sectors calculation
Message-ID: <20190927212212.GD16819@lst.de>
References: <1569099499-24017-1-git-send-email-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1569099499-24017-1-git-send-email-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190927_142215_702538_703F89E5 
X-CRM114-Status: UNSURE (   9.73  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: sagi@grimberg.me, israelr@mellanox.com, linux-nvme@lists.infradead.org,
 keith.busch@intel.com, shlomin@mellanox.com, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Sep 21, 2019 at 11:58:19PM +0300, Max Gurtovoy wrote:
> By default, the NVMe/RDMA driver should support max io_size of 1MiB (or
> upto the maximum supported size by the HCA). Currently, one will see that
> /sys/class/block/<bdev>/queue/max_hw_sectors_kb is 1020 instead of 1024.
> 
> A non power of 2 value can cause performance degradation due to
> unnecessary splitting of IO requests and unoptimized allocation units.
> 
> The number of pages per MR has been fixed here, so there is no longer any
> need to reduce max_sectors by 1.
> 
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
