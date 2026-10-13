Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9F7CC6B12
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 15:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3b6XsX6coe7wQVnv95dimNXsm+R1YHHriqp/Z4dvvWM=; b=TfWjndUYSHRnHYkT5/rYXYcDPa
	mNDRtu8sG9W/EcoxQF4Wwc7V3KHHQHf6XWgodfeEaMPnhnQcobY5ZoHVg2WnIb3UR6qLB83Ix2QMt
	nEd3ay2QUXTGDpkrxtHx3hzcVySFVCay6YzYvM+sG/7sntvperDSfbRH4iScfA1H/E/FHTI/zJJ2e
	N3nfNhuqRexr8sgh/0pU+eSZ5LRePLDzXypZicbzJfz1/2wiA+pUPVTuT0TMBXM7m8SDaw1xaCErI
	Za9jP14YhyFs9m3ixf12zDMsegGwEjynxr5o64F+S1ZALWcItg0MI7szV3sezHHx2CzqS9l6Ef8sB
	U+936Ulw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGeVg-0000000DMAq-43GK;
	Tue, 13 Oct 2026 15:33:48 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGeVW-0000000DM8X-0fB2
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 15:33:46 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2e5378b281aso16842015ad.2
        for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 08:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791905616; x=1792510416; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3b6XsX6coe7wQVnv95dimNXsm+R1YHHriqp/Z4dvvWM=;
        b=G9Lx9mlvJq/hgS9FzxwG5yLhmTZ2ZSVJqSxO4qhh8b8IK65Pk5BFWTa207tmFwCpZy
         FYu6oWJJF9JlfaDweMAQnBjor9QwFlgnbwtSMyAywrg207uw41YZPgZ+Zpj1fNtwfDds
         HnHnlVNLmqDny3NQIhsiYH/OuMQirRxBA/i/UAw9E+bvitf4R098bVqrTz6HFDr/dDqH
         HPtaAFTTuboXZ7pSGGO6OjlXazSXS+w87qisZ5mW/wsdT6Cg3+Ued7fDqtxNfRYe7cUA
         DDOi+QmeQV5Rgm914acpn3s3CsnWHkkY6BIYrEGm/VBFb3jtJ9h62C+Sw3BHUHZET3DJ
         SCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791905616; x=1792510416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3b6XsX6coe7wQVnv95dimNXsm+R1YHHriqp/Z4dvvWM=;
        b=Px/1JeIO/HiHICSHhMhvIm0zDR0gBzwV0bIwMZG9NI6HZiY+rXlxi+PYf7Gzs1/2iu
         ySlEXfpctMImgrguesiqEMh1xTT02tmTXn7KH12C5TWeh3I/EG/f/GYvD1ePewtBpDDO
         VAAiKaj5T6CmoPSzD6CN3SS4xOSz5mJ469Ga540YWlyrrUVpNzMExRtn3+W8FyaJ3MdF
         LlCcDn1o2Vd5wVU6gLxt3pFiqnnZ6u39tFhFZIiGK6BDVyoMQqOi4431ad8YcEBZK+Xy
         CKoB0LuypxQ4yucZIJo4WB7VMvwABHblk0nCy8cnKHJc3IcKqawMA3TFHokmz08NA0p6
         nhpw==
X-Forwarded-Encrypted: i=1; AKwUvBzm2QsqotrOjuyvePQ1SZb7M7CPq3HaXS8bYu4EIxenYdZUNkiUfdbTvdGrkCtFHfAwhS2KU5oSSbwg@lists.infradead.org
X-Gm-Message-State: AFq9FYK5jzpWKepAEBEKALPvtRNbbJE9imjpGBYjEegsHU2Quf1KJOOM
	oEjzdMZHxvUzquVQrIAQvMfnTZ+gD+AWDX28luf/Fb4DVAYtUchJvL4h8t3OLocojDc=
X-Gm-Gg: AYBFou2h9DpFshA7Vqm90Wuur1/u2+LHlO4+Fs57kxWIU4AK9u1U8t/QglYuVxcnNh7
	erPI7nYAtH5SXAjBZzDQ3cx3MyKuNqOQhG11/0aXNk/3WeUeIplpnq+4Id4RdUlguyj8SGdAjYi
	Z9EJhTWRtDDF9JY5RSMOupXzLPzSzv/Kf5laVtx8jI+Ge5fUaEPewmzVKYG3CyloMmY5CgTXl6l
	eLWJYWbyuDxV4HmpC/FRnDvYkBypcSuWD3Pm2qV0T9AYxpmGFdm7BFYb8zOGm/XIoqAojoJ+70w
	qda1lSqExUNyLk/IgNURlbGxGqxFn7v54AAHVRIbHwKVJHv+bQ8broZ+dSPm8cmLChjbB40NeNG
	GLTjtGppfawHLMbtADg9CYhaeD8eixypvEFXx0dH9Eaj3BG6s4YszyPTlebaN/ccTGHjYRj/7LZ
	hvfjIgd+h4d3p3HJ716gyyCnyVWfJT+FKmEKN90SlT+i3U0bzgfgS0NKFuB+8sZqL/8Z/tWU390
	iSh3KgB5KUvy17+Gc+6
