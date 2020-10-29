Return-Path: <SRS0=pD35=EE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F43C55179
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 14:55:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85B85206D4
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2020 14:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HWESnL0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85B85206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=YQAQ8pDM3w+o88v0OhD/k87ZV6G4PVJ1x5Jl4y+PHbA=; b=HWESnL0JsmGrwarnaUCHMYCmo
	K1THh2Y9qXic+mNlluNoaeC2GysObsnFGDEbGcwP9m4vEntR8GgP51DzwS45Em8Zeg2uAHJtNY2kh
	PI/jPXhwR7hL32tXzPOPDAyDwuwmIS9/4EYJ/PC6UrJCVYCJ+A3tIutnGEt1Y1ZeS7jQLQmFk0JIN
	7iTH5DpI2lGQXJONHuchqdwBeJ97ZfMKEdi2pakVDMvuuAuZrbCgVDRaDar9d2LU4sOmfD7MhX/93
	9qWYYexWY8PyEHXh7ljz5gLHAC4TX77HhkjWI+iTZCmGre8gbMSiMBxAx5bk+QsJra+mgt3lw12pg
	lofEzZc7A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kY9L0-0003Yz-PP; Thu, 29 Oct 2020 14:55:38 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kY9Kx-0003Xw-Gz
 for linux-nvme@lists.infradead.org; Thu, 29 Oct 2020 14:55:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0E8BE67373; Thu, 29 Oct 2020 15:55:31 +0100 (CET)
Date: Thu, 29 Oct 2020 15:55:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jongpil Jung <jongpuls@gmail.com>
Subject: Re: [PATCH V3 1/1] nvme: Add quirk for LiteON CL1 devices running
 FW 220TQ,22001
Message-ID: <20201029145529.GA19011@lst.de>
References: <20201028091421.GA667673@image-900X5T-900X5U>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201028091421.GA667673@image-900X5T-900X5U>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201029_105535_903574_3557AA00 
X-CRM114-Status: UNSURE (   8.96  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, gloria.tsai@ssstc.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, jongpil19.jung@samsung.com, dj54.sohn@samsung.com,
 Keith Busch <kbusch@kernel.org>, jongheony.kim@samsung.com,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I'm still worried about this.

If power state based suspend does always work despite a HMB and is
preferred for the specific Google board we should have purely a DMI
based quirk for the board independent of the NVMe controller used with
it.

But if these LiteON devices can't properly handle nvme_dev_disable
calls we have much deeper problems, because it can be called in all
kinds of places, including suspending when not on this specific board.

That being said, I still really do not understand this sentence and thus
the problem at all:

> When NVMe device receive D3hot from host, NVMe firmware will do
> garbage collection. While NVMe device do Garbage collection,
> firmware has chance to going incorrect address.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
