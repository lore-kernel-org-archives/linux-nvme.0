Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79C0C3ABC6
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 19:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ry/d/QFRa+CCJeLWBcHpDiZuFW29Mx8yrLvarzoKQ/c=; b=qv92hWKV/jy35qgHG5tcW643A1
	IP+Hwc6BJc8qE0xyxVq2U9KCkxBT8SePW0cH0K8b8DaG94mNZttDuqyrKzLQpVvs6xm9LejwR1SKp
	yMmJ+HDRb3HpxKHWZ8YOTDwk9j+LqI76dJK3fjhTEfkI5ud3lLx8haR0oqPjnjhLrwi7fRUNTxhGw
	n7rv8eq4IPr32ZFdaFM0CZmKddvOtt4IxltXjP4M3O0jynViBc96R/UjXWaicpOLVQSzXE2a7DYoI
	CpmaCQ6STAIoyS5uYF+TjZRdkDafyfSPERaOENxeHGRS6J1qYRWbGbp60pUJxZ5ouiaXnJCg1mXo1
	7hPGDAzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCOMo-0000000DHON-07rP;
	Tue, 06 May 2025 19:54:14 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCKKP-0000000CW7d-1ZxH
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 15:35:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 49D6F629DB;
	Tue,  6 May 2025 15:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F42C4CEE4;
	Tue,  6 May 2025 15:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746545727;
	bh=Gus9KrzWoBrHqtUGIGFAZ7aC8bnn3iNLmAiM5j/j89E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L8SJJt8KM522QrF2dZJotva1aEMfEB4SgA/5HgrNe+upot1mjzA9ugPig+QqAte9I
	 PelmxImLr8b5Px7b4S0aHjlhxloRh/HiSJGU5geu0gflaemYid0A1hGKYMhj5s+73U
	 Yslm4Arw1X9DkASiftFw1gO3yGrI8orSSqbsNH6n/zOCAg8dzU9NhrsGr8s9mj/R3J
	 BwnzoPhn59PIUlgQrGVH5J68ww257n+DfHmf4jPf/3HXA3dLiBhsv/JHH8ncbbvvcE
	 hzg91DR+HOelXhVU3repvTaXmY+S53o+FWzJlRecmS+KhPOvVYdNOeq6GYnXD9Gn3s
	 cMeEdGaH3CT6g==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 5/5] qla2xxx: enable FPIN notification for NVMe
Date: Tue,  6 May 2025 17:35:07 +0200
Message-Id: <20250506153507.83094-6-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250506153507.83094-1-hare@kernel.org>
References: <20250506153507.83094-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Call 'nvme_fc_fpin_rcv()' to enble FPIN notifications for NVMe.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/scsi/qla2xxx/qla_isr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index fe98c76e9be3..cfe7afc905b4 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -46,6 +46,9 @@ qla27xx_process_purex_fpin(struct scsi_qla_host *vha, struct purex_item *item)
 		       pkt, pkt_size);
 
 	fc_host_fpin_rcv(vha->host, pkt_size, (char *)pkt, 0);
+#if (IS_ENABLED(CONFIG_NVME_FC))
+	nvme_fc_fpin_rcv(vha->nvme_local_port, pkt_size, (char *)pkt);
+#endif
 }
 
 const char *const port_state_str[] = {
-- 
2.35.3


