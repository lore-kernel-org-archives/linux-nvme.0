Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED87CD4F54
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 07:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0iW3LrTqWSMLLa9HDk8vrvTznR1WnuzrMZCgjkfBYas=; b=ryqK1725XMij+JW/USkB6S5Kf3
	pQQbo7ppvFfadz0sqJ3AuJgGxTCzzWKCP4fBwx0WHdbsMv8IGTkss7OW/L+qSr1BUUDr55bcbinmK
	qD7SHUczOC0J5+mYLM6vkPpAKRd9/P11nWTfcr58ML87EKbUqbNop0NYH4O7BnMe4fT55AamE+qbd
	O4K2suNYoqkNW1zPzxk6qsAQViNn5G455qTDm5GCk/TZ4XVwKAug1p+CErn2kprAZtkFAMztzki1c
	QjqWRn/3cMQnOB2KAF7uwiAs+kCYgIyxim25Hfr3ehi1lbAETAvzUTs1Y+LY3c3Mu7WOz76ZeoVqa
	OFtwMnFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS95T-00000003Uoi-3iz8;
	Wed, 27 May 2026 07:53:59 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS95R-00000003Uo2-0Zgo
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 07:53:58 +0000
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-36608b2f2dcso7575788a91.2
        for <linux-nvme@lists.infradead.org>; Wed, 27 May 2026 00:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779868436; x=1780473236; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iW3LrTqWSMLLa9HDk8vrvTznR1WnuzrMZCgjkfBYas=;
        b=eBxux3wB0/wwOliCh0NhmN7TV0uf0eh6FARFC80ruWRl7bZ/5mtunklOWha4oxtmnp
         8Bnq6hYq7xsUDA9l0CaPLFpYayniXZFbSYyYVwedAMQDRrbz5Z2qlMD/8YcMsTgYFnwp
         WGtGtyq3W151soC66f3FgdLV1LK3eKPSbqA7DIJWeB70To+nsdch8OojdZm8Gso5Vqa0
         m9pM7DufXaSg02/pM0BBV3v7f0j5w9lr9/t7liV9CcE2IHZLpCYPioCQOrC/12aYQFuU
         XbeElnWL+YI9FZqwNCguJZ+fxUuPrR0EaWpRuLuLr/QzBpqZYjx52BvmaeV6wSn1nCGA
         tp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779868436; x=1780473236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0iW3LrTqWSMLLa9HDk8vrvTznR1WnuzrMZCgjkfBYas=;
        b=BXrNgmVMMt8yJl1jocDIsvLGk8lB5qUI7Q9CMbTNG5h/HAtHS8u2X5Xbdp4zJ5covW
         OEOvrCceoSxdJevTYojbmAS98UKe2wq8Lm6CQQa+eBQ/lv+gtUQlC2r6vw0rVHD4I4Po
         eXUe8nvyDGulmp8eMZAqRwIK0lhwhsoedpuMovO8p0M76didJEDAsJ5qk2TaOeUwsUTm
         BV6xvTOdy7Q03IdXGlZK7BKkdq9rWVN8mZzO9mXjL94B4Y3qBnNUBpUVwcqsbhDNbS7g
         R85fz5RBFuXDWU4b63/qz9hgtOkFmchLl977vhyv2Irz1wrUVXB7KiIdmnyTdMQqFAFl
         ur2A==
X-Gm-Message-State: AOJu0YzBQXrEuWxdGUpfJl42g9cO+SaM9U+dAFUXZ3B0SNoLNgFXlLz3
	bpOLp6W8hvRL25J9pla+GGjHZuHHFIS3Hp8BnzCzv9DHyx9kWvSLlnsN
