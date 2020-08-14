Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26789C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 15:17:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5715207DA
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 15:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F9JKKJhE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PGIrcbUH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5715207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QgiiGMabmcM1VzW/hedeJ/2/6aQL5qJ4K2OB+fm1Gac=; b=F9JKKJhExlByAIbNRulQqgZpWY
	K1KHe0HnlDEQU3Wzp0HBOnPK4xBFpR0AlQGiN84W4DWced7yh2bx3gschNXBCnde6C7bLJovB501w
	ZhGiCdNlqHZVRSLOt6OghidUVhv1RUV8zJPMChcrX+lDBvcAYppZoqoHU2oL22zKpXysAfHcaItk0
	aZHoyOKMk0KHbq0nfJx72WVYs0Xrsy7qOljs0l8G34gRXxjthkoegR7sITLBlkGM1kPb37hnnatym
	SMFBE/KGtXaQT+dJu1/IdFQvX8XF9YqtF8gup+Y64RpFxsyb3x1852vx2X/0bBtZJeGT8yh0yS2q9
	qQEylW+w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6bSl-0005JN-2r; Fri, 14 Aug 2020 15:17:47 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6bSj-0005JD-D4
 for linux-nvme@merlin.infradead.org; Fri, 14 Aug 2020 15:17:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=djWKqvQcBEm+Lokpt4tBTlEsuwB9bPzOrVUMGC5cC9o=; b=PGIrcbUH7B3RUP1JU05ggguQx5
 SgB7hZiB7T9Mys7OazcUo/tsXEfB8LlkyCdPr5ysBuSoWXvFNoz2V8fbyvIvrTe+ri4KKrj3Fnw5p
 BlUR9AavuaFsy6BVWCnEZtKQzC6ZkO3e4Wuj1wi04xD/BBEKDQJLuTAIvrNMYbDdNqZ/BZVd2TCQm
 3+a/VTHwJys2S5MmDuc3pbdvOs9z/9qrBCReJ8GtoSG0T+0cexig0F/2XzFh0G9JcBZNCRxf+dM83
 fTDAsuUQCvcZz8/BitDWpRO5S0SoVopamTk4vNsgONHymFvktAjH+kwOzeLvo0AXi9Ar9x+RwD++Y
 8Gyjge5A==;
Received: from 213-225-37-56.nat.highway.a1.net ([213.225.37.56]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6bSf-0002R5-GJ; Fri, 14 Aug 2020 15:17:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: nvme completion handling refactor and fix
Date: Fri, 14 Aug 2020 17:15:25 +0200
Message-Id: <20200814151528.277465-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,

the first two patches refactor the common nvme completion code
to be a little less obsfucated, and the third one is the fix
from Chao to redirect to a different path ported on top of these
changes, which now make the fix very simple.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
