Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D0AC433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 18:08:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9404261175
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 18:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9404261175
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ic6LaPV5bsd2VHJrx2WX1Cav/vCJWRGic3sm4wCbdJw=; b=Mik6bYGAYNmK7giodqvWrnqHD
	l4/K0jfb/+/5SYLezL3ixIy/LO+UQS5YdqYwuLGWZ41XLzrQHu7xRq/6rmuLGggrDmLh4pWOJtJkT
	EEcR5fyaWOoChC+g1+eL7n5k42t3NwLTDrEBgDncZHQTo2ra3e13IE9P4MNtWrE5kxWu3aP/cRew9
	VCq3pMe/DBUJj1CAiU9KhZRTAL3ZocKQfOme28rxTqthsV1dchsb2eRovkgOfCx6/EV733C0mmI8g
	DGdnYNW6XgO0iT9I8txUw/fxMPO9NMRpRJoRsLGEJdI9q3UfV7HZg+lKNygNtXkSHQEEaieDUVEcI
	IXDzL8/Jg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgtH6-003XsE-Qg; Wed, 12 May 2021 18:08:00 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgtDB-003WK0-2O
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 18:03:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=rMoJObk65Twf24CDJj9qpvznS9CqhBaQ425/Ur+qHwU=; b=4b2nI+gcurM+UeV8sbg3o5l1So
 ycrhZMRBWvvU1Ak4TnqDGtf8HrXUYPr6agX39I4I+gjla3udWQeRVMkD+fRzY2yXZqr5bFDJoiGgW
 tf8mgTzPZs6PWz8crkK+JDFM24/LGqeOqvKEEhEyctq2w17J48Rdr0HpbV6uNS8xnos/r6eQ+1SPy
 olFwe2FDTB3q7+gYzvYUspSvRnicBXFkiMj9eGq2/mK3BCKAu2D9cO/+DTKeggoB+oYlEMMvdiDb+
 nmfgjyuYLf0n78HF/Rwh8suZvFfG9hVIujCjFq2RvzSs4jrGs5NvKgrpjtMK637Aacbl2FZ4TOWLd
 Ld809YDw==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgtD8-00Ag3W-Iv
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 18:03:55 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 061536144F;
 Wed, 12 May 2021 18:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620842634;
 bh=ExydBHKLCM14uH+9/3S7Ho+rlBl1hT/P/8vnkRGnzjk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ca0wqmLOMxuHuFwcZMWVUQ2gIjN9B//Dpr+TLqpAXKTqLCwn/YUUk3q7zJonLwCtF
 GuIzlHT7hjOn89RqvGeM7yVzCB5cH8VlQmQhAntoI+XW+js2faH1rdeOL1JuTR0asZ
 Byf9uUVoSkUY5xDWkci75O1nQ0e1Pd22YG1qxeDbMO8J8pakgemcepfw5JH3PexeHZ
 enDCsb73goNEeGi6TP6qNDK1Zf7b7TXt4IRfY7v+gO4qH3JgwOEKJ/ZcLv+otdSAcK
 T/uxqIaeuEtQ6iZk4ncHhs17HU5ZVhc4OY2O4S0pEP4gepyKxbsUMM3zkgAOEuV1Ah
 HOxovGy2dv3Sw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Yi Zhang <yi.zhang@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 27/34] nvmet: remove unsupported command noise
Date: Wed, 12 May 2021 14:02:58 -0400
Message-Id: <20210512180306.664925-27-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210512180306.664925-1-sashal@kernel.org>
References: <20210512180306.664925-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_110354_681720_02F51EB8 
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
index e20dea5c44f7..6a8274caa3bc 100644
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
