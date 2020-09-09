Return-Path: <SRS0=XP6N=CS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306F3C43461
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2020 20:33:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9F0D20C09
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2020 20:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I2QWxi23";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vw5cGVfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F0D20C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=c1/JIV2Bg1iLgkBjJC4HdpB01FFi7yYKsqa15MiVKZo=; b=I2QWxi23+bMObzyYRlE3ASCUjD
	jOH4o4UQQmCU4y5CcocGcnD4fB5q7+eMrlmqVnJI3dxihcMORppDHrxIMpJsNCpVUNBT+PIic40wS
	DI4JMOPZx7mqEq4J6sopLNERVX5oRw5bD9rUj5zbyvHa22Iy7QMQWl5JUgBb+peBGIWtuoKyh+vfK
	NTbmw8EZfcwiBZeTCms+xMHXUHOw72Rf+yhkq4RWxsOL0kMjt9vgz6IqvoDiz/1LhqLRvRdJ83b4o
	nvGJq+Bs4wl4cHE0cP8/CUS67KtTSvYfXQv4dOcEWMN33P80Ee2fXZrreOgeIQFkZ8saUiLPMJCAY
	16ZTMF3w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kG6ma-0005Jg-99; Wed, 09 Sep 2020 20:33:32 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kG6mV-0005Ip-7b
 for linux-nvme@lists.infradead.org; Wed, 09 Sep 2020 20:33:29 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 000D921D46;
 Wed,  9 Sep 2020 20:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599683606;
 bh=x1086e4ReQU4yl50r0f8XjrWzg9WDz8qDjwAeXTi6zI=;
 h=From:To:Cc:Subject:Date:From;
 b=Vw5cGVfvMpAukwvgN/CBRVf4L+eJYZKkgn49gfqF779RkQTWqkzkVOUmqCkrEjc7T
 BnYQi8KszpzZXAIwZgiKdJWfV2fZH2MABSAR2rvz9v9VpaOJ6xA2i2xZayjTDiA2wB
 MlYMQLMVC4w4ZnUPgGhMNIdqJFK5m16E/r1ihdXM=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de
Subject: [PATCH] nvme: translate zns errors to blk_status_t
Date: Wed,  9 Sep 2020 13:33:24 -0700
Message-Id: <20200909203324.3356679-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200909_163327_435985_D3979235 
X-CRM114-Status: GOOD (  11.34  )
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
Cc: Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

EBUSY is the appropriate errno for commands that complete with zone
resource errors.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ea1fa41fbba8..aff556837115 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -249,6 +249,9 @@ static blk_status_t nvme_error_status(u16 status)
 		return BLK_STS_NEXUS;
 	case NVME_SC_HOST_PATH_ERROR:
 		return BLK_STS_TRANSPORT;
+	case NVME_SC_ZONE_TOO_MANY_ACTIVE:
+	case NVME_SC_ZONE_TOO_MANY_OPEN:
+		return BLK_STS_DEV_RESOURCE;
 	default:
 		return BLK_STS_IOERR;
 	}
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
