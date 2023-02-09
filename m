Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7B6C05027
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Feb 2023 14:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jv8luRaqGnkY6oF1RPo4VAIIxQvZxUy6Au0F1IyLBBo=; b=MMwyZYYTYZUNz6CpvAx/LXGeOF
	gwb7LU043HGxL7F6puXw4flKjaWSRd3w9IEkEaQlNhn948TWzGA1uAYfAOrlKp+xyVYb3cRg0SC9s
	V/hdZzsTiipEbHoyLIXxN4QCwDCYE2MiIXuWL3EyUa+2BYtAuM4RbN/xOhK5Gc2BTs18E0+BaRGYc
	kWTMW7hqJTVngmoc4a+6qz5vKNBRQZ1RD5NMQTypixM9Np8LSvNQsdbiGTrqks3Q2rLWnLgShy0CC
	BZU84/aS5TFH1T1GZzmx5O8EuY7EUnNkpMfJ0peMSN7XzB+njucE1XbEchWgxkVX6VZt/SCz/XKmJ
	hJ7LbYzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ84H-0020i4-T6; Thu, 09 Feb 2023 14:38:33 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ84F-0020ez-9T
	for linux-nvme@lists.infradead.org; Thu, 09 Feb 2023 14:38:32 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id D4639375D2;
	Thu,  9 Feb 2023 14:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675953509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jv8luRaqGnkY6oF1RPo4VAIIxQvZxUy6Au0F1IyLBBo=;
	b=YYMpsqJrY2ZOuFmfoyIJzfvJdk9p3vXYX961PX4t3lYjWlwaoJNouXmZzriJVmO10mB37X
	DCPwdJu4Whwh17dg4Qx/nHP/KpjBCBn01S3P9PXImAGi/zaHfKiATBxxTVW9ARMKssu2a0
	Ho1mapSxzjC+Li6LKtqmYiNVN31mMRc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675953509;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jv8luRaqGnkY6oF1RPo4VAIIxQvZxUy6Au0F1IyLBBo=;
	b=WvsPo5J3On6mIQoOLtTQmpXGb5zfHNO1uH9FqRk5DpeU8SqrmW2GNpAKU54B3NvO/r+N7C
	L4bhJhpnNeFrebAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id C623A2C149;
	Thu,  9 Feb 2023 14:38:29 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id A833551BD140; Thu,  9 Feb 2023 15:38:29 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 5/5] nvme: retry authentication commands if DNR status bit is not set
Date: Thu,  9 Feb 2023 15:38:20 +0100
Message-Id: <20230209143820.118097-6-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230209143820.118097-1-hare@suse.de>
References: <20230209143820.118097-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230209_063831_502508_6BF4D8F4 
X-CRM114-Status: GOOD (  11.55  )
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
index ef5dcd885b0c..935f340607a7 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -87,6 +87,8 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
 			"qid %d auth_submit failed to map, error %d\n",
 			qid, ret);
 	} else {
+		/* Clear failfast flag to allow for retries */
+		req->cmd_flags &= ~REQ_FAILFAST_DRIVER;
 		ret = nvme_execute_rq(req, NULL, false);
 		if (ret > 0)
 			dev_warn(ctrl->device,
-- 
2.35.3


