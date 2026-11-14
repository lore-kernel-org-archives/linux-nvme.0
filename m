Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC3260A382A
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 03:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HDfKX1d2;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=fOm4V95Y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=FZbPC0myHrV6ZtRIopwi7g6RfQPq7qu2TTBmXWHuWPM=; b=HDfKX1d2PbxBu8
	M660L7OzvD1oENBdacY7JyrKRwTlJaxXJZXr05oe4kxAZ661o0otOvIVDftC5JbUCopL0BaSVveik
	Z+wkqQdCp32vRLnKLdBH7ZagxIxCutYEHo6YNU7suIjaU9rXk8xhFb60nuoMPXDGsX5ukQWahtu0E
	xOvWmrvwsZQJqkMSDKInuyQkV2jddTMwX0Iyd47KPyQxDUu8Jo9ogfujMExxLtaVzXTIiWsNIFemL
	O9jtKUl/pmxoI2BUE4k29KpMEbN/WwgRpuGSpFSx2SXecUYzsofBiyZJ9CvT9nbjiQSfH84oPQYe8
	iS5bAVGQaYBCdje16vsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS45X-0000000F9ti-3Q68;
	Sat, 14 Nov 2026 03:05:59 +0000
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS45S-0000000F9m5-2TAJ
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 03:05:56 +0000
Received: by mail-dl1-x1233.google.com with SMTP id a92af1059eb24-1a2761c69fbso1079092c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 19:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794625554; x=1795230354; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FZbPC0myHrV6ZtRIopwi7g6RfQPq7qu2TTBmXWHuWPM=;
        b=fOm4V95Yrp0Fs5W8cKCugGa1tsGHu13CVJtqEtw84GQVIyPZ3S2CE69O7OuNOvNq5N
         C5hO4dGwODcQXyAB6vEu5mSD/s6vVyxTTz8BC3smoiPdNofPdGjHBLDxiCu5kPEWXkEq
         gtG/bazQ/zvRYfMFtzNQT1p/MfVzUsCGPZ3CIt7dMI2IJ3F0+kqKtq6Xc4pvht380Bf7
         XzOdedwqGugq37kjn+00qEZqwu36kFk2W44BF46IIcLWSUfw95/vQ8rHvJoHt9A+4GYb
         RyXBGcGJ2QTz0DdWx+HD4dedvXkmZLjINolyJB/hlV7GYLDre4+NkLDHshs8A18OKzZV
         Z3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794625554; x=1795230354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FZbPC0myHrV6ZtRIopwi7g6RfQPq7qu2TTBmXWHuWPM=;
        b=j3FbPadF/kKDI7gMHMHrQzhp73CuoCd85FJnxtlKPECvFN5QPQWX1OPASPbQtHdRKw
         ATakW3bFm52fGOYlbAawkklwWSZsfZda8Q8j16tUnWywxRvecdvatMF8aZq8bwBtMsyW
         GNfFtwewr1QmcnFJ80EwDbeyeKl/p858GJr/ewm9iYYp1y62ROzFztt/KQXTG3op1m8a
         tw+eTMHpEB/QSWuHXuLY4q3deIwYe5RcQ/0/mb/EJIAFbUn8ufNUdDbFgFh3VpPnN/r0
         PvdUd8y9BwbxCHPpemnFiPNLTmgAXISgbfAIHtcasEHcWX2noP2F8KwBfz1iA5JDN/DV
         VXvA==
X-Forwarded-Encrypted: i=1; AL+hErGwjtpuCVAcX0O2rrM8ftmpa4lZouB95jL5aMA+DoRCXNUqMAqblouWPwmtjZLE4aB31M+/ysSTYLFN@lists.infradead.org
X-Gm-Message-State: APuU4Z88s5t1Yi2VDzOeQ89iMUZYn+L8S5XeMxLoBGamnlSVQt5DiFWZ
	aWN4/h8B2Kzesty7NSbbgyJWQm5XlYDpPFehE7DvIRMnGn3rNqeC3XpYxfywEL4AMDjQ0o92jLa
	htCTL
