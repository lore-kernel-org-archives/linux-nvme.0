Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DC9C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 05:42:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9F2D64E29
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 05:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F2D64E29
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9nSLBd8EWC/qbYVOJtCGtrtOgnMjEjWUxWeOh1UokAk=; b=nDtmjei5tql1OUn+AegcVn+qB
	SZJ5r7JthCBo7+8RiYOfeWez7XQcr51O0Gn2fD0pic2bFJBGYS+7oDeVMaw9emhnuAVDkCzBkeydu
	3WKRGiRwLR7t1RCT1cXHcNc19RRKXrRKSQSdPgWiYnmho36pWVMT0ntiWW6wZTQ5QAT9tiEn68ivZ
	ErzKp97HezJiChTQGZT4/b8pCFc6LkDA5TUm7eglBDGBAYp2Ab3M7RFGPpjReF7BsTF5fZrFTtTSN
	HiRAGPTY0iRC4M2iRXkEh+ILydp2SGi7CS65Jw+Bbs3Nfp1ao/IfaQpCMnhltHNQJLmz3cj6P7Yqk
	jLQDP5/uw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6Ryj-0004vz-9E; Mon, 01 Feb 2021 05:42:25 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6Ryg-0004vH-QG
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 05:42:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612158142; x=1643694142;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tHabmBr/P34ibVFVT9qKXPU+kFXfOMpyqYScuipffX8=;
 b=ZZXFNj5ufm3Vk0ypiVca2xLtWjvQPHgh8wDvrEPUNdvFDnArxT/AZYUQ
 FsDHGr+8+gZE/ktYJcijbLPQ0+2PeLrQN0chkgKn8YyitZ5BXUNN7Gtvf
 1iXyMxeeYNJe44Re03qbSqDVU4zYxBdgQZivuAnG8rMyNDfQFT4KI//UV
 EgNNGwHmFNR6xDEaFhx/IITlFR0TOPf6QZHR4FXBEbrmNyznMLpuAXMEd
 90isKSWSTr6iz7+5TweL0GAAtmoN0tOdxPegoNF18UJJOlO5ZBi+MwI1w
 DKD3/qb6jEW5wtoLEYEokPkc83ZO1BAbRRJpbkULlakneRvCB4DUR9Nxf g==;
IronPort-SDR: POZMyxknFAvACgRnvYWVo3dLDLx7BtXL//iGvkLm0w64+jZFc6Jv3XbcAwW+xd0yKtriqgf0qZ
 pBoOkkNthlLzbkt0AbdIzUMH6tdlfSYfiBncxJ+pTVAcXzCGfGxJm4YBMZBTzWfRC14O1k1kXe
 EkKEE91osZ6Q/Lo900MrkHg+RjGuuBaswY2oiV0ISPBsMS/fWZ/Q5WlhM3eBls1d4FQT90r+RJ
 0uafzbGjxANt63dJumWrLz8jimMaso8RcY2B6Cw2AmSrNiBFYc5Xdarodev9NHp7flUtr2ta+X
 Sdo=
X-IronPort-AV: E=Sophos;i="5.79,391,1602518400"; d="scan'208";a="158783269"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2021 13:42:21 +0800
IronPort-SDR: yTlIXw257l+MQI7WAXkWrA3hos7ijPSs8X6Z5gCiGLQYM3bmUWbvOjO8PCihbPamuHjCrnw0hj
 MSXrZKTDv8rwbQh6EZSern/xtnKw1pILkKG6vw5eNDNCSLF/5ui48t5PqOLdSKvAysXpjvlDY8
 g1rQaERUpjKqbmT/oh9B5CI75aaCWYAoXZjjleqCaa9VLji5IE0kyb0qlm1lWsVYL86Nh6j3xv
 8GGhyG3dxPlLDo9VDEtGLukZc0lMseWpLrOnK0sPDCZWahs8eL1CIN/aVjqnolLva2fzvetpiB
 0KG3s+NM9i4B8ZwS5JE1423R
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2021 21:26:35 -0800
IronPort-SDR: pqhW/jKwo0teFXPN8dGgnkA4uN69qkHfLBj+SLNnmDN0EK4HaIBzizIWIjqduB4a8CYb9Gicpc
 /UuBkMsBSxF1m/yCKx79xia99CkGczgDzMWG2NzulK7Hq+nD2jYpbmfcHSgsrBFK3npEg8gyx+
 qK4hG/E5O3zqd6mfBAnIYVt8KPOML8ixXd52MDr4molWgBD1XcAvxx1ZPb3g0/eQnKiBmdD3o2
 3pXVQ6HLyZEc7krxTZf0MBS8cQ2P/8KgGgnmDYJXOBHTX3Xkw8NvgXn1ZrCRn9l68dLbSUylIs
 IXU=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Jan 2021 21:42:22 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 05/10] nvmet: remove extra variable in is-ns handler
Date: Sun, 31 Jan 2021 21:41:33 -0800
Message-Id: <20210201054138.34324-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210201054138.34324-1-chaitanya.kulkarni@wdc.com>
References: <20210201054138.34324-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_004223_010238_EC9108F7 
X-CRM114-Status: GOOD (  14.07  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In nvmet_execute_identify_ns() local variable ctrl is accessed only in
one place, remove that and directly use it from nvmet_req->sq->ctrl.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index ec64218db03c..d4e8f76ae59a 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -465,7 +465,6 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 static void nvmet_execute_identify_ns(struct nvmet_req *req)
 {
-	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvme_id_ns *id;
 	u16 status = 0;
 
@@ -531,7 +530,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 
 	id->lbaf[0].ds = req->ns->blksize_shift;
 
-	if (ctrl->pi_support && nvmet_ns_has_pi(req->ns)) {
+	if (req->sq->ctrl->pi_support && nvmet_ns_has_pi(req->ns)) {
 		id->dpc = NVME_NS_DPC_PI_FIRST | NVME_NS_DPC_PI_LAST |
 			  NVME_NS_DPC_PI_TYPE1 | NVME_NS_DPC_PI_TYPE2 |
 			  NVME_NS_DPC_PI_TYPE3;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
