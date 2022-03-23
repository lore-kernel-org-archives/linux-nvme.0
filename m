Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E87C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 07:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oq/vZ7XghI1mZ4NQj5jbB50AvR+Ej+9P8dEWe+23+pU=; b=zvP3jkvqFj4nsSK5mE5dub4cdr
	heU4asxmPSsrlenZ31jPz0EXrBWTd+LvJ6ND2B7Q87Zyiyz4V2e9U4LLI4ULzw7zXFhyxgmWmAq/N
	3k94Rl8WH9lVLHHLfLL/RvS/SzbEN+6ObJmybZAA/30EdYnoZe18dTx9+oP2onTlJl/ZSitmjpDJS
	6SF9zfyikW/XzvggirtHZvHFPGnQZkDrSuzMlYELYlqHIBqlDINZb0dnv/nTH1EJAxpLf+KoOWy60
	o2NQtK30h76tqbFVBFctccuEb9Mvp9JzdrC4ZWGhlYIHxhVNSnkAYidCgOH6i8IJbTyM3fNTZDabJ
	U2npx/dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWvBQ-00CveS-Hl; Wed, 23 Mar 2022 07:13:28 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWvBM-00Cvaq-D6
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 07:13:26 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 4B1FC1F38C;
 Wed, 23 Mar 2022 07:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648019602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oq/vZ7XghI1mZ4NQj5jbB50AvR+Ej+9P8dEWe+23+pU=;
 b=sPmJV3zGhlRnOqetcZmu264dHUwqICumIEzt0P5tmTka7897qcOaCyDJA1XT7gsJ9eJCvd
 i4x9IlxtoCNBqv1g8YO0JR5R7vKBX0YxpXg3//pntjffXtUrQdgFXnfRetTkyhjath9PcI
 /CblCGCE4NXme1iI06AH9KapGJ2aSvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648019602;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oq/vZ7XghI1mZ4NQj5jbB50AvR+Ej+9P8dEWe+23+pU=;
 b=NBwWcFarLsLPQbmA40lyJSeu9TU/Rb2XWuFyEaJ3Q7qqIVYqR8LPdZWAu12/QX+o+T8rlO
 FTSFhHqQqe417YDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 4074BA3B95;
 Wed, 23 Mar 2022 07:13:22 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 440295193883; Wed, 23 Mar 2022 08:13:21 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH 05/11] nvme-fabrics: decode 'authentication required' connect
 error
Date: Wed, 23 Mar 2022 08:12:57 +0100
Message-Id: <20220323071303.14671-6-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220323071303.14671-1-hare@suse.de>
References: <20220323071303.14671-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_001324_629191_4FFA717C 
X-CRM114-Status: UNSURE (   9.96  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The 'connect' command might fail with NVME_SC_AUTH_REQUIRED, so we
should be decoding this error, too.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/nvme/host/fabrics.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ee79a6d639b4..953e3076aab1 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -331,6 +331,10 @@ static void nvmf_log_connect_error(struct nvme_ctrl *ctrl,
 		dev_err(ctrl->device,
 			"Connect command failed: host path error\n");
 		break;
+	case NVME_SC_AUTH_REQUIRED:
+		dev_err(ctrl->device,
+			"Connect command failed: authentication required\n");
+		break;
 	default:
 		dev_err(ctrl->device,
 			"Connect command failed, error wo/DNR bit: %d\n",
-- 
2.29.2


