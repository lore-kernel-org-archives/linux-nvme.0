Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B9FCE7AE4
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2024 07:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V8thfd3shXRlFz23z+pe8WKTBlvG+p9QCGvcFSjAyfQ=; b=gD867prqvDlBWsDVYy6030KKiC
	fOkumfCMe9GROauQMWyn9SDo+sM9QRYQVmjwp4OjX9KJ8oJwp8DMNUMqh2ziWJ9T70BUcLVpdHEtA
	mATBLk984rfSJTRroyeNgrvLXN4J+/rnZ60SVS95FG+Niy+QhrZnNLiHzt+6hoX0IcskZbdhSPHS+
	MAPAgv2Os87GgtSjldNwUaxl6dtqSSn4eG6VAf6kiaiGkODiz1vdku5fsQXrmHpW63ab3eqlzXZpP
	xbkzz92Y2kc10YUoTdC9hznyTTR7He8i34/DJVP9Q7EFIeWc4ZXgnsYkyW9cKiLFtboV4en/ugeJR
	+JOcCcLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smTPE-0000000B5Er-0hQz;
	Fri, 06 Sep 2024 07:29:20 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smTEz-0000000B3Uj-0Ns7
	for linux-nvme@lists.infradead.org;
	Fri, 06 Sep 2024 07:18:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 11769A405B8;
	Fri,  6 Sep 2024 07:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C98DFC4CEC6;
	Fri,  6 Sep 2024 07:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725607124;
	bh=vk3iyZhvnsCU40g1FK7YOE5Muo1KvMXFV6z4V1QmXl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DKOW3nutFkvYc3/qe02gN5GX6c7ZyI9iqD9C3HlItOusKs9fGHP+p9XWLODDkeOJp
	 wJaJAAXEuXUaWOyea6IIjO4NPLaD+F7IZtGNYGVyKmIL/o3/27Q1Isx87bfuHYFJ1i
	 vQdd1arXfF+yITdazigs6G46RsQr2i/W5KEOv86IBYDcsn4cqeqWyJSWmQUxmUA7iu
	 Wgph9ZuTFNeg/7p1Eadxr8+P2z3mBtHqMkK/9BIu1Qy/UtZEkN5kInmvH00hOfN3HN
	 BR+UghOF+OsRVwTIJcm/XD/G+ZRiWl96TwD9Rm/MiQfqx+C1IYAm7bG0n37xtHnY/M
	 oGum/MYlBoXOQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 3/4] nvme-multipath: always requeue I/O when updating the ANA state
Date: Fri,  6 Sep 2024 09:18:27 +0200
Message-Id: <20240906071828.125614-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240906071828.125614-1-hare@kernel.org>
References: <20240906071828.125614-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_001845_215299_B1456BD5 
X-CRM114-Status: GOOD (  13.62  )
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

When we've changed the ANA state we always need to kiek the requeue
list to ensure any pending I/O is retried with the latest changes.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/multipath.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index f72c5a6a2d8e..143c9d64dfa7 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -734,9 +734,12 @@ static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
 	 * will reprocess the ANA log page in nvme_mpath_update() once the
 	 * controller is ready.
 	 */
-	if (nvme_state_is_live(ns->ana_state) &&
-	    nvme_ctrl_state(ns->ctrl) == NVME_CTRL_LIVE)
-		nvme_mpath_set_live(ns);
+	if (nvme_ctrl_state(ns->ctrl) == NVME_CTRL_LIVE) {
+		if (nvme_state_is_live(ns->ana_state))
+			nvme_mpath_set_live(ns);
+		else
+			kblockd_schedule_work(&ns->head->requeue_work);
+	}
 }
 
 static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
-- 
2.35.3


