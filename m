Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D0BC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jul 2022 19:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=P/BPGntKrlJzEPfvltLN0Erobid99m4v2m2RxQ2xveo=; b=tlOQ+TSWED0n4y119UEEpRLxz0
	atVoZljCxxueySu7Ber0CMpStMuybrkE6k0S/DXzziJPWhz5A9F089rfWYXUDFgqwFLaZHwXWIagw
	IXcuZNC11ro0UaKzn05gl2BzqvCFGfZFKlytP429/PNZ9mQAjam951458Uw2q+yjVQ4EpnXK3tVrX
	5h2ie0sgKekNFTBAsf6EZxNtQ/QrCjOVYN6RG6QIG6q0ur6ONpEBJ7op/8JMkE7kEMi0r0zr0WY8I
	8fgNOLCcAFre+Xf8mdWGcX2YTRQ5YmipLqR1zb5jXaCwI22xUODvMkXphaA9dUFOMOEn08CRvfBNw
	eXfYJsZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCRIc-009uid-Mm; Fri, 15 Jul 2022 19:48:30 +0000
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCRIZ-009ucb-32
	for linux-nvme@lists.infradead.org; Fri, 15 Jul 2022 19:48:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657914494;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=P/BPGntKrlJzEPfvltLN0Erobid99m4v2m2RxQ2xveo=;
    b=S0mro0BHCuqvDBoy21k1GUKqwTk5dSdwtvSUBuUU+LttOD4sjv4YRTX5/EQgjh2psR
    aCDANAqjn5PGprXF3hd8mkaCz/lMI1z0S01RvCIX3qwKfLBD1i+ktAfmplVby2AhB8RK
    2x0ZeQYWxuxSFDH5rt+e33IwKtBP1iBNteCbotEKsGrlRHsh8aFN0GUFtGaP0g7YHQiE
    DXAjAnPdCb2xRf73XUNvCu+P8ja0ZdzcMGTxHYqW8enTkK5KJTs5byO6MFp3kH25x2+c
    u3yaDs3wQDlHzB2nNbxyR0aXQQ3qmeIs/AoZ0eP5IlHzO91wlSoMKi36xTjYPSyWx6jX
    ztKw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1UzWvoOJrrSACWlJOqXdPodE67SDBKlmD1RX4Q=="
X-RZG-CLASS-ID: mo00
Received: from linux.speedport.ip
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id z88edfy6FJmEE5I
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 15 Jul 2022 21:48:14 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	beanhuo@micron.com
Subject: [PATCH] nvme: Use command_id instead of req->tag in trace_nvme_complete_rq()
Date: Fri, 15 Jul 2022 21:48:04 +0200
Message-Id: <20220715194804.324158-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220715_124827_298535_28BC2675 
X-CRM114-Status: GOOD (  10.56  )
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

From: Bean Huo <beanhuo@micron.com>

use command_id instead of req->tag in trace_nvme_complete_rq(),
because of commit e7006de6c238 ("nvme: code command_id with a genctr
for use authentication after release"), cmd->common.command_id is set to
((genctl & 0xf)< 12 | req->tag), no longer req->tag, which makes cid in
trace_nvme_complete_rq and trace_nvme_setup_cmd are not the same.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/nvme/host/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index b5f85259461a..fe8c90080731 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -98,7 +98,7 @@ TRACE_EVENT(nvme_complete_rq,
 	    TP_fast_assign(
 		__entry->ctrl_id = nvme_req(req)->ctrl->instance;
 		__entry->qid = nvme_req_qid(req);
-		__entry->cid = req->tag;
+		__entry->cid = nvme_req(req)->cmd->common.command_id;
 		__entry->result = le64_to_cpu(nvme_req(req)->result.u64);
 		__entry->retries = nvme_req(req)->retries;
 		__entry->flags = nvme_req(req)->flags;
-- 
2.34.1


