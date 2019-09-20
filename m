Return-Path: <SRS0=jFtc=XP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1742C3A5A2
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 18:18:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1E9C20717
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 18:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bNccv2fq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1E9C20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=gD9Z3oE0A2DBJyv+cvqcULRFnvNZfbOVjJO2ZaH0bmg=; b=bNccv2fqsnP5Qz+FCkxKrExbe+
	Mk0Zr3yVv/bHIilKSwVCGUD16dzZ4JsCA7BjJrVDoHP23eLZfNsYUKm5B2hHVaTmv6uFNyQl1CBay
	IZItaK56van67jD0QS3E26LVlR/NOh2SGDkJPVTb9MnuEQYbNHjl4ckvcfC4yvVPdkGVS0YWpGx2r
	mQ0utggf7IkZ5nsO3RBLHLJpq6KuiYED5Zjk8Gfefir2j5s4a9hQ5NbvwZuV1WaPldPgAagUwQBml
	NOTKly+aR26OZ//x01YVSE9oMjDRrLzYVe2rd9C5A6pndYFR/bOoLE+0SerNLZZC8P8u0CVx7wp1t
	gNm/TnMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iBNU9-00072l-FQ; Fri, 20 Sep 2019 18:18:25 +0000
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d]
 (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iBNU4-0006yL-Nz; Fri, 20 Sep 2019 18:18:20 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvmet-tcp: remove superflous check on request sgl
Date: Fri, 20 Sep 2019 11:18:18 -0700
Message-Id: <20190920181818.14424-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190920181818.14424-1-sagi@grimberg.me>
References: <20190920181818.14424-1-sagi@grimberg.me>
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
Cc: Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Now that sgl_free is null safe, drop the superflous check.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/tcp.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index bf4f03474e89..d535080b781f 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -348,8 +348,7 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
 
 	return 0;
 err:
-	if (cmd->req.sg_cnt)
-		sgl_free(cmd->req.sg);
+	sgl_free(cmd->req.sg);
 	return NVME_SC_INTERNAL;
 }
 
@@ -554,8 +553,7 @@ static int nvmet_try_send_data(struct nvmet_tcp_cmd *cmd)
 
 	if (queue->nvme_sq.sqhd_disabled) {
 		kfree(cmd->iov);
-		if (cmd->req.sg_cnt)
-			sgl_free(cmd->req.sg);
+		sgl_free(cmd->req.sg);
 	}
 
 	return 1;
@@ -586,8 +584,7 @@ static int nvmet_try_send_response(struct nvmet_tcp_cmd *cmd,
 		return -EAGAIN;
 
 	kfree(cmd->iov);
-	if (cmd->req.sg_cnt)
-		sgl_free(cmd->req.sg);
+	sgl_free(cmd->req.sg);
 	cmd->queue->snd_cmd = NULL;
 	nvmet_tcp_put_cmd(cmd);
 	return 1;
@@ -1310,8 +1307,7 @@ static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd)
 	nvmet_req_uninit(&cmd->req);
 	nvmet_tcp_unmap_pdu_iovec(cmd);
 	kfree(cmd->iov);
-	if (cmd->req.sg_cnt)
-		sgl_free(cmd->req.sg);
+	sgl_free(cmd->req.sg);
 }
 
 static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
