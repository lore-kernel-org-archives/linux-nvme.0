Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB1AC43334
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jul 2022 21:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ftOZyHjc9fR4P7242V8ktD8hYYx3sxdAtQDS71sPEmA=; b=UNCsyYmUCIg14t19JEI6Qvxlin
	sh7lY0hmKtJqcccNxdL+wyn1bwwBXw9wxnCut2sdDIov/AHz7tetWUUD9QKrOGGxkGtJOevaAZEyC
	qT5BqQ65GZ1Sp8E1530MTW/MltoUkwHzt0nRbOsjTXNturIDRh0UnyxdY/UXJbOJqHOdW/pFpdZ3X
	TVQHn1IoV3IOEAOFaIp8gmCnvYw0kcD2e+3/RxUEi7ZkpFOArzpGOjvPDj8vb4u1WN5zXHj3MsBKM
	5u78Aes7ztHG+s+0PYIIXcfP5XWW6Eb2ZJYnxgrwxoKeEFzHaTz9VX7ESNCUqZY23Rgy5ggQvpCUq
	WE2Wcwmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCSqh-00ARhS-Ts; Fri, 15 Jul 2022 21:27:47 +0000
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oCSqe-00ARg0-RH
	for linux-nvme@lists.infradead.org; Fri, 15 Jul 2022 21:27:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657920455;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ftOZyHjc9fR4P7242V8ktD8hYYx3sxdAtQDS71sPEmA=;
    b=DO/MC0H/eiSQcg5H6jggad38h188504b5uxud6U4v9MEVXubNLQJHjIzjvXSbOgQvW
    YPGjOa0baJjnuBsQBFA/c6SiEJhmZeX1Pnp3xqELJBcwB/FvnZPDPVdZV71HkpIFPFT2
    XjPbfnWdoKXV9daWmuiMZ3wS5jYwt2C/aG72m+FKWpUSLIu1nETLlVMs3lwmk1p3P8QG
    nM7vyh+DM0hW5BXm3xIYlUUbnyJ0Dw4NC03UBE3yC3eoRAkMZasFTL5bEzIK5HF/jjvR
    hzKRrxixJw00SLF8ZHksFJp5PoSq/RE+OO8VS/AJqQv5W7BbgRWnRLdrGbiWmwrPnyll
    llgw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1UzWvoOJrrSACWlJOqXdPodE67SDBKlmD1RX4Q=="
X-RZG-CLASS-ID: mo00
Received: from linux.speedport.ip
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id z88edfy6FLRYECh
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 15 Jul 2022 23:27:34 +0200 (CEST)
From: Bean Huo <beanhuo@iokpp.de>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	beanhuo@micron.com
Subject: [PATCH v2] nvme: Use command_id instead of req->tag in trace_nvme_complete_rq()
Date: Fri, 15 Jul 2022 23:27:21 +0200
Message-Id: <20220715212721.332857-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220715_142745_137798_7E44E65D 
X-CRM114-Status: GOOD (  10.49  )
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

Use command_id instead of req->tag in trace_nvme_complete_rq(),
because of commit e7006de6c238 ("nvme: code command_id with a genctr
for use authentication after release"), cmd->common.command_id is set to
((genctl & 0xf)< 12 | req->tag), no longer req->tag, which makes cid in
trace_nvme_complete_rq and trace_nvme_setup_cmd are not the same.

Fixes: e7006de6c238 ("nvme: code command_id with a genctr for use authentication after release")
Signed-off-by: Bean Huo <beanhuo@micron.com>
---

V1 -- V2:
    Add fixes tag.

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


