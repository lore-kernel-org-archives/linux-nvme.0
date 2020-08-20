Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7788C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 03:54:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40B92078B
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 03:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W/iG6ddY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A40B92078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oD6TKuDNYxToZ7z2zBQi7Qoi7bAHizqZ3G7qWe+OpHQ=; b=W/iG6ddYsgFJnzkeEzYE3VlRDG
	1YHosy/lENVY7739RlzXnM3x3NwzYf0SMNLhH7EIWDQbiCuVboItGdtfp/Fegw444X/c/ObCRSS6Z
	Pk1NKJZbVzjNzG8l3jRC7KlPcEzYJY1J43TU+2PJwHsd/BvpAWSTy4EKxkmv0D3KUuK8AXVbM+OuW
	OG9EvCJze+gi38iVPh20aAOzAhcHCo1sQ9rEKQtW3cWZW/N0FdyWZ/yzonc0PPQuJN3YJ24qtcMZ3
	+foS32ORPBTBWQiMpUWfObmg3+az/WxU93pisvA36XSjQ9mKwqWkDRzWzIau5BWJG9qx1XAjhnKF0
	g5ji0g3g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8beb-0005e6-Nb; Thu, 20 Aug 2020 03:54:17 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8beZ-0005dW-GE
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 03:54:16 +0000
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 284B850163286839D6B4;
 Thu, 20 Aug 2020 11:54:05 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Thu, 20 Aug 2020
 11:53:57 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH 1/3] nvme-core: improve avoiding false remove namespace
Date: Thu, 20 Aug 2020 11:53:57 +0800
Message-ID: <20200820035357.1634-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_235415_801010_F391FB1A 
X-CRM114-Status: GOOD (  12.88  )
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
Cc: axboe@fb.com, sagi@grimberg.me, linux-block@vger.kernel.org,
 lengchao@huawei.com, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvme_revalidate_disk translate return error to 0 if it is not a fatal
error, thus avoid false remove namespace. If return error less than 0,
now only ENOMEM be translated to 0, but other error except ENODEV,
such as EAGAIN or EBUSY etc, also need translate to 0.
Another reason for improving the error translation: If request timeout
when connect, __nvme_submit_sync_cmd will return
NVME_SC_HOST_ABORTED_CMD(>0). At this time, should terminate the
connect process, but falsely continue the connect process,
this may cause deadlock. Many functions which call
__nvme_submit_sync_cmd treat error code(> 0) as target not support and
continue, but NVME_SC_HOST_ABORTED_CMD and NVME_SC_HOST_PATH_ERROR both
are cancled io by host, to fix this bug, we need set the flag:
NVME_REQ_CANCELLED, thus __nvme_submit_sync_cmd will translate return
error to INTR. This is conflict with error translation of
nvme_revalidate_disk, may cause false remove namespace.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 88cff309d8e4..43ac8a1ad65d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2130,10 +2130,10 @@ static int _nvme_revalidate_disk(struct gendisk *disk)
 	 * Only fail the function if we got a fatal error back from the
 	 * device, otherwise ignore the error and just move on.
 	 */
-	if (ret == -ENOMEM || (ret > 0 && !(ret & NVME_SC_DNR)))
-		ret = 0;
-	else if (ret > 0)
+	if (ret > 0 && (ret & NVME_SC_DNR))
 		ret = blk_status_to_errno(nvme_error_status(ret));
+	else if (ret != -ENODEV)
+		ret = 0;
 	return ret;
 }
 
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
