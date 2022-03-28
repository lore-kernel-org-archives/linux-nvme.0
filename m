Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171D8C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Mar 2022 13:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oq/vZ7XghI1mZ4NQj5jbB50AvR+Ej+9P8dEWe+23+pU=; b=G8fEkP5m4q7LqdkzUe2W1aSzw+
	1TedZzU6xAlNcV2RI4rmkRjqSFwTF/GOA8RKtA8Avnp6+nBDnTh5PcQ9tXn1nclk4mqXMeREjI9Kz
	VExNVnbMXD+7Kq8XoxMkoMDRBu4Zuwh9y4DMlciit00UHfF4rC9S/KrTU5XX2tj2MdJOH/MnJQ4qB
	BTHKYps/Ec3Hz7BwUeLxxvsOV3RgL1KZwTaRaj9DOIZGK+8nscht7BX8TxqVB2EkASIdJi0QMFaM5
	JxOZhWZjvqTAVLG3xaqVVxdx9wcXGQC7CXFDdTflX6Wre7dcKGFsebLOyCwDVHcoVWmlX9yTydBpE
	Qdn4pHig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nYpbP-008qf6-V1; Mon, 28 Mar 2022 13:40:12 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nYpb5-008qWm-JK
 for linux-nvme@lists.infradead.org; Mon, 28 Mar 2022 13:39:54 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id F1EA31F38A;
 Mon, 28 Mar 2022 13:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648474789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oq/vZ7XghI1mZ4NQj5jbB50AvR+Ej+9P8dEWe+23+pU=;
 b=pEYVS3u61dxI9o9XSZLX9EiiRhaQC+oOKyqkTFhde1jUhr/DnPy+rp+REMugzMX4fh7WZM
 bKsjgTE4LB/quS5iji1cj5+vURmh6n0vgjAU35tXQ80CjuAQx/SJ25ISLPP5SMBQCFWc7/
 1gv0bRcNJf4mfhnyiaYeKfuUsOWzw5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648474789;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oq/vZ7XghI1mZ4NQj5jbB50AvR+Ej+9P8dEWe+23+pU=;
 b=8TGyhcvLhA02dWsOOysZ7wJjloaG0XLO0KgRSVfWX+fX3mv5yoAzVQ7c2kscyCwxr0YJOF
 /fJ+xSrkkQZAk3AA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id EA689A3B94;
 Mon, 28 Mar 2022 13:39:49 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id E52C551939DE; Mon, 28 Mar 2022 15:39:49 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH 05/11] nvme-fabrics: decode 'authentication required' connect
 error
Date: Mon, 28 Mar 2022 15:39:32 +0200
Message-Id: <20220328133938.146146-6-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220328133938.146146-1-hare@suse.de>
References: <20220328133938.146146-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220328_063951_869323_6A7F58B5 
X-CRM114-Status: UNSURE (   8.96  )
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


