Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E10560A3838
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 03:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rE8Wh/p/;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=Idc2PboA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=cNitPS2mKtkkWvG3Koj/BsDrCRsqIPAWTzui6Y3UlPA=; b=rE8Wh/p/5AXySD
	JusrLSKCoJEVP1RTsfuOTGrW5sl5t+Z/mmc3Kj5yw/jfzepAjl1/pxiW4SoZErvJ6LAvvcXFFtZ5i
	9BvxEKKDzriIadM1lGFfl57tLrnogmwz0oFFjbprxFg6Lp8fRnT/quWG6izogVxdB8iR0Kox4TAXQ
	Sv4CGik7m137KWsK/5A81/zEfMa8Qs6j9K+msH6acDPUAquwQejPG+fKymTryIaPf0dOcLtxXiIEr
	ED6Tf9wUY8V0IqU2MfL/7NcBeii/ByGgxrmLYqEOqiKcmleJQ+3wr+JVhlKppZgwgssBftEztCist
	qF+vm/qiq6cCAVflv80A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS45Y-0000000F9uq-17S6;
	Sat, 14 Nov 2026 03:06:00 +0000
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS45S-0000000F9lc-2P2k
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 03:05:56 +0000
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-36dbde64409so2466007eec.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 19:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794625554; x=1795230354; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cNitPS2mKtkkWvG3Koj/BsDrCRsqIPAWTzui6Y3UlPA=;
        b=Idc2PboAKD1Ug6d/0b93VvJpuksUeEw2ZZFWdvQQy2Cgo0Q+89g5xo1spyPAeb2fOB
         g6qMxArcucp9KODS/piLUoZQYlc9gfe5dNtNUk4ouDqqHUynB5H1QA9jN3F7icpGQlT3
         78GCtxGrF2h82Qiua6MwxsMRP19f6wtL5NCIyAeB/mvwKkwacvTRpCMfu9msLn2gTsA8
         J8WfZ/E9szKGpj7Qd4+ZlsvBr4Z6o6b58uZ3rJ0IEaLfFzRNq4yxNrFKeHl6+TqpN34b
         G8k9waSyIoPK0XdgI49u53h0RfZ7aMkf6GUQGO+vzcuRKVsNW7VLyacYnypT/PxuHXWD
         jioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794625554; x=1795230354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cNitPS2mKtkkWvG3Koj/BsDrCRsqIPAWTzui6Y3UlPA=;
        b=lnPmdLwqohEYQSoNLJ7gzgSTy/XJM1B6Uuyp9GHYhgU7K1rmhCcq/PYG2Tmy7XojdR
         kQJQJzCjCl1/priMwcH83uA8HwkuH90UU0DrJYDAUHvFSNWuz5f3Xi/KA0cZ3NzANMAu
         VRA2E/Hvmhgwp6ohLb+1nsEMpXvPRS6xtkJr5C4GMw4AJorTl8rvX7me4s4EuBXUaKIw
         zl06QBkCAb9J0dKBtsC3sQbWlXQLCfhisvd+tBfEfvXOW+3fdZ+zzHpq4yo3+hoehQSl
         6815Ucow5C7NhGyQGgmlyr+iPuNxRQNbJo905bpQCnAbabksLblSQgdt934kmxqO+sXu
         4WXA==
X-Forwarded-Encrypted: i=1; AL+hErEp9H+BiMf6f+lNmbbORPIngxqq6Rqf1ZRW7nlorivJA1UNeDeLpY979qp35f6CoqbYE8Iy9LnTSOYv@lists.infradead.org
X-Gm-Message-State: APuU4Z9uyXiGXklyJxiLCnTf47hTEcClcLKmKYhtgjb7EBYrtBAIz0n8
	Rrz5NfEVCVN4MkhEPV5rb5MV7S8AJKwR4rPteWk2y5RzkG1UvDlsXODMZopaN9xuAI8=
