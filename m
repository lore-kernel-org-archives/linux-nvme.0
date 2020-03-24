Return-Path: <SRS0=HgRT=5J=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168FEC43331
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 15:42:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF11C20714
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2020 15:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WvRverR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF11C20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4i/K9i/HjsfKagJFjxajbeXZ9g+ZLbHSJ2EQu3LNAIs=; b=WvRverR26Wu4iL
	POiB+tiyaejo2wdJTcjpB6G0TbENTi0JrI906CdJodr5HuBvBHyC3ok7pD/w1I0RgPV3QUfYdCnpK
	ygtIY0TsTA/L2sn/DEqJgviPSjXrqlqTJb5HysfMRB2kHHYU18m1WrGI11LuJSlHl7WcjaUl046Cr
	iuzx7cL92/+XV2bk5phtECAejDKzw+/DdLjpUSj0+0Ajm8rWm5IwBDepJ0Xze7IIj/JGkGvk0PjoA
	aWIEbLL//eWxDqfFPv6Awf71XK3RpEoR+7JUde5mGRiXsABKra/UL+BLv9Rvv7qQF8Yy4DwWI/2av
	NI2dXdhRSIMKmCx/0ZPA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jGlhL-00037h-VM; Tue, 24 Mar 2020 15:42:35 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jGlhK-00037G-1H
 for linux-nvme@lists.infradead.org; Tue, 24 Mar 2020 15:42:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 33AE268AFE; Tue, 24 Mar 2020 16:42:32 +0100 (CET)
Date: Tue, 24 Mar 2020 16:42:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: Israel Rukshin <israelr@mellanox.com>
Subject: Re: [PATCH 3/7] nvme: Fix ctrl use-after-free during sysfs deletion
Message-ID: <20200324154231.GB22197@lst.de>
References: <1585063785-14268-1-git-send-email-israelr@mellanox.com>
 <1585063785-14268-4-git-send-email-israelr@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1585063785-14268-4-git-send-email-israelr@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200324_084234_218131_1A189A16 
X-CRM114-Status: UNSURE (   9.66  )
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
Cc: Shlomi Nimrodi <shlomin@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 Sagi Grimberg <sagi@grimberg.me>, Linux-nvme <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Mar 24, 2020 at 05:29:41PM +0200, Israel Rukshin wrote:
> In case nvme_sysfs_delete() is called by the user before taking the ctrl
> reference count, the ctrl may be freed during the creation and cause the
> bug. Take the reference as soon as the controller is externally visible,
> which is done by cdev_device_add() in nvme_init_ctrl(). Also take the
> reference count at the core layer instead of taking it on each transport
> separately.
> 
> Signed-off-by: Israel Rukshin <israelr@mellanox.com>
> Reviewed-by: Max Gurtovoy <maxg@mellanox.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
