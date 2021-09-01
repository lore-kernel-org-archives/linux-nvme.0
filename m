Return-Path: <SRS0=EXAn=NX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8619FC432BE
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 12:24:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FB0B60F92
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Sep 2021 12:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4FB0B60F92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iuktLIzarvHjEJlKtxuBEUVUXP0f2R+/dgHk/7kC0YA=; b=zH3xsUt2xqAB9x
	WwI/f4ZFXAa61wfprkPoba+pY6or5IFtsR2funhUxFDxRd/QeTLuZ0Zfx2oDuY7+gw9RsvmeRkpmv
	uUWNkjDw97iw391zt6N4cvhuC8i5fPua1zSRy54l1xoHGbhP2Yh6DPzBiNh8/9zZngyPZ5v7TDplH
	WOVg4fjQvtR0/2PN20i2bmmo8bAVcGBi/7raD9Vch6twa5aUi2OfjVUUacdo4S5Vgfj0n+2dIcqpI
	1x3lVzaAS2aOf3cpOeGbBW4CqrtNoHLYU/nS5eF3B0ZWCglRL8KIFJSfYuAc7SdILA4Q0eLTiNp1O
	fxrETRQOrMJywA7OBEWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mLPI8-005vLF-E1; Wed, 01 Sep 2021 12:24:32 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLPHY-005vBE-8p
 for linux-nvme@bombadil.infradead.org; Wed, 01 Sep 2021 12:23:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=0YHLZvLC/xYlfH0XYhEFmgV1nKxhlxOO7Z/IK6ZmpAI=; b=svqh8PybeQzFZ8KtxeRMO8ZsQe
 CCqgaOww5GCqk/9gcaqfFcrn39lgz4XyShkpdmiNZNvvWo0O2/4XFlAyJ66QLuv1lLzjm0NL1ddpl
 mF5PjgoYGhBnuJMYXvCB6KhEgwugtl3i73H/6inFdDkC2FWUspmIbSZkbj0w1ij9x7o09WqaDv9fM
 EGHydw9gPJw0GkDF2RywC0+Wc2sW4Kellvtyq8zHy6U0KH4DC1+pwV7Lz1Blvr9SVwf0kDq3lADmy
 AuEOllOcfy91C4m9RbBmTyTwlGYhJNomYGJJSR3BFlEhUQX1cxSrJaU+Y89mPitnVIMwP/uI+Nr2l
 k7DJsB3A==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mLPGe-002Il2-R5; Wed, 01 Sep 2021 12:23:26 +0000
Date: Wed, 1 Sep 2021 13:23:00 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 yi.he@emc.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6] nvme-tcp: Do not reset transport on data digest errors
Message-ID: <YS9wpJwKFyfsAC3V@infradead.org>
References: <20210830133626.139828-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210830133626.139828-1-dwagner@suse.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

Thanks,

applied to nvme-5.15.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
