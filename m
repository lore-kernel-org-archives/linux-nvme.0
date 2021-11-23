Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 991C2C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 12:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vesnEftm40bgE0Mlb2KauB4xABlzfSQSQnBa7DVdpmU=; b=jq71/4HTbVr5CfIcALyO7u0lKM
	Yt8FiSbzYO4MBFG/yfd3Ts3RlFmORZHjGjFWGHdG2xLelYi+ERrGDNIS9qKGgR6Eky8z3GYpVSL+/
	K44VrrHFejv59yPSvijOPJDlLuKtXPIQGNSb88lmDHn/39Cc3IPxLF6pcWWGVgaIBqL7Ics5crECe
	5hCfATbWIg3hglkvcB1JbZmZ+34DftMMzwypjLGPY+hFyFv0G3htfoOP0ZC9d8Zz1nXxF+PLIYSOv
	9i9FmSnHhFRwJvRiTwvOxKHDGY9kWTiKzXkKsOtjGVCxOguHqc3lJsQkIZkhd7bBGAXb4Q16sz9IC
	CsPCyFfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpV4c-00294j-R5; Tue, 23 Nov 2021 12:38:58 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpV3w-0028s9-7D
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 12:38:19 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 3D5421FD5E;
 Tue, 23 Nov 2021 12:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637671094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vesnEftm40bgE0Mlb2KauB4xABlzfSQSQnBa7DVdpmU=;
 b=wUFJOasYmYml6wzSbye5IiUFB5nv/i1OSkkzkti44knpp1CP4wrucKXzBqGaepZ88wI7wB
 p6gNVFo5FPSEC5YEc90NhCoqkWy/XNwQX889/0MnufBEGmOeQp+V4wv1qGl8IZt8bVoj4x
 gwIzXD0BVhrf9hM4BT6PGGbGPCh8oWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637671094;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vesnEftm40bgE0Mlb2KauB4xABlzfSQSQnBa7DVdpmU=;
 b=jeuF4otAon5ARYNUros0UHKNg2pA3VwGC4jqaap+conkEowY2qD0jRIlGEs+m03J6J0Ffc
 6fO/j1rWYF23+0Bw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 2C7A2A3B8F;
 Tue, 23 Nov 2021 12:38:14 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id C2BF251918CC; Tue, 23 Nov 2021 13:38:12 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 David Miller <davem@davemloft.org>, linux-crypto@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>,
 Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH 09/12] nvmet: Parse fabrics commands on all queues
Date: Tue, 23 Nov 2021 13:37:58 +0100
Message-Id: <20211123123801.73197-10-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211123123801.73197-1-hare@suse.de>
References: <20211123123801.73197-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211123_043816_565371_58CF4C07 
X-CRM114-Status: GOOD (  11.50  )
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


