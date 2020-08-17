Return-Path: <SRS0=j3u6=B3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A943FC433E3
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 08:18:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7381A20738
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 08:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LkdBSmEs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bEzGEewr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7381A20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hqwff9n7ppHTbLBnXv9Vsk64gA0JeP/PiC79lXlHWAo=; b=LkdBSmEsdCwLnKhqWUU71lGLRX
	KWAK9H3Th6DqhIy6UWtH/dIvYUzfg9iLirK79Y0pOgpHlQoIXsBFg/qK8k3K+My2DrYYZU2uCPlcJ
	Ca7rbE1AjgWAfvlPGpR3p6h9Z1ZhS6vLBLEKU7i9KgmBYxU23nYDajgFBa6I3BlkXMRToL/fjSMJU
	ih+yBI3CSG7M39vFAKuoBkT1f1bHYUoCuWf6j6L/1Vf1vA2zC5AqAvxFaXCK4e5RKQYXRAAXBw17n
	Fz4Sz0Nymi/5r9v4+FHpj3DiNA5uJb2Izaj5FQWCQ4r9fU5LOr7mJzEyhIzeswmqy/mbAqIXICi0k
	F84WDc9w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7aLY-0007Fh-67; Mon, 17 Aug 2020 08:18:24 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7aLB-00077A-UV
 for linux-nvme@merlin.infradead.org; Mon, 17 Aug 2020 08:18:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=2RXRwzyyCrAAz0F4ELykxuubcnVXgcrShES7ANRlwzw=; b=bEzGEewrgpBB5uMxG9kAqTF0SO
 hjUgm2767uJGmv9CmI7Zx5qSm5dEcZdL2hEGt0dFd3LxpC/th2uyjpGXZzEF+HhRJAB3LQ5LKLbb7
 gHn1lI1hwc6lg1QFrg6hjcI43opgO/QTBlCBR+WmJQu2RFUio66baj3+59sKOAIk9h8d2bXbjOiVb
 1iWCZnb9t3Bv0JbAjG2pJUYT3r5ZvQWDW9fGkO8TKj2r3UFq7iQ/onjQaTQ8lchwuHqXA1oDV0SkA
 yKTFJXEaoMqIBubwEkCNvP4EYlOfToKS7ZDwoBIaNx05V9b0twH9TcUN8loEvvwVDS+hDWfBhH+fv
 56xS0Scw==;
Received: from 213-225-37-56.nat.highway.a1.net ([213.225.37.56]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7aL7-00044t-O3; Mon, 17 Aug 2020 08:17:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: nvme completion handling refactor and fix v2
Date: Mon, 17 Aug 2020 10:15:40 +0200
Message-Id: <20200817081544.837699-1-hch@lst.de>
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

Changes since v1:
 - add a new patch to handle the path related errors using the
   SCT class

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
