Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C61D10375
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 02:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=myVWmyIcrLWM/1NcPstHQcp5kFjs3Rj2+YxkwTil04s=; b=UVYJoWAY8cO3SPDUjCWlTrHAdp
	A1Pll84zrHVlUbh4aqx37eEYs/ZNnluJMiKsf0jWEZgls9KJChw3SEIx90SB/+w61xH94P6/PYnGD
	FnECjElFOark7QUYrQQgO9LoEyBVJA9uZkgyBj0eBe0UwDg6pCNLBNXTVfTkSP0/alpvVwgIpYZNt
	fdZ3P4rsgArDKPRjEQokE/gwpiPToMg+8iTz3Hch/YsiSA1d2kLZu2bGK3goh4bix1wJwg2PDiHqT
	9GE9mcrrL9zaVxfZ2LY7SLVYjWJiKprOwxVKVW9jX6EOPSxQ2sfeeYtCo6/JxhVNpD4UEYN3gps6u
	+Ay2+png==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO52C-0000000EDPV-0nVz;
	Wed, 26 Nov 2025 02:13:32 +0000
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO526-0000000EDLq-0Ife
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 02:13:27 +0000
Received: by mail-dl1-x122d.google.com with SMTP id a92af1059eb24-11b6bc976d6so555516c88.0
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 18:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764123205; x=1764728005; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myVWmyIcrLWM/1NcPstHQcp5kFjs3Rj2+YxkwTil04s=;
        b=ZRC5rTE8Zo/U9+auw/jokk1RYq0Tsov5tXfbzWLE2VMQbVX5Nx+Jr3/BrkMKM7+zBR
         woCoj7biLp2K4ns5cVmSMclcnHXqoIwRUw2C0eM1MvfSK+mlfROCB+tx2dUAdla5H5Wy
         kAsKbhLOAUpAnPlyHxZIPRgQ9n7AITmiuLGp64ZeQN+eBIeyPd9jpKgIbYljZ/XVNdlu
         6ytxgkO4b0gEYJrnYkXT1+42G/ccCA8Wj78e2SIyH7cuYInhYDrnLAiMb4tRgkab1nEQ
         SuognBghE4iwPW6zPU5tBsbfdWsGQirk2RWaM0pSwSi/BgHY9qbCvYq950//iIR/kuA9
         iHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764123205; x=1764728005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=myVWmyIcrLWM/1NcPstHQcp5kFjs3Rj2+YxkwTil04s=;
        b=VMVUjxCgq9Bt46XyJ7zY9TcjHcVXqV8eLuNMsAxvRwl4GK524/C7kmoT2oLnwTxc63
         6/FXrgBxEvSQW1rS0U3WOYM8BAx3Y97ohZDd5C/GFwOzQ1kW/EU3/F7Z+sJSB1m6serB
         Jnw0G5QRN/7VvsIYMkgsHUzMyFraibHGUpayCP436BP9oy1wlp89gxnRap5NcsVWYyCG
         AWADt4DAVm5XqAQZrKwKcdd5gY4lD6divEae24kF7Zpy41LUv+3mpOWQD1TvdvzmLU/2
         jdeStyuxb3CorGpLSVGx6xDr2iweSuUfgUGf3frdeWlbiBrJ+baYCB9HLbUENEkJRAMy
         AnKw==
X-Forwarded-Encrypted: i=1; AJvYcCXvyJ78UKGPph/Wl4A6bMTuQ/YM2TB5zemswxNKstA1IYiluq/udDG4BvWJBfNZGAYkkLAy1av+GGee@lists.infradead.org
X-Gm-Message-State: AOJu0YyQ5g+Svfa6b0xLe6m9zmFB1MQsgToDNBTihdJdsEAyXQx7PM9h
	EyOOM0yJ4vjelMZHHW1YgDbgRXeD38G4io0IaHcv5CJ0un/SVxnKbwAIiMjSMWHLoQc=
