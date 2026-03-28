Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2800D10F3DC2
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Mar 2026 00:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gNe2anjf3U+8vvrDpf4bS35uyUrfzt1FE8OQuJB51II=; b=ZtrH70x0jIExnGnOk6eTkfun3E
	gluWNmBUrBQXvhKMWl8jbjq/vWcl7102eeVREKO/C9W7m+U8CLLd42NiDaGjoSNkm7CTYTpQNA+9I
	l/yUBdmXcH9+Yveu491OQkt8lCsw0L4d9y7wZWQ+dDxD1xnVFGjz+cjefD69lWLFxnrQXl0oIihxI
	7yKV8TMgF1Cb9ZmAzL+7h9d6jlrjefcpTH334mXAZPtUttC12YA0kwZ5ha+A2yFjZV4kcXSnzcPK5
	HomI3tY/2KWlPCmprni/vybIMm7BWD/0RUjY1XHgKmZt5oneKr9IU31L1ucw/XO3hEsvO4BeGL0hk
	J9EOjc2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6HoO-00000008Nss-1VKD;
	Sat, 28 Mar 2026 00:46:00 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6HoL-00000008NqB-3jWz
	for linux-nvme@lists.infradead.org;
	Sat, 28 Mar 2026 00:45:59 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-35c206f0481so2341995a91.0
        for <linux-nvme@lists.infradead.org>; Fri, 27 Mar 2026 17:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774658757; x=1775263557; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gNe2anjf3U+8vvrDpf4bS35uyUrfzt1FE8OQuJB51II=;
        b=MpCWTIKFwH3FHGUf8a8fFVO8jJdVwBvgSfgk/Ej1WLZcK/lx9LzMl+t7U8EMFR0W8/
         hqLSetz3CgDxQdrPx99OVyqBtzqoz/ImijG96Tni6hcANKYA9iC8v54zSHQoXCoXf50A
         jKAu5XYwzr7nWGAyfLXDEppouL2YH9y6q2Uxgzr8JlL/LtNpFBFhvxRt7KFbDqVvLQMZ
         5g4Gng0kFSl6h6cjPubedNFZBCffvpRMYjWA9graZMl+sDudC/jvNx4E2xdVE+s6l+he
         24efe1K6jTuLVwQHkMh2M3dMkeAri9NK6x2lNqqByL+K74nRRESWSqD0I9CdkN/zx6NF
         Pfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774658757; x=1775263557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gNe2anjf3U+8vvrDpf4bS35uyUrfzt1FE8OQuJB51II=;
        b=hllQktyzoBVcD9keqAJNTX1yyvm/NoDJyhk4NZKenLDDmm2CCsM/RAn5TCsI1i42r2
         n8r1HCR1CTR00iL1NJ9VfB0QVrV5j9jlfDJW9JIcWGdAQDFG2lDDRpl5/mtrTal490G8
         H4gdrNMlvWnq7aD2WlZPxPvT7lrHpMQ7+Sp2o+IGJIXC+sTUiexlO4cobsFGJZlpQjO8
         qhhJ+wJpCzraz8Y3LMqca/ooyjm6VMvtJsMXaXJLeBZPaH3ls28J9wHlgvcbFk1ZltFn
         D8oxPN1rT31XoWQ9e/mCXSkmGVJkBSm2R8w8xSRAJkXKU6RMedKbNL7XNWYJniwZEQHn
         3uFw==
X-Forwarded-Encrypted: i=1; AJvYcCV+dGYpUTca8FVX4tCjBhSpOoua8TRygoYlpun7txXcqszjePguPqxnLAGnOjl1h6XedtrvEXmYwBjM@lists.infradead.org
X-Gm-Message-State: AOJu0Yx92+cNOjr38K/uOhJ4G5OOK13bQo9wmTrCx1SfX5vCq1GJH/Ih
	pyfnKuFgTqMnZhKYQ2/y4b7ygCfHg2g6oFegZM8l60A3vwV41+l1BiZzRONnu9EhwIM=
X-Gm-Gg: ATEYQzy2WG7rQphGZ/Fz4pWS+Vg4NQpnSgzVM8KNTnTCzYfSEQdRXmsBZ2NqusBemFe
	/M7ZCDA4YX+up0vBvlGL8qq3aUqNyH0S5F4kSpx4252SkFn0rtFliBGg6Ll5A41QP4Qh5agu26B
	5mn7MkZbr8GxejWHmSA5NswTFGzkO93qnw8wx2Esg2eX10tLg8cmS5XC6nYqdNj3AeZNKHPoEqp
	Jf37UjVjL8xHpcWsCZnHZgqJx3i1tfVsQsonumMIeWqMGh7XGhpjTK5mN1bnxVUKHrwSEP7Ishy
	e6l1ECYdZqOF98gO4/hhqwWwb2Dg6yJGTaMiaaqFmfNoIZSCTCBNDoe15/VGORMaRXLYKfsTPUN
	EMjr84dL83bBDhlK08KVI7+8HH931NUot2x/IRQRoTnfF+8Z9hxx6vbaQ85rzQg/2IPK28sZU60
	HbkUSlmxd+ycOcOLIfAQ==
