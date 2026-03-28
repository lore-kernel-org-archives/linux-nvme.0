Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 079DF10F3DC1
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Mar 2026 00:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nERYj0eATMlhf7gB6O2MeYTzi4vYF6Jp5+hxczBe0L0=; b=jNQJvggN1mY6MrjXLx8mMuvxAK
	zNvtiPZ5YcUWSaI9xC9pm1iYFdE5TpsTo2QZQTMT58LS9r2XLpkqh0R8FASFeiD2cW077MEDAOg5n
	L188tkPNwvOuDeEZiBQP/jEbURNStWUuJQPPiSEaizeFV3pGCiRSGfgfEC9aq/DX9/OeLQ4bIrH4d
	CEBbAzECZsYVOsZmAKaEgNW5hjAubJi4oZRlRrbLRtd6WzPt0sGZvfh48VJ9ry/ZSsdmd5IKLKVNw
	0jyfdLR4MLywRhFv0CUF8Ox/9Z/a81Rr/dximPaIcGizID4XnVNTXGiSe0tFlDUTRDLXdizx2PKE2
	vtL6PYNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6HoN-00000008NsD-44jt;
	Sat, 28 Mar 2026 00:45:59 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6HoK-00000008NpI-2E3N
	for linux-nvme@lists.infradead.org;
	Sat, 28 Mar 2026 00:45:57 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2adbfab4501so13113055ad.2
        for <linux-nvme@lists.infradead.org>; Fri, 27 Mar 2026 17:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774658756; x=1775263556; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nERYj0eATMlhf7gB6O2MeYTzi4vYF6Jp5+hxczBe0L0=;
        b=fdsN+hC9EyOD6pZjh4RP8qmkPRMmoJzPsWiidP59unPWumkArcgY6UM3rRgt6gJUDW
         luAa3myCDMfU/mCJdr9JyGuuuixzmQOFhm8mpoCOdMV5dhRj028PvTjHARnqzPnJEW1B
         h96OiS/gjTPKJRIuH4XT4Ly85TV5g3g6xh6G4Gb3NQOLUiTOAGY7uG4U5Fz1AbaDsD+c
         crWZH1zXIL0sfZIndfXXw4WOxbtaQtR+R0etALoNQpNK/NWh/RmV+iiWo87hym9sWGkM
         kXK7GrS6x69syxy/OCV0/wjBEqYB6JlxSDbWKn37aosGiDjiObuKzaDR1Ntuug3cW2nU
         0OdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774658756; x=1775263556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nERYj0eATMlhf7gB6O2MeYTzi4vYF6Jp5+hxczBe0L0=;
        b=bU1xpwzeBClQ7o9+XBdJQw/6MPQHrzEe/3ceHY9NziI6OjQQAFkq6gNfziZq7uXDpZ
         T1Kmx31P0gteyzuWZPJrPoWETXkQWL5mnB3XRRbG8JjallgfcPDKBFXauukKsOsU9tZN
         PwlLsd+jlBsDED0qtdaKP76+qPon0pXbTE+SvAw2G6t03ymMD8ZVn0Rdau56uPAaeJHP
         v0hWZK28t4uRTAlCvAuCw35gGBOdBXRWZcwiseS9HXmWN3W64hUxHXU7ZXbdr2n+iqSS
         mUnf3b7R7qZkBtV11dN15+rpb2VrAvveIizUkUBVgYTrLWHSu5fNVwUkjUGlJw7nN9W7
         kUYA==
X-Forwarded-Encrypted: i=1; AJvYcCVeWWlZIrkomlLY5qgljNc6ey/d0BugXYiaXxDejKL6ttl+AJnmRkZqwPkF50Ljf6aNE6RKeac0g6C9@lists.infradead.org
X-Gm-Message-State: AOJu0YzoZsOmk7Ns47BhCsDzaAEqJB2e4vfN4ibtTt/tA8dWNgaPM6MY
	h0LSPwF9u7W2s/5jMFYD5hH8e4VzCsQLJ1rtczjsSM+i91kuMfmrCK278wnxdJvN7aI=
X-Gm-Gg: ATEYQzyK5vLV5SuPlewcGlOaxC0HpJPmZ8zHtNkTlMYrCOz5Yi6RLdXTB754T4zp7XD
	tTT96S+MhXdVgQG2pSy8ZUSAUmEQxbBBv3U4meP2Zskr9e4JgfP9KaqNiQg5y2xWnelhSJCzdgu
	5JW46D23UBcFnRSErxZx7ChbIeyzt6x/D0dj0Cqf9zqM3L2piniiZFNoVbhaip3DCS6mLw7un3E
	8hbGO5miLQyeLDyQz0zNcNsLdPrFmKcv6z+8Kki+hNdP8DVmL/ILRnSsbSZfHkiB+hAiyTfq5uy
	IvJOIDLbL42ogp93FdwkZcZhk0shWPtHN0LwKPPCtrkf7rA85+XODaKL7pKgqIXX2PWE+ybCjyH
	ENYbd4OePa2PD1pvFFVVohtbezr+e1Jd0eunqDCyVyxUqZb99km4CV3hVPJRncivqzWNpur3D3e
	VoHXvk43w=
X-Received: by 2002:a17:903:4b2b:b0:2ae:5e75:3821 with SMTP id d9443c01a7336-2b0cdc2c4d1mr41101815ad.18.1774658755568;
        Fri, 27 Mar 2026 17:45:55 -0700 (PDT)
