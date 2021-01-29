Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9675C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 15:38:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65FFC64D9A
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 15:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65FFC64D9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=n0QACUiJPXwHpNxA4jv5lg/748aDIWgXSjtK6fJcjcc=; b=AdoHbc/twics4haXm3l6uLgMi
	I8tN5NsnfZSnXvqVYsQ0D+3jATJsrkxq/VVOyyC9SxMCPF+Du4niKi0Vnc9xDQk2jDAc+o52oYXqv
	Nu7qhEYgK9HkbIHRJxQc7UONU7uvuUk5sofmjThReuyDe1IjW8JwQTbhc2+S68B9FEb29tJ7FFGny
	W+nNSYUx1GJekZKz26fahBH9mCq+TPCrSqcN3XajEoqHC4kq90HbSsMfGGR4CRdcWqKmyRdkW2ESm
	hdmEFGnzszpPlNVJSm/QQeKkERmGdcNZUy5rDMpYPA2mGbXUI5ErtStj9YhAmffZUlPxPXq0DHGor
	f7Y6v5cCw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5Vqs-0006lY-Pm; Fri, 29 Jan 2021 15:38:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5Vqp-0006kL-PO
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 15:38:24 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43B2964E34;
 Fri, 29 Jan 2021 15:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611934703;
 bh=fl2F30CRd+mW6gXgKQt3PGr4zq/8oNPPtd/TxfOKpDE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FdTxMJSANXBBGNWtLA0PvIq5wVT612cJKKw3E8zlnr4WNSYz0tvcAuoSA0a3yW1Yn
 BiWzSyfg2NQh7ooL3DODm8ldCdtnN7DeAnYmOv6aHdlEEy8fSSN8ZyOE/68obCBxre
 2z+l89zPIzSbJb4U0dzhZa9laWBCZAlS2KQUH2PsormBOwj1Ga3DP37sNQ2DoGF+Vm
 zxhorX4VtmDYiQ03pWpJwH685yIwN3R6FcfikeIMzdC9XxHecxRjmpRmeH41lIov7X
 oVRDB4LQPeAR2LdfKDW8fIuzvhK8KRusWezKXW2/KvehkMNMPDYilkqJzgp+SZN38q
 asWhkcTkgfiPQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 13/19] nvme: check the PRINFO bit before deciding
 the host buffer length
Date: Fri, 29 Jan 2021 10:38:00 -0500
Message-Id: <20210129153806.1592565-13-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210129153806.1592565-1-sashal@kernel.org>
References: <20210129153806.1592565-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_103823_921066_2B581D7C 
X-CRM114-Status: GOOD (  13.79  )
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
Cc: Sasha Levin <sashal@kernel.org>,
 Revanth Rajashekar <revanth.rajashekar@intel.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Revanth Rajashekar <revanth.rajashekar@intel.com>

[ Upstream commit 4d6b1c95b974761c01cbad92321b82232b66d2a2 ]

According to NVMe spec v1.4, section 8.3.1, the PRINFO bit and
the metadata size play a vital role in deteriming the host buffer size.

If PRIFNO bit is set and MS==8, the host doesn't add the metadata buffer,
instead the controller adds it.

Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7a964271959d8..c2cabd77884bf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1295,8 +1295,21 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	}
 
 	length = (io.nblocks + 1) << ns->lba_shift;
-	meta_len = (io.nblocks + 1) * ns->ms;
-	metadata = nvme_to_user_ptr(io.metadata);
+
+	if ((io.control & NVME_RW_PRINFO_PRACT) &&
+	    ns->ms == sizeof(struct t10_pi_tuple)) {
+		/*
+		 * Protection information is stripped/inserted by the
+		 * controller.
+		 */
+		if (nvme_to_user_ptr(io.metadata))
+			return -EINVAL;
+		meta_len = 0;
+		metadata = NULL;
+	} else {
+		meta_len = (io.nblocks + 1) * ns->ms;
+		metadata = nvme_to_user_ptr(io.metadata);
+	}
 
 	if (ns->ext) {
 		length += meta_len;
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
