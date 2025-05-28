Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF90C3ABB2
	for <linux-nvme@archiver.kernel.org>; Wed, 28 May 2025 17:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QQGiTjLdJnbz3eyY9R0o72A2vZvhvnhEj1rzOdD/CwY=; b=x7DbxVGSGGCvD+OGaNiScxfr7v
	5Z8Zqx4uu6BflixYl9Qxdci2SGYe5gPzM+Z/PlvFP4voqpgcW1Xjru17mQ4Phwed2MCOX8ktF1C78
	H1hrldR6K+bGRNVEVztkOaVDAvte8W3esJk6XAbOkKqW5a22ncF46P1Zqow9e2Z0R9f8NnZCvviDH
	3PLZJEJwbRkPOncl1P/9LA3uJp2N2xJogW1Hw+cZY1QgBskaNUB6qhLcHo9MRX67vMjrUO6Epmp3v
	8JA3sHyef4zHfEZ0zx9YRYMSi1/id9Hcn5ZSnGoMyiF10BNGtQyRqnldo5S3bYUXDXWnpFprPwh7d
	rF1igdtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKKFE-0000000DmkB-1zB6;
	Wed, 28 May 2025 17:07:12 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKKCD-0000000DmOq-1E8E
	for linux-nvme@lists.infradead.org;
	Wed, 28 May 2025 17:04:07 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-7426c44e014so3802106b3a.3
        for <linux-nvme@lists.infradead.org>; Wed, 28 May 2025 10:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748451844; x=1749056644; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QQGiTjLdJnbz3eyY9R0o72A2vZvhvnhEj1rzOdD/CwY=;
        b=ETarfR2ei36giEOFDt6If0kdarRmHkrWxd6uRD47DN2oqA6Xz3hr2bvxZ9rM1RzRMc
         iyNft7BHyJIcEdQVrTYyXmf7YIep52uga7BTYsdpXYEc7KQq83Ezk6O8wfCnh5IYeIsA
         HIhZ03A1+vNoMjy314169nk5kY0wHD00a/CAc2cZKZ9Qi/qQuiPzWOWkjX5At5fRv5Hj
         NYMJKza5iaApCJjAq8Famd7GCeoocelVb2PqbUh+5L5+CTJPYYs6avagWLmWYusht3Ou
         P8pgzL0/RbUNHAd226D2GqmCxToFaXolRbqbTGRLOJMxxcq91fraCNnHtGGXynbNIbyy
         EJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748451844; x=1749056644;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQGiTjLdJnbz3eyY9R0o72A2vZvhvnhEj1rzOdD/CwY=;
        b=SOfT1COmVZKIY59duPRqKHc8wmnmjo15avPGb0kToVNfXJbCtjYiG+Z+pplgTz03YJ
         QJXhtw9Y/FYjL2q9086dQIksbWAQSsntz8/kYxa97PnsxilZiBWoqoBkWUUu9Ex14Cn+
         gNq7kiDzFj/UDcYY0SQI1na0tk4r/9P9mMM3sA3A8Lm472P8NMe1a5FeEY6gdY6WogQl
         xZZZMYCwfp2cPYfS68HB3SnxYoegOPX7MFoXnNF+SSM7a7zEMYhNjSPv2d9bMECwmYpb
         pZo67odiS1wghAMdPM6JcOaV80wJp+wUWatLHIK+LJrnLhivLUa66x2bW+9OBNxwphRV
         9yZA==
X-Gm-Message-State: AOJu0YztnUvAsMyKhOaAh9mhdpYdJXjKmF1yCm/bdDVumN31if7J/Wfd
	Tj3724KWwNrda3JbJueSPxyymoAmdutWBv9Nr2xILLxcSSLku8Buxa7gcH8Zhw==
X-Gm-Gg: ASbGncum1lPWSm6HZkBG9aHJ3N0NJ7mEyw2a/7cM3/f3tVJqdKFH58pa1gtx63isWuk
	k98BdtaPFOjV50iFt4H/ohl3EbomZl5LXc75ap2jbDuPddKvMIi/kGdQb20IUzxGg8zoCRzBV/Q
	m/UfhqAocEkqMJ7OTI6pDdsg78sV8zb7H2vJV9VkhsNlyY5GNl5aB9rttb1wxZfwhGKGGOIDI0/
	VEf8QcvhgVTw5uKHFCW5zRhmn/nCk9polmpYFQ/LI/FA86OKtm6ouH2HjKs+6vO9xTx+HNSupzW
	0Zw2ZF5oPzNCoZdlLU6eUscPtcHbK/ZOdGheUR87Zhdcw9vOfsNk4FuJvrmWALEM8kQKhaoTdtg
	T
