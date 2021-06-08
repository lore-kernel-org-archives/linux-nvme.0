Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406CEC47082
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 12:37:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F1C06101A
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 12:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F1C06101A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AdwmYf54A6LtbW6THojsjU9hIA2xsozG06vKBcRAwdI=; b=fAb2cr+FAL51LU
	JSydciEzZOkI2qzAMHr7RBwFeVgMrQ9FKgxtRZ+nz6tPa0S6gvIkBCW2U3RT/ZOnavh1AVXW5W6cv
	JsmpBo0KErv+nYJgbusJPER9ZN82w/e9j+6+wkcD9tP2oubEoyyDKj4uS7VCP7vYNrNrYKIoaWjb1
	oYrF5JrHhOADVjYSGytxhTAt/bTnBTljRQAk7u4toEBGO2DKrGxCDmAN0SB8Xo1BK3EVl3fcoXv9U
	ABwm7y3leEukjnyB731e41Dykl3HG6BJFDd8idbf5LoTyK89XCDX1ng6VI2fIgI8geHaUCTk7rmLQ
	uiNFySHJzbzYs0oAeuOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqaye-008OgY-H2; Tue, 08 Jun 2021 12:37:04 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqahf-008ISV-L2
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 12:19:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E93F468AFE; Tue,  8 Jun 2021 14:19:25 +0200 (CEST)
Date: Tue, 8 Jun 2021 14:19:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "David S . Miller" <davem@davemloft.net>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Omkar Kulkarni <okulkarni@marvell.com>, Hannes Reinecke <hare@suse.de>,
 Dean Balandin <dbalandin@marvell.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>,
 Shai Malin <smalin@marvell.com>, Petr Mladek <pmladek@suse.com>,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: NVME_TCP_OFFLOAD should not default to m
Message-ID: <20210608121925.GA24201@lst.de>
References: <39b1a3684880e1d85ef76e34403886e8f1d22508.1623149635.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <39b1a3684880e1d85ef76e34403886e8f1d22508.1623149635.git.geert+renesas@glider.be>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_051931_905634_5B2311B1 
X-CRM114-Status: GOOD (  14.98  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 08, 2021 at 12:56:09PM +0200, Geert Uytterhoeven wrote:
> The help text for the symbol controlling support for the NVM Express
> over Fabrics TCP offload common layer suggests to not enable this
> support when unsure.
> 
> Hence drop the "default m", which actually means "default y" if
> CONFIG_MODULES is not enabled.
> 
> Fixes: f0e8cb6106da2703 ("nvme-tcp-offload: Add nvme-tcp-offload - NVMeTCP HW offload ULP")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Err, where did this appear from?  This code has not been accepted into
the NVMe tree and is indeed not acceptable in this form.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
