Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F374DC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 19 May 2022 06:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=47CscBsbaklBb3PSBSzv1YgHqVyhBCh5MI/cx9Rj+gk=; b=REpbQA/Uk18QryJ3GfWNVydSyw
	JNb1zCEubkGpPi32sPVOfbTO6GEzhf4maDmZbIc1saXohAEBLU3MsU+z67px0hP7aSZEt8h8PTR7T
	vT7+DayalaNgy6fnUNArkuwfv6r7wED7NOEhJVoHmtYykhVfxuuzc9QMJ43zAy1seZRVNVVAW2zOB
	hAGBS/R2XhsRDM2DpcX4DXldfQZPiv1WQKoIRWEnMxlYkYqSQYXjCjDS5P8ytq+W2pjeyiM8JFZW9
	G7SfG2Tasfivbv4vhDc8Fn8sbhlvdEDxcfcn616oUvC4wxzJEgIEmsVfI5qRVc8/OZ8cLvmSteRjo
	zpWwnSMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrZcR-005HG3-Ai; Thu, 19 May 2022 06:26:43 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrZc9-005H8i-6T
 for linux-nvme@lists.infradead.org; Thu, 19 May 2022 06:26:28 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 63DBE21C08;
 Thu, 19 May 2022 06:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1652941581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=47CscBsbaklBb3PSBSzv1YgHqVyhBCh5MI/cx9Rj+gk=;
 b=Zx7P7JlgGPYSCdsv/Szz/dr+U0jC6VII0upkX/1Oecd+XqS/zw5SfVN+SGQhq96oSolL8g
 3adyKkvj6FR59LAT5bJ2bLJ42ep2eAGVh7V03gJuTTnXkV9O5pXXEQ0vluEqd++yCO1Naf
 af1a4Q7pJFNG3enhDAynaaHmSGwTXuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1652941581;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=47CscBsbaklBb3PSBSzv1YgHqVyhBCh5MI/cx9Rj+gk=;
 b=DN87Jm8EqkF0ADBZ9tH5hr8ETg+Ywkg8xwdO16IPgZH1j2ugX64/2lw6gsOe+JjKdRlCUR
 jBMAY8sKz6OeQoCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 5644B2C145;
 Thu, 19 May 2022 06:26:20 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 86882519453B; Thu, 19 May 2022 08:26:20 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Daniel Wagner <dwagner@suse.de>,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/3] nvme-tcp: send quota for nvme_tcp_send_all()
Date: Thu, 19 May 2022 08:26:17 +0200
Message-Id: <20220519062617.39715-4-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220519062617.39715-1-hare@suse.de>
References: <20220519062617.39715-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_232625_543897_47AA563D 
X-CRM114-Status: GOOD (  11.73  )
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

From: Daniel Wagner <dwagner@suse.de>

Add a send quota in nvme_tcp_send_all() to avoid stalls when sending
large amounts of requests.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 606565a4c708..87d760dfa3a9 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -308,11 +308,12 @@ static inline void nvme_tcp_advance_req(struct nvme_tcp_request *req,
 static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
 {
 	int ret;
+	unsigned long deadline = jiffies + msecs_to_jiffies(1);
 
 	/* drain the send queue as much as we can... */
 	do {
 		ret = nvme_tcp_try_send(queue);
-	} while (ret > 0);
+	} while (ret > 0 || !time_after(jiffies, deadline));
 }
 
 static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
-- 
2.29.2


