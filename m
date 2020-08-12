Return-Path: <SRS0=KW74=BW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA7AC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2020 08:19:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2750020774
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2020 08:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W31/YW/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2750020774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0P2NaxKFcicSlB6BQVRq0VhLcAepyzy2vXNvJSo0pdo=; b=W31/YW/flPrgvyJPFJtyrPxQWJ
	YV2wiOB1j+88+WEqMebd2UG85908uGc+LqiODfXnOxu2KPOYcBF3s8JVMSraFzH6LnFlGF/c6ytgD
	eUVfRllbPuOkU8D8yLq5+Fq81uGCtrR6OLpRJugdtEGBgR074DsGFVNN4/83Dp5RHiXNlNPRoiBVy
	d7RQGJm7+bEoQ821vjP2LXhxwMWBVizi6IbrmrQe42pu123R+D/tUKexvYaPjw2ZnujPil63Qpzlm
	VDw7bQE5sJYcFQBPwd5X89+mCODDuhW58yap5mH3xC57s43F3+9voBQY0dyNlIO+5FNX/euALr4TF
	pxix/X5Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5lyr-0001Nv-OB; Wed, 12 Aug 2020 08:19:29 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5lyp-0001J8-0v
 for linux-nvme@lists.infradead.org; Wed, 12 Aug 2020 08:19:27 +0000
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 4B2E89D126F018B1108E;
 Wed, 12 Aug 2020 16:19:05 +0800 (CST)
Received: from huawei.com (10.29.88.127) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 12 Aug 2020
 16:18:55 +0800
From: Chao Leng <lengchao@huawei.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
Subject: [PATCH 3/3] nvme-core: delete the dependency on REQ_FAILFAST_TRANSPORT
Date: Wed, 12 Aug 2020 16:18:55 +0800
Message-ID: <20200812081855.22277-1-lengchao@huawei.com>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
X-Originating-IP: [10.29.88.127]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200812_041927_310093_35EAF868 
X-CRM114-Status: GOOD (  12.14  )
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

REQ_FAILFAST_TRANSPORT may be designed for scsi, because scsi protocol
do not difine the local retry mechanism. SCSI implements a fuzzy local
retry mechanism, so need the REQ_FAILFAST_TRANSPORT for multipath
software, if work with multipath software, ultraPath determines
whether to retry and how to retry.

Nvme is different with scsi about this. It define local retry mechanism
and path error code, so nvme should retry local for non path error.
If path related error, whether to retry and how to retry is still
determined by ultraPath. REQ_FAILFAST_TRANSPORT just for non nvme
multipath software(like dm-multipath), but we do not need return an
error for REQ_FAILFAST_TRANSPORT first, because we need retry local
for non path error first.

In this way, the mechanism of nvme multipath or other multipath will be
same. The mechanism is: non path related error will be retry local,
path related error treated by multipath.

If work with dm-multipath, The patch can also fix io interrupt when io
return NVME_SC_CMD_INTERRUPTED or NVME_SC_NS_NOT_READY. Because
NVME_SC_CMD_INTERRUPTED or NVME_SC_NS_NOT_READY will be translated to
BLK_STS_TARGET. blk_path_error will treat BLK_STS_TARGET as retrying
failover path will not help, will cause io interrupt.

Signed-off-by: Chao Leng <lengchao@huawei.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 246988091c05..07471bd37f60 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -243,7 +243,7 @@ static blk_status_t nvme_error_status(u16 status)
 
 static inline bool nvme_req_needs_retry(struct request *req)
 {
-	if (blk_noretry_request(req))
+	if (req->cmd_flags & (REQ_FAILFAST_DEV | REQ_FAILFAST_DRIVER))
 		return false;
 	if (nvme_req(req)->status & NVME_SC_DNR)
 		return false;
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
