Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B38C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 18:02:41 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD8F861438
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 18:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD8F861438
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=w7Bj4iKLlftYjp1ulUCElrWxGBvMV5NX4Gdkf8fJ8YQ=; b=dFWsFfCFfjeyq1g6be2vNAa0l
	NUSrApr9R3mjhJCFnt6w8qpv5ehNah3gSIJktg62K3SAsCfNzVZKslZyRt1GaJsbLgvagLbVBVdA4
	8XuVIF+UJgLb+HaVGN5uWTg4kpgMo21BsatazxFkVs8JlvLe3i9SL81ehfzS4SLk906BWRrBmbo7e
	joid/Vv0YzWQyNkOtsGeA1dBLhryUKfxZHrTQugnljITL4Y4+adDujQxFNvoCgb3T2/WJt755nGT+
	4Wxx+MfGfQjUuvH3Lwy9h+dbSrsVIHKmbo8xib2U6hyeSabGSPrsmMPLCRJ+4X1tStliAKk5ruWrb
	nt7D9ipzQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgtBU-003Vbx-FG; Wed, 12 May 2021 18:02:12 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgtBA-003VVp-AW
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 18:01:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=kl93x54BJskchK7KRDCFvbDVv+4JTpAnLAyyFjUhthg=; b=fyqfayyGccM2QOFn1VWWfhppcd
 5VDiba9aVeCnEDxijaWwaAVsr/W5KUypvcntzsQVFclcqv1HTh7zgsB6FeSZF9rtDV4MHYSGyBA+W
 dyKHCrKD9UGPs7W1nSgNOlv1kTbX5k7zuoaTVQUifVl3qHoIgNtmP6DJPcRtdDhgB6POqWAe12BhT
 +Rv+NlSbyZgOHr6Bi4Q6qEll9SNv9guHiVf58dR/d7fiCQAwnKEoCNoGDo4EloOdsaUoPtpskQ3M+
 YKThi6YOGiRrqIAFfRfMCjJz7IbBvVLAUUR868wO5rHnQI4Tl4plxjM9kwl7Rpdta4GNz3aBckWHS
 EswCvlRw==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgtB7-00AflW-Oc
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 18:01:51 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4522861104;
 Wed, 12 May 2021 18:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620842509;
 bh=E8rWj4FUdAPOc+cfOTS9ZRbI7XYBdEGIcCkTrL4YFCw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QWruANvdK47L4khFIVPn2AjokLb3ujLS6Q4B+VbuDisnvKD2QM+tuYe1XVdTMt9al
 334BBErIeyMfXXoip30pJKnT4Q9D1q3ERPHaME1+5XRhp4XRM8KRG25lpEzg0eH1/F
 KmOq/1dl27URRPSRPnIWARvxjmVQ5HVVggUQhU+Z65UDGxB+y8hyPjPMUmPCMK+V3L
 /678DPoNyHzBWgfw3RSYZZNtdkvZppmfqJGCJm2IFNv8hJwLXtpXSvo7n2RqqF0U3f
 LzmCWUEv8sPnlmbuAi4rNOpl9yCZyr2RVbyaouvOeDJNIy+PB4/tJ67T83zrl2jUka
 lsETGLqL0nbag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Yi Zhang <yi.zhang@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.12 30/37] nvmet: remove unsupported command noise
Date: Wed, 12 May 2021 14:00:57 -0400
Message-Id: <20210512180104.664121-30-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210512180104.664121-1-sashal@kernel.org>
References: <20210512180104.664121-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_110149_861661_1608BBE3 
X-CRM114-Status: GOOD (  10.41  )
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

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 4a20342572f66c5b20a1ee680f5ac0a13703748f ]

Nothing can stop a host from submitting invalid commands. The target
just needs to respond with an appropriate status, but that's not a
target error. Demote invalid command messages to the debug level so
these events don't spam the kernel logs.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/admin-cmd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index fe6b8aa90b53..2d68c86845ee 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -307,7 +307,7 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 	case NVME_LOG_ANA:
 		return nvmet_execute_get_log_page_ana(req);
 	}
-	pr_err("unhandled lid %d on qid %d\n",
+	pr_debug("unhandled lid %d on qid %d\n",
 	       req->cmd->get_log_page.lid, req->sq->qid);
 	req->error_loc = offsetof(struct nvme_get_log_page_command, lid);
 	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
@@ -659,7 +659,7 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 		return nvmet_execute_identify_desclist(req);
 	}
 
-	pr_err("unhandled identify cns %d on qid %d\n",
+	pr_debug("unhandled identify cns %d on qid %d\n",
 	       req->cmd->identify.cns, req->sq->qid);
 	req->error_loc = offsetof(struct nvme_identify, cns);
 	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
@@ -971,7 +971,7 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 		return 0;
 	}
 
-	pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
+	pr_debug("unhandled cmd %d on qid %d\n", cmd->common.opcode,
 	       req->sq->qid);
 	req->error_loc = offsetof(struct nvme_common_command, opcode);
 	return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
