Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D8C5EF99FF
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Feb 2026 04:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/3PZZpvojr3QJ+1nB0s8EMVY3OCbXeX5sFwA3G15rFM=; b=C7KRJHGdEl12SSJj3ag0pr8Wri
	36pYe/XSlnJW74aZfemstLLpDUWEZR+oOA6q0NHcpEv1lo5cAYtUo+NbzktFd0H/MJEDBcKykEOGr
	unsoEls+VG8CKQTUGEf5aDTgy5OFzCwGiCilNY9m2chzL8Wq5vmuDB9jit7O7gNzfoVB9cQ75yeMz
	yLSYj/JS0D+YakFy1HpBV2o6/1HSKZC0tuF5woNH5BbdYPXQgSqHpVNvMQ2AngrfDl/c5bAvc7sm6
	7wlQbY2p6U+TPfhpMJeWkx4Rz+jlKxAMFhq7f34flN8Ju6RoXdef6Y93FQxdoI712SMJbn4F0O/HY
	lOXM/FDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7H9-00000004FlJ-0OlM;
	Sat, 14 Feb 2026 04:28:59 +0000
Received: from mail-dl1-x1230.google.com ([2607:f8b0:4864:20::1230])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gp-00000004FIn-3p4J
	for linux-nvme@lists.infradead.org;
	Sat, 14 Feb 2026 04:28:41 +0000
Received: by mail-dl1-x1230.google.com with SMTP id a92af1059eb24-12713e56abdso1238853c88.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Feb 2026 20:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771043318; x=1771648118; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3PZZpvojr3QJ+1nB0s8EMVY3OCbXeX5sFwA3G15rFM=;
        b=MFn6Xtq3B6La2+Ke1fgKx4HrkbJHDdEb6sAVKP5bmflDtQH7dj/lStUMhKEn5DgNUI
         Z7BSJFU/+qnwaLVmibNdGTqqKjMQsyRbXplrmrQVgng4aPTA6CuayLYhXrLSsxaZQcAs
         G4UFQzn2QOSZYbycSu9xLIqEIEpgbrmBRGjp1pIbS7CboiRVV0sA6mg89lvT3bsFbk3x
         w+bTBNMNkd5lPGa2j/V6UBCx8Ja3/1JayutBGVnhIWkrXeJvdRvPTe5jX3p46ooqZsWK
         duXv+ZSIh38VgHlzwvYN95wYGoitG8btOgVVaAJJakP5INIEXKz/ldU9d1oMTmelhC/7
         X/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771043318; x=1771648118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/3PZZpvojr3QJ+1nB0s8EMVY3OCbXeX5sFwA3G15rFM=;
        b=veFqHcOUmLuyAEHUIU7hywS6RzVZ/P8VpEDRNZqeg+eDSL4TSdob/9GuUl8N0HMZXd
         GSSkzEoFfD/hQnaW5tE6+v1mS4vcO2zm2tSLSy9fEAo2i7n4kOuNGpIxbO2jOqDczqSR
         +cMYm6HvgM2wNWyFvsNRzRR4SPXUYy1AHTh0axfIeJ9NhMYE5v8Y0pMlBWsSWTCzsZT3
         dyMs/FoQCMKKhSV2kRghVV/si0Axchjji6Acc3NuaB+D7AXDHrsEoPnAFoHMKePnjmhA
         vwLQp6PwvVknNn24RkMrleXnbkD05gpPJ8QFU6u7wFJnxVFtfT7dysRDvqi+kxYB66MU
         JjFg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ7fUM290TEhFz4KmUDPx10W5qzaY5oO0P1LUEnQSbb9R/kADT8wMJ39woh1SlVKjmZlAe0+tAvaNf@lists.infradead.org
X-Gm-Message-State: AOJu0YxsieVUuovXn5joqisdYitbuf2VMO+4WFt7iNRitjqf9fQpi942
	l6DkhR79/UcmOgN2SMMYqZF0JXKGTo+xvHgS9ccBJpCn/6eSUZHM7F5VgRj/LSbYL0Y=
X-Gm-Gg: AZuq6aKZdesGC/54VwCHHGuxcpOIhGJRpDCtLZFHTHqpX46WQ+ckdyQdtt7eiK2oKgN
	Ntnb+SC6P2DB0LRtUlP5fd5zaiqZ8YHRp7zz/zgekzRErNr6WUeeL2Z28iHDELKHdG9nz7zG+Aq
	AHopgo84+CC10GXx8q3k1gtH8vcXS2kKnmqHg1mlicJI5J074DnApw0q1i9lZ11x5VRoB0rN+Yi
	SDDKaBHczG9DLQWR8MFTu30UT1/dkpakuZf0EgIKPcuhYNzXcx4IStSQzXaWyxAcKNqEylcMyPL
	1XnnCjLYzNo0pKjUEND41EqOWtWKDdFH36UJf/y3qP/wdy+k8Uw08UH03V1zik/ZPRph/dLTRmi
	AX3QGqpfOLHe+TI9ee9VQCxu9Ntxjx4rSG6FZK9dxNhPorz6nT1DGhTHA73dW0J+RMDG0rwDwNJ
	OA6jCNMkKyMDkCjJbUSU2p2NMJ8mRwH83vmVlnRDw6DKD8hw==
