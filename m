Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D5ACA9ED2
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 10:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LoNEcPDXDDbnlveBeeC45rD3sgSjJXZHddsvFQD932A=; b=EXcAto+ER7Nevs9QN1GG7U0Hjm
	CQmlPwFAAxvSHsI0HTMfkpDtAWgmjyOGFNbkVIt+jjJlB1vpn1kNPIGkGyCPa8zSE72n2QtDIPyMP
	iFzi39VzdbqhNv0ihb3b2ai4sLD3E7Kjf1cmFPCQm+HX265xiw6EfG3BGkIjuST+jhSjhLP0wkcPU
	tJqJQBfRm2pDdbo89z01nqfe+Fie7ZAZpwkgcIZA7JFBz/PfilPLgwsLIjZh4KT1B9Xh5sTGzbmwC
	1kS9j36IcMbs3KGSOVxzq7BZlJpU0gXqHPiggCtWpoeCLWXrkEq7R1QrOWsUgDLlEoNWwyMs/+g7I
	l32ZNGpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGZwD-0000000CboG-3NRr;
	Tue, 13 Oct 2026 10:40:53 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGZwB-0000000Cbnw-2MRT
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 10:40:52 +0000
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-3ac397836fbso531342a91.1
        for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 03:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791888051; x=1792492851; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LoNEcPDXDDbnlveBeeC45rD3sgSjJXZHddsvFQD932A=;
        b=gfsFkPyw1qMO8CplxBmbFVOVmN1Cg4d8/qjozXDWeYZffT5GjpWHNadZLMZQj3n4cP
         MF3vh5pz1UuBIX+bUqNu90eAvCPdRlfMn6HQa1B0I0t7nAux2lwFaDQmi6QUxqCft9bC
         onWvz5uCNwFjKErLy51lhKOr6p5BxOsmBuFvwbCRaWbspiG8P8PvPh31zf0O9fyQe+HH
         QCEH6KMruEn3xLKg6cNRgUdGCjwI5BU2WvBj4Mmp7RXfdOK8jGuqIETay2FqgVgJ8xJA
         5RWVEclczGNMn43grE3nmEatEUshPgx8/qrf0t0F4E4Emw1NZur8a81AfCy1rJfElQal
         I83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791888051; x=1792492851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LoNEcPDXDDbnlveBeeC45rD3sgSjJXZHddsvFQD932A=;
        b=yUvoZoV/gTc0lZbRxBAGc9e91PR0QSi0LOF067COZFPznANrRGKtb8Jstx5gYmcExf
         +qgg56EbUl3syce1mwIYTLRGA15BPhjx3Dl0SORfmeuesFBSiZV+bxHrm9MW7YQmcIIg
         1NS2L1irvg4m4TgCOqv1jaG86DU267NBxBgUTaZ93ycYDvmsbBWPFcB9zUp+fSI4r60H
         ruyYjtonSpEU19t9jeIuRI14epMTn2+iARoONoUHrl+dpXZozTn9wIbBa5t7MGePug8B
         hZaNMlgeRUwY3DHjPTN4JMgLbXeoTkZzW9YG7r1aMjy7aFMIYCDmPVLkqsoB8ExyYQa3
         ojTA==
X-Forwarded-Encrypted: i=1; AKwUvBwxOusqnv9cvh9qcp7CRMyTtAD0b66Xmq5WqQIgMG8OZ++OMM70ujwGDsqCVnCXO7pqtNbich+cPmsV@lists.infradead.org
X-Gm-Message-State: AFq9FYJ3Yte7opuntSIxx+3blPSXgTDCbirKZPEIMQXQL6AdOrDf8AiC
	5e52afMkZlO2lk7D7bhBe9YJKbEyzToTsEtgZ5p0NBIG58B/Vp9wg2qSa66XncHnBl4=
X-Gm-Gg: AYBFou3RgjfkSG28LL9hqINPSINmouBxUAjzRoPw3VoogpW66g0RQtGoQSy86vFgFGy
	URCLoM9lAy9OoSsxJPdeubW46lD6nmC0vuudSH+1Mh6c6A9NXZIdDPVMs+USkoztTDmKDOk0vGE
	/AN3cvZSrMCD14ZTVXGjJatdCLeeSGJZGbhjYVczWYu3o/KQziyYiIqxomA+/bt4XiDJLlqr/La
	xtfuLBlIReNKng3lkbpgcfrJN682qZrt8/iJS/KYiSM5qJCpCZyUb89Lpt+SMMGu6snQnLekRzp
	alnldgWoqH47e/zyVl/bDxtULVEgvLy/lFeB5iX4pro4pZMaEpJpmMJX5Rph6rlm8UEAKTP1gLO
	u+hS58lKkFNeyioqVq+T9eiRG/Byz+zZE2++eSdtHGIztQ+DuS+gRP9tQn9gOctizkPcwBs4ieo
	AL3B5H98uRNEPughexBtGoFnPFHbIXBiAqtb03wkLG2ZYGEHvDWRufKR9nqegkQ5Be1ynKhFsz/
	WJJUgh7TePc8QhG