X-Gm-Gg: ASbGncsL8ZYKbM6efPfLWdLTBLV27DekCNKuSZz1BHOq++L8iE/y1XPWNyQHmODuv+0
	8YEKG6L8Xf/a9J89V2JR+8/TDu0cZGvtrr0JsTTtlZ+7xxOAzSBnnzvjyMn/WodYV2cGGAJv6NO
	7P+xhi2BBSzAFc7BOfTac2wELEZ3Smiqxx2R8QRaK/gPMRYOdbu+ObhHmyYZDqqtgnWRfXox6CQ
	6r4RDmb+Asa3SSXNsoBMZwvI/NE4YUSOMSntlEEiNOWDJ0iuhRZlDdoZ2ymK7s4oesFdbyK/G7p
	HOBTSV6eSNTVHkEMXibUnlEIX0ZkJDAacP4htE9v4gdJf9hk/LdkXO+LhZDc+F6CSi2MoA6Gj+2
	6Ij8bVfyyBvAeUTKLnzIJIiqDK1MdtpdLJSWcKmcnBjyFMXmY+k+z+jsLQ2mupY/k4HSewxaS/G
	Tj52O7ZVH18U+4AHimuWGFeETn5kUNb1CkeQ==
X-Google-Smtp-Source: AGHT+IF762dvIfiy+MJfaaRdfezo6gJCeNNNIF95vwqjmCbVZcZEuTz+XQbUmdcGAbK33RotfljyPQ==
X-Received: by 2002:a05:7022:ea53:b0:11b:7dcd:ca8d with SMTP id a92af1059eb24-11c9caaf0cfmr7562603c88.19.1764123204952;
        Tue, 25 Nov 2025 18:13:24 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-11cc631c236sm17922979c88.7.2025.11.25.18.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 18:13:24 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [RFC PATCH 04/14] nvmet: Implement CCR logpage
Date: Tue, 25 Nov 2025 18:11:51 -0800
Message-ID: <20251126021250.2583630-5-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251126021250.2583630-1-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_181326_110303_5496CFAD 
X-CRM114-Status: GOOD (  15.48  )
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
---
 drivers/nvme/target/admin-cmd.c | 42 +++++++++++++++++++++++++++++++++
 include/linux/nvme.h            | 16 +++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index a55ca010d34f..d2892354bf81 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -220,6 +220,7 @@ static void nvmet_execute_get_supported_log_pages(struct nvmet_req *req)
 	logs->lids[NVME_LOG_FEATURES] = cpu_to_le32(NVME_LIDS_LSUPP);
 	logs->lids[NVME_LOG_RMI] = cpu_to_le32(NVME_LIDS_LSUPP);
 	logs->lids[NVME_LOG_RESERVATION] = cpu_to_le32(NVME_LIDS_LSUPP);
+	logs->lids[NVME_LOG_CCR] = cpu_to_le32(NVME_LIDS_LSUPP);
 
 	status = nvmet_copy_to_sgl(req, 0, logs, sizeof(*logs));
 	kfree(logs);
@@ -608,6 +609,45 @@ static void nvmet_execute_get_log_page_features(struct nvmet_req *req)
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
+	list_for_each_entry(ccr, &ctrl->ccrs, entry) {
+		log->entries[index].icid = cpu_to_le16(ccr->icid);
+		log->entries[index].ciu = ccr->ciu;
+		log->entries[index].acid = cpu_to_le16(0xffff);
+
+		/* If ccr->ctrl is NULL then we know reset succeeded */
+		log->entries[index].ccrs = ccr->ctrl ? 0x00 : 0x01;
+		log->entries[index].ccrf = 0x03; /* Validated and Initiated */
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
@@ -641,6 +681,8 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 		return nvmet_execute_get_log_page_rmi(req);
 	case NVME_LOG_RESERVATION:
 		return nvmet_execute_get_log_page_resv(req);
+	case NVME_LOG_CCR:
+		return nvmet_execute_get_log_page_ccr(req);
 	}
 	pr_debug("unhandled lid %d on qid %d\n",
 	       req->cmd->get_log_page.lid, req->sq->qid);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 0f305b317aa3..d51883122d65 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1435,6 +1435,7 @@ enum {
 	NVME_LOG_FDP_CONFIGS	= 0x20,
 	NVME_LOG_DISC		= 0x70,
 	NVME_LOG_RESERVATION	= 0x80,
+	NVME_LOG_CCR		= 0x1E,
 	NVME_FWACT_REPL		= (0 << 3),
 	NVME_FWACT_REPL_ACTV	= (1 << 3),
 	NVME_FWACT_ACTV		= (2 << 3),
@@ -1458,6 +1459,21 @@ enum {
 	NVME_FIS_CSCPE	= 1 << 21,
 };
 
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
2.51.2


