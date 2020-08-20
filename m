Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A93CC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 03:54:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB8F12078B
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 03:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q2KiWWVT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8F12078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=m5fss+8qSUW7Ey9NcwZKgO3uCj39WC7/+hsPJwZ+g7I=; b=q2KiWWVT/Lh1zkvGHm/18qH6PR
	yYSz9Tej96xjzEbDlkOKjK7ElZlAR72QYfAh4qWOMV9vuAY0Ltx9XoX80zPIt6yr1P+w4De2fT6N2
	ojQ1aywiU3NYYszlJ7uoQGWEWes/2mEIQakR9BbSqZMukemjqNF/CVVmtNv9G0a/1cZjgtoG4JhiG
	nnzllcgElmBtprhaWUqJtiUH0tIOiIk3h3vpsrrRRU6Qejh4vxAglMvzsve/hFmOzrb7WktyBrTL1
	KOS9MxLK6L4p/iqlxjR2b27udPneDHYP/MbLLmhQ18GWcvLalyBLfBHqeeLxIA1/xe85X+WS7dhxF
	lfG+pxAQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8bf5-0005jx-2E; Thu, 20 Aug 2020 03:54:47 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8bey-0005dM-GL
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 03:54:45 +0000
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id A9D0B895FAD8BE814C02;
 Thu, 20 Aug 2020 11:53:54 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Thu, 20 Aug 2020
 11:53:44 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH 0/3] fix crash and deadlock when connect timeout
Date: Thu, 20 Aug 2020 11:53:44 +0800
Message-ID: <20200820035344.1579-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_235444_793632_9D20CEBA 
X-CRM114-Status: UNSURE (   7.97  )
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
Cc: axboe@fb.com, sagi@grimberg.me, linux-block@vger.kernel.org,
 lengchao@huawei.com, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When we test nvme over roce with link blink, deadlock and crash happen.
To fix the bug we need set the flag:NVME_REQ_CANCELLED for io which is
canceled by host. This is conflict with error translation of
nvme_revalidate_disk, so we need improve the error translation of
nvme_revalidate_disk first.

Chao Leng (3):
  nvme-core: improve avoiding false remove namespace
  nvme-core: fix deadlock when reconnect failed due to
    nvme_set_queue_count timeout
  nvme-core: fix crash when nvme_enable_aen timeout

 drivers/nvme/host/core.c    | 21 ++++++++++++++-------
 drivers/nvme/host/fabrics.c |  1 +
 2 files changed, 15 insertions(+), 7 deletions(-)

-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
