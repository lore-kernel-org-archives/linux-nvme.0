Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F465C982CC
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Sep 2026 03:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oabfjurRH6XQ9WVMXjabyPnktnthRe0YnAMx1AUW6wk=; b=qLaUqNxakuE0Q3pBHdzK2/8NOW
	vviuOpG+UFrdC04zRZNuf+UTz0LZm2PBcAJVGeL7ycen9avkj7I+06W9Zt128QEU4yA4txVNdsZ66
	bODxTBw6IsqfYqjexPOYzZz/7NbhDLegpkHD0nEs7L8AEoLxwbluBvDgYRE2uKr+ckn/2eWCKcEr0
	VbPjApGAtmL6ibwMhWuMVEPl8h6DXI60cQatlSCjk+T5zSA20Xd75+uZxhnjnegVSQL4ygucK9prn
	l8jyrDWYNKGOigrQkOiQcdkYtPeiNWBKXCpUymmBDq6E2BubluD9fDkZWIGCUyu0h/3qI4Xk+gAHL
	QECw7SEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x88Kp-0000000GoTx-3YVl;
	Sun, 20 Sep 2026 03:35:23 +0000
Received: from out199-10.us.a.mail.aliyun.com ([47.90.199.10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x88Km-0000000GoRZ-2TvR
	for linux-nvme@lists.infradead.org;
	Sun, 20 Sep 2026 03:35:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789875315; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=oabfjurRH6XQ9WVMXjabyPnktnthRe0YnAMx1AUW6wk=;
	b=L6d8BVCHRpsHG+lMuhSlpRFF50iGKel86H42MFp2RbmQe5FrvzaVoZXHXDtgyAAc5CwTmD4r1qf0Dm6bnfQZ9jPI1sZPr9sYBfwdeABy7VAn08mPjjNm+oGrJrsu670pTAdpqRq0fwfcT298ou1+h48jimujol7jhUybYmsKzlw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XBEwMkr_1789875313;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XBEwMkr_1789875313 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 20 Sep 2026 11:35:13 +0800
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
Subject: [PATCH v2 2/2] nvmet: return Invalid Field for invalid NSIDs in Get Features 82h
Date: Sun, 20 Sep 2026 11:35:00 +0800
Message-ID: <20260920033500.3209138-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260920033500.3209138-1-kanie@linux.alibaba.com>
References: <20260920033500.3209138-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260919_203520_902966_DE7B4BC6 
X-CRM114-Status: GOOD (  10.36  )
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
 drivers/nvme/target/pr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
index a36c732883d4..62ef8e85f7e9 100644
--- a/drivers/nvme/target/pr.c
+++ b/drivers/nvme/target/pr.c
@@ -77,6 +77,8 @@ u16 nvmet_get_feat_resv_notif_mask(struct nvmet_req *req)
 	u16 status;
 
 	status = nvmet_req_find_ns(req);
+	if (status == (NVME_SC_INVALID_NS | NVME_STATUS_DNR))
+		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 	if (status)
 		return status;
 
-- 
2.43.7