X-Google-Smtp-Source: AGHT+IGi3ume80dHJWRGrGPxk+v7CAEPo96WuwChDB5khgI74qevfokN3U1m+nAjpWF7k1Ua23Z+/Q==
X-Received: by 2002:a05:6a00:1703:b0:742:a7e3:7c84 with SMTP id d2e1a72fcca58-746b403fea7mr4036158b3a.13.1748451843465;
        Wed, 28 May 2025 10:04:03 -0700 (PDT)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:1edf:c9c5:d94:71f7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-746e343f892sm1499129b3a.142.2025.05.28.10.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 10:04:03 -0700 (PDT)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH] nvme-pci: add NVMe controller statistics
Date: Thu, 29 May 2025 02:02:56 +0900
Message-ID: <20250528170350.5514-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250528_100405_331041_CDDFEC1D 
X-CRM114-Status: GOOD (  11.21  )
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

This is to count the controller warning events.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 drivers/nvme/host/nvme.h |  9 +++++++++
 drivers/nvme/host/pci.c  | 20 ++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1de1b843afa5..aa28bea48783 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -277,6 +277,13 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_FROZEN		= 6,
 };
 
+struct nvme_stats {
+	unsigned long timeouts;
+	unsigned long aborts;
+	unsigned long resets;
+	unsigned long disables;
+};
+
 struct nvme_ctrl {
 	bool comp_seen;
 	bool identified;
@@ -410,6 +417,8 @@ struct nvme_ctrl {
 
 	enum nvme_ctrl_type cntrltype;
 	enum nvme_dctype dctype;
+
+	struct nvme_stats stats;
 };
 
 static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 94ed13903b1b..5ce26408e426 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1465,6 +1465,7 @@ static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
 		dev_warn(dev->ctrl.device,
 			 "controller is down; will reset: CSTS=0x%x, PCI_STATUS read failed (%d)\n",
 			 csts, result);
+	dev->ctrl.stats.resets++;
 
 	if (csts != ~0)
 		return;
@@ -1526,6 +1527,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 		dev_warn(dev->ctrl.device,
 			 "I/O tag %d (%04x) QID %d timeout, completion polled\n",
 			 req->tag, nvme_cid(req), nvmeq->qid);
+		dev->ctrl.stats.timeouts++;
 		return BLK_EH_DONE;
 	}
 
@@ -1563,6 +1565,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 			 "I/O tag %d (%04x) opcode %#x (%s) QID %d timeout, reset controller\n",
 			 req->tag, nvme_cid(req), opcode,
 			 nvme_opcode_str(nvmeq->qid, opcode), nvmeq->qid);
+		dev->ctrl.stats.resets++;
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
 		goto disable;
 	}
@@ -1582,6 +1585,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 		 req->tag, nvme_cid(req), opcode, nvme_get_opcode_str(opcode),
 		 nvmeq->qid, blk_op_str(req_op(req)), req_op(req),
 		 blk_rq_bytes(req));
+	dev->ctrl.stats.aborts++;
 
 	abort_req = blk_mq_alloc_request(dev->ctrl.admin_q, nvme_req_op(&cmd),
 					 BLK_MQ_REQ_NOWAIT);
@@ -2390,6 +2394,19 @@ static ssize_t hmb_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(hmb);
 
+static ssize_t stats_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvme_stats *stats = &ctrl->stats;
+
+	return sysfs_emit(buf,
+			  "timeouts: %lu, aborts: %lu, resets: %lu, disables: %lu\n",
+			  stats->timeouts, stats->aborts, stats->resets,
+			  stats->disables);
+}
+static DEVICE_ATTR_RO(stats);
+
 static umode_t nvme_pci_attrs_are_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
@@ -2414,6 +2431,7 @@ static struct attribute *nvme_pci_attrs[] = {
 	&dev_attr_cmbloc.attr,
 	&dev_attr_cmbsz.attr,
 	&dev_attr_hmb.attr,
+	&dev_attr_stats.attr,
 	NULL,
 };
 
@@ -3055,6 +3073,7 @@ static void nvme_reset_work(struct work_struct *work)
 	 */
 	dev_warn(dev->ctrl.device, "Disabling device after reset failure: %d\n",
 		 result);
+	dev->ctrl.stats.disables++;
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 	nvme_dev_disable(dev, true);
 	nvme_sync_queues(&dev->ctrl);
@@ -3591,6 +3610,7 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
 	case pci_channel_io_frozen:
 		dev_warn(dev->ctrl.device,
 			"frozen state error detected, reset controller\n");
+		dev->ctrl.stats.resets++;
 		if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
 			nvme_dev_disable(dev, true);
 			return PCI_ERS_RESULT_DISCONNECT;
-- 
2.48.1


