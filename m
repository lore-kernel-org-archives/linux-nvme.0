Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E9CC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 08:07:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3044622D2C
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 08:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3044622D2C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RXZ8t+l8ReER83faE7+VYnt+TTo0SF/tRyIzNCbHtIA=; b=hyC+B3nN6EJ89xVw/RQKt/e/a
	y/gUklD7oHNKNKHCtiwdrQVpOuQGbMIO1giwkyejHrJX/hts7MdSn6D2YWV/eI3XM8/If/19ORYGd
	GpS1+owVBIxAgftvHm8FO0iNckCn5o7nUzoWPDhb9D1+1/dKPw0n4J8qjtdbrdsjt22CaIQPsnLv6
	RV0wcnqWhxAL/2ljrbfLBtTwddc9aIZcFlHBsTInGlm/vR9S5jbZC9nogJ80cLxGO8nMQtyjIlaiL
	5HeoeAeEmiuIXbhW/8v49eY8/Hhhs+snPDrunL+zBBFY7rYLno7oOTrwEB6zx2hdIR0mPHDD6q7dK
	SoEmrJ94w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzEhe-0004vi-RT; Tue, 12 Jan 2021 08:06:58 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzEhb-0004tx-Ba
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 08:06:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BCD0D67373; Tue, 12 Jan 2021 09:06:53 +0100 (CET)
Date: Tue, 12 Jan 2021 09:06:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH 1/3] nvme: support command retry delay for admin command
Message-ID: <20210112080653.GB24949@lst.de>
References: <20210108144659.7126-1-minwoo.im.dev@gmail.com>
 <20210108144659.7126-2-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210108144659.7126-2-minwoo.im.dev@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_030655_562977_423A465F 
X-CRM114-Status: UNSURE (   7.55  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Except for the little wording issue this looks good to me.  I'll pick it
up for nvme-5.11 and will fix up the commit log.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