X-Received: by 2002:a17:903:298d:b0:2ae:483f:b23c with SMTP id d9443c01a7336-2b0cdcc6c31mr46778695ad.36.1774658756823;
        Fri, 27 Mar 2026 17:45:56 -0700 (PDT)
Received: from ceto ([2601:640:8202:6fb0::9c63])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b242683064sm5342705ad.33.2026.03.27.17.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 17:45:56 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
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
Subject: [PATCH v4 05/15] nvmet: Send an AEN on CCR completion
Date: Fri, 27 Mar 2026 17:43:36 -0700
Message-ID: <20260328004518.1729186-6-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260328004518.1729186-1-mkhalfella@purestorage.com>
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260327_174557_932010_842A0DD7 
X-CRM114-Status: GOOD (  14.20  )
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

Send an AEN to initiator when impacted controller exists. The
notification points to CCR log page that initiator can read to check
which CCR operation completed.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/core.c  | 25 ++++++++++++++++++++++---
 drivers/nvme/target/nvmet.h |  3 ++-
 include/linux/nvme.h        |  3 +++
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 2e0c31d82bad..4f1f0562cef8 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -205,7 +205,7 @@ static void nvmet_async_event_work(struct work_struct *work)
 	nvmet_async_events_process(ctrl);
 }
 
-void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
+static void nvmet_add_async_event_locked(struct nvmet_ctrl *ctrl, u8 event_type,
 		u8 event_info, u8 log_page)
 {
 	struct nvmet_async_event *aen;
@@ -218,13 +218,19 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 	aen->event_info = event_info;
 	aen->log_page = log_page;
 
-	mutex_lock(&ctrl->lock);
 	list_add_tail(&aen->entry, &ctrl->async_events);
-	mutex_unlock(&ctrl->lock);
 
 	queue_work(nvmet_aen_wq, &ctrl->async_event_work);
 }
 
+void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
+		u8 event_info, u8 log_page)
+{
+	mutex_lock(&ctrl->lock);
+	nvmet_add_async_event_locked(ctrl, event_type, event_info, log_page);
+	mutex_unlock(&ctrl->lock);
+}
+
 static void nvmet_add_to_changed_ns_log(struct nvmet_ctrl *ctrl, __le32 nsid)
 {
 	u32 i;
@@ -1784,6 +1790,18 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 }
 EXPORT_SYMBOL_GPL(nvmet_alloc_ctrl);
 
+static void nvmet_ctrl_notify_ccr(struct nvmet_ctrl *ctrl)
+{
+	lockdep_assert_held(&ctrl->lock);
+
+	if (nvmet_aen_bit_disabled(ctrl, NVME_AEN_BIT_CCR_COMPLETE))
+		return;
+
+	nvmet_add_async_event_locked(ctrl, NVME_AER_NOTICE,
+				     NVME_AER_NOTICE_CCR_COMPLETED,
+				     NVME_LOG_CCR);
+}
+
 static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
 {
 	struct nvmet_subsys *subsys = ctrl->subsys;
@@ -1807,6 +1825,7 @@ static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
 		list_for_each_entry(ccr, &sctrl->ccr_list, entry) {
 			if (ccr->ctrl == ctrl) {
 				ccr->ctrl = NULL;
+				nvmet_ctrl_notify_ccr(sctrl);
 				break;
 			}
 		}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index b9eb044ded19..6546be25901a 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -44,7 +44,8 @@
  * Supported optional AENs:
  */
 #define NVMET_AEN_CFG_OPTIONAL \
-	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_ANA_CHANGE)
+	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_ANA_CHANGE | \
+	 NVME_AEN_CFG_CCR_COMPLETE)
 #define NVMET_DISC_AEN_CFG_OPTIONAL \
 	(NVME_AEN_CFG_DISC_CHANGE)
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b792d488f72e..1fbb5b268303 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -860,12 +860,14 @@ enum {
 	NVME_AER_NOTICE_FW_ACT_STARTING = 0x01,
 	NVME_AER_NOTICE_ANA		= 0x03,
 	NVME_AER_NOTICE_DISC_CHANGED	= 0xf0,
+	NVME_AER_NOTICE_CCR_COMPLETED	= 0xf4,
 };
 
 enum {
 	NVME_AEN_BIT_NS_ATTR		= 8,
 	NVME_AEN_BIT_FW_ACT		= 9,
 	NVME_AEN_BIT_ANA_CHANGE		= 11,
+	NVME_AEN_BIT_CCR_COMPLETE	= 20,
 	NVME_AEN_BIT_DISC_CHANGE	= 31,
 };
 
@@ -873,6 +875,7 @@ enum {
 	NVME_AEN_CFG_NS_ATTR		= 1 << NVME_AEN_BIT_NS_ATTR,
 	NVME_AEN_CFG_FW_ACT		= 1 << NVME_AEN_BIT_FW_ACT,
 	NVME_AEN_CFG_ANA_CHANGE		= 1 << NVME_AEN_BIT_ANA_CHANGE,
+	NVME_AEN_CFG_CCR_COMPLETE	= 1 << NVME_AEN_BIT_CCR_COMPLETE,
 	NVME_AEN_CFG_DISC_CHANGE	= 1 << NVME_AEN_BIT_DISC_CHANGE,
 };
 
-- 
2.52.0


