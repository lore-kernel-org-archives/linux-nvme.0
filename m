Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CEFC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 08:16:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5E82206FB
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 08:16:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E82206FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1UASA2fJwp8tRuNA3QeDrv5A0rxLO1o7l5xpj9clfGk=; b=UgxJz5gHpbiY7lShMG0USjmw7E
	z0FHqgtpp0X0//KjIFf21gfZ8ltjQ3iiPwMN4Sn95mUnaHiSZQ44UPHPUQz8n6q/NKSIx/tOKC1N4
	5/76PeJISq1Nt5wn+vYsiLzeHXCDkXAAqsdSA4Sxp5ynR7FuzPHpMpmeVXQYuFfrc2wtxTp1tfSp2
	KteGyEDCfLPI4u9Uyjt1OQtqgGFb9eKfLVQzZnOxQ70WDzcSyeukfUgmyE2wJS+Q1bPLhPvVXy68D
	IhTlQ5SaUZIKFWl8CFSIMjcGy4LtqYHJViJaI7/EhfHenlDQ5B6E19wzyqIeKhu6QmFhge9Lg0TbM
	X4OESCJA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4JW8-00024P-RQ; Tue, 26 Jan 2021 08:16:04 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4JVx-0001xo-Th
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 08:15:55 +0000
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DPzzX1Hz9zjDQL;
 Tue, 26 Jan 2021 16:14:32 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Tue, 26 Jan 2021
 16:15:39 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH v4 0/5] avoid double request completion and IO error
Date: Tue, 26 Jan 2021 16:15:34 +0800
Message-ID: <20210126081539.13320-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_031554_655552_7EAB232A 
X-CRM114-Status: UNSURE (   7.61  )
X-CRM114-Notice: Please train this message.
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
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, sagi@grimberg.me,
 axboe@fb.com, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add blk_mq_set_request_complete and nvme_complete_failed_req for two bug
fixs.
First avoid double request completion for nvmf_fail_nonready_command.
Second avoid IO error for nvme native multipath.

V4:
	- add status parameter for nvme_complete_failed_req.
	- export nvme_complete_failed_req instead of inline function.
V3:
	- complete the request just for HBA driver path related error.
V2:
	- use "switch" instead "if" to check return status.

Chao Leng (5):
  blk-mq: introduce blk_mq_set_request_complete
  nvme-core: introduce complete failed request
  nvme-fabrics: avoid double request completion for
    nvmf_fail_nonready_command
  nvme-rdma: avoid IO error for nvme native multipath
  nvme-fc: avoid IO error for nvme native multipath

 drivers/nvme/host/core.c    | 8 ++++++++
 drivers/nvme/host/fabrics.c | 4 +---
 drivers/nvme/host/fc.c      | 7 ++++++-
 drivers/nvme/host/nvme.h    | 1 +
 drivers/nvme/host/rdma.c    | 9 ++++++++-
 include/linux/blk-mq.h      | 5 +++++
 6 files changed, 29 insertions(+), 5 deletions(-)

-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
