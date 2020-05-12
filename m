Return-Path: <SRS0=WsD/=62=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD14ECA90AF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2020 16:19:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D895206B7
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2020 16:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DLeRtpwH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D895206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=T+XrP/yau0JR2L69rcHeqT6obs7699/ZQmtMrqNkNyo=; b=DLeRtpwHypOBzI
	D2ad9WWHqn2Q7m/xq3JgLaAMhzZWN6a8rkxHiv8lZz75lJfR+0ZaiIq2WVKwI7BDrbHZJpzea6AzV
	ZGkft0YAOO2gut37cjLVC3N7PAtAPc2ynLbVYuInPbwUnM4lWNbg1S3uQT+G2l05HkSkFN28jaAX6
	d5f96+xp5k98JbqXuqOb1JgRINhaxe9EwDaVZwFhEMdX0USb7z6vc4tIaD0FvCGt2ifwB8jDdTCyu
	O5Wv709aYhoaEJAlHadLKfpg9SkKPdNZ4I7u0wkMceLohrX5xxW08J/rayz11XBtkqd9ZtKK/rQHg
	kVg4HK/A727gWhTLv4qQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jYXcx-0002tq-MQ; Tue, 12 May 2020 16:19:31 +0000
Received: from [2001:4bb8:180:9d3f:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYXcv-0002ta-Ff
 for linux-nvme@lists.infradead.org; Tue, 12 May 2020 16:19:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: mark nvmet_ana_state static
Date: Tue, 12 May 2020 18:19:26 +0200
Message-Id: <20200512161926.1822603-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/configfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 19bd5e1c681ce..24eb4cf53b4f5 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1146,7 +1146,7 @@ static const struct config_item_type nvmet_referrals_type = {
 	.ct_group_ops	= &nvmet_referral_group_ops,
 };
 
-struct nvmet_type_name_map nvmet_ana_state[] = {
+static struct nvmet_type_name_map nvmet_ana_state[] = {
 	{ NVME_ANA_OPTIMIZED,		"optimized" },
 	{ NVME_ANA_NONOPTIMIZED,	"non-optimized" },
 	{ NVME_ANA_INACCESSIBLE,	"inaccessible" },
-- 
2.26.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
