Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3DFC433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 00:16:03 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7CC161184
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 00:16:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7CC161184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gQkQjIKnQIZqFxfANV8RYIU/puudZbsGEUWYWM/xO+s=; b=DH39OpNnVpIX3jwGi5MkpjBBw
	2DP4GItQO2ySbmlSuFSeJs1jWYHeZXBIv6ilQKYU2Ieqg+kBFZaFewSAn/feQ4i+p9jcLCbpulv4z
	ojMnWhZyT6NSVFqkkcGDCrmW4HDRn9NqJv5TuZNWz7FBLJCtz9viRKo9gIvdQm38EO7EX6t/pmp7z
	M7Dq/+OwZOJfva5GWdcwZBoU/lA/ZHnLwV4CD5BlgbjV/l3b7bpLQsaq1zwTfSEEq1g/LOKBpSBco
	KnIDf/JPolDxlKrzW6uENYb5WP2+cLxjdaFQ/EoJXxSGGqMcp412p5HE6R544q7VsP1uVdF/N6ZxZ
	56ynPLnEw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUIKp-006L6Z-2F; Thu, 08 Apr 2021 00:15:47 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUIKQ-006L2R-8L
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 00:15:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1617840923; x=1649376923;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=48IBaMiy+XMSLvltkY9XR7oqoc3RiesT5CikJ7H5oAU=;
 b=NMNYRudj96W3iXmhON58VhsGGE7nAlQhwtZbN7fsTP3G2OhAEm5YACdt
 RSuNXQtUlG7kBquwAKR0u8CjbQooJpxt7aSQJquRC+xlTJsj1pZwDiqsa
 be9fhZqofUtsvEhZ5iEkCO4f7pVoL21F77sW8fD0Ic1IM6Kz5QJX48MFg
 C/gr12a6rIcxnKIy1wmMtm2nKtHwgpvcymPntSF1EsDgvS9pFqZ2PaTyl
 UWQmo7mUhNA6VhckME2v0x9PRu2aQxAuXpUCWsDHq21bpNOpWPI9/tSn8
 lPfspjNNVLlr6Trmi/Szz8vlv5v5Rt+hOoqadySU0lM2a03j0y+Fl9xb9 Q==;
IronPort-SDR: EtsCQ+h53TGY5s0DnSYMia+ltC2Fg4rJ3abN/SBn3XYnFoPFzowSBAfRJPo7wRphWgdoay/Ksa
 EvR8a22cQpB5SWwRa8vWrlIUUq5Z07ROoubOhk4SNF6VfzZUURvJStCA23+wIMfwdVh+VzaBL+
 yIwopd31x/VAZ6U+h7f6kC5p1tl9Z5hQX8WpdhcstbLNVttF9OmKgIS5csrhTCIT3CbwS44syD
 eV8mLXylpT6EhzpIZ9Y8FCuM9PiINTA58ATWbGu2GuXxVoWwljyz222Y/6rbyudpeUjD4aZDnz
 PdE=
X-IronPort-AV: E=Sophos;i="5.82,204,1613404800"; d="scan'208";a="268440929"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 08 Apr 2021 08:15:07 +0800
IronPort-SDR: BmiJPBrw7sxtX/3mjgIgw51SZd/gHqsAF8Hr/5YJ2VI77CT5iQ2yAmgJN7UzuSma7dq0zRZiHC
 CvBGhVGGluwpfua6MRiPkpm6oGa8tke7FrP6IjONz+NkVI4LcJoSaZSQrYNq/d/tG8wJgvWnow
 1Ek5g5ddhsGisnvPmnm3A5UpTHBkSkrMqeRgVnVH+3t/Td6NLx4y40sl/wrLdcn8YUdeo4dLkM
 YB4/p5BTsL2xs1wcPt1prNxDRTvr73vDtm5mDOTZOhpQzDqWnhbGkP+P/60VAK6gkw6erskUVD
 iQmN0WVSZdyD6kSWLNdlYIRV
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2021 16:56:20 -0700
IronPort-SDR: NpRMsYvWnN25dECh2c8GlCDJE2qFw+aNdNNQPBBjCA54jhE2sH2UMIb3lPH9/OZfsCjcHxkyIj
 L5RFq6UB8o1VYZuz0EVCZU84XoaM5by1legfzPgMg2p3iEyifBtSXiDp2Bc4SB4uOHB4tn6N21
 Fyu2vuUcqKbz17jfQv2VNMIU056zUo4U84N4OgXZ7RkSSkuFb00iRKPXeznSOtnj/iw7KGADY+
 CnR/S3FfaKmsxlflkDxkYf85joUbpNnLgZBqBAPJljmu9vpz3CX2+TZGAPi0G4Ej7MXlYOtC8E
 ZkA=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 07 Apr 2021 17:15:02 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, damien.lemoal@wdc.com,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH V13 4/4] nvmet: add req cns error complete helper
Date: Wed,  7 Apr 2021 17:14:27 -0700
Message-Id: <20210408001427.20501-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210408001427.20501-1-chaitanya.kulkarni@wdc.com>
References: <20210408001427.20501-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_011522_760051_C1515F99 
X-CRM114-Status: GOOD (  11.29  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We report error and complete the request when identify cns value
is not handled in nvmet_execute_identify(),
nvmet_execute_identify_cns_cs_ctrl(), and
nvmet_execute_identify_cns_cs_ns().

Add a helper nvmet_req_cns_error_compplete() to remove the duplicate
code from all the above three functions.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c |  5 +----
 drivers/nvme/target/nvmet.h     | 18 ++++++++++--------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index bf4876df624a..da9dee38bdce 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -717,10 +717,7 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 		return nvmet_execute_identify_desclist(req);
 	}
 
-	pr_err("unhandled identify cns %d on qid %d\n",
-	       req->cmd->identify.cns, req->sq->qid);
-	req->error_loc = offsetof(struct nvme_identify, cns);
-	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
+	nvmet_req_cns_error_compplete(req);
 }
 
 /*
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index cf542bf5df31..752a4a9ab759 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -590,6 +590,14 @@ static inline struct nvme_ctrl *nvmet_passthru_ctrl(struct nvmet_subsys *subsys)
 }
 #endif /* CONFIG_NVME_TARGET_PASSTHRU */
 
+static inline void nvmet_req_cns_error_compplete(struct nvmet_req *req)
+{
+	pr_err("unhandled identify cns %d on qid %d\n",
+	       req->cmd->identify.cns, req->sq->qid);
+	req->error_loc = offsetof(struct nvme_identify, cns);
+	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
+}
+
 #ifdef CONFIG_BLK_DEV_ZONED
 bool nvmet_bdev_zns_enable(struct nvmet_ns *ns);
 void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req);
@@ -605,18 +613,12 @@ static inline bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
 static inline void
 nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
 {
-	pr_err("unhandled identify cns %d on qid %d\n",
-	       req->cmd->identify.cns, req->sq->qid);
-	req->error_loc = offsetof(struct nvme_identify, cns);
-	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
+	nvmet_req_cns_error_compplete(req);
 }
 static inline void
 nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
 {
-	pr_err("unhandled identify cns %d on qid %d\n",
-	       req->cmd->identify.cns, req->sq->qid);
-	req->error_loc = offsetof(struct nvme_identify, cns);
-	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
+	nvmet_req_cns_error_compplete(req);
 }
 static inline void
 nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
