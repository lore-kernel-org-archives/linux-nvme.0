Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6602C433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 04:36:11 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AE076139A
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 04:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE076139A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ARl6t+2H7GvQLSAOr6YR2xRtdNeLk6e5mv7hOz+xv4A=; b=WCXqonHPOhuyT7eJ86xb6Boyw
	6bcTojRfY1iU+yY5d6/1mIoYp5wUlMAZzGHxvz9TFNWx00lAtd7LSvrkQGlnrSL7+gX+9fC9piKgW
	6CbHTgNsPCnW+dxk4yJ3G2gNSwkrJcVXMioA4aptNNhWZaZvc45fh6sJdhSeznJrOGZJrcFtCyUwu
	B9PFqFeY2i9EX7q2guXvB0xbNncOU8Y269vsTBgl0fNMFsn70yfRjIMdFfmnV3F+vKwNIPbSeKgHH
	HXbPO4+5UPO+qGItmblbvUeie6WKQvO4NrGLQqOC8X28Xy/Jnf963ljweNZwNNGEeW9eq7jnrpcMX
	njsRA+dEg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljDvt-002kZC-Ek; Wed, 19 May 2021 04:35:45 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljDvY-002kXT-CO
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 04:35:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=xilD0w6nqadGMUKyDKwGtRXRYNtwndQAyAgBdMh4yPU=; b=dKMVekIG8yQP8Yqa9Ji8pimBLc
 1qA8Rq9UL5ENxS0ZmtWf5CTGPASx8+JPcizhA8vzJgIExoalkZddMfQ3y2rQbO7cG5v4eDaM3EVT1
 MNxiqri36ZJo3vEUxVkdOKwP+sgdZlpI3I1HzSw5/7L9qOuXRigH9uPbMGik87Y9mk21UGm4Bfr4y
 7zHL8Sgvqmn87LSYYRtLf72nzJjYEypme4LJlIuVJuDUNCbD33YZcZf6q+F5ZW8IsUlFsdrhceFsf
 VOaALgNn7DqIr8hskvLw4jbaTVo59WvlHVB+NDrUWYs1MvKqsEnXr4MdAzLWv/TXQ9/VWqwtHgJ+I
 PDSXSNWQ==;
Received: from szxga07-in.huawei.com ([45.249.212.35])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljDvV-00F7ag-Pk
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 04:35:23 +0000
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.59])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FlKjF6t2zzCt01;
 Wed, 19 May 2021 12:32:33 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 12:35:20 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 19 May
 2021 12:35:19 +0800
From: Wu Bo <wubo40@huawei.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <chaitanya.kulkarni@wdc.com>,
 <kbusch@kernel.org>, <amit.engel@dell.com>, <linux-nvme@lists.infradead.org>, 
 <linux-kernel@vger.kernel.org>
CC: <linfeilong@huawei.com>, <wubo40@huawei.com>
Subject: [PATCH 2/2] nvme-loop: Fix memory leak in nvme_loop_create_ctrl()
Date: Wed, 19 May 2021 13:01:10 +0800
Message-ID: <1621400470-593256-3-git-send-email-wubo40@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1621400470-593256-1-git-send-email-wubo40@huawei.com>
References: <1621400470-593256-1-git-send-email-wubo40@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210518_213522_016669_40D71D98 
X-CRM114-Status: GOOD (  10.74  )
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

Form: Wu Bo <wubo40@huawei.com>

When creating loop ctrl in nvme_loop_create_ctrl(), if nvme_init_ctrl()
returns fails, the loop ctrl should be freed before
jumps to the "out" label.

Fixes: 3a85a5de29ea7 ("nvme-loop: add a NVMe loopback host driver")
Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 drivers/nvme/target/loop.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 74b3b15..cb30cb9 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -590,8 +590,10 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 
 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_loop_ctrl_ops,
 				0 /* no quirks, we're perfect! */);
-	if (ret)
+	if (ret) {
+		kfree(ctrl);
 		goto out;
+	}
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
 		WARN_ON_ONCE(1);
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
