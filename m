Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C67C43217
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 07:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vesnEftm40bgE0Mlb2KauB4xABlzfSQSQnBa7DVdpmU=; b=gQA5yhqWCsL3DaE+QrWX9PEwmq
	cyN1X9YvD07HWXosCJFOaJlh7zOSMCMU5zUNcwsLqJbIBZampDxs6Ip9z5NhVxnSdh5RsHR9wSnOU
	f3fMA5dQjdrWwxmJppkjdwmmo9NnSmQFNWHa+vnZ6vy5QU5jyAu5w3Mj5BIzBDQl1wW3LeJqCuDYP
	1CShpJ/Paf6MLUueSAvoLjqWlWqbNrVyrqQV7a66IehEp7HWBMtsCNNvhUpvT38Po4kgRs/ku2ywx
	fwF2xaCGzJvEFmty6Mq32kUrWKiah31oqoi1NZuImT0909dsfLmErjkJeql9UGEUOJ5kWPQBk2WXg
	nzDk8bDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp43H-00F89h-0y; Mon, 22 Nov 2021 07:47:47 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp43E-00F86m-5p
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 07:47:45 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 1F9731FD4D;
 Mon, 22 Nov 2021 07:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637567261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vesnEftm40bgE0Mlb2KauB4xABlzfSQSQnBa7DVdpmU=;
 b=cP7OmTrbY/XFfrIjmG2WFW1f/8Mhx3NdVp8KX+FHLW+NTMrRRQan3K2E97IMqgqmJUNw3N
 Q0j5CJLRBd9/WkImdeyu4WfL5go9T0Duts7QKUZZfIK699r4CI9DokvaIg3fHrch7WI+6G
 /35Ndiqr0pgPYKmokIF9kPjzonzJLUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637567261;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vesnEftm40bgE0Mlb2KauB4xABlzfSQSQnBa7DVdpmU=;
 b=vmr1MTKFoifyFsrY0aqR9nZgh9tYT++0Wt3R3qd7flV/YdaYSvw/U9R7w2J68uZJuoMdDL
 0G+AIEQ8fA1sCUCg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 12E81A3B89;
 Mon, 22 Nov 2021 07:47:41 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 498EF51917E4; Mon, 22 Nov 2021 08:47:40 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herberg@gondor.apana.org.au>,
 David Miller <davem@davemloft.org>, linux-crypto@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>,
 Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH 09/12] nvmet: Parse fabrics commands on all queues
Date: Mon, 22 Nov 2021 08:47:24 +0100
Message-Id: <20211122074727.25988-10-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211122074727.25988-1-hare@suse.de>
References: <20211122074727.25988-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211121_234744_386365_5933E0BA 
X-CRM114-Status: GOOD (  11.37  )
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

Fabrics commands might be sent to all queues, not just the admin one.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/nvme/target/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5119c687de68..a3abbf50f7e0 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -943,6 +943,8 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	if (unlikely(!req->sq->ctrl))
 		/* will return an error for any non-connect command: */
 		status = nvmet_parse_connect_cmd(req);
+	else if (nvme_is_fabrics(req->cmd))
+		status = nvmet_parse_fabrics_cmd(req);
 	else if (likely(req->sq->qid != 0))
 		status = nvmet_parse_io_cmd(req);
 	else
-- 
2.29.2


