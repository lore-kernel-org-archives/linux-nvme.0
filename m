Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103F9C433E6
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 07:04:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9463423877
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 07:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9463423877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+MTTWbnDHVDcp5MPRwxg9eBUY6ew7vC9aN5demEHD7k=; b=OwryYagGkspftRK7Dx+jgjgAqG
	vxkDTUuiCRG0mQxEy29zR77UBkXoS9Z5dMv2vY+eUj6o4XSxOf+P5s382GlN/huf9NpEnDyH7mgEC
	d6EKSjIQvRbH1IW50x2lTPO5SEnKWN9kdJF9i9hl8JZxwDGeMoafNdDlHzx0cILbRyzGL2mANy/ee
	mchePnZ3SOpRcMJFFnwzHl/7tNYRhoMlF+N6uvTWpfLvZjeR3YTXG86X94XrS5JVrVDujyLUgxk6W
	7yXS5+DjSOlZjKnvbF8nFBeZWnxBMsaVQ/6TNC8S5d9eyuUitawO91cuNBs1Atw9p/3krFkiVNI1Q
	C0qHxYOA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2U0O-0006jR-Tc; Thu, 21 Jan 2021 07:03:44 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2U0J-0006hL-Gc
 for linux-nvme@lists.infradead.org; Thu, 21 Jan 2021 07:03:40 +0000
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DLtcc6MzHz7VJ9;
 Thu, 21 Jan 2021 15:02:24 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Thu, 21 Jan 2021
 15:03:30 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH v3 0/5] avoid double request completion and IO error
Date: Thu, 21 Jan 2021 15:03:25 +0800
Message-ID: <20210121070330.19701-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_020339_838181_8DDC64BA 
X-CRM114-Status: UNSURE (   7.09  )
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

 drivers/nvme/host/fabrics.c | 4 +---
 drivers/nvme/host/fc.c      | 7 ++++++-
 drivers/nvme/host/nvme.h    | 8 ++++++++
 drivers/nvme/host/rdma.c    | 9 ++++++++-
 include/linux/blk-mq.h      | 5 +++++
 5 files changed, 28 insertions(+), 5 deletions(-)

-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
