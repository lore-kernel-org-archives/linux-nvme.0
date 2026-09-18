Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF31C982DF
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 18:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XucfLuTS9otn5RCUHBJMmZsLBhJtMpUV15kULQxOZKo=; b=jpZjG64M4nNdMgs7Vx5LHZWO3T
	/elk4Oa/U6OBcyWVuncDRD9R5/8Bg6ruel1Yj2jcMxvy2CL2iZTO9aWxc0wMuFhMvHRpzgoGrTvMX
	geGY+dVEEHDYhi85WSI7pu0VIyf2xBXBfMbfzzLfPRYWrTo/9EqfYQTdOspxy37gWWH7uXU5ylnP0
	zD3JKiQmL9YHPhkEtcpv4PSvrDpRp3O3iV7YLdx9CojKtl7JMqruIgEOoIq6m2JqSOIKdOL8Stzwd
	HCW8opZCsEX1RkG0SSXJtHr8PMmcfZ67U7NJUP5AFnYKP3FJ0qjIrYhWsOL8ZvKiBjtWnr8YhWbIw
	CV1grkcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d93-0000000FH2A-1F08;
	Fri, 18 Sep 2026 18:17:09 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d8z-0000000FGyF-1ySq
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 18:17:06 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so941338a91.0
        for <linux-nvme@lists.infradead.org>; Fri, 18 Sep 2026 11:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789755424; x=1790360224; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XucfLuTS9otn5RCUHBJMmZsLBhJtMpUV15kULQxOZKo=;
        b=Dd5a5xaJp5UDdtDCIHnZU0cO0h+0HtLAIB/rTThAGXtxE2dYgVZHIFW47qqjQavaor
         BP5bX1xYfuxB89OYeYBwjbzWDbqkGgwi43PVwsXt5W5SKk5uWuo6jJy+aa7l3JsTE0uE
         ukNviXMhIP0B5wYlB5HitqIiWHQnwFEVvXqXRGZfbTccAB1QWh7fpQstGbTjJPrgeW6r
         IaRZDzSQGc+7l/5Ors6EzusWcg/Hrd0GWDVYLpdfkXze77ufkofaRvQSTIegi8QRrQRa
         gwQra0cLAe2UD8j6RmUs6AN7urIIK/8utv5UfGtWtPv3Zoz+pA4fLTH0z+O36SPhHy7A
         xBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789755424; x=1790360224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XucfLuTS9otn5RCUHBJMmZsLBhJtMpUV15kULQxOZKo=;
        b=gDqyjTQJ2uz8XMGdE6NWo0WyGCdLeE6JEADyYbl9fUJmjwsWQlMMjyAm/yOjyPASao
         vfTfVVS2M9Jw8rYLfHpsYIh4/34B85YjPXVvLLwjuUUpqmNKyjRiFJ/sjmNLQUmsn8BL
         pK3NeeBkmL2b/AnH8RepyzXHh7qLR5bNYBOwf7RmWa8Ld5FYEt17RFkcRM4oGy6jnNHX
         vpr4K0DwRSSLW201cR7P0FFfU6RTsCAFkvekvKBFtr1lFLGHNq4U6+Gt/hD/kV44YUiK
         9jkTvOFrNMPP+XXBm/E5Uad5/4YLZS9Y+T1kD57auBJKQ7PLFzBeXZzcVPWG5CwD1zZm
         LTuQ==
X-Forwarded-Encrypted: i=1; AKwUvBxZrYVhgGMtACFMKU8lhJzm6FazUtt9MeznjhYCqtAxXKVV36Dba/5Sy+h+UtEhneNssIQRxg37HM05@lists.infradead.org
X-Gm-Message-State: AFuF++l3gSCeR5tdGfDqMBzLKt/tiTVq/Ei5tJ4Q+O1zOdDL/UjZr1ld
	mWnddFO31xazqkgX8dcNeljjp6ckIlyKX5OFKdFEzls7Z1/zUEVgVYgcdvTwxo6FNZQ=
