Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB90C36005
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 06:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0ewMT02/RPas9w9zDxHcrhKyyp5vUpHayTeGQmoAQWA=; b=CGR7PttzMcIO/4vjMUdjzRUHQw
	4tULItBojOiurbxdmCaVJAwbheF1WS0o1doDzGC8n8iphXeFmkIXs/VmjAgvL1QlEdgx52W2U6gkF
	kOln4n7Pqf9RIWLuct8zSgibhxRDPbnk4qp5Fi5XaXKAVVE2hzWKD4eWnrZCdKo79HZQRaSZj44Rk
	0pA8L2epLrARNfRI5WdCrR5cWrvgjwveN+xksVpByQVdzs5Knc3Q/Jd/MY3Ev4ppUQ6e9KGzsmo67
	vH7x7mIX8UcLk9XMKImHxHf6N0l4PK+dZuVke0DVxhaHqlFlIEW+It/4CaJ3CQvv8cKyCS3YnhDHi
	y5udqlyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9I6q-0000000575P-0wax;
	Mon, 28 Apr 2025 06:36:56 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9I6i-0000000573P-1Gwp
	for linux-nvme@lists.infradead.org;
	Mon, 28 Apr 2025 06:36:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D3F8E4A6F1;
	Mon, 28 Apr 2025 06:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810BCC4CEEF;
	Mon, 28 Apr 2025 06:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745822207;
	bh=UIFWbYmHarxMMLhW8AK4GxhhvFplC+QaL7HX1httIMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aqe2q4vhxv5mWomZCUn5koz3d7AcD0QA9T3Mc2jks9E0o4FmcWd8YUh80e0/KpJc0
	 wRJghlLH09b42F+pBbNKfxhmPGYem5FiK1snnU8l52chAftwChjPGGeYUDaD3WT/53
	 A0re00Sqi+KHTNLOM1wKJsokbPqVLu+tcOAim7hTYsC3FD2Bw0ySjtrI9dymR1/Bkb
	 Ao0NMyG0MSmfJg12hpFsWznD3rRKGIcxRPKx7lcUMmKo5t5OK2zaLFfcWk4dCFfjsf
	 junXwrGnulijwVy493LrRV4nWjfb9p5jPFVqw63yBHpGt1cJ4fgwJm3sF58f2CRvaA
	 is579KanZywcw==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 3/4] lpfc: enable FPIN notification for NVMe
Date: Mon, 28 Apr 2025 08:36:34 +0200
Message-Id: <20250428063635.125879-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250428063635.125879-1-hare@kernel.org>
References: <20250428063635.125879-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250427_233648_364303_E6D809A7 
X-CRM114-Status: GOOD (  11.14  )
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

From: Hannes Reinecke <hare@kernel.org>

Call 'nvme_fc_fpin_rcv()' to enble FPIN notifications for NVMe.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/scsi/lpfc/lpfc_els.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 4748c00f0f32..cf1fbfb15c5d 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -10248,9 +10248,12 @@ lpfc_els_rcv_fpin(struct lpfc_vport *vport, void *p, u32 fpin_length)
 		fpin_length += sizeof(struct fc_els_fpin); /* the entire FPIN */
 
 		/* Send every descriptor individually to the upper layer */
-		if (deliver)
+		if (deliver) {
 			fc_host_fpin_rcv(lpfc_shost_from_vport(vport),
 					 fpin_length, (char *)fpin, 0);
+			nvme_fc_fpin_rcv(vport->localport,
+					 fpin_length, (char *)fpin);
+		}
 		desc_cnt++;
 	}
 }
-- 
2.35.3


