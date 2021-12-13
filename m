Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B6CC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 17:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PnzxCydCMJJAPSMT6Xttv1+qK2wkm9RLYifT1qJ4FWA=; b=V0DsGzW/8GU3d1sBzmqlXjnaAH
	+ffF3aVd4/aNRhiUtCtPKaSDUy8Vxd+w+CEm9uC6PduNm0+D/u7NEdRNlt4EyfppU4I+F7dIAsVLY
	hVz0/RS5wCTwM6wEtM+NxeuL1Wix5wfErxb2bFz8a5i5yybkKXb7LaT9mwCdR2y3zXs8sS3o2zFrd
	MOmwx1MtrQJUzn21hBx5XvwbX+wW8fhN+GEgI4avayKnf/4SGFGI7PrxPoKcCdLdDRZENZXH0bT23
	wvnA574gqFb70hFRBbplpfbp3gIV8l1IJa4rGvYOLTdLSsmNLdTCNQKeuMSG2CEnwCsH40ylrIT5Y
	7EvvXsig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwoos-00Amoy-Ia; Mon, 13 Dec 2021 17:08:58 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwooo-00Amnr-Vk
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 17:08:56 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 15FA7B811D6;
 Mon, 13 Dec 2021 17:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF43C34602;
 Mon, 13 Dec 2021 17:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639415331;
 bh=OG4wl+3N15flxcok9nzgXr5wYI4ooLG37kAmy9AWdLI=;
 h=From:To:Cc:Subject:Date:From;
 b=tDocyl/76PMWzsf7Ql3D9P8m+ErfRMDVqCGDQaqRGGi+F+NF2BKhVLClbxwbQ0UBg
 g2gongsUxgzCwxC+tywD704IV+RQhagIMiN3TfZhGkyOiLWwQ2nqpqBHAhUGBnTCyZ
 9D+44DsH1+Q5Wa94mD69KETzIRxs5L6iLCXhNh/nI/2IhU7K1vHn7OgGfKTkPxprxf
 5uWLBAhF1lutHfQiF3t7GxYNNGVJ3ExLwNK1cDZWtCIEb5egC+duVtF4UvBYgITsw3
 qev95EeXS8pH7A9Ehe55Y5VbhqudSIzA15f78z0wdxHtuL6ujNjDIKis7sb0GRkmAF
 p6OIiRsYtX6Sg==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: increment request genctr on completion
Date: Mon, 13 Dec 2021 09:08:47 -0800
Message-Id: <20211213170847.4161474-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_090855_192536_8DA13D37 
X-CRM114-Status: GOOD (  12.69  )
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

The nvme request generation counter is intended to catch duplicate
completions. Incrementing the counter on submission means duplicates can
only be caught if the request tag is reallocated and dispatched prior to
the driver observing the corrupted CQE. Incrementing on completion
removes this window, making it possible to detect duplicate completions
in consecutive entries.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 2 --
 drivers/nvme/host/nvme.h | 4 ++++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f82c098b1a61..44c375a1edbb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1037,8 +1037,6 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 		return BLK_STS_IOERR;
 	}
 
-	if (!(ctrl->quirks & NVME_QUIRK_SKIP_CID_GEN))
-		nvme_req(req)->genctr++;
 	cmd->common.command_id = nvme_cid(req);
 	trace_nvme_setup_cmd(req, cmd);
 	return ret;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b334af8aa264..a54096ba0552 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -614,6 +614,10 @@ static inline bool nvme_try_complete_req(struct request *req, __le16 status,
 		union nvme_result result)
 {
 	struct nvme_request *rq = nvme_req(req);
+	struct nvme_ctrl *ctrl = rq->ctrl;
+
+	if (!(ctrl->quirks & NVME_QUIRK_SKIP_CID_GEN))
+		rq->genctr++;
 
 	rq->status = le16_to_cpu(status) >> 1;
 	rq->result = result;
-- 
2.25.4


