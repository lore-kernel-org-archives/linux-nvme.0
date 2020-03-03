Return-Path: <SRS0=oVUq=4U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC43C3F2CD
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2020 02:51:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F3D5246D9
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Mar 2020 02:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tzUS6e+N";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2YAY/2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F3D5246D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q8drEKBzGchOAryvXtHOYvSTVIUZqvZWRKx49HVRJ9Y=; b=tzUS6e+N6/mqxN
	pCJqt7qU+/V1RsR3DvyaFe37aRtGkfm1ZG0Y+hsI+sTw+0LIU16/J8AeX2GWPYOvdTRPLSAqBt80U
	2ceV6a4D/USV32rtSogYHH9v2SiJ5DDaTU3qdB5FVCkpjBwLvonD++9vpsSlkwjC5sFSl/v2GiBXa
	4pqhB1/0x14mfszFi6LjnTdy1WqZae85KYbLXJAswlDUM6jVq+lfamHKumd6qQZz/nFSWdjLEyxpb
	ayMCZQ/ijj8yA7BwuKe7nFQRSKmI3QSL9keY0EIywpeEbpvA4z8bR3F0IdzatHk3y7Ll0ANNevPfa
	EIWntW9bTpPKeJ8Ysf4Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j8xe9-0000ig-7O; Tue, 03 Mar 2020 02:51:01 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j8xd8-00079l-O3
 for linux-nvme@lists.infradead.org; Tue, 03 Mar 2020 02:50:01 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6FC57246DD;
 Tue,  3 Mar 2020 02:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583203798;
 bh=DTvAi7nyZ5pVZtpqgp5278khv2aoMnUfNo+fbEEUtWo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Q2YAY/2gGxYGA9j17fjWtsFNM4OvJ0nT8NCGdCUKdy5BeZcGtYY+MKzz7CI9fM60s
 IlcYVbljk2rvDrk/D6JLLV8P/gD2Q3VR/J9Jdc07ippYzptQrIJT0BYEKJC/5ivH+7
 TsXINpZYRstskHYelHQIO46Ns3QqUYFx8Z2ndMCQ=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 19/22] nvme: Fix uninitialized-variable warning
Date: Mon,  2 Mar 2020 21:49:30 -0500
Message-Id: <20200303024933.10371-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303024933.10371-1-sashal@kernel.org>
References: <20200303024933.10371-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200302_184958_895094_BE46E0B3 
X-CRM114-Status: GOOD (  12.19  )
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
Cc: Keith Busch <kbusch@kernel.org>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 15755854d53b4bbb0bb37a0fce66f0156cfc8a17 ]

gcc may detect a false positive on nvme using an unintialized variable
if setting features fails. Since this is not a fast path, explicitly
initialize this variable to suppress the warning.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f543b9932c830..a760c449f4a90 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -889,8 +889,8 @@ static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
 static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
 		      void *buffer, size_t buflen, u32 *result)
 {
+	union nvme_result res = { 0 };
 	struct nvme_command c;
-	union nvme_result res;
 	int ret;
 
 	memset(&c, 0, sizeof(c));
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
