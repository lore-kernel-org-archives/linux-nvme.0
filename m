Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA0BC433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 04:35:46 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E70C61364
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 04:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E70C61364
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=okR0XkvEmANQQdHgVsJZXjOZn4RsDckZN2CEHsNenAg=; b=ei7Xd2EYtlESK9LCtWmohDBxjW
	GmcVhlWl3GiHlvJjDzdDRewkjxEVhQm93nXmKP8ZSCC21FeI70UsE1F2qpNgDraF+V78tEkccHaQR
	mHMSmlC3xQifJFpMienrISNZFIbA2nzTOfGK4hElV9J4kBzhAeoIdpVvbhspoL5v9aNETcgUrLCJM
	smEjfj/5j7yrf5Tjsn+tRK3ABOEn30DVdARwL2MlfbYJ5QcKsHvdL7I5UFhj3hWXRajrwSSBW1V97
	l+xDJvbxCDlDxW0UJSLE0vClGAW8qfxO02uxHuwvwaF7GTZ7qmDFAPMRAChnVNDRD8N8jZENMWkkd
	f6oAq22g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljDva-002kXa-Ld; Wed, 19 May 2021 04:35:26 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljDvX-002kXK-9g
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 04:35:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
 Date:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=Onf/oBvrEBrleKpLkof8+5uuCN/bWPS6bjj8Xnvw6Cs=; b=dSbP2w5MWbUOjStj5PzFeK5q6g
 U6fklVrTZBARn3PYBG9m/0dpRBCE3KSpGXiPHZnMDhdX5bR5dqq9C3Gaqikxn+ciJJsC5/GMy/L+b
 6l46+SfFuOMqJWqAk6R0A5LJoznG6Cr8wTdB9jONMEQ/v8ik2S7dDgdx/Q1JYOCrXCnsxZJ5dEV7O
 YjQBFv7NLOhRYZi3YEkN5qZbxx427n98McKQHdotoL5VI1JOIUEQ4HBPlc6Wnl5qSUYscWP1Spnef
 dgisdFlJWz0Yelx3UArOhYlqUZVAhPqMZ2FRoI73KME/LtKwdAqg4CwoiT52d2HfEndXcCH+U/8N1
 okfJZHMQ==;
Received: from szxga07-in.huawei.com ([45.249.212.35])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljDvU-00F7ae-Qu
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 04:35:22 +0000
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FlKjD6lXYzCsc8;
 Wed, 19 May 2021 12:32:32 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 12:35:19 +0800
Received: from huawei.com (10.175.124.27) by dggpeml500019.china.huawei.com
 (7.185.36.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 19 May
 2021 12:35:18 +0800
From: Wu Bo <wubo40@huawei.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <chaitanya.kulkarni@wdc.com>,
 <kbusch@kernel.org>, <amit.engel@dell.com>, <linux-nvme@lists.infradead.org>, 
 <linux-kernel@vger.kernel.org>
CC: <linfeilong@huawei.com>, <wubo40@huawei.com>
Subject: [PATCH 0/2] nvmet: Fix memory leak when create ctrl fails
Date: Wed, 19 May 2021 13:01:08 +0800
Message-ID: <1621400470-593256-1-git-send-email-wubo40@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210518_213521_055598_16ACA6CB 
X-CRM114-Status: UNSURE (   8.45  )
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

Hi,

This series of patches to fix the issuse of memory leak 
when creating ctrl fails.

Wu Bo (2):
  nvmet: Fix memory leak in nvmet_alloc_ctrl()
  nvme-loop: Fix memory leak in nvme_loop_create_ctrl()

 drivers/nvme/target/core.c | 2 +-
 drivers/nvme/target/loop.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