X-Gm-Gg: AYBFou0nx7wBKXYtMhAMK+G8Rl3v9mY1+83hQobCW/a+RanGiye6qp38ePh7SUBk8et
	SZQ5UtfqZrSioYt1w9lotQ1GOGuvJWbEKsUvujRBsB7n7u8ll37BYSgsPfRVv0wNanc52hPPssr
	p/McFgW2GL3eOrpHT2wrkTjkdTllM/p2J4w7XEMXA8nU0MWdMq5A2ZC5Hr1ZVTznyjqIYiCbfvB
	ur0oTzXFcpzJKu66LCWmKF8/FPjS8H/ZD53HygqF3+Tuz0nGYRJN15YaTUbbgL2Rw/mqTmYmZxo
	Mmt8v4niuWtgqdB8oDkGpigSTbRBpnDT8O9qCH9Kt5GmqnYs0XiMg+y4/PeRIXeVIqy8i7oVS5A
	ndkdGiNCkauihVap7/OZ/BDqcaq1Na264sDaS0lCKQBj0aHcVJJMfZvifxZJTbb0g8MEdS3NPod
	gPAO9JbSZpS2OovytnEeG/pSP09RCB+ysUodyLPcyXRahzanskJcgUP+i0ajKqTrDJp0fhBUAl4
	qZQbnXOKA8lpyOnRnp5PMMRjZEoG2xdSiDn/HxWa1TDllg591AawJc/4Be01nKxGxj6oQNwD36g
	Diy0D5GeulMN9vnEMWnvyckdfroGrKszDMSfqKqyVVThrHK0dNmtByKnYnc3mQOYm7Szq3A/0Q=
	=
X-Received: by 2002:a05:7022:b056:10b0:1b5:1a6c:af64 with SMTP id a92af1059eb24-1b51a6cb8ebmr564905c88.17.1794625552354;
        Fri, 13 Nov 2026 19:05:52 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1b50316e008sm10829382c88.6.2026.11.13.19.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 19:05:52 -0800 (PST)
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
Subject: [PATCH v7 04/17] nvmet: Implement CCR logpage
Date: Fri, 13 Nov 2026 19:04:18 -0800
Message-ID: <20261114030454.2836543-5-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114030454.2836543-1-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_190554_630825_9590A49A 
X-CRM114-Status: GOOD (  14.56  )
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

Defined by TP8028 Rapid Path Failure Recovery, CCR (Cross-Controller
Reset) log page contains an entry for each CCR request submitted to
source controller. Implement CCR logpage for nvme linux target.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/admin-cmd.c | 43 +++++++++++++++++++++++++++++++++
 include/linux/nvme.h            | 29 ++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 3df9db454db9..25c320752d2a 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -220,6 +220,7 @@ static void nvmet_execute_get_supported_log_pages(struct nvmet_req *req)
 	logs->lids[NVME_LOG_FEATURES] = cpu_to_le32(NVME_LIDS_LSUPP);
 	logs->lids[NVME_LOG_RMI] = cpu_to_le32(NVME_LIDS_LSUPP);
 	logs->lids[NVME_LOG_RESERVATION] = cpu_to_le32(NVME_LIDS_LSUPP);
+	logs->lids[NVME_LOG_CCR] = cpu_to_le32(NVME_LIDS_LSUPP);
 
 	status = nvmet_copy_to_sgl(req, 0, logs, sizeof(*logs));
 	kfree(logs);
@@ -617,6 +618,46 @@ static void nvmet_execute_get_log_page_features(struct nvmet_req *req)
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
+	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
+	kfree(log);
+out:
+	nvmet_req_complete(req, status);
+}
+
 static void nvmet_execute_get_log_page(struct nvmet_req *req)
 {
 	if (!nvmet_check_transfer_len(req, nvmet_get_log_page_len(req->cmd)))
@@ -650,6 +691,8 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 		return nvmet_execute_get_log_page_rmi(req);
 	case NVME_LOG_RESERVATION:
 		return nvmet_execute_get_log_page_resv(req);
+	case NVME_LOG_CCR:
+		return nvmet_execute_get_log_page_ccr(req);
 	}
 	pr_debug("unhandled lid %d on qid %d\n",
 	       req->cmd->get_log_page.lid, req->sq->qid);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index d31c9648af43..98961f80b173 100644
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
2.56.0