X-Gm-Gg: AYBFou0uh8CUpiltk/eUle6Xdw7Z4o+4JXkxNIQtTsbkhX744eevUpMEoQWJmzqBwnB
	iYq/t1P23MWPGH4tXoqTGVEKKWpngXSi35AL4wcXqqAGkvVG/EFcJC3Gh9I62/FqG7R5WXHKonk
	wdyLn9COGdRV5IJ3MLE2E7i0syPyUjMRy+PUE2slBoIZftlPL2d3XHhC55sUF0G8kmcxPvAbOWw
	wmJgcXydxOuOOVT//1sEK6f09NzpJNqGtt//kWUII5fDWzL305Vf36Pw+LALjw7s04wTnOW5i23
	A1X+zjbrKHovE12maioPWqTCTPAfAMrrYd/BvZSOXFM2jCDOW6+KiRjXqb53ZeS1GgcaH1Ts7E0
	4VQS4h4y3Jgg/m5lv3WK5ayZHRVaTjZzsgAfgTjwbPMDwts+38gIfhqHBeclUE3KbIs+BsSvb/U
	lFo89WX4untfC++2cWgOtrDZMUTv762HETJQ4a5GurgNdRBTylxnLqueUdqTvicmDYTkTbPiP3Y
	Gj7tBsuoMxlcKxPWiHehxOZwLFqkvGGMlIhYNMgAMC/uZ13uXts782SwN7NRBylmARURC4VCUzo
	cMcPIc46YMgmRnY577TKR256aPCdUyw7ZNtgcM2VLE49JVnPHlOS
X-Received: by 2002:a05:701b:418f:20b0:1ab:de8b:5f0f with SMTP id a92af1059eb24-1b50319d4f5mr4230698c88.40.1794625553607;
        Fri, 13 Nov 2026 19:05:53 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1b50316e008sm10829382c88.6.2026.11.13.19.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 19:05:53 -0800 (PST)
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
	Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v7 05/17] nvmet: Send an AEN on CCR completion
Date: Fri, 13 Nov 2026 19:04:19 -0800
Message-ID: <20261114030454.2836543-6-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114030454.2836543-1-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_190554_724236_375CECDA 
X-CRM114-Status: GOOD (  16.40  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When an impacted controller that is the target of pending CCRs is torn
down, send an AEN to each source controller that issued a CCR against
it. The notification points to the CCR log page that the source
controller can read to check which CCR operation completed.

Split nvmet_add_async_event() into a locked helper so the AEN can be
queued while ctrl->lock is already held.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Randy Jennings <randyj@purestorage.com>
---
 drivers/nvme/target/admin-cmd.c |  1 +
 drivers/nvme/target/core.c      | 27 ++++++++++++++++++++++++---
 drivers/nvme/target/nvmet.h     |  3 ++-
 include/linux/nvme.h            |  3 +++
 4 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 25c320752d2a..e13ffd17669b 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -649,6 +649,7 @@ static void nvmet_execute_get_log_page_ccr(struct nvmet_req *req)
 	/* Cleanup completed CCRs if requested */
 	if (req->cmd->get_log_page.lsp & 0x1)
 		nvmet_ctrl_cleanup_ccrs(ctrl, false);
+	nvmet_clear_aen_bit(req, NVME_AEN_BIT_CCR_COMPLETE);
 	mutex_unlock(&ctrl->lock);
 
 	log->ne = cpu_to_le16(index);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 86018e0fb158..12ab522ea5a1 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -205,11 +205,13 @@ static void nvmet_async_event_work(struct work_struct *work)
 	nvmet_async_events_process(ctrl);
 }
 
-void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
+static void nvmet_add_async_event_locked(struct nvmet_ctrl *ctrl, u8 event_type,
 		u8 event_info, u8 log_page)
 {
 	struct nvmet_async_event *aen;
 
+	lockdep_assert_held(&ctrl->lock);
+
 	aen = kmalloc_obj(*aen);
 	if (!aen)
 		return;
@@ -218,13 +220,19 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
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
@@ -1843,6 +1851,18 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
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
@@ -1866,6 +1886,7 @@ static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
 		list_for_each_entry(ccr, &sctrl->ccr_list, entry) {
 			if (ccr->ctrl == ctrl) {
 				ccr->ctrl = NULL;
+				nvmet_ctrl_notify_ccr(sctrl);
 				break;
 			}
 		}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 5b8d87454772..2cdfa1165292 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -45,7 +45,8 @@
  * Supported optional AENs:
  */
 #define NVMET_AEN_CFG_OPTIONAL \
-	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_ANA_CHANGE)
+	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_ANA_CHANGE | \
+	 NVME_AEN_CFG_CCR_COMPLETE)
 #define NVMET_DISC_AEN_CFG_OPTIONAL \
 	(NVME_AEN_CFG_DISC_CHANGE)
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 98961f80b173..96b71aaad630 100644
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
2.56.0


