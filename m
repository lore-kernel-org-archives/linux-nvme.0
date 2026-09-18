Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EF1C982D6
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 03:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8dZ15Rz88mX9T8w6PPPFLZlgEx8lT94ZPin3xCpqst8=; b=Ml9tPSjCV7udLsm/GUAsEktY/2
	LUN/YtPeJ8Bw7Zf9QCKknaEvhqKkzENCflvgdfWCWXLHTTHe3uKNCSyU4PKai4i9lqB6VGjOIB6jp
	gioPWcAzMQvKBqjEM8pV/I9s79qSJip6a9e0QXKlX344QJWfgJ5shGYyD7c6TP5B3mD8NRoJwaEVO
	kTI8KDZ1baQl/oijPW1reRRtca6KXkULcBzjFsTYLW7UczoYDMxJQpSfixR6GuCmo0e9BiXMRH9sL
	GUp/13FIDByMsEUgGWv3ELB4fzaRnk5NXkHNTEJM58QaRxYRaxZRpxkiJSoQFcNoXaxGxlf0yaDyD
	4LqpqYBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7PRs-0000000DP34-2jEo;
	Fri, 18 Sep 2026 03:39:40 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7PRp-0000000DP0h-2Du4
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 03:39:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789702775; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=8dZ15Rz88mX9T8w6PPPFLZlgEx8lT94ZPin3xCpqst8=;
	b=Xnl/7HJkgID/CYn8U/B2agXCkqsevJn3HO5w6N0uFCjONepta82jIW5/B5Dc0m5Z83D0AGOe0rG7pS9mdXRGDDnkQEw6l5WBjRcSvuPfY0fiJ8n/n61nosvN10HrDV9mP7x9E77XpYYGFJVzgfPm2dCxmd/9NhJluqid+nKPV/A=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XB9qvtk_1789702774;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XB9qvtk_1789702774 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Sep 2026 11:39:35 +0800
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
Subject: [PATCH 2/2] nvmet: return Invalid Field for invalid NSIDs in Get Features 82h
Date: Fri, 18 Sep 2026 11:39:32 +0800
Message-ID: <20260918033932.3864965-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260918033932.3864965-1-kanie@linux.alibaba.com>
References: <20260918033932.3864965-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260917_203937_718802_CBB3F104 
X-CRM114-Status: GOOD (  12.14  )
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

The Reservation Notification Mask feature (FID 82h) rejects the same
NSIDs for Get Features as for Set Features, plus the broadcast NSID:

  "A Get Features command that uses a namespace ID of FFFFFFFFh
  shall be aborted with status code of Invalid Field in Command.
  If a Set Features command or a Get Features command attempts to
  access the Reservation Notification Mask on a namespace that does
  not support reservations or is invalid, then that command is
  aborted with status code of Invalid Field in Command."

  -- NVMe Base Specification, section 5.2.26.1.33

The Get Features handler routes the namespace lookup through
nvmet_req_find_ns(), which returns Invalid Namespace or Format for an
unknown NSID.  Both rejected cases land there: a nonexistent NSID
fails the lookup, and so does the broadcast NSID, which never names a
namespace.  Both are aborted with Invalid Namespace or Format instead
of Invalid Field in Command.

Translate the lookup failure to Invalid Field in Command, as was done
for Set Features.

Fixes: 5a47c2080a73 ("nvmet: support reservation feature")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/pr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
index 927e3c44952b..8762ef64aa46 100644
--- a/drivers/nvme/target/pr.c
+++ b/drivers/nvme/target/pr.c
@@ -79,8 +79,12 @@ u16 nvmet_get_feat_resv_notif_mask(struct nvmet_req *req)
 	u16 status;
 
 	status = nvmet_req_find_ns(req);
-	if (status)
+	if (status) {
+		/* 82h is Invalid Field for invalid and broadcast NSIDs */
+		if (status == (NVME_SC_INVALID_NS | NVME_STATUS_DNR))
+			status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		return status;
+	}
 
 	if (!req->ns->pr.enable)
 		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
-- 
2.43.7


