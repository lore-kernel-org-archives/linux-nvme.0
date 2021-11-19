Return-Path: <SRS0=7/ZJ=QG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87234C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Nov 2021 17:11:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5756061A53
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Nov 2021 17:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5756061A53
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VszlENjCJ3QQ5KvFIeSsfGOEUhb2i0XX2RaQ3R5pOdc=; b=nL+1K14Ok/Q6ocoJWSzj0hHcNT
	uV1XHqETWPIy4HYtQKqskaA1qtCHaYuXJcG2ROOaj/JZAR0GbB+p32MZ03W6OuUOEMAMr56JRO1Xm
	v0s9BRPGtxV5m2NHZKHEr8kDInXmBwiI/CZm9napNMpR2k3b6/Oo14PMq5JvjygYQ0acJc1Ohns6I
	DBK4zmCiFiKv9QUQV2OMEJfCR5ZzqxfK5y6+WQG4WtWm0R7lZlADxTG9CFvNyTArKzykv9O0rXjy1
	1E/y4B3VbNqBb0uTCVCez/mYbHH+HLAB7mkK+yg0qnuq/mifWvEZspepk/ITB+Avra9kGwYxoa9Ec
	NFbl6HtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mo7Ph-00B9tz-RX; Fri, 19 Nov 2021 17:11:01 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mo7Pf-00B9t9-UE
 for linux-nvme@lists.infradead.org; Fri, 19 Nov 2021 17:11:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 51E7268AFE; Fri, 19 Nov 2021 18:10:56 +0100 (CET)
Date: Fri, 19 Nov 2021 18:10:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Klaus Jensen <its@irrelevant.dk>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v2] nvme: fix write zeroes pi
Message-ID: <20211119171056.GA15601@lst.de>
References: <20211110091906.20958-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110091906.20958-1-its@irrelevant.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211119_091100_147640_6E46CF18 
X-CRM114-Status: UNSURE (   9.26  )
X-CRM114-Notice: Please train this message.
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

Thanks,

applied to nvme-5.16.

