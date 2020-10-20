Return-Path: <SRS0=uU0g=D3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9800C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 09:08:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CD7322283
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 09:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iGGuYvGN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD7322283
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PjFTpKypU+WYWLBJK7uQCOtIQjrWJIdl9HA8JL/sRTk=; b=iGGuYvGN16uxVyeS9swNLsP6b+
	KA7iyZVdD6xWYNBAINgx1M4pAlW+s+ORvAN0VJouO5tmnD9gQh6gX1J9JJyyiz8TGACf5iLELSfz8
	QQp4l4OCtVKzjnfL48DDvQyVuuWRphZL+BMJdnOe33mCsQVB4fyOY5XLOILx+UMeoqOrBQYahbwW6
	buUJXCIsCfI33Fkj7h2eALCkXSfgWyQPZCwP0fcYAD3SxSATG8uAGmlvLJoPklnILK6QZGMZP/pgT
	BJzJfPoESkNl/X30YnejEeEP+hJu3+eKoXUnDooNlDI/R1DUytaYrI4W5jRnucVZtne8ZwryLhJvS
	CxKjkX9A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUnd0-0007KG-0X; Tue, 20 Oct 2020 09:08:22 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUncx-0007IC-M0
 for linux-nvme@lists.infradead.org; Tue, 20 Oct 2020 09:08:20 +0000
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 5EEC32CE191A0F24048E;
 Tue, 20 Oct 2020 17:08:15 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Tue, 20 Oct 2020
 17:08:08 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH 0/3] avoid race between time out and tear down
Date: Tue, 20 Oct 2020 17:08:08 +0800
Message-ID: <20201020090808.27702-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_050820_003814_EEBFBEFC 
X-CRM114-Status: UNSURE (   5.51  )
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

Avoid race between time out and tear down for rdma and tcp.

Chao Leng (3):
  nvme-core: introduce sync io queues
  nvme-rdma: avoid race between time out and tear down
  nvme-tcp: avoid race between time out and tear down

 drivers/nvme/host/core.c |  8 ++++++--
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/rdma.c | 12 ++----------
 drivers/nvme/host/tcp.c  | 14 +++-----------
 4 files changed, 12 insertions(+), 23 deletions(-)

-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
