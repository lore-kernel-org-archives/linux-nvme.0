Return-Path: <SRS0=Qo8g=CQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA98C433E2
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2020 16:34:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FC3821D82
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2020 16:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="M9tXKdQi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EC6DneCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC3821D82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JogopFCHmexhyfZ4owJy/REiarsS7DkXdXCa2VBIdZ0=; b=M9tXKdQi1l3EOPqSTg3w/Ggz2
	+v4ssOxSu33vd2Akz5kQb7OD49NGX8MLNPG3wHLcqEOBaw8C0MZXIY9u2GVoJfKg42q0MbQ1WKsFi
	faX2J1EKv+QB3tcXh0vd0zDQp2eSjbPLS9R6rJp1kD3BMjAmbREzn8Lwkdssq05/UxSUbgK9dSQ/4
	0aaNFNZwzZYZXaJIug217ek5nrMYBi/BgviTVrB2iYcNXEX2FViZIDW2TmWw9W8JS2HBKjk3wpj2h
	xT0omXxSJT/a7XCCZ6wpqeBv21NXLJUo8R7EA1xpPMT+ScPK5T6+PugtPaFxTncgsT2UxBjgBLjmT
	B+SqwuoKg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFK65-0005w1-RN; Mon, 07 Sep 2020 16:34:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFK5d-0005iJ-9a
 for linux-nvme@lists.infradead.org; Mon, 07 Sep 2020 16:34:05 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DA33A21D20;
 Mon,  7 Sep 2020 16:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599496436;
 bh=DN1QFIiCGUOZpIUU7k3WwUP4VFVGGomKaZtle0ZutOA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EC6DneCCulBbdQkpcJm+EyuL5M3z4r/8AjFZnUOVquPCQc+71Y6T9ywivth3lLMqB
 Hr3jkgO3RkwspRPpYPjdQmW1azCKOQ+dFIUGxaNKATUndRuB/RJdTdJmF5nQYWC6Df
 M57zt3IemngP2Qr23FcDmioacQ6HZYfPRY/9XPUo=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 20/43] nvmet-tcp: Fix NULL dereference when a
 connect data comes in h2cdata pdu
Date: Mon,  7 Sep 2020 12:33:06 -0400
Message-Id: <20200907163329.1280888-20-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907163329.1280888-1-sashal@kernel.org>
References: <20200907163329.1280888-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200907_123357_446401_3B36DE36 
X-CRM114-Status: GOOD (  18.50  )
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
Cc: Ziye Yang <ziye.yang@intel.com>, Sasha Levin <sashal@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Ziye Yang <ziye.yang@intel.com>

[ Upstream commit a6ce7d7b4adaebc27ee7e78e5ecc378a1cfc221d ]

When handling commands without in-capsule data, we assign the ttag
assuming we already have the queue commands array allocated (based
on the queue size information in the connect data payload). However
if the connect itself did not send the connect data in-capsule we
have yet to allocate the queue commands,and we will assign a bogus
ttag and suffer a NULL dereference when we receive the corresponding
h2cdata pdu.

Fix this by checking if we already allocated commands before
dereferencing it when handling h2cdata, if we didn't, its for sure a
connect and we should use the preallocated connect command.

Signed-off-by: Ziye Yang <ziye.yang@intel.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 22014e76d7714..e31823f19a0fa 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -150,6 +150,11 @@ static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
 static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *cmd)
 {
+	if (unlikely(!queue->nr_cmds)) {
+		/* We didn't allocate cmds yet, send 0xffff */
+		return USHRT_MAX;
+	}
+
 	return cmd - queue->cmds;
 }
 
@@ -847,7 +852,10 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 	struct nvme_tcp_data_pdu *data = &queue->pdu.data;
 	struct nvmet_tcp_cmd *cmd;
 
-	cmd = &queue->cmds[data->ttag];
+	if (likely(queue->nr_cmds))
+		cmd = &queue->cmds[data->ttag];
+	else
+		cmd = &queue->connect;
 
 	if (le32_to_cpu(data->data_offset) != cmd->rbytes_done) {
 		pr_err("ttag %u unexpected data offset %u (expected %u)\n",
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
