Return-Path: <SRS0=rRT3=GK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9991C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jan 2021 03:32:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 698B023100
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jan 2021 03:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 698B023100
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QiEwKW2EaPinPIHWCsYOjFCXOwsJGWJ/9F3DmgdjA3A=; b=w2zIq2nFM3FE3O7azzCUIOSnfh
	e4pm0He+grosUw4BpeDO6Ly5qKkArgSK6c90F1qUoTXBJQljZJUsCh4glm8KWSyg4jU1uCSq0yrQg
	dqwLv9eHbgStCefmBYcDYLJ06eOgA7y3KxaTQoR6OGPx9bkuw+DUaBA0d5XKtU9JX1kBL0VP6Lrxn
	VAgbZQaJcTTDWngQCq39Mo/Ih7Og52qQhJLevggLqvAQWujDoKEZ2aow6Cx7vC3Jg9Zr0xW+v4dLU
	LhdpXzdXr2XBiueJ61oWUnSEQZ8TWMWLRcdVDEoXkqvZTRs0Jz5iVznd0F+bp0xD4ZsurGirOmNKy
	nwV3SS+w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kxM1v-0001Kj-Uj; Thu, 07 Jan 2021 03:32:08 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxM1s-0001JY-DX
 for linux-nvme@lists.infradead.org; Thu, 07 Jan 2021 03:32:05 +0000
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DBBbM0PqRzj3Rm;
 Thu,  7 Jan 2021 11:31:11 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Thu, 7 Jan 2021
 11:31:50 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH v2 0/6] avoid repeated request completion and IO error
Date: Thu, 7 Jan 2021 11:31:43 +0800
Message-ID: <20210107033149.15701-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210106_223204_705570_2175C487 
X-CRM114-Status: UNSURE (   6.37  )
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

First avoid repeated request completion for nvmf_fail_nonready_command.
Second avoid IO error and repeated request completion for queue_rq.

V2:
	- use "switch" instead "if" to check return status
	
Chao Leng (6):
  blk-mq: introduce blk_mq_set_request_complete
  nvme-core: introduce complete failed request
  nvme-fabrics: avoid repeated request completion for
    nvmf_fail_nonready_command
  nvme-rdma: avoid IO error and repeated request completion
  nvme-tcp: avoid IO error and repeated request completion
  nvme-fc: avoid IO error and repeated request completion

 drivers/nvme/host/fabrics.c |  4 +---
 drivers/nvme/host/fc.c      |  6 ++++--
 drivers/nvme/host/nvme.h    | 21 +++++++++++++++++++++
 drivers/nvme/host/rdma.c    |  2 +-
 drivers/nvme/host/tcp.c     |  2 +-
 include/linux/blk-mq.h      |  5 +++++
 6 files changed, 33 insertions(+), 7 deletions(-)

-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
