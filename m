Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6560C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 18:04:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28F1861480
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 18:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F1861480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MagdaVdNrfPZ6Ia9i4qVBd7J5w7dekmMY6lHkmf+ttY=; b=eMywQn+9rMIQ1rA0qrcuf+tzf
	8MV2X+FWzftNXwI08f0ZAWDjT8I61yFini7N9q8CrnJM4iMW+FUDRqeJjydkGdn8o/j3NUi5/OBZG
	6aMpnBxcFo/ZmFCSvVMNYyJzx/AU4nEAK5Mf0OKTrtDkeHnnEtjuC8a8VB9jUeF88zgK6Uqo2jEHl
	Olb9aY7j1eaPb3IUSA+PE+yk8+5Fb0/ZsdZL07aAe7eT1407D2eQ9VRElx3ttB1odoh8g00W/Jyvb
	GHN8dgpIm8k0+0SruCWlBuljBibVvU/ESIoXUOyHyj/9fDTyln/Lfo9bQU50X6be3UqQq48S2ByhC
	LAZ1jgU4w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgtDL-003WPz-1H; Wed, 12 May 2021 18:04:07 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgtCC-003VrR-G9
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 18:02:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=Y30T8nPqcQOFGWwhgf6XzpUvI0WHZie1Yhj96+MhGsE=; b=De0Yv7380a5lwgFkNA/vBlgA8r
 ZfVXeMWmrkg66LMTpPHB95SbiPRTkxVk9r+oK6gTqE0DteVnHQYvl+h0Vwh4kc0YNsmF2Ntei3N1p
 bhdVjBIy7PxkIlfvOo/W5bv6N19G6LPLesmdgENoWFdd8Yr05ZcV0J7whcIMa9rSOCHmKfiJIKNMV
 c/RTeeVBLbLenoRA0k3A/7Rib5w2V07D+r5UIFLHwerVT7AQrxuEyhFna+i9UQjwNZf18LZ+RDui+
 wkzG/1X0qKC7GBZUoSyOGsp/nB3wVMEQzhoFAGja8NbqIG976jZxtCte6dKIEvocLIS6Tjx3og6TB
 Ibhs9Cpw==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgtC9-00AftP-UO
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 18:02:55 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65AEB6143C;
 Wed, 12 May 2021 18:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620842573;
 bh=+IXOILcU2zmIP0zOiWzIOBTLsnPkTNvAChfh7lmrFIk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=orc2ygmXH2cW33ldosbc460xMQZIvfSMztlCVDIhjpQWC23OGC+7Tg+3BjLM/pzLs
 GkrA/qvv7aZ2oiy79IP3ZywtPfLWCnnWJUm0qidlaNoqVt1fVTJkMeUNfweCUiL6eg
 kEkX55ok1c1cNM714uZKdxCoBeU0iuaiP9I0p9DZNvOQEXjFkPq4riy6QbWyjI+aRe
 4QaTlNyfk/7rBUrySwlvIGAzLzrpu75qFJvR9I3yqBdzRW2gOKE0QN7PUSxfS2Y3/r
 e8EvW6KqMV0rzxI8sQQs99pymvdwUipFEhvXSCncFgqFjnwY8jmxPaOaX/Z6PU25aY
 oixoM9QrMnHpQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Yi Zhang <yi.zhang@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.11 28/35] nvmet: remove unsupported command noise
Date: Wed, 12 May 2021 14:01:58 -0400
Message-Id: <20210512180206.664536-28-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210512180206.664536-1-sashal@kernel.org>
References: <20210512180206.664536-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_110254_039677_9CE5F07E 
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
index 1827d8d8f3b0..2c547d195d55 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -313,7 +313,7 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 	case NVME_LOG_ANA:
 		return nvmet_execute_get_log_page_ana(req);
 	}
-	pr_err("unhandled lid %d on qid %d\n",
+	pr_debug("unhandled lid %d on qid %d\n",
 	       req->cmd->get_log_page.lid, req->sq->qid);
 	req->error_loc = offsetof(struct nvme_get_log_page_command, lid);
 	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
@@ -657,7 +657,7 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 		return nvmet_execute_identify_desclist(req);
 	}
 
-	pr_err("unhandled identify cns %d on qid %d\n",
+	pr_debug("unhandled identify cns %d on qid %d\n",
 	       req->cmd->identify.cns, req->sq->qid);
 	req->error_loc = offsetof(struct nvme_identify, cns);
 	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
@@ -972,7 +972,7 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
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
