Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0EBC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 09:10:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D79023A01
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 09:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D79023A01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lD7Dn3yG2iU7YALxwu2rRORlaAR1Mm+mXSvPZ2BehLE=; b=yBm9aPAtYu6V1JatoeweRq8jNk
	hgPFujF+rPlOdwfUJ+liGox5h0z7/eNC1JP+LFHTaC/zTh6rbXcCeOyUqyCYxaZ1pgcLSO+jKfemH
	WBg4kQn5qZK3bewSFGE2gqpTwEAyQNR9MVzlaxwDcAlv4yARBHABkdNA2zblAuwjjNORXG9nK6CBi
	nt7FJo7so0oUYf2Is/5ETjldZPsjXV9JpXRoSulV3jsxNBnUoPeEFs/iJzSYlpc0ciRaQey01EwC5
	KHldgVA/3jnQeCYCrzhlMSWv5UVpNmUFi0OVY7wC0JU/4gDavpZlIATd5Tau+PbdHZwpPP+FlAnvC
	IwAkaagg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzydV-0002H3-Qn; Thu, 14 Jan 2021 09:09:45 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzydS-0002Eq-6J
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 09:09:43 +0000
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DGdlf46V4zj6PL;
 Thu, 14 Jan 2021 17:08:46 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Thu, 14 Jan 2021
 17:09:27 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH v2 0/2] avoid request double completion for concurrent
 nvme_rdma(tcp)_timeout
Date: Thu, 14 Jan 2021 17:09:24 +0800
Message-ID: <20210114090926.12109-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_040942_639088_72C02372 
X-CRM114-Status: UNSURE (   5.95  )
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

Concurrent nvme_rdma(tcp)_timeout may cause: complete request
before the qp is fully drained(the io work is completely canceled) may
lead to a use-after-free condition.
The patch sets fix it.

Chao Leng (2):
  nvme-rdma: avoid request double completion for concurrent
    nvme_rdma_timeout
  nvme-tcp: avoid request double completion for concurrent
    nvme_tcp_timeout

 drivers/nvme/host/rdma.c | 15 +++++++++++----
 drivers/nvme/host/tcp.c  | 14 ++++++++++----
 2 files changed, 21 insertions(+), 8 deletions(-)

-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