X-Received: by 2002:a17:90a:1196:b0:3a8:a1f6:3b32 with SMTP id 98e67ed59e1d1-3ab423f7336mr6083299a91.38.1791888050617;
        Tue, 13 Oct 2026 03:40:50 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab3386ba90sm12332028a91.1.2026.10.13.03.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 03:40:50 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Justin Tee <justin.tee@broadcom.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Cc: Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart2021@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH] nvmet-fc: bound the FCP command data length before allocating buffers
Date: Tue, 13 Oct 2026 19:40:38 +0900
Message-ID: <20261013104038.3078601-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_034051_607449_47F9AB92 
X-CRM114-Status: GOOD (  16.46  )
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

nvmet_fc_handle_fcp_rqst() takes the data length straight from the FCP
command IU (cmdiu->data_len, a 32-bit value from the wire) into
fod->req.transfer_len and calls nvmet_fc_alloc_tgt_pgs(), which hands it to
sgl_alloc() with no upper bound.  nvmet_req_init() only parses the command
and clears transfer_len; nvmet_check_transfer_len(), the only other place
the length is checked, runs later from req->execute(), after the allocation
has already happened.

A remote, effectively unauthenticated host can therefore declare a huge
transfer length and make the target allocate that much kernel memory for a
command that never delivers the data.  nvmet-tcp bounds the equivalent
length and the rdma transport is limited by its 24-bit SGL length field;
the fc transport had no such limit.

Reject a command whose data length exceeds NVMET_FC_MAX_XFR_LENGTH before
allocating anything.  The ceiling is 16 MiB, the largest transfer any
in-tree fc LLDD can describe (lpfc maps up to LPFC_MAX_SG_SEG_CNT 4096
segments, qla2xxx 1024), so no in-tree configuration is rejected.

A command declaring 4 GiB reaches sgl_alloc() unbounded before this change;
afterwards a length above 16 MiB is failed with SGL_INVALID_DATA before any
allocation is attempted.

Fixes: c53432030d86 ("nvme-fabrics: Add target support for FC transport")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/nvme/target/fc.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 1b557775e033a..5ec581780454e 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -62,6 +62,16 @@ struct nvmet_fc_ls_req_op {		/* for an LS RQST XMT */
 /* desired maximum for a single sequence - if sg list allows it */
 #define NVMET_FC_MAX_SEQ_LENGTH		(256 * 1024)
 
+/*
+ * Upper bound on the data length a host may declare in an FCP CMD IU.
+ * This is the largest transfer any in-tree LLDD can describe: lpfc maps
+ * at most LPFC_MAX_SG_SEG_CNT (4096) segments and qla2xxx 1024, so 4096
+ * pages covers both.  The length arrives from the wire as a full 32-bit
+ * value and sizes the command's buffer allocation, so it has to be
+ * bounded before anything is allocated for it.
+ */
+#define NVMET_FC_MAX_XFR_LENGTH		(16 * 1024 * 1024)
+
 enum nvmet_fcp_datadir {
 	NVMET_FCP_NODATA,
 	NVMET_FCP_WRITE,
@@ -2577,6 +2587,14 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 	atomic_inc(&fod->queue->sqtail);
 
 	if (fod->req.transfer_len) {
+		/* bound the host-declared length before allocating for it */
+		if (fod->req.transfer_len > NVMET_FC_MAX_XFR_LENGTH) {
+			nvmet_req_complete(&fod->req,
+					   NVME_SC_SGL_INVALID_DATA |
+					   NVME_STATUS_DNR);
+			return;
+		}
+
 		ret = nvmet_fc_alloc_tgt_pgs(fod);
 		if (ret) {
 			nvmet_req_complete(&fod->req, ret);

base-commit: 2c3418fffa9d037b2038a6db48be63f9e2291806
-- 
2.43.0


