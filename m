Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E35C982DE
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 18:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tcg806D5vzEHCLipGmbi/V7P1l0j+1hngUNt1RnsJGI=; b=v0txGxkyOPXFQY/3jylSNCHv6D
	GUQRzowXkwKmL/XZgTBGHEmUkX9qmo7hBT2QDDREvsUPEQBwzkI3HsyL7LvX6YpwKFHtemB23Ve0s
	59rIE8ckRYdMZKIhNMSIHGggRB2+aap9mZZm1Y7Uulv+tkYwmXB12saAWqtHn3EjCsqAeV9kzosBJ
	9hHOSPB1Xr0ihoKnr06MFsE7t3CytVKWdzaHaaYm9AqnvXEVqqKIvfQatebZeK1ZDpLvSwDb4blKU
	kYyRbHwG8miN5/prev8daJpCUu9ygZtPaA6qEEUES33ZuxFFlqLAIcufBQ0t0PSbJIk+3JcP2hRqz
	8Nmc9SXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d93-0000000FH31-2Ep4;
	Fri, 18 Sep 2026 18:17:09 +0000
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d90-0000000FGyi-07La
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 18:17:07 +0000
Received: by mail-pj2-x0f.google.com with SMTP id 98e67ed59e1d1-396ccd4f99dso1148473a91.2
        for <linux-nvme@lists.infradead.org>; Fri, 18 Sep 2026 11:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789755425; x=1790360225; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tcg806D5vzEHCLipGmbi/V7P1l0j+1hngUNt1RnsJGI=;
        b=DLVaqka8MlAFR5fLN6AejOS0T8H2L90q//ixjyE9jD+fq7AQ3t46OIvacvHdJeRz1r
         5NgNgwRqTjAOdSG4I4eqkOlhCH2atNBHKBg3y51uCV5bk/6FAR5CvEgm/EELIoyOM8MT
         HbMyI8H9gek60DT+Sbl0YO/bz+G8iZ9g5Rez7xrBcGkq3JwtTmYWiVlKMJHe2DBbxbc8
         VciXRES9PwbWbMaPTNAozfoactgUP4NJXvtpN51rNMUKsLjSIyckepGJAEHsStfaVFmY
         b4uE0cuNtesM4FwAQaoLedjQkFUG0uEehPvpCvZdEB8FM5SMMvZ5pA3c4PZMdrFLmDGF
         VOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789755425; x=1790360225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tcg806D5vzEHCLipGmbi/V7P1l0j+1hngUNt1RnsJGI=;
        b=ECHP++ZKC38m66N8Bp+uhW6/dImgscP4qtRMSps7UT50I7L4k8OVZnpacLUoLGSZpr
         zvnILnxn78dEYVoK/bd1XjT5E4ExQPLkwyI+bG7+iRudNgBV9zo8XGRNox3RLCSQ2ZbE
         qFKOMJAyNlL/0GoiG4750/eJMtilLFHR4kGCCZEdzueu5nSqiPRYeAz3DXWzRSMPecpk
         KMfHObxjCgFfQqq73prqZKFrlYt5f0Un1YweDg3kdMc/7Xa690GndeRuTg9eQwZeAS/F
         aaIqSwK8dyf/VrrokBVDx7OUIoSsvyXQDxtZZ/5s5oL3PhE4e/ohLTsyRHkwUW9ghUO3
         f/kg==
X-Forwarded-Encrypted: i=1; AKwUvBw5aydxmOI4WI5REFSXlN9rroT8AR4cQOXxHUr1ySZw0ENBf+C1sHgAcGTjsL+jQyKlwb7Kqyl5o7z1@lists.infradead.org
X-Gm-Message-State: AFuF++ntZdzYWB007xc8C35ybMxG5AUlzSV4ptHxCbVZWfIOOZhWLEZx
	Wux/+P1jSz9mEJ57y+Ah1DLbGLRPRPhXnc0copIDSti8KYetv5Dd4h94jPBkJkWiI78=
