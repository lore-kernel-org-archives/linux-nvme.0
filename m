Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF66C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 01:05:41 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1AB264F92
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 01:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1AB264F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RiIG8RLlg9rw2paFU776u+jULkjyD4esUgo+rvROg+0=; b=bn+XmOL4cjalvBXqf/zr1Kk8h
	8v/YsZGwyNidKj/43js/07Lb48gRVxcmTxZfoUdUpFWXn2ln9gftNSHOjHwQiySPqWGuI2QGn/t3K
	VYMCeLMBq+JgHsdGud1+mQaI/5Stf96vVw7D2eJgThoef5SpMHYh/lbrVOn+dFEjVdU/+xHPIaTcx
	voYFi54WNZ/E2aDIsmfpeafVm8+v2DVl+VgBcTzZ0+zyj7FgsxzfTeP2Efm/yvwa/z46saCObTz0P
	vDidYxq75ziU+FdXsRf6m8/NGh9bMMccCnDw+UVqiMRLZgPHcEZFS2F9jQqbh7pitWUOjUcKjcUKX
	ow/PhJPTA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMKcp-0029T1-NH; Wed, 17 Mar 2021 01:05:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMKWI-0027bt-Ru
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 00:58:47 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E05264FE1;
 Wed, 17 Mar 2021 00:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615942721;
 bh=DktL64CecxMdctqRV6G669oGtXDYAHLcGAc3jaz8tcg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GT4f3K2tUW6kHTkniKIHfAyvcA+FYLLJR8xaQ4reRnZE7L1hWYs8IzacGsJ+eeleo
 FarPHGBYX04FRDpP8jU6q0xyHR+969MXpJWXHdwz0xeOOIA7mfOJwGVGQE7XT7NfTq
 sLHJIzUttLJSDxxHmNh7fEYqkcttFzlco4P01iVmbIbaEP5PjaF856cptTIGfhHjNb
 Oyr+xJMEElaRsTGxE1mYKQ/yARG4/i8NPIRUsH4Fc5CfCWdbH63tsqqwQdP7OKf1ve
 6vqEZfv4IGEiYSR6oEXtfXDcds5KsYqCZqQQvYJgnn6bXThGBEUrc9wRlLZDfUkKXl
 U3i/IdlNtI6yw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>,
 Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>,
 Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 31/37] nvme: add NVME_REQ_CANCELLED flag in
 nvme_cancel_request()
Date: Tue, 16 Mar 2021 20:57:56 -0400
Message-Id: <20210317005802.725825-31-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210317005802.725825-1-sashal@kernel.org>
References: <20210317005802.725825-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_005844_635649_A462B25A 
X-CRM114-Status: UNSURE (   9.58  )
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

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit d3589381987ec879b03f8ce3039df57e87f05901 ]

NVME_REQ_CANCELLED is translated into -EINTR in nvme_submit_sync_cmd(),
so we should be setting this flags during nvme_cancel_request() to
ensure that the callers to nvme_submit_sync_cmd() will get the correct
error code when the controller is reset.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chao Leng <lengchao@huawei.com>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 95d77a17375e..2719f84c3759 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -312,6 +312,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
 		return true;
 
 	nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
+	nvme_req(req)->flags |= NVME_REQ_CANCELLED;
 	blk_mq_complete_request(req);
 	return true;
 }
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
