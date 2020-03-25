Return-Path: <SRS0=GoWw=5K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8894AC1975A
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Mar 2020 13:21:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5793B2078A
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Mar 2020 13:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tadfPUNV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5793B2078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=EhNl5oWWvduwnIbKW0wEPQtmhtlE68PfE3ZVTemPDbE=; b=tadfPUNV9uvRcC
	3eFsv/nVM5ixPmLupFaiuWQPKEZyD/i6+89f2zG8E8H8RsFh+cF3oJpSd/VSgwIbk1M4G6jf61zx2
	L013/gaBS+WCVku3cYBZrAx/uPihjfnACx7mmRxLk6keBPJIClUsV7wE/tQ9vstUKn5r6kvbApgRz
	Cz24vkZsyg/OUGrt+E/q/Xkny0EWyUEfjR+ZuUb1xhYRz34tPqlaF/uJtgRxA9Gke4HBeJm8Q4nMA
	Bl00yc+0U1Hue5KFU8dCLb9Smy26nFYwLQl6Jv6SxBWwJtRYWFr3VfgeIhmLZDzr8I1LUUQuqNruT
	h9ZIi+hWVDYtbPu3bd/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jH5yh-0002ck-OH; Wed, 25 Mar 2020 13:21:51 +0000
Received: from 213-225-10-87.nat.highway.a1.net ([213.225.10.87]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jH5yf-0002b7-Kt; Wed, 25 Mar 2020 13:21:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: misc nvme cleanups
Date: Wed, 25 Mar 2020 14:19:34 +0100
Message-Id: <20200325131937.1198787-1-hch@lst.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Keith and Sagi,

a few trivial cleanups based on some exploration I've done for namespace
types support.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
