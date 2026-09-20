Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104E4C982CC
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Sep 2026 03:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rTRVkDph7ziWlWbC+qpUQiVJu1EOqR1eXP0SNr3EYLI=; b=Gx1KMjqZjjchTcvWvdhbFKjxQt
	1WVq7T0zmcTDWhryDsm3cBI6euxqGpNm4WCg9z42HHjQpbx69k8JAcv3aHm78/aPr7L7jU9MUw3+d
	bITrUdNvlXuH5LA0EZ61q7qCeWxqZ0pzl3kNi7hDuXj3yesGMXSyAHMH3TInkV4sb2I7cet/3SXZ2
	n04fT+P1HNMF9wDnS7MVzQzvd33n+FhqTSuvRThXtQuyDweLVioahW6/FMVIHImikaUX2kmB5ec9O
	Cq/NzbtVbb1sK802Kx/2NYKUqTETcNmdVJlY/k5zUXUhUb4qtE6+VTnz/wQJLFyuQ4wemnLSwAdhU
	LgKHRhBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x88Kk-0000000GoRl-2nyI;
	Sun, 20 Sep 2026 03:35:18 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x88Kh-0000000GoQR-2tZs
	for linux-nvme@lists.infradead.org;
	Sun, 20 Sep 2026 03:35:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789875313; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=rTRVkDph7ziWlWbC+qpUQiVJu1EOqR1eXP0SNr3EYLI=;
	b=ScQelT3BPsyS/W/RwE8hRIGepLr8z84GEFMqw5R2vjk5I0upvD6ljaXH7MPudNk8jP3hSuspf5L2OMGZVvkFAOO3gyDvIyuc+wlMODp8XHkkjkkOzBlKMblh34eB0T9aUnWjO7IWExNk/0OdIDLQKYmTToZkSGjX1oLNUTito94=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XBErtiz_1789875312;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XBErtiz_1789875312 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 20 Sep 2026 11:35:12 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 1/2] nvmet: return Invalid Field for invalid NSIDs in Set Features 82h
Date: Sun, 20 Sep 2026 11:34:59 +0800
Message-ID: <20260920033500.3209138-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260920033500.3209138-1-kanie@linux.alibaba.com>
References: <20260920033500.3209138-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260919_203515_906522_E0C3B59F 
X-CRM114-Status: GOOD (  11.16  )
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

The Reservation Notification Mask feature (FID 82h) defines its own
status code for namespaces that do not support reservations:

  "If a Set Features command or a Get Features command attempts to
  access the Reservation Notification Mask on a namespace that does
  not support reservations or is invalid, then that command is
  aborted with status code of Invalid Field in Command."

  -- NVMe Base Specification, section 5.2.26.1.33

The Set Features handler routes the namespace lookup through
nvmet_req_find_ns(), which returns Invalid Namespace or Format for an
unknown NSID.  That is the correct status for the generic
namespace-scoped admin commands, but not for this feature: a Set
Features 82h naming a nonexistent NSID is aborted with Invalid
Namespace or Format instead of Invalid Field in Command.

Translate the lookup failure to Invalid Field in Command.  The
broadcast NSID, the namespace-without-reservations case and everything
else keep their current behavior.

Fixes: 5a47c2080a73 ("nvmet: support reservation feature")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/pr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
index 0948a690a1c0..a36c732883d4 100644
--- a/drivers/nvme/target/pr.c
+++ b/drivers/nvme/target/pr.c
@@ -51,6 +51,8 @@ u16 nvmet_set_feat_resv_notif_mask(struct nvmet_req *req, u32 mask)
 
 	if (nsid != U32_MAX) {
 		status = nvmet_req_find_ns(req);
+		if (status == (NVME_SC_INVALID_NS | NVME_STATUS_DNR))
+			return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		if (status)
 			return status;
 		if (!req->ns->pr.enable)
-- 
2.43.7


