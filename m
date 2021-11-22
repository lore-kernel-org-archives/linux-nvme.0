Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70D4C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 07:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WrgCh25NwnVfz4gld5vXX6xGM5yqU1dka6lj5KLnPE4=; b=pxQmHlsWIYQlqd3XQsurswF3B+
	LzeV2v7NJdLrq2NnPd1F7SaEYl/GWtHHNG4+wtnG9OJ5HI2wpY+ZMG7AvqSPmzC0EvhRt4W0HNfnU
	l9pHcnNuprc3ROvBCcYuz0NWp6jCC4YrJgJFhTP+/NvCCkKnu/z11W6TFT3hwHlHf9i5mz9I6AYnk
	WAfndxQWNriGzTtyNU5PycJgjpCjYfgJOlBrOpbjGk8pJX95qRD6KkAbKrSKMhfNtYVR04ZNSsXdn
	AljNKg6j8AgDVaLNypuZgJe914edcUdfOPy+oJ/27J/ksOewSrk090YEx97WwYVsCtOBABTwH8rc/
	KWUwiINg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp453-00F8lQ-LY; Mon, 22 Nov 2021 07:49:37 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp43H-00F89e-73
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 07:47:49 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 3AC6C1FD56;
 Mon, 22 Nov 2021 07:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637567261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WrgCh25NwnVfz4gld5vXX6xGM5yqU1dka6lj5KLnPE4=;
 b=BPF75jPWu7rvmd+AJ8jxUW1gBklMh/cqJzZFIYjWtvnUjS/q3YXIOA3zBu+1zA48einPkV
 yVkV9SJmRnyxQ1juomo9vkbcpZlV4hOu/8PznEdnHxsWTJBe7IxryzwYfrC6NAXMZczLdX
 fLcW53VnLOHfgsDYfiDwXfJHWlUr9vY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637567261;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WrgCh25NwnVfz4gld5vXX6xGM5yqU1dka6lj5KLnPE4=;
 b=TtibRwbmZMqDyy+5qpGWRdr4p0iLtasTJvcH9ajFKX5UlQgwcxVyevKnBFpYMbKrfqpGmP
 9JEVLbxXA6swCNBQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 13634A3B8B;
 Mon, 22 Nov 2021 07:47:41 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 376C551917DE; Mon, 22 Nov 2021 08:47:40 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herberg@gondor.apana.org.au>,
 David Miller <davem@davemloft.org>, linux-crypto@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH 06/12] nvme-fabrics: decode 'authentication required' connect
 error
Date: Mon, 22 Nov 2021 08:47:21 +0100
Message-Id: <20211122074727.25988-7-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211122074727.25988-1-hare@suse.de>
References: <20211122074727.25988-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211121_234747_525132_ACBBC7AA 
X-CRM114-Status: GOOD (  10.11  )
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
index c5a2b71c5268..a1343a0790f6 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -332,6 +332,10 @@ static void nvmf_log_connect_error(struct nvme_ctrl *ctrl,
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


