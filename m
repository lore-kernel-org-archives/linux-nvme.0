Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5286E6BF3F
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 22:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zdXGSegTzhmsQ5qZhBP6CsinO53oPJTvN/vUTL8HtC8=; b=0OQ4JhYKV3LCGAB0E1yLfmD9LY
	R5vfdYZiO34hpZUFk3FmCs1tSp/Au9FgO1twTLnDUsxYYuFg3Fiz2JB8A96KmcCuDP4Z6qaZOh8qD
	hUIS/oYurAk6y7rq7Bn9NH9XI2+y7YX6KaL8XBmT7RO9ab1W38KNCjfWS+wKfivd1NY71XXAFq8ba
	jljRlKa1P7jVkgSOn55pg2inFuRPwMld+B9TpUeVMFMuhxFe2+vSASMfZlEfg+D1skdA/fVsofyeb
	7hRt2oMqmQznSITNQR8BbiPyXcNntQIHtSe0tFuQN2viacY1zIu+jIJhL5ATl8w4f1fOqyKMdySpS
	M/GCrAmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx6O-000000022lU-0AWv;
	Fri, 30 Jan 2026 22:36:32 +0000
Received: from mail-dl1-x122f.google.com ([2607:f8b0:4864:20::122f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx6K-000000022hE-1Di7
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 22:36:29 +0000
Received: by mail-dl1-x122f.google.com with SMTP id a92af1059eb24-12336c0a8b6so3674793c88.1
        for <linux-nvme@lists.infradead.org>; Fri, 30 Jan 2026 14:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769812588; x=1770417388; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdXGSegTzhmsQ5qZhBP6CsinO53oPJTvN/vUTL8HtC8=;
        b=MEudR9bmfHnKr+9zIpbzDPgPZ6kn0BbOslYcz6pgfSdS80zP/pJZCIz9z0vt+WYPT7
         GT9bmKn+ddo6I86h/77Xctg86AOnFKSe5i11LQaqQ3NMiirPYdHNzItcaALUlwhetvmd
         jSwQceJyCLt5QYpOpj7I5LGvYGyq7mGqAu6PNejVnbVKAQN3tsr4STD0KNReDCOw+66v
         hVwAU7DaTi176MAz7eiSc6Qn0bICSPT0w7naavXwFNhSxIlrowUP6V1m9kJuLm+3Gl8q
         YsQieIPpQ1U9rsH2oeWkYr3Dp2DGdmBRkykcajo6LTL9husGqa4uscDLIgo8ZF5Qh3ZN
         hk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769812588; x=1770417388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zdXGSegTzhmsQ5qZhBP6CsinO53oPJTvN/vUTL8HtC8=;
        b=VDgrq70w6Dk2KVoqrelGCLgllQOwvhDJkutg5ixBSkoCsLYqcWbqcu+3TQg+XBtyc4
         U2zZ4hoZoSpRg2myWH44Uc+0FRKks6yYT5lPCf7WvidtF/R+cc1BBV+xrVWjqDwo9Pdp
         gEkpB+W7g5CFI9lNAimJDqzikIwYGRdnK8fiFLkt1/FttpT4sbaKQPApy2b8Fo4bYFin
         3ohUyVGn1jZOacZGjdQ0XQ6yLdTWydrCi9krMng8yW43/s+S5p17Q2SrJn62susXSoRY
         f9JgPtJ16U7Z3rNu51QisMjQjOJH3MCnjtHERUBEZzANArTjQYMveuEKOkn7Y2seZdmX
         L+BA==
X-Forwarded-Encrypted: i=1; AJvYcCUWvBduFMiIkoEQIOJmH0/l6VV4fdmCFlcXEQaV5XCh4sQOHirX9qDHPhq1mh/R5CYzYafQ5XLYIUac@lists.infradead.org
X-Gm-Message-State: AOJu0YxhWKqzzvUX5wNV4UCmRigJTS6L6OotZ7oLuw3m72hMcHaMmw9p
	NWTztmws6z5YBgO6JNJNq9RXeWK50r6aZkUUz/eXOEBxiXEA0n9yrxTBnVLjnVG9W58=
X-Gm-Gg: AZuq6aInWycGdfN888h3Q9zpNucznJF01F6HNcIW7D+Nc0oqxslsqrz8WFIcXxF31D0
	BEhJc64aZOtIY7jPZjOO8ssYFP4e3N2sYL5qOt6jQu8JRPkMFGrOhi7GkM4+upYZyYlcwYYiIGp
	9jR15PqM3UEjtPByWl193y49Vo2Ch3xj+52329CzVc/7sYHV/iTNH7BHTwQ/ysw+YCipJgEIEAP
	lAQzrgJkyaEw1cUDouKXl+9iVWLKXjjr5i3IzNDZvf+UxICtqQayVt6AacdRxSBfhWzsX8qNxNw
	bV8eSni6krRgI8ELc7haSw6pT/Ya0szHviXehHpya/5XpViCFJnUVi4P1Nwiik3ZuEfTXK0yEj4
	6d7MZ+saM4TSu2I9EFTAusG6ZzrE8Ahuxg/qE2RiDD9dnCDoN7j7P/0WhG8Bh086epVJTUu15Ad
	U8PkXq9Fb2Ewe0R9eyxwipJ3GK4N12ugJGEg==
X-Received: by 2002:a05:7022:419:b0:11e:163:be60 with SMTP id a92af1059eb24-125c0fff8f3mr1909114c88.31.1769812587500;
        Fri, 30 Jan 2026 14:36:27 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-124a9d6b906sm13161717c88.4.2026.01.30.14.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:36:27 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v2 04/14] nvmet: Implement CCR logpage
Date: Fri, 30 Jan 2026 14:34:08 -0800
Message-ID: <20260130223531.2478849-5-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130223531.2478849-1-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260130_143628_336927_88DE28BA 
X-CRM114-Status: GOOD (  14.63  )
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
 drivers/nvme/target/admin-cmd.c | 44 +++++++++++++++++++++++++++++++++
 include/linux/nvme.h            | 29 ++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index c0fd8eca2e44..fdeb79ec348a 100644
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
index 0f305b317aa3..3e189674b69e 100644
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
@@ -1458,6 +1459,34 @@ enum {
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


