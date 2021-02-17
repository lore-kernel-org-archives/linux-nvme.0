Return-Path: <SRS0=TApw=HT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C4CC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 00:11:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D30FB64DFF
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Feb 2021 00:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30FB64DFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DQsxzOBdkf5NUlkiD8x0z2kx1tC4eFhf1mAkkMm1BnA=; b=pFbypor7TI3jhENbR4LYR/4XP
	SCJZsX4TD5ZI+QdApet23w8Aq2KXDpN+MrCuK1ApXKmHJWS4gcqLQcdB/AolkKgjdl7hG+3YkU074
	GJ6Q2kTslDyOFJa2+mE/NL8w5ozJAjbf7M7unRbSE0OlErVIAE9xnBgWfjsy0cEDyMACHu4QmDj5C
	mYNXw08tQwksryq12spJ8wFxIhuyRcrayUcfqei2P9qhnYdCeyhjW7P8pF8LZQ7Eey/6Uu8ke9wEj
	u84iEyaMGYX8Wn/VIBf6Oif0qX/wYsXWvOVhqtt1wnKC5Yrjyzpgmyxxe+ps+lN4ZwfstlKwRj1L2
	1c5ay36jQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCAQm-0007YA-TO; Wed, 17 Feb 2021 00:11:00 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCAQj-0007XK-UD
 for linux-nvme@lists.infradead.org; Wed, 17 Feb 2021 00:10:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613520657; x=1645056657;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xqubQ2gMO7xkYOgrjEaD6Sx/snEdKEL92xnTE22lGY0=;
 b=kBZ6hejrbEDp66v4w0ymayzsT/XWvIPHl9cCr8IaeYAj/GgEfV1MTf85
 FZ9rZnRIBNU0qHXZwrkfq8vImgU9TIIO40j4xOTq88vkdD1xEjo0+oCzq
 73r93llV47XSh9QVXkp9oXfg33YUEe84xpH29sKD2kBeVDTPXI7oUROVi
 5u2KWZ7sbQzXCcujSlG9x0JljFz4ZM8DndpBIWfCPvkNZoOPFkJDQgDrh
 1VjIvbKxjYW/uObL9cw6Eb0UO+AvHrbxNayWwhZ+1FG6sRiY6W/DwdjTH
 PmDBghq9bR0tE97ash495Lxp0sjQEZf9nrJK71Pbxy5N6g2d8qc3wCPH+ g==;
IronPort-SDR: XAklV6VoA3pXJgFo4wNByXuyXalfMzJilkfGWs2Qpk9YqPbfV4wgC8HwC3g3HZsT6wgW8ZTEJ2
 RDvPnK/85Ubq7BQdJMH/Sgx0yY/6g8HOZnDuAq2jm33319pD2P7hQmsCRaYsRs9rGox/J9cH5T
 zXS55fMrJOu3vlS6NT6vfuTmIbCFf6OD/tPODlVhCrAAX42MDnF5nAYLnBRDQfqVWlWCE3zPmH
 dGE16ZGapSPvaiSsG/OCzCqPST++lE5YVbLGaSUmEXOVR17cbFa530QLZOX8R7qZ8W0UEc+MrK
 ILM=
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; d="scan'208";a="160123465"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2021 08:10:57 +0800
IronPort-SDR: KJUKB4nNYZmw7FpR1VUFdnQloMylC4X/y5CdDZmbTvpFo/jrhTStYxyUpxM9S3fm3XNaZX0Wcx
 NKLEgFzU+xGvIN8wOFMdyj1tw7awI2G0A06r9okE1k6uZnM2cX+Hd90T0dG9H1xxy6orJI3RVr
 XadX0hv7rK9jOgli9BWPbtcq5sVfroJxorQrzOoIEaQyOa0vs9tnVsxL3q7HRZrC0ORqAvNCJV
 LZue3jaSiG9zV+RaZTmicvWq0Z39fgOkjBLGnNAy58qYFFMvQSnFysbj3wtIIlX3sKK01e/E+I
 TE44DqyUQphDJQ4pDmP6h+CB
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2021 15:52:41 -0800
IronPort-SDR: JA2qsTYQlRZtCURKTWlKC+skGkEYUGMCpI6tNJiQRfwpvLDlCkJHNP8yStaVz2KvXTHf0O702A
 kOd+BjRoVra+AXJ8IU/eGAh9o6nutTij4VkbknmlCkmvp9Gzz8TM8MNFTTAMv0q1FRT5iF4Gr+
 MTfGES3l20EDUjpy3FBqFOkzQbWtxS395lXw8NSd46FXiD4Qa45YSwGUsaIIxuW3OcIeWomJBz
 LvoXq0MKBwjl5HRhmF8Yg9v7A+TGetxxVDFFgAoCGuFWqjI7/on1vzcdaIevOAlFAF+rwlpYl7
 i/o=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2021 16:10:58 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 03/14] nvme-core: use right type for ARRAY_SIZE check
Date: Tue, 16 Feb 2021 16:10:21 -0800
Message-Id: <20210217001032.25741-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
References: <20210217001032.25741-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210216_191058_149750_D08F47D4 
X-CRM114-Status: GOOD (  12.90  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Use unsigend int value when comparing the values of the expression
that involves sizeof() in the macro ARRAY_SIZE() that returns
size_t.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2f6b89f6309d..cae526757e03 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3096,7 +3096,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		ctrl->cntlid = le16_to_cpu(id->cntlid);
 
 	if (!ctrl->identified) {
-		int i;
+		unsigned int i;
 
 		ret = nvme_init_subsystem(ctrl, id);
 		if (ret)
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