X-Received: by 2002:a17:903:1c7:b0:2d8:d4d3:3fbb with SMTP id d9443c01a7336-2e842ab650cmr108150165ad.15.1791905613073;
        Tue, 13 Oct 2026 08:33:33 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c51c:be8a:c517:276])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8dd5sm60841555ad.55.2026.10.13.08.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:33:32 -0700 (PDT)
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
Subject: [PATCH v2] nvmet-fc: bound and advertise the maximum FCP data transfer length
Date: Wed, 14 Oct 2026 00:33:16 +0900
Message-ID: <20261013153316.3178656-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_083338_202666_766676CD 
X-CRM114-Status: GOOD (  21.11  )
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
fod->req.transfer_len and calls nvmet_fc_alloc_tgt_pgs(), which hands it
to sgl_alloc() with no upper bound.  nvmet_req_init() only parses the
command and clears transfer_len; nvmet_check_transfer_len(), the only
other place the length is checked, runs later from req->execute(), after
the allocation has already happened.

The fc transport also advertised no limit: with no ->get_mdts callback the
target reports MDTS as unlimited, so a host has no indication it should
keep transfers small.  A remote, effectively unauthenticated host can
therefore declare a huge transfer length and make the target allocate
that much kernel memory for a command that never delivers the data.
nvmet-tcp bounds the equivalent length and the rdma transport is limited
by its 24-bit SGL length field; the fc transport had neither.

Advertise a Maximum Data Transfer Size through a ->get_mdts callback and
reject a command whose data length exceeds it before allocating anything.
The ceiling is 16 MiB, the largest transfer any in-tree fc LLDD can
describe (lpfc maps up to LPFC_MAX_SG_SEG_CNT 4096 segments, qla2xxx
1024), so no in-tree configuration is affected: a compliant host now sees
the limit through MDTS, and a host that ignores it is failed with
SGL_INVALID_DATA before any allocation is attempted.

Move the fod->offset reset ahead of the length check so that the new
rejection path and the existing allocation-failure path both report a
zero transferred length in their response, rather than the stale value
left in the recycled command context.

Fixes: c53432030d86 ("nvme-fabrics: Add target support for FC transport")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
v2: advertise the ceiling through a ->get_mdts callback, per Christoph
    Hellwig's review, and move the fod->offset reset ahead of the length
    check so the rejection and allocation-failure paths both report a zero
    transferred length; keep the allocation-time bound as enforcement.
v1: https://lore.kernel.org/linux-nvme/20261013104038.3078601-1-yhlee@isslab.korea.ac.kr/

 drivers/nvme/target/fc.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 1b557775e033a..55263d162cb7f 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -62,6 +62,9 @@ struct nvmet_fc_ls_req_op {		/* for an LS RQST XMT */
 /* desired maximum for a single sequence - if sg list allows it */
 #define NVMET_FC_MAX_SEQ_LENGTH		(256 * 1024)
 
+/* maximum data transfer length a host may declare in an FCP CMD IU */
+#define NVMET_FC_MAX_XFR_LENGTH		(16 * 1024 * 1024)
+
 enum nvmet_fcp_datadir {
 	NVMET_FCP_NODATA,
 	NVMET_FCP_WRITE,
@@ -2576,7 +2579,16 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 	/* keep a running counter of tail position */
 	atomic_inc(&fod->queue->sqtail);
 
+	fod->offset = 0;
+
 	if (fod->req.transfer_len) {
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
@@ -2585,7 +2597,6 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 	}
 	fod->req.sg = fod->data_sg;
 	fod->req.sg_cnt = fod->data_sg_cnt;
-	fod->offset = 0;
 
 	if (fod->io_dir == NVMET_FCP_WRITE) {
 		/* pull the data over before invoking nvmet layer */
@@ -2988,6 +2999,14 @@ nvmet_fc_host_traddr(struct nvmet_ctrl *ctrl,
 	return ret;
 }
 
+static u8
+nvmet_fc_get_mdts(const struct nvmet_ctrl *ctrl)
+{
+	int page_shift = NVME_CAP_MPSMIN(ctrl->cap) + 12;
+
+	return ilog2(NVMET_FC_MAX_XFR_LENGTH) - page_shift;
+}
+
 static const struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops = {
 	.owner			= THIS_MODULE,
 	.type			= NVMF_TRTYPE_FC,
@@ -2998,6 +3017,7 @@ static const struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops = {
 	.delete_ctrl		= nvmet_fc_delete_ctrl,
 	.discovery_chg		= nvmet_fc_discovery_chg,
 	.host_traddr		= nvmet_fc_host_traddr,
+	.get_mdts		= nvmet_fc_get_mdts,
 };
 
 static int __init nvmet_fc_init_module(void)

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.43.0


