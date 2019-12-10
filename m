Return-Path: <SRS0=hdrt=2A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0350C43603
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2019 21:11:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCAA7246C3
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2019 21:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pTPfxquU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYvHmgM0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCAA7246C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6ZULxxbNNhaFVuBN/RF7343JUe7mguAqwiMI8KpKsfY=; b=pTPfxquUsJ8ISj
	x/f9I85KroBRHBA4iFXgDmyCNtwfzfc2An02oj0IzBa0oPojW3aYL3coyPst0tmdC34Ous8YOYK1k
	gR4fTc8UxY/o9zqDBvCHRXF+L3ib5tk1OyTtBgMT+hPqNly3iWHYV3QdoUzpDqGP4GOKGGYrKNq20
	2kvYqK+CoYSVF6C5vx6M7SZJHdDzvDYFhlLk8MbXJ1PW9P1o+X6z6TgGT7UKVVYSzHf5dbTvxM3GR
	5u1aDUxwQCZAULdsyZsvVcoqkvYLOJk/RvJXJTld+r7RCrrlpfXvIBWeqptDTGD6l9pabn066kOew
	Ve3j+waZ6UxTxNbMrv9w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iemnO-0005nm-Pn; Tue, 10 Dec 2019 21:11:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iemmZ-000510-FO
 for linux-nvme@lists.infradead.org; Tue, 10 Dec 2019 21:11:02 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5CEFF246A2;
 Tue, 10 Dec 2019 21:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576012258;
 bh=4v+wu3+/i+OF4T0mA3aDC6lXJenOvIh7tni3jmpi+V8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mYvHmgM0m4k/pbq6/M4OkpYxbdB9dW1r3mvswDCNSMCsLcaPkE8Br11VUY8avUOZF
 /EpovlqrKiHrFW/VNaMKoPFNl4yCq8f+8bl1xGu+YFU8dq3oxBWjbmNlYPeCI8bNUA
 +5q/l8jpakLw4aGv25hoNwh91Z8bPtb0Wg6HkmEI=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 204/350] nvme: introduce "Command Aborted By host"
 status code
Date: Tue, 10 Dec 2019 16:05:09 -0500
Message-Id: <20191210210735.9077-165-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191210_131059_659131_15DA5E4C 
X-CRM114-Status: GOOD (  12.21  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Max Gurtovoy <maxg@mellanox.com>

[ Upstream commit 2dc3947b53f573e8a75ea9cbec5588df88ca502e ]

Fix the status code of canceled requests initiated by the host according
to TP4028 (Status Code 0x371):
"Command Aborted By host: The command was aborted as a result of host
action (e.g., the host disconnected the Fabric connection)."

Also in a multipath environment, unless otherwise specified, errors of
this type (path related) should be retried using a different path, if
one is available.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c      | 2 +-
 drivers/nvme/host/multipath.c | 1 +
 include/linux/nvme.h          | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa7ba09dca771..393913e2fb233 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -313,7 +313,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
 	if (blk_mq_request_completed(req))
 		return true;
 
-	nvme_req(req)->status = NVME_SC_HOST_PATH_ERROR;
+	nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
 	blk_mq_complete_request(req);
 	return true;
 }
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index e0f064dcbd021..132ade51ee877 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -95,6 +95,7 @@ void nvme_failover_req(struct request *req)
 		}
 		break;
 	case NVME_SC_HOST_PATH_ERROR:
+	case NVME_SC_HOST_ABORTED_CMD:
 		/*
 		 * Temporary transport disruption in talking to the controller.
 		 * Try to send on a new path.
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index f61d6906e59d1..a260cd754f28b 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1368,6 +1368,7 @@ enum {
 	NVME_SC_ANA_INACCESSIBLE	= 0x302,
 	NVME_SC_ANA_TRANSITION		= 0x303,
 	NVME_SC_HOST_PATH_ERROR		= 0x370,
+	NVME_SC_HOST_ABORTED_CMD	= 0x371,
 
 	NVME_SC_CRD			= 0x1800,
 	NVME_SC_DNR			= 0x4000,
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