X-Gm-Gg: AYBFou2f61EApbq3ohTXjCru6Mint9tgWAjPge6Gs6nDIxNYBxT3xbieEaWwhok5pEV
	wryHBr9RVWiQ3qCHvSkAZdpMXX+f2ILCPq67hhqSv59IoBv4mO9MeoBZpUEP6z96aAA5+U8eFFM
	QYh4n3/fiqE50++NPxwAnyhyHLvwwf5vRbcIejxnwdCyKvvRkeVyQhAKupAvD6qP5W2gxa0pzsa
	Gr63fUPjYn6Npiyoa601Kryr5IIE/yK1iC3fyhoa7MQvenaDfXaDZnYuBkfj49+DSYPObOwfpl0
	wfAjBDJH0BRwskYKXWsCcaU2tR6VQTrjt+fADrgXfYuPKeeTFBFEFcht9XtM+d+jQBKeWK5jmGA
	K5tTcIaHPmzTQkuAw/+0M3w5b6TI8MhNW4XZ4hQalxMjMkAanYMd64tQW+w4YFX957CAcHPd7js
	r5zsL+Ls4NXF6HHhD0nGTnkYW/0vOxC+290DDN9cdXMEFVxfWEl1z1pHSlJLhNrvWcrp3c16+c+
	V4IDRJbr4KUnlLgSuN/sg==
X-Received: by 2002:a17:90a:3f10:b0:39e:5cd8:2140 with SMTP id 98e67ed59e1d1-39e5cd825f0mr3188400a91.20.1789755425376;
        Fri, 18 Sep 2026 11:17:05 -0700 (PDT)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33c331aeeddsm335107eec.24.2026.09.18.11.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:17:04 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 05/18] nvmet: Send an AEN on CCR completion
Date: Fri, 18 Sep 2026 11:14:05 -0700
Message-ID: <20260918181614.3947933-6-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918181614.3947933-1-mkhalfella@purestorage.com>
References: <20260918181614.3947933-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_111706_100847_87882976 
X-CRM114-Status: GOOD (  16.96  )
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

When an impacted controller that is the target of pending CCRs is torn
down, send an AEN to each source controller that issued a CCR against
it. The notification points to the CCR log page that the source
controller can read to check which CCR operation completed.

Split nvmet_add_async_event() into a locked helper so the AEN can be
queued while ctrl->lock is already held.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/core.c  | 25 ++++++++++++++++++++++---
 drivers/nvme/target/nvmet.h |  3 ++-
 include/linux/nvme.h        |  3 +++
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index f5d7cb9c943a..69491e8e52ba 100644
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
@@ -1807,6 +1813,18 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
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
@@ -1830,6 +1848,7 @@ static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
 		list_for_each_entry(ccr, &sctrl->ccr_list, entry) {
 			if (ccr->ctrl == ctrl) {
 				ccr->ctrl = NULL;
+				nvmet_ctrl_notify_ccr(sctrl);
 				break;
 			}
 		}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 3c70ef13c9b4..88fa11aa0587 100644
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
index 70dd0770e032..3757d11ffea3 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -871,12 +871,14 @@ enum {
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
 
@@ -884,6 +886,7 @@ enum {
 	NVME_AEN_CFG_NS_ATTR		= 1 << NVME_AEN_BIT_NS_ATTR,
 	NVME_AEN_CFG_FW_ACT		= 1 << NVME_AEN_BIT_FW_ACT,
 	NVME_AEN_CFG_ANA_CHANGE		= 1 << NVME_AEN_BIT_ANA_CHANGE,
+	NVME_AEN_CFG_CCR_COMPLETE	= 1 << NVME_AEN_BIT_CCR_COMPLETE,
 	NVME_AEN_CFG_DISC_CHANGE	= 1 << NVME_AEN_BIT_DISC_CHANGE,
 };
 
-- 
2.55.0