X-Received: by 2002:a05:7022:628e:b0:119:e569:f86d with SMTP id a92af1059eb24-12740fdcd97mr1003218c88.10.1771043318277;
        Fri, 13 Feb 2026 20:28:38 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-12742cbc900sm1021042c88.14.2026.02.13.20.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 20:28:37 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Hannes Reinecke <hare@suse.de>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v3 21/21] nvme-fc: Extend FENCING state per TP4129 on CCR failure
Date: Fri, 13 Feb 2026 20:25:22 -0800
Message-ID: <20260214042753.4073668-22-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260214042753.4073668-1-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_202840_035072_6A1A9397 
X-CRM114-Status: GOOD (  14.00  )
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

If CCR operations fail and CQT is supported, we must defer the retry of
inflight requests per TP4129. Update ctrl->fencing_work to schedule
ctrl->fenced_work, effectively extending the FENCING state. This delay
ensures that inflight requests are held until it is safe for them to be
retired.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/fc.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index eac3a7ccaa5c..81088a4ce298 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -167,6 +167,7 @@ struct nvme_fc_ctrl {
 	struct blk_mq_tag_set	tag_set;
 
 	struct work_struct	fencing_work;
+	struct delayed_work	fenced_work;
 	struct work_struct	ioerr_work;
 	struct delayed_work	connect_work;
 
@@ -1878,6 +1879,18 @@ __nvme_fc_fcpop_chk_teardowns(struct nvme_fc_ctrl *ctrl,
 	return ret;
 }
 
+static void nvme_fc_fenced_work(struct work_struct *work)
+{
+	struct nvme_fc_ctrl *fc_ctrl = container_of(to_delayed_work(work),
+					struct nvme_fc_ctrl, fenced_work);
+	struct nvme_ctrl *ctrl = &fc_ctrl->ctrl;
+
+	dev_info(ctrl->device, "Time-based recovery finished\n");
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		queue_work(nvme_reset_wq, &fc_ctrl->ioerr_work);
+}
+
 static void nvme_fc_fencing_work(struct work_struct *work)
 {
 	struct nvme_fc_ctrl *fc_ctrl =
@@ -1886,16 +1899,33 @@ static void nvme_fc_fencing_work(struct work_struct *work)
 	unsigned long rem;
 
 	rem = nvme_fence_ctrl(ctrl);
-	if (rem) {
+	if (!rem)
+		goto done;
+
+	if (!ctrl->cqt) {
 		dev_info(ctrl->device,
-			 "CCR failed, skipping time-based recovery\n");
+			 "CCR failed, CQT not supported, skip time-based recovery\n");
+		goto done;
 	}
 
+	dev_info(ctrl->device,
+		 "CCR failed, switch to time-based recovery, timeout = %ums\n",
+		 jiffies_to_msecs(rem));
+	queue_delayed_work(nvme_wq, &fc_ctrl->fenced_work, rem);
+	return;
+
+done:
 	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
 	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
 		queue_work(nvme_reset_wq, &fc_ctrl->ioerr_work);
 }
 
+static void nvme_fc_flush_fencing_works(struct nvme_fc_ctrl *ctrl)
+{
+	flush_work(&ctrl->fencing_work);
+	flush_delayed_work(&ctrl->fenced_work);
+}
+
 static void
 nvme_fc_ctrl_ioerr_work(struct work_struct *work)
 {
@@ -1917,7 +1947,7 @@ nvme_fc_ctrl_ioerr_work(struct work_struct *work)
 		return;
 	}
 
-	flush_work(&ctrl->fencing_work);
+	nvme_fc_flush_fencing_works(ctrl);
 	nvme_fc_error_recovery(ctrl);
 }
 
@@ -3396,7 +3426,7 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 	struct nvme_fc_ctrl *ctrl =
 		container_of(work, struct nvme_fc_ctrl, ctrl.reset_work);
 
-	flush_work(&ctrl->fencing_work);
+	nvme_fc_flush_fencing_works(ctrl);
 	nvme_stop_ctrl(&ctrl->ctrl);
 
 	/* will block will waiting for io to terminate */
@@ -3573,6 +3603,7 @@ nvme_fc_alloc_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
 	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
 	INIT_WORK(&ctrl->fencing_work, nvme_fc_fencing_work);
+	INIT_DELAYED_WORK(&ctrl->fenced_work, nvme_fc_fenced_work);
 	INIT_WORK(&ctrl->ioerr_work, nvme_fc_ctrl_ioerr_work);
 	spin_lock_init(&ctrl->lock);
 
-- 
2.52.0


