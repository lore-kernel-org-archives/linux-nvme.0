Return-Path: <SRS0=ToWz=FO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92CDC4361B
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 02:59:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5211723B1F
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 02:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5211723B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KWZCdDmh6+kEpiJ0JzEI1AffPJ+ziwYQVRg5qoNrsao=; b=erhVykyull4rBy51yYmxh2Q9j
	RAIFeyDFSI3mTdu7MvrO3XSBxXHYhkyJwoAnZBZ+EvRRLD325YPnHKQSbbUvcemzASpvHmd1N7A0o
	nrGTZH5WRpEFhOJszrWdvkEJENs7S9tloCy3vMuGXdbH9B7f6yydpicYKQwUB6QsVRlNjkecXVqvM
	cMsORre3ReVmjy1VGthp2exmYEhkXPQ6cvJdO94bqaiKfTBCF4Au+5a1svwp+VyewTtveDkDTanOb
	lfELaSUaIjifc2/hnW/0EmQIGvv/JGRmPWryngVQDoiM90vXpErcCWW8gS93byKf5ZTuagCe/it30
	PEbzZIt5g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knCAb-0000ED-CA; Thu, 10 Dec 2020 02:59:05 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knCAT-0000BH-KX
 for linux-nvme@lists.infradead.org; Thu, 10 Dec 2020 02:58:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1607569752; x=1639105752;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+QDs0S7cYUjV0l5u/eqhU9qzZYEDfi24xQ/9uyeH52U=;
 b=K/bsqwQFKJYWKtrklns01VVT+9iaZHF812qPBELgsTMdJtHOfCnh+4V1
 bz/PfLbkOUwgiVLBGrTA5UGMGxn1FrevdkDe6DRUm+I8iYNXzB7shZyEg
 qTy2OoGOWNos0rmbFtxZFcKiKBX6WyidgSPTsekC1yHbyJ43Sls+MueDw
 ///INdObn5uySga+ZDAUOj7lZRapbIVmUhifmyX8qNeLNaEvZtu05Hivu
 fyqOkI/kartWRCPXcd2KbXxaq8MH3yQXExkKJR4QSLx+DAveLotVi+bCW
 prtGnxuw9SC6CEW0R2kPCxcMF86mFkpQoRtdGIkHe4NvlyhVZHLLZR9au w==;
IronPort-SDR: 2GZqTR442KXgim81wr8H3WIjh3SjRZXEQEyNA32rAL1IRwpdllo3e1XX9J9e3ODGm4nc57xc7m
 KWoYs5tkSiRLc6wrC0rDkrsmgYAHM8T3R3zRSBgEaf5CYxXdRBxWnOc24ZXB9TMZJetmGboSUD
 47UpZcm4LFWOsILUG7FyVTmh5lL/NS6USRNTstMt1fCW4IFuir4LG1nUwiw2CFoCWLOV4kbTmu
 mv4hUW9GeLLURcwNeNEX9O2/GAM43+qCGBMclIlVMXviBTvfkx6s58d8n0BVhSMNQp5Bx7J/1x
 FyM=
X-IronPort-AV: E=Sophos;i="5.78,407,1599494400"; d="scan'208";a="258549090"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2020 11:09:11 +0800
IronPort-SDR: k1rmD6+EcIOQod40Vp2xvDJsLJ+wOnQRBXKLxxlJJo1XOvEcVdpI/t5w1UY5/brFoe9jfTxePB
 /xxLPaZmL52AV1vVCCENMzl3mwAmUfgu4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2020 18:44:22 -0800
IronPort-SDR: BcYeUj8RsgomkwbSoz98T41azRcpWkViYhlM3hDiTc+MZXMo6HaO82tYQDn03YFWAtzHHcgKtv
 sI8p7wzSBVgA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Dec 2020 18:58:57 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 3/4] nvmet: remove extra variable in id-desclist
Date: Wed,  9 Dec 2020 18:58:47 -0800
Message-Id: <20201210025848.46903-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201210025848.46903-1-chaitanya.kulkarni@wdc.com>
References: <20201210025848.46903-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_215857_823903_B67ABE57 
X-CRM114-Status: GOOD (  13.45  )
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
Cc: sagi@grimberg.me, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We remove the extra local variable struct nvmet_ns in
nvmet_execute_identify_desclist() since req already has ns member that
can be reused, this also eliminates the explicit call to
nvmet_put_namespace() which is already present in the request
completion path.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 86b6bd9a662a..29438ecfecae 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -601,37 +601,35 @@ static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
 
 static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 {
-	struct nvmet_ns *ns;
 	u16 status = 0;
 	off_t off = 0;
 
-	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
-	if (!ns) {
+	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
+	if (!req->ns) {
 		req->error_loc = offsetof(struct nvme_identify, nsid);
 		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
 		goto out;
 	}
 
-	if (memchr_inv(&ns->uuid, 0, sizeof(ns->uuid))) {
+	if (memchr_inv(&req->ns->uuid, 0, sizeof(req->ns->uuid))) {
 		status = nvmet_copy_ns_identifier(req, NVME_NIDT_UUID,
 						  NVME_NIDT_UUID_LEN,
-						  &ns->uuid, &off);
+						  &req->ns->uuid, &off);
 		if (status)
-			goto out_put_ns;
+			goto out;
 	}
-	if (memchr_inv(ns->nguid, 0, sizeof(ns->nguid))) {
+	if (memchr_inv(req->ns->nguid, 0, sizeof(req->ns->nguid))) {
 		status = nvmet_copy_ns_identifier(req, NVME_NIDT_NGUID,
 						  NVME_NIDT_NGUID_LEN,
-						  &ns->nguid, &off);
+						  &req->ns->nguid, &off);
 		if (status)
-			goto out_put_ns;
+			goto out;
 	}
 
 	if (sg_zero_buffer(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE - off,
 			off) != NVME_IDENTIFY_DATA_SIZE - off)
 		status = NVME_SC_INTERNAL | NVME_SC_DNR;
-out_put_ns:
-	nvmet_put_namespace(ns);
+
 out:
 	nvmet_req_complete(req, status);
 }
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
