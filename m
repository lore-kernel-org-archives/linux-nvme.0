Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A182FC982D8
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Sep 2026 18:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tcg806D5vzEHCLipGmbi/V7P1l0j+1hngUNt1RnsJGI=; b=IkHqfJcnOwIUw8y9ftBbtgK9zg
	amX/MNkhqwHNtr99APe1MUXpfExofMkc/3Wo+H7m5tZRLmJxNATlTdwBbtCCr9q4fWNOrthbCC14N
	9CjIWoPlmCer6X3mSUqZcABimNIYhmw0kMLQuFmcoa4r1eMIRwfUVBM+CvR2E0PCuW37RwKXMQHeQ
	6eKqPmVqQSxSN1WdDbgATGaKuboKKmcBx3R0tbJ9v2Bq5h9Yyp2fVAca/D56kttJtCLzWEun7RA2x
	xm1MdQ0WQPA+AU27Ob7oieQLvTxW1dRPNb41ZqDXnFjtWSmambhXwTiiph3FvyUx1n0IAJp+Q1daH
	ijVdcMiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MJ1-00000000Dne-0hiw;
	Sun, 20 Sep 2026 18:30:27 +0000
Received: from mail-pj2-x0e.google.com ([2607:f8b0:4864:39::e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MIx-00000000DkO-2ZQk
	for linux-nvme@lists.infradead.org;
	Sun, 20 Sep 2026 18:30:24 +0000
Received: by mail-pj2-x0e.google.com with SMTP id 98e67ed59e1d1-3a02902dce2so546336a91.1
        for <linux-nvme@lists.infradead.org>; Sun, 20 Sep 2026 11:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789929023; x=1790533823; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tcg806D5vzEHCLipGmbi/V7P1l0j+1hngUNt1RnsJGI=;
        b=Py2tAwYn0xI0DZ6LOnsiHVKTt95Dq6RX5aFCqSgOhtKC0QtKRPqnGfjcb/t/F3FDDq
         ZVSAxG43vWiZT9JBmtVxjpgl4/HR6p+Vih9+uRWROtTiLG0yqGyIC9VDttCaN91uK3jh
         LDKlEb6VC7LE9es5q8ddD/2xrhvzfCMr7AxguoKIB/RyNPTcL0yBqmCcfQshr74Z7x76
         DBqBHRrZBYE/0tX8nRJRk01NWwlBcu9Echb8jXJ+XL8MQ087I8mbWV6FHgbXWqWtUE4i
         SpbrWsmLuB4yzQn+95rL16xBeVPvUfXAAvEoCqGlVaJIoNL3lLcq7z3hvJZl5hfJMofb
         nlVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789929023; x=1790533823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tcg806D5vzEHCLipGmbi/V7P1l0j+1hngUNt1RnsJGI=;
        b=2wXRNGaXTmk3FjvBJpz3tsJymkOzOx3SHFHzuJ5rIRtyHooItjANVhBL5YXSE2ySYC
         CADn4+xx3AOJaKOyJtcS7y+beuyvt4uaYoOQATIxJjAchii1NOFnKMAr/tyR7yjOij6+
         +AkZtl++NLYj4MZx3SkmHgwNGeN8RclZJI5O8/JmcnTlvMDObRN0vmV5BgHLZibpw7NI
         yxi30fvY8ZAjflcgt5FQ4ATtBcHoWM3CfD2OkWcsro6p9mR/mh5q2fLqXlfHlEwofCo/
         2D+pnQoFql6kejQmAq3c917h1UAmloewEAqkMgUruMLDyOYyjDlVCvMdW3KMJ7lTj+Aw
         bQ7Q==
X-Forwarded-Encrypted: i=1; AKwUvBxKrv4h4332eIQJwzeR1UGSK0DP4YEIURnjKuiXRsBOzQwCHPmd2Am0hKUELywEXROxIYxDnQr7YNfg@lists.infradead.org
X-Gm-Message-State: AFuF++nIrSlifb6NQuZ7XjLdF2hzjIX3nKFWlXf0tPNLlHoe60NjWzS5
	Yo2jrGcmD6bA0IXcwDop8HL9cCz2izUY0uW3YF0V325PjykW0HJW4S9+iGWkARksfLfVlMZ63we
	3kIvX
X-Gm-Gg: AYBFou3Im1NZ0l9qrGAgGn3WunPopC1O/7IMhXixOZ92qGGsk2uHawnnzAEkES8b/Ml
	lxDF4iricFH50E8AJ1EQSGqU3FY45dWhWP4ocShPy4jMR9eweucjyB7DO6zUj4Sh1ebyjUI+5gL
	wyQxfnnh8LMRKVck0KY3HHEJEFJS4SlD5fcQ0hAFBuxxF/WbuPkmJmnDUFJE429v9y0s+q9bcm7
	sDLhoVYIJqjZJYXjMfKFZRKkKVropSnXeFG8jioqntjb2u0gPB23hFCXoGPKCn9do8b7j8l4ngn
	/4G+o5mJM+pu3+VHHsdsPNgjUVT4RWFKmoIFhjU10gsmTpx85SiNJIidv3Hcxrtv6KcFhXl1ZKW
	Id4YHBQkGd0PCD5VYN/ehRSmqlUNwmoMSgh5MrFr+SegqaN8PjQiRNfSiVrn7MT21a0pj7lJpAE
	GIXPKDom86+S2jKKTp6HA4H6z1Nv739HNc10gW1JBRwFNRmb819lJ9uqLi
X-Received: by 2002:a17:90b:1e42:b0:3a0:345a:3620 with SMTP id 98e67ed59e1d1-3a0345a48a4mr3412173a91.45.1789929022908;
        Sun, 20 Sep 2026 11:30:22 -0700 (PDT)
Received: from ceto ([2607:fb90:9c20:5ac0::1d8c])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-144da432647sm20924589c88.5.2026.09.20.11.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 11:30:22 -0700 (PDT)
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
Subject: [PATCH v6 05/18] nvmet: Send an AEN on CCR completion
Date: Sun, 20 Sep 2026 11:28:03 -0700
Message-ID: <20260920182936.2317916-6-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920182936.2317916-1-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_113023_669889_E598BF99 
X-CRM114-Status: GOOD (  17.04  )
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


