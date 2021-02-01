Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE15C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 03:50:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6E1E64E25
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 03:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6E1E64E25
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Asb4B80yYIdeOALLkGosIfIKLrHwVOYEk90pAsX6XLY=; b=Z3i62fVRfQahouMUSdsDf5vpbY
	f615bvLCkm4DQHFsCXNb12cZF37FUxE3UC/85cvH/i+tMQGFUq6lambF/+gjmBMK723BwGEhR4GeF
	mW8Z8LjgA5XwBAjUbPv34E7G036jIt70oekWZ9oDIJvOldutG5F72GZ4G60iWNVvGNe3gjWLuVmw6
	VHDCDwVzT/M83iDz+z44RtyxPdiZKGEU+wAvb0nKqNy8onvzykzbOjmGQ8qBDvRyRbrWmzCvuRv7O
	NBS3nfJNLHmGWKXV5ekEXGefJDXLHBWVRoPTRNr7t7tLw/5fmos/NXxHhE3EZip/BwHHrYiMtDcOU
	qq8U11UA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6QDt-0005v8-EQ; Mon, 01 Feb 2021 03:49:57 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6QDp-0005sL-GY
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 03:49:54 +0000
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DTYnM4PFJzMSmt;
 Mon,  1 Feb 2021 11:48:07 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Mon, 1 Feb 2021
 11:49:41 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH v5 0/3] avoid double request completion and IO error
Date: Mon, 1 Feb 2021 11:49:37 +0800
Message-ID: <20210201034940.18891-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210131_224953_829763_5372FE9E 
X-CRM114-Status: UNSURE (   8.70  )
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

First, avoid double request completion for nvmf_fail_nonready_command if
the request is freed asynchronously.
Second, avoid IO error. If work with nvme native multipath, rdma HBA
drivers may failed due to failed hardware, queue_rq should failed the
request instead of returning error to block layer, So upper layer can
failover the request if another path is available.
Need set the state of request to MQ_RQ_COMPLETE when queue_rq directly
complete the request. So introduce blk_mq_set_request_complete.

V5:
	- add comment for blk_mq_set_request_complete.
	- fail the request just for -EIO returned by rdma HBA drivers.
	- delete the helper: nvme_complete_failed_req.
V4:
	- add status parameter for nvme_complete_failed_req.
	- export nvme_complete_failed_req instead of inline function.
V3:
	- complete the request just for HBA driver path related error.
V2:
	- use "switch" instead "if" to check return status.

Chao Leng (3):
  blk-mq: introduce blk_mq_set_request_complete
  nvme-fabrics: avoid double request completion for
    nvmf_fail_nonready_command
  nvme-rdma: avoid IO error for nvme native multipath

 drivers/nvme/host/fabrics.c |  2 +-
 drivers/nvme/host/rdma.c    | 13 ++++++++++++-
 include/linux/blk-mq.h      |  9 +++++++++
 3 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
