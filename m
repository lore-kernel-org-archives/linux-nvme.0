Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC62C4727C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 18:25:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5732D208B8
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 18:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GF9f7roe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5732D208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ak6ZzrDkS4uRsgo9h2mKjBjwiGpVY8k3306nyS3GVlQ=; b=GF9f7roeWX3uc7sVkPDR70JFd
	8ndcK2uJHz05E3EUKqZn1CFBFfnoUVw0kTvuWz/A5o8CK4ETAvMPr4z8x9mu9tCM4xkxpnk07XKYW
	TrgRbGUy+gepxDElLXHwBa6MQToZiLuoApfXdrFsvKGq2ut+Lako92PC2PF0VSflBTUu6Tyv+6OGR
	/f8NmQgYEYy9iSWLN11yN2kWT/E0o8YIaz0sdSo30tlsPcfzM2a5mASbt2yK1nuNusceT7PDO5Xu/
	q7MiMB5zJ2B4+6znSKh32N3BjHsMf5fEE0AQOH2+YDjJ1rWgl3vYbxR8JuIW3vlrZGCiLbjEwuAW2
	EjtoHTAxg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNKJd-0003AR-Pw; Tue, 29 Sep 2020 18:25:29 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNKJb-00039W-AR
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 18:25:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DA1DC67373; Tue, 29 Sep 2020 20:25:24 +0200 (CEST)
Date: Tue, 29 Sep 2020 20:25:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 01/20] block: optimize blk_queue_zoned_model for
 !CONFIG_BLK_DEV_ZONED
Message-ID: <20200929182524.GA12948@lst.de>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-2-hch@lst.de>
 <b92cb028-ef1e-97d6-01d3-e31cc47dd220@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b92cb028-ef1e-97d6-01d3-e31cc47dd220@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_142527_491479_2EB29048 
X-CRM114-Status: UNSURE (   9.99  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 29, 2020 at 01:29:47AM -0700, Sagi Grimberg wrote:
> Looks good, but seems misplaced in this set.

It is needed by patch 2, so that calls to zone-specific code are
optimized away for the !CONFIG_BLK_DEV_ZONED case.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
