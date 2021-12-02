Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD4CC433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Dec 2021 15:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WrgCh25NwnVfz4gld5vXX6xGM5yqU1dka6lj5KLnPE4=; b=ELdhrUymSOiCSAfSxNvVp1bUzO
	9fgz2/f0BGQuRpYn4Gu1+pTSb/lHG0EmQX/I8Ug9rcMSi+tlGdwTEQ8J7+V3xFb7cw72D1DMl9/Fh
	kvcbf+8iNzTCv/3xellHi65QkXyiJWVKpj9Z4TABEnS63ixbVPmziZwqmffn1MvqwLLblAa9v7TyP
	/2SBXoSI3GVlFWRu87LY8+5onykwx/2Nm0I997CaWBJCUQ0FMNE0hFqgtusij9LVPePKBghEf7y0l
	8UUowYuR3J5PqAZc9vhmzqPCcwv87KY0bdemK7gS3FQk49m97gFRwoxvNSX26jfJ0rM5e6wC4h+bX
	Ji/JUdgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1msnzA-00CkFV-NY; Thu, 02 Dec 2021 15:27:00 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1msnwU-00CjS3-Ve
 for linux-nvme@lists.infradead.org; Thu, 02 Dec 2021 15:24:18 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id ACD261FE05;
 Thu,  2 Dec 2021 15:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1638458648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WrgCh25NwnVfz4gld5vXX6xGM5yqU1dka6lj5KLnPE4=;
 b=WSBaC6fcenKftbVqzpYR1kLRTBABJw+g3S8sO9nNsOOx7WB8B87Rbrh0gBMCXEetENCh0A
 q70SZ6yVt4OG0L9o1prl9oZr6eMzVJZC1rquGNtdCkE0qcP1H/xIgfBg55U6V3ANEAH1oi
 E3D50B4MYjFB1KWeEUGwYxojslCaiGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1638458648;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WrgCh25NwnVfz4gld5vXX6xGM5yqU1dka6lj5KLnPE4=;
 b=x0qG8tGZZPbVT0uPoiziITRamUCsgttPVQ0tvz2SpDoVEqUvP+pDKWteJm1LfifdsNW+9z
 1Ao+7auP7caiO0BQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 9B604A3B93;
 Thu,  2 Dec 2021 15:24:08 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 3ADE45191DF4; Thu,  2 Dec 2021 16:24:07 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, linux-crypto@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH 06/12] nvme-fabrics: decode 'authentication required' connect
 error
Date: Thu,  2 Dec 2021 16:23:52 +0100
Message-Id: <20211202152358.60116-7-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211202152358.60116-1-hare@suse.de>
References: <20211202152358.60116-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211202_072415_226073_D3430764 
X-CRM114-Status: UNSURE (   9.75  )
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


