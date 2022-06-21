Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA69C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 17:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=URjVvC7P5TBPmqCj/Mhbq08/2Z2rUvpmsSxVHyG4mJk=; b=i7xYsYW4k7nFoUfvDfQUN7B5AF
	Lz/xd3z1mjXjJI74ppqPncMBmM75brsR5TegE0oBTwxBsbgJ80IfaEg9/l4/F6cWl+8K1KLuujrGZ
	vdb9qoaax/2fVJUzAMqpJfbQemkurBYNzytTTf+6c13ckTFi1PYd53UO/uhe7uVwAmqAcnBUJzSsz
	G3FyKfW+JnzDNZHNuPFc6VeJrofzqDmjZngLbKSJLsEmr7XE68k39/p1/7PbH13+LWRZrQvfW+IDU
	0NQgz7LY7EvX5/dorT85D6ksWD/nLnFdQ65474C/mfwkLcaCtfJM+EuZTzbFWDuOEH5GkF73rmuHI
	7iX58jTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3hcM-006XGh-TG; Tue, 21 Jun 2022 17:24:46 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3hcB-006XBu-4S
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 17:24:37 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 41E1B1F8B3;
	Tue, 21 Jun 2022 17:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1655832271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=URjVvC7P5TBPmqCj/Mhbq08/2Z2rUvpmsSxVHyG4mJk=;
	b=gat1uVhv+gTJ0EehU30xy88h6I2YVA8qexzNBg8Q2GL4Cg7zs/yfLcQVN2phkPNjnN0If/
	VpCUrX+DRX/KUyJCcAUsUZ5iEztJfXLC5gQL7KZLKeCYfwUFZ1RQduIKXUcTcyVSvikbus
	mAFXNmb9CJR7aqVQe+4074TKuGai/Oo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1655832271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=URjVvC7P5TBPmqCj/Mhbq08/2Z2rUvpmsSxVHyG4mJk=;
	b=83BIQeG+1nljzoS7uEjUo4/z9ekQfBc2LZiyH91pWuqjLc5XunU58YKIOWlbZuv8NhGatx
	lDzFTTX5epXDhFCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 2FF782C149;
	Tue, 21 Jun 2022 17:24:31 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 684075194C80; Tue, 21 Jun 2022 19:24:30 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH 05/11] nvme-fabrics: decode 'authentication required' connect error
Date: Tue, 21 Jun 2022 19:24:08 +0200
Message-Id: <20220621172414.82847-6-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220621172414.82847-1-hare@suse.de>
References: <20220621172414.82847-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_102435_374645_1B0394BA 
X-CRM114-Status: UNSURE (   8.92  )
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
index 0a0512300f1b..e4b1520862d8 100644
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