Received: from ceto ([2601:640:8202:6fb0::9c63])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b242683064sm5342705ad.33.2026.03.27.17.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 17:45:55 -0700 (PDT)
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
Subject: [PATCH v4 04/15] nvmet: Implement CCR logpage
Date: Fri, 27 Mar 2026 17:43:35 -0700
Message-ID: <20260328004518.1729186-5-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260328004518.1729186-1-mkhalfella@purestorage.com>
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260327_174556_569516_72208165 
X-CRM114-Status: GOOD (  14.05  )
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

Defined by TP8028 Rapid Path Failure Recovery, CCR (Cross-Controller
Reset) log page contains an entry for each CCR request submitted to
source controller. Implement CCR logpage for nvme linux target.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/admin-cmd.c | 44 +++++++++++++++++++++++++++++++++
 include/linux/nvme.h            | 29 ++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 0a37c0eeebb5..305a5d9b5450 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -220,6 +220,7 @@ static void nvmet_execute_get_supported_log_pages(struct nvmet_req *req)
 	logs->lids[NVME_LOG_FEATURES] = cpu_to_le32(NVME_LIDS_LSUPP);
 	logs->lids[NVME_LOG_RMI] = cpu_to_le32(NVME_LIDS_LSUPP);
 	logs->lids[NVME_LOG_RESERVATION] = cpu_to_le32(NVME_LIDS_LSUPP);
+	logs->lids[NVME_LOG_CCR] = cpu_to_le32(NVME_LIDS_LSUPP);
 
 	status = nvmet_copy_to_sgl(req, 0, logs, sizeof(*logs));
 	kfree(logs);
@@ -607,6 +608,47 @@ static void nvmet_execute_get_log_page_features(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
+static void nvmet_execute_get_log_page_ccr(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmet_ccr *ccr;
+	struct nvme_ccr_log *log;
+	int index = 0;
+	u16 status;
+
+	log = kzalloc(sizeof(*log), GFP_KERNEL);
+	if (!log) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	mutex_lock(&ctrl->lock);
+	list_for_each_entry(ccr, &ctrl->ccr_list, entry) {
+		u8 flags = NVME_CCR_FLAGS_VALIDATED | NVME_CCR_FLAGS_INITIATED;
+		u8 status = ccr->ctrl ? NVME_CCR_STATUS_IN_PROGRESS :
+					NVME_CCR_STATUS_SUCCESS;
+
+		log->entries[index].icid = cpu_to_le16(ccr->icid);
+		log->entries[index].ciu = ccr->ciu;
+		log->entries[index].acid = cpu_to_le16(0xffff);
+		log->entries[index].ccrs = status;
+		log->entries[index].ccrf = flags;
+		index++;
+	}
+
+	/* Cleanup completed CCRs if requested */
+	if (req->cmd->get_log_page.lsp & 0x1)
+		nvmet_ctrl_cleanup_ccrs(ctrl, false);
+	mutex_unlock(&ctrl->lock);
+
+	log->ne = cpu_to_le16(index);
+	nvmet_clear_aen_bit(req, NVME_AEN_BIT_CCR_COMPLETE);
+	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
+	kfree(log);
+out:
+	nvmet_req_complete(req, status);
+}
+
 static void nvmet_execute_get_log_page(struct nvmet_req *req)
 {
 	if (!nvmet_check_transfer_len(req, nvmet_get_log_page_len(req->cmd)))
@@ -640,6 +682,8 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 		return nvmet_execute_get_log_page_rmi(req);
 	case NVME_LOG_RESERVATION:
 		return nvmet_execute_get_log_page_resv(req);
+	case NVME_LOG_CCR:
+		return nvmet_execute_get_log_page_ccr(req);
 	}
 	pr_debug("unhandled lid %d on qid %d\n",
 	       req->cmd->get_log_page.lid, req->sq->qid);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index bd3b3f2a5377..b792d488f72e 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1432,6 +1432,7 @@ enum {
 	NVME_LOG_FDP_CONFIGS	= 0x20,
 	NVME_LOG_DISC		= 0x70,
 	NVME_LOG_RESERVATION	= 0x80,
+	NVME_LOG_CCR		= 0x1E,
 	NVME_FWACT_REPL		= (0 << 3),
 	NVME_FWACT_REPL_ACTV	= (1 << 3),
 	NVME_FWACT_ACTV		= (2 << 3),
@@ -1455,6 +1456,34 @@ enum {
 	NVME_FIS_CSCPE	= 1 << 21,
 };
 
+/* NVMe Cross-Controller Reset Status */
+enum {
+	NVME_CCR_STATUS_IN_PROGRESS,
+	NVME_CCR_STATUS_SUCCESS,
+	NVME_CCR_STATUS_FAILED,
+};
+
+/* NVMe Cross-Controller Reset Flags */
+enum {
+	NVME_CCR_FLAGS_VALIDATED	= 0x01,
+	NVME_CCR_FLAGS_INITIATED	= 0x02,
+};
+
+struct nvme_ccr_log_entry {
+	__le16			icid;
+	__u8			ciu;
+	__u8			rsvd3;
+	__le16			acid;
+	__u8			ccrs;
+	__u8			ccrf;
+};
+
+struct nvme_ccr_log {
+	__le16				ne;
+	__u8				rsvd2[6];
+	struct nvme_ccr_log_entry	entries[NVMF_CCR_PER_PAGE];
+};
+
 /* NVMe Namespace Write Protect State */
 enum {
 	NVME_NS_NO_WRITE_PROTECT = 0,
-- 
2.52.0