X-Gm-Gg: AYBFou2dA6dx18Zjh96ADKqwmddrYdrLAm2EloaWv1zmGDSZoyucO66t+CdYApoI1cx
	oVnoXdFxPPl3keTuXz2eDkZ+iYA4OCFXGijRH9qbbE2nJUklfPnl8cUzX3WWKid3i/wzaISip2w
	/b1X8cieAW5uFEOabNZcoI45/RPI7EMM/xSJFbn7qFXnYm7w+IOWYYjpP1bvB7IVv1aCfipNKql
	+JVEvzbfF2WiUk7dAVsMMmpD05NCHTzLOYM9OCGa5TikjvG7nUdAgsdu488rGClZEbBeeYAMlrq
	8ICS1grZCC4tjfC72ppY/mXIPmSPbusGiCBiAGYmIT6ZQ2qYsdHT0bkLFbYq9sa+4RDmtpgu/FO
	YOEWrfSaEsFk7A9/aeBgNASC+c4OCd98N+4zm6Y7L4JnWcvhEl3GTdZptp3bhOCz8gLpOyDN8IL
	or5dP1hW87jICmDUBKKnGveMhCJ4ISAB7h7ilY8FZIrpyTE8X+NwO3X7XmeULXhXZWQj0oOqHn2
	4PeE/tILPyQPrDKhLUpHg==
X-Received: by 2002:a17:90b:3c92:b0:39e:542d:a8c5 with SMTP id 98e67ed59e1d1-39e542da9ecmr4678007a91.7.1789755424265;
        Fri, 18 Sep 2026 11:17:04 -0700 (PDT)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33c331aeeddsm335107eec.24.2026.09.18.11.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:17:03 -0700 (PDT)
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
Subject: [PATCH 04/18] nvmet: Implement CCR logpage
Date: Fri, 18 Sep 2026 11:14:04 -0700
Message-ID: <20260918181614.3947933-5-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918181614.3947933-1-mkhalfella@purestorage.com>
References: <20260918181614.3947933-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_111705_514479_936D5792 
X-CRM114-Status: GOOD (  15.46  )
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
index 21538e7c83be..a60b2f271e98 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -220,6 +220,7 @@ static void nvmet_execute_get_supported_log_pages(struct nvmet_req *req)
 	logs->lids[NVME_LOG_FEATURES] = cpu_to_le32(NVME_LIDS_LSUPP);
 	logs->lids[NVME_LOG_RMI] = cpu_to_le32(NVME_LIDS_LSUPP);
 	logs->lids[NVME_LOG_RESERVATION] = cpu_to_le32(NVME_LIDS_LSUPP);
+	logs->lids[NVME_LOG_CCR] = cpu_to_le32(NVME_LIDS_LSUPP);
 
 	status = nvmet_copy_to_sgl(req, 0, logs, sizeof(*logs));
 	kfree(logs);
@@ -608,6 +609,47 @@ static void nvmet_execute_get_log_page_features(struct nvmet_req *req)
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
+	log = kzalloc_obj(*log);
+	if (!log) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	mutex_lock(&ctrl->lock);
+	list_for_each_entry(ccr, &ctrl->ccr_list, entry) {
+		u8 flags = NVME_CCR_FLAGS_VALIDATED | NVME_CCR_FLAGS_INITIATED;
+		u8 ccr_status = ccr->ctrl ? NVME_CCR_STATUS_IN_PROGRESS :
+					NVME_CCR_STATUS_SUCCESS;
+
+		log->entries[index].icid = cpu_to_le16(ccr->icid);
+		log->entries[index].ciu = ccr->ciu;
+		log->entries[index].acid = cpu_to_le16(0xffff);
+		log->entries[index].ccrs = ccr_status;
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
@@ -641,6 +683,8 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 		return nvmet_execute_get_log_page_rmi(req);
 	case NVME_LOG_RESERVATION:
 		return nvmet_execute_get_log_page_resv(req);
+	case NVME_LOG_CCR:
+		return nvmet_execute_get_log_page_ccr(req);
 	}
 	pr_debug("unhandled lid %d on qid %d\n",
 	       req->cmd->get_log_page.lid, req->sq->qid);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 7e6150d9494a..70dd0770e032 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1440,6 +1440,7 @@ enum {
 	NVME_LOG_ANA		= 0x0c,
 	NVME_LOG_FEATURES	= 0x12,
 	NVME_LOG_RMI		= 0x16,
+	NVME_LOG_CCR		= 0x1e,
 	NVME_LOG_FDP_CONFIGS	= 0x20,
 	NVME_LOG_DISC		= 0x70,
 	NVME_LOG_RESERVATION	= 0x80,
@@ -1466,6 +1467,34 @@ enum {
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
2.55.0


