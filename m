Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52214C636CC
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Feb 2023 15:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gs5xWcIExAJNGv/EIJIeJyu0E3eylTCD+yZHlyT5Vu0=; b=fAoIyapJhNfhWC3in5UP/HUdYF
	7BLg0b0VTi9SarGjrfsHFJwm1BdxXwjzh6dZnTgbmxgVqjfXHqODFkkYuT0xGsWdSQqG1GSL9kay/
	flaHKM7MXxiwCiE2ygagD0Tzu5HdRc59V8wfAizWo1AChVBu8TS7nGXpKg7vxcUvmJw3wDaaqzPGT
	GhO6EhV3j+LRcMUgYqK7mZVDyCnswWW4q6xkGit2MEik/8WZomA/6ywyKEZEdz3QpS7ByzoTNK9IV
	iH9omZHl501MO7Ul5fkSw+gapQT2uLz6ipPxcAreCJ+6Ex0FvO89zeGnMnRSBx70MWh7eWpFKg8R0
	dzumMWdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPmCP-00G38F-3B; Wed, 08 Feb 2023 15:17:29 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pPmCM-00G36a-8K
	for linux-nvme@lists.infradead.org; Wed, 08 Feb 2023 15:17:27 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id C41FA1FE9A;
	Wed,  8 Feb 2023 15:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675869444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gs5xWcIExAJNGv/EIJIeJyu0E3eylTCD+yZHlyT5Vu0=;
	b=aJpTcn0Bh7o1TJI+P9quw8wcKRP0+Ky5AXdML0tSUQPel+PjT09qjEM/BhAcxT0u6uDW72
	ZzNvYMNPltP5HEcSz8VnGE5gOxC6ZQDFkhqPN8dMtJl2afiSAyvpEYqByI/Rz6mHXDXoby
	zaZtTI7qxbcMH5+D9vcVkYBhyTgr3IM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675869444;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gs5xWcIExAJNGv/EIJIeJyu0E3eylTCD+yZHlyT5Vu0=;
	b=Y3siT3XJJaop7Li6I+ciKHn/2CK5KmGDHp8EgAf6ejGI+7tXzGmcCPGTxQGsuxTvXgXozZ
	hA/tJ71nm0ZccJDg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id B249C2C141;
	Wed,  8 Feb 2023 15:17:24 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id A50DA51BD09B; Wed,  8 Feb 2023 16:17:24 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/3] nvme: retry authentication commands if DNR status bit is not set
Date: Wed,  8 Feb 2023 16:17:19 +0100
Message-Id: <20230208151720.109130-3-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230208151720.109130-1-hare@suse.de>
References: <20230208151720.109130-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230208_071726_499924_64C8E141 
X-CRM114-Status: GOOD (  11.47  )
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

Clear the FAILFAST_DRIVER bit for authentication commands
allowing them to be retried in nvme_decide_disposition() if the DNR
bit is not set in the command result.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/auth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index dcea6873ca2c..8a1edbf69b47 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -81,6 +81,8 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
+	/* Clear failfast flag to allow for retries */
+	req->cmd_flags &= ~REQ_FAILFAST_DRIVER;
 	ret = __nvme_submit_sync_cmd(req, NULL, data, data_len, 0);
 	if (ret > 0)
 		dev_warn(ctrl->device,
-- 
2.35.3


