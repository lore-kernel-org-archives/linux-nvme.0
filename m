Return-Path: <SRS0=DfP6=K5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B044C47097
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 17:13:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDDAC613DC
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 17:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDDAC613DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=m2ttj1q0I4Ivv/BXk+HDX2YmmI6vBzHaw3fVniEhvWc=; b=e98Po51X/zgBVJ
	tMvvXuSWYco0yXNdRAEbAvIxyEot5K9ORT1xFFejBg9T9z8YxD5oxxmn2ZkHGNr9misWeKgmZzys3
	UatxNoSsHBltZuY7RjGxeOx4yFAK7BJxo7d8k7Ypb+7eegOhTuUTkI4cl/wrKPoBW3RtqikXOrdhB
	U7PODOrqTo1Iaz4Hovbe8z/W/OjGo/tJSvnBQZq2EmYY8e5Og9fcLvVUlVnH7mBMwR/CBesu68nd2
	Bg0K73GB0Yrp7qARr8uGa/Ld9PCUSVzFruHv0sMn4qY/NgZSqv2kViDO1Ye5oZB067rz3NLUpmCdG
	uAGjolXUkFInbvCEdhFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1loquM-009mjV-K3; Thu, 03 Jun 2021 17:13:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loqqt-009kmy-1e
 for linux-nvme@lists.infradead.org; Thu, 03 Jun 2021 17:09:52 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id B245F61413;
 Thu,  3 Jun 2021 17:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622740190;
 bh=Qsd7/ZcxgyX7sGOwkV0r3LGLN/TenipAy3EBGId8fNA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WFpMbGhofmNvvNJVJnwKsyPfYOOYDwYcPjYJ5AdKcosTNiE9uDp7mYMefv/DrpDuN
 Ef2MwiBKHOAX/cON1zNNFlTjCCaXgeWRK804hk4BRR13rtCGafZon7epR7QHBXzZ9r
 uKNm57OLzPZtWLhMximLBAXLDlrYzn3sX1vRkBHBtTb2YWwen5tj8Tr+wY9AzPHq8l
 QgGq4UeVjGS0LQS3KpwLzqhXVOlZw3ZhGUYoUaWz8ffa4K4NyQfvwS7xXs9FJ3NLDJ
 rUaKwfUVyx/CHCrwrqtXS63wB7xLeUSn9zBsdctCxgi6MgmvuMEgcczIJUPXbbWg1T
 2jIntbva0SIaA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 25/31] nvme-fabrics: decode host pathing error for
 connect
Date: Thu,  3 Jun 2021 13:09:13 -0400
Message-Id: <20210603170919.3169112-25-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210603170919.3169112-1-sashal@kernel.org>
References: <20210603170919.3169112-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210603_100951_137468_6A5996D3 
X-CRM114-Status: UNSURE (   8.85  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit 4d9442bf263ac45d495bb7ecf75009e59c0622b2 ]

Add an additional decoding for 'host pathing error' during connect.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fabrics.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 3bb71f177dfd..d884187d7706 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -336,6 +336,11 @@ static void nvmf_log_connect_error(struct nvme_ctrl *ctrl,
 			cmd->connect.recfmt);
 		break;
 
+	case NVME_SC_HOST_PATH_ERROR:
+		dev_err(ctrl->device,
+			"Connect command failed: host path error\n");
+		break;
+
 	default:
 		dev_err(ctrl->device,
 			"Connect command failed, error wo/DNR bit: %d\n",
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
