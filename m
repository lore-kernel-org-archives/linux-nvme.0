Return-Path: <SRS0=qX5s=J2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08EFC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 04:26:28 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9967C600CC
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Apr 2021 04:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9967C600CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SnRHVXsVQX3x0jBHjR3+gBcc1FJARuWXLyo8AAsRo2M=; b=jtPptn3fDa6DDVm8fm4dBeMQFO
	3Er3grfHursFXMAOUi9e5FPX//3rlSpQYOVa11u633Pk5j+fUHDQhCR+AJmUxI11sr1kwHqXmNdhR
	7NI4u6biB0bWTUAoIleTV64vHdNl2dbxx5T148D+04B3R4X7h8OmHbbYFYj//ZA98TxeCsKUfmIFF
	L+PujvLHPQvT4/3q+YzTmyOBRGNugj8DKDxWMolvGrUWul4ugcvqAY1xYMr4FZvfut9acw43AVz3K
	s04trUaalVKwBAVNswpIms1r9qWm+spHQ4qCi6gnvjg1r28X/SMenPHo2vzNGrDXfkqMq8ppbbmNw
	ot5vwQSg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbyFg-004s8F-12; Thu, 29 Apr 2021 04:26:12 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbyFX-004s7L-Ct
 for linux-nvme@desiato.infradead.org; Thu, 29 Apr 2021 04:26:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=ChVibypqZBt47Uxn8eMossA4dkj6NEsJVH+MRT3yFUc=; b=XphZN03WGd1Q2ptSroWz0egTGZ
 0s2w/f6gKN7dLoYlCCTa1ZFLFormhR5mU51smLBYwQZzUSYCyJjFz269BapacYQFqqSHHBpz+dTFY
 EvzmIzNDpilJdFtBcRbo2VnpGwuHabFxf9FclrBag/FakqXQW6YZsm5DQf8ozXE2UPOzHMAjNit55
 ZXTLJ9LlNU2jC+/qjNQulO5AseV57SCOa8N9Whh+Ssi4xb7AGxjPNEDJPfj/imNamwT8n/4yho0QN
 ZrvoB2iRy99Rk5ji+qoZA5MgvEwFDjQH1zoaY2Si4nX7/bsyPLrGkyxdTrFUQWHdSxCwUQhja0/Zu
 cKXgiZ/w==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbyFU-000MYd-Qs
 for linux-nvme@lists.infradead.org; Thu, 29 Apr 2021 04:26:02 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCF7C600CC;
 Thu, 29 Apr 2021 04:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619670360;
 bh=qx625/f81fpCULCUedox0Pk62LSp2vfoYDGJNacE/is=;
 h=From:To:Cc:Subject:Date:From;
 b=RnU2gynIw6jywcABVU/L5KnVoLlyVwIIhw3g3jb1f4WsGtetZQ4xFzQCb2Pnig+xH
 qyKgkTAGTOT2tzu/FrHgxQNqem4gSJ8M2M6kzJp7hjLxwOKMQihPDVAvUeMQDqj6lh
 /a6EKanSkO8UP3jr0FDSKNWfgOVK4/DZ65xxMN/CETnox3BSrWPzt9/8y8Kfko2NBP
 lXpNY5WaxaUkFAhwn6bgVGfEwur5IjXYMihWPbvQNSnQ3UR3LUDg4OfVFA/P7kPdJK
 Lq6inPnFDqUhVHaCIiLEVZS70t/xQPf2/VQ+EraeoxQuq1ziU6xKUESJl4Bt+8HzHc
 YGqx+3Dsy0zlg==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 chaitanya.kulkarni@wdc.com
Cc: Keith Busch <kbusch@kernel.org>,
	Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH] nvmet: remove unsupported command noise
Date: Wed, 28 Apr 2021 21:25:58 -0700
Message-Id: <20210429042558.905404-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210428_212600_913572_1E47418B 
X-CRM114-Status: UNSURE (   9.27  )
X-CRM114-Notice: Please train this message.
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

Nothing can stop a host from submitting invalid commands. The target
just needs to respond with an appropriate status, but that's not a
target error. Demote invalid command messages to the debug level so
these events don't spam the kernel logs.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/admin-cmd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index d2a26ff3f7b3..8175b61ae0a3 100644
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
@@ -977,7 +977,7 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 		return 0;
 	}
 
-	pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
+	pr_debug("unhandled cmd %d on qid %d\n", cmd->common.opcode,
 	       req->sq->qid);
 	req->error_loc = offsetof(struct nvme_common_command, opcode);
 	return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
