Return-Path: <SRS0=nO+g=NO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF79FC4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 08:02:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 951F26135A
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 08:02:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 951F26135A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iuktLIzarvHjEJlKtxuBEUVUXP0f2R+/dgHk/7kC0YA=; b=vxB/+LhdlKuVRv
	iNTkKOe5sxK4AQJSpDfW3tGLHfHaDgVUcAnC/qPvVr+lA9bxXJWVF2lcM/ixz9kTXY9MV+YVtb8VD
	YIi+scDqfAVGoRWjNqL5WKlnWB87aohWsCLWiHEKfklw2LqG6hrtO+KH/hwSy+qkP/q6l28SPCjnQ
	VBXu9dFqXATC0SIoGpHbEpKtwAtBXn20IZ522dWThAZtJasNvTglVfRw0UqMPVDAZwGxwODMbl01m
	LKM4om5lvlos524yTy4HErGCHISxr+obuU7wbbccl6lXHnP/UiDZ8MOMZlnf5sNqRkmC0EDISakaM
	zG9YrgD0nB/fCmoah6Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mI4tq-00Fq5R-Hj; Mon, 23 Aug 2021 08:01:42 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mI4t5-00Fq2j-1w
 for linux-nvme@bombadil.infradead.org; Mon, 23 Aug 2021 08:00:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=0YHLZvLC/xYlfH0XYhEFmgV1nKxhlxOO7Z/IK6ZmpAI=; b=LwsmtFikbcXbaYBXBdZ3mQcZMl
 DTnWULW8+ctm9puDTLm96Ubh7pAXsKXZ9n3U4SyScm98QBozTDAU5GyTKDmkaPfY7dxuHcA5omXlA
 PC0xanTLSBd9dvpUhAEd11qa2XS4HE55nk1tqush/NPKSK1/sTnkfpB/YcvcpN5yfpIWtnQD61xbi
 UjQLE0XKpdOQ1WAtdg1PS5k1Wm6LrFEQzgCAw6ny3DkVlda+KOwFWVMRt/9dtmhdgzkZZpZ4Lp2ZS
 i7sS9Q3y/x7ivnfEeChXPM0MVraFjPak+0EA3B/GJFuKVjInRxUvNLLQY+0H5Ur7YigvCqaSTRfzl
 99qRcLPg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mI4sJ-009SGY-Dj; Mon, 23 Aug 2021 08:00:16 +0000
Date: Mon, 23 Aug 2021 09:00:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v3] nvme: revalidate paths during rescan
Message-ID: <YSNVh+o3ZCBQaa1G@infradead.org>
References: <20210811152803.30017-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210811152803.30017-1-dwagner@suse.de>
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