X-Gm-Gg: Acq92OG3sf/NaOJ/a8LXOlSdcZtHqL5V8R2nKa+RQOt/27hR9fqOG7mOF/VR/ZLXg9q
	kH1r7yfugEmJ8PySfZx1KNlqnkCYUcNNXHWQ4bivhdGzxC8F9pD+R/svLZnAiCND8o4RkVTfmCi
	zl8QYtc0N4Z5dfAQllQvwkJ27ghQCWS5YHb5Ip20LFPg0pqGZba/u9T5O29TmAaR+KVXsQd5OYV
	gtv62FMFpr/9yb0ujtAgwlSrHsLjYdUcQ01EpKc5d2SNEwvAMTeeFAGImRtPnhPsGLlPR9X7uEj
	pvBMWbPOcZhMo1Y9vsmYMLD0s5IsJRC1e0MrdT3BUFheNUXsT09UWzc/9U0kHdAwqfJWgmzt9pO
	Edx0xxU/H5jKuJ8T3LJsslMKuAOsNbVLNeg3XQVukXKW5VAnbuytrB8223S00WGaBJJAna2GY1N
	drAFvCaerrkkOB9+Bi+g==
X-Received: by 2002:a17:902:cf0b:b0:2bd:93b0:2c18 with SMTP id d9443c01a7336-2beb0385282mr248861285ad.9.1779868435997;
        Wed, 27 May 2026 00:53:55 -0700 (PDT)
Received: from n151-105-216.byted.org ([240e:b1:e401:3::a4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56bc151sm147558455ad.24.2026.05.27.00.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 00:53:55 -0700 (PDT)
From: guzebing <guzebing1612@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guzebing <guzebing@bytedance.com>
Subject: [RFC PATCH 1/1] nvme-pci: detect I/O queue depth changes after reset
Date: Wed, 27 May 2026 15:53:20 +0800
Message-Id: <20260527075320.3178600-2-guzebing1612@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260527075320.3178600-1-guzebing1612@gmail.com>
References: <20260527075320.3178600-1-guzebing1612@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_005357_183921_5E9A419A 
X-CRM114-Status: GOOD (  16.71  )
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

From: Guzebing <guzebing@bytedance.com>

Firmware activation may change the controller queue depth reported
through CAP.MQES. In the nvme-pci reset path, nvme_pci_enable()
rereads CAP and updates dev->q_depth, while existing struct nvme_queue
entries keep the old q_depth and SQ/CQ DMA addresses.

If the new depth is smaller than the existing nvmeq depth, reset recovery
would try to create I/O queues with a depth the controller no longer
accepts. Detect this before recreating I/O queues and fail the reset with
an explicit error; without this, the failure shows up later as lost I/O
queues and namespace removal.

If the new depth is larger, warn and continue with the existing queue
resources. The larger depth will not be used until the controller is
removed and probed again.

Signed-off-by: Guzebing <guzebing@bytedance.com>
---
 drivers/nvme/host/pci.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index db5fc9bf66272..4bc112f8a096e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3155,6 +3155,33 @@ static bool nvme_pci_update_nr_queues(struct nvme_dev *dev)
 	return true;
 }
 
+static int nvme_pci_check_reset_queue_depth(struct nvme_dev *dev)
+{
+	u32 nvmeq_q_depth;
+	u32 dev_q_depth = dev->q_depth;
+
+	if (dev->ctrl.queue_count <= 1)
+		return 0;
+
+	nvmeq_q_depth = dev->queues[1].q_depth;
+	if (nvmeq_q_depth == dev_q_depth)
+		return 0;
+
+	if (nvmeq_q_depth > dev_q_depth) {
+		dev_err(dev->ctrl.device,
+			"IO queue depth decreased after reset (%u -> %u); "
+			"live reset recovery is unsupported\n",
+			nvmeq_q_depth, dev_q_depth);
+		return -EIO;
+	}
+
+	dev_warn(dev->ctrl.device,
+		 "IO queue depth increased after reset (%u -> %u); "
+		 "remove and probe the controller again to use the new depth\n",
+		 nvmeq_q_depth, dev_q_depth);
+	return 0;
+}
+
 static int nvme_pci_enable(struct nvme_dev *dev)
 {
 	int result = -ENOMEM;
@@ -3371,6 +3398,9 @@ static void nvme_reset_work(struct work_struct *work)
 
 	mutex_lock(&dev->shutdown_lock);
 	result = nvme_pci_enable(dev);
+	if (result)
+		goto out_unlock;
+	result = nvme_pci_check_reset_queue_depth(dev);
 	if (result)
 		goto out_unlock;
 	nvme_unquiesce_admin_queue(&dev->ctrl);
-- 
2.20.1


