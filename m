Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8360C433E6
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 03:33:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 560D72388E
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 03:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 560D72388E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Y3SiJlCvt5nSG0I/34bfTqJms/6P8DswlZn9Kja1q1U=; b=uiw8Y2yfwp94orYoemNCYFSpBh
	x4oh2R6WV5isBBDSUBLhiZ8P0KiS+xlUBysIeoWgirIlhlykxedtGw4aARNBNm1tMWKx//TZrVxZU
	g7bfsfNmXLt1G3h8a/BdyAbx2JsrCebi8sZwFinDhmxOa1u9gZHELg0Hv0O2YpPxS0S84BqbltH7j
	TS7PiWG7g9P48YfTLduRBERs+htzN3SGZYDZhcvGPCCxlPH/41+RudDCPzc5p4LRDx/bj8v3Ml/1F
	YgGq5tz6ID1W6CFLPqxJ/4HWF/Ps52FIZ8G8tEnMLRud68ILiJlaKJ2F6btNpm7osM+tEZHEUJIaQ
	doiSkovQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2QiV-0003yS-8B; Thu, 21 Jan 2021 03:33:03 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2QiL-0003uv-NT
 for linux-nvme@lists.infradead.org; Thu, 21 Jan 2021 03:32:56 +0000
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DLnx805X9zl7lN;
 Thu, 21 Jan 2021 11:31:24 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Thu, 21 Jan 2021
 11:32:40 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH 0/5] add clean action for failed reconnection
Date: Thu, 21 Jan 2021 11:32:35 +0800
Message-ID: <20210121033240.31906-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210120_223254_048623_5C1E0FD3 
X-CRM114-Status: UNSURE (   5.97  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, lengchao@huawei.com,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reconnection error handling process do not clean suppend requests, this
may cause crash due to use queue after free.
Add helper for clean code.

Chao Leng (5):
  nvme-core: add cancel tagset helpers
  nvme-rdma: add clean action for failed reconnection
  nvme-tcp: add clean action for failed reconnection
  nvme-rdma: use cancel tagset helper for tear down
  nvme-tcp: use cancel tagset helper for tear down

 drivers/nvme/host/core.c | 20 ++++++++++++++++++++
 drivers/nvme/host/nvme.h |  2 ++
 drivers/nvme/host/rdma.c | 30 ++++++++++++++++++------------
 drivers/nvme/host/tcp.c  | 30 ++++++++++++++++++------------
 4 files changed, 58 insertions(+), 24 deletions(-)

-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
