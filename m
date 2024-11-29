Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0AFD6EC0E
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 14:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=e+cHTP6L0htDr7tT9IPnDicwCiZlrrfThPvIE6QDlNM=; b=ohZAICcR+yQ8+Pw+W6Cn/MFAA7
	kRVEndY7bWfr2YyGQm0xswHhX94DPJknKCMvNAnGwcqc2etD9JRj+c7RjAqsqRbLq5TQ4/fz5lFQA
	RMCgoWGai33ahRG+s2esmU0q8TOYUjtgXXG2vToNVMXcZ6Wt/apsCVxlGpcSZzFG/92nAdb9plYUx
	IOZJuX84ewDOqttKaUs+mb+bMcAgRk+zhfMxcGQTlkb18VM59eND5roWqknCHQVhBCQUEYfr9qUaR
	lS3wdozz4tBt6sI8wnbhKVvlOVKOyopq26t6O6VbUSI3a9SQml4mc7HPzZOaRkofR2IIm0H/FvTs/
	x5r/5xqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tH1o9-00000000Hw4-0Q4n;
	Fri, 29 Nov 2024 14:17:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tH1o5-00000000HvU-20fJ
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 14:17:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732889835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e+cHTP6L0htDr7tT9IPnDicwCiZlrrfThPvIE6QDlNM=;
	b=EuB6m9qLbDRrUvYDjWkzSUp0Gvxy4CpjO4v6sITJLYoMDkp7my3wyQxOfQA6Sbp1CiBhBF
	4THriapAQL//2Ach+dlo0+PTuUXllhPgHj7UzkS2Bxk9gJnXsYqy2jFjoECL46jYqrMNpA
	yE9kVl+ySw+5M/a1g6SgpV1XgpKKVTE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-LYZFpGU5N3y2IUZ0RxULWQ-1; Fri,
 29 Nov 2024 09:17:14 -0500
X-MC-Unique: LYZFpGU5N3y2IUZ0RxULWQ-1
X-Mimecast-MFC-AGG-ID: LYZFpGU5N3y2IUZ0RxULWQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4BAF81955F40;
	Fri, 29 Nov 2024 14:17:12 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.45.225.184])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B9FB41955F2D;
	Fri, 29 Nov 2024 14:17:07 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	kanie@linux.alibaba.com,
	kch@nvidia.com,
	loberman@redhat.com,
	emilne@redhat.com,
	jmeneghi@redhat.com
Subject: [PATCH] nvme-fabrics: handle zero MAXCMD without closing the connection
Date: Fri, 29 Nov 2024 15:17:06 +0100
Message-ID: <20241129141706.261171-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Xi3_ddNomy3emJWlDbitHhKZDZpdF29Fi3-SyZ6lwO8_1732889833
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_061717_586818_132BC2D8 
X-CRM114-Status: GOOD (  13.89  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The NVMe specification states that MAXCMD is mandatory
for NVMe-over-Fabrics implementations. However, some NVMe/TCP
and NVMe/FC arrays from major vendors have buggy firmware
that reports MAXCMD as zero in the Identify Controller data structure.

Currently, the implementation closes the connection in such cases,
completely preventing the host from connecting to the target.

Fix the issue by printing a clear error message about the firmware bug
and allowing the connection to proceed. It assumes that the
target supports a MAXCMD value of SQSIZE + 1. If any issues arise,
the user can manually adjust SQSIZE to mitigate them.

Fixes: 4999568184e5 ("nvme-fabrics: check max outstanding commands")
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1a8d32a4a5c3..91ee2c3aa95e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3257,8 +3257,9 @@ static int nvme_check_ctrl_fabric_info(struct nvme_ctrl *ctrl, struct nvme_id_ct
 	}
 
 	if (!ctrl->maxcmd) {
-		dev_err(ctrl->device, "Maximum outstanding commands is 0\n");
-		return -EINVAL;
+		dev_err(ctrl->device,
+			"Firmware bug: maximum outstanding commands is 0\n");
+		ctrl->maxcmd = ctrl->sqsize + 1;
 	}
 
 	return 0;
-- 
2.43.5


