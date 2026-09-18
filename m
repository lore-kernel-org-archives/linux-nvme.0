Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC6BC982D2
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 03:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EcD7Js1Au+851eBamiKGGX0noiYeQDM8DLtDT9hEqT8=; b=1IcRIYVNfTiyOw5b3f/rjaz+Wq
	x6bcy8/8C485U3WdxSq/90GWX1DL2/ZMVTUPBvJtB9c9jurd27TJA7HIpmiTKJ9YHZa9oUfVVFEJ5
	DoYJoFVJQ2BHvX3jW2mN5tUUJXU5F+K5RaX6tIUrKnvFSq92mNbagPvjC9fHPp12UcXaJtooJesmw
	7wk/RotzDBAtk6nSw0ngxcaJJ4JTFpTWoN4qge2CIDFXOAj9CY580VY5DxEnEu5iq6hHW4NDvdZ+y
	M2cruc3q+mM8n6o+ixfY3a3yF+ddfIQALtBEd0zV46W054LsxVyDrGoGqY1iCxfMwCZWWHQG0c9qG
	d6YosTMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7PRs-0000000DP2e-1DKR;
	Fri, 18 Sep 2026 03:39:40 +0000
Received: from out30-110.freemail.mail.aliyun.com ([115.124.30.110])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7PRp-0000000DP0R-1JAE
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 03:39:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789702775; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=EcD7Js1Au+851eBamiKGGX0noiYeQDM8DLtDT9hEqT8=;
	b=PJiQNiHhAdtuUWyRxmkviWMzvWlQycwCw/HlfOS4mQCmP8sOx4Iy0qSp3iYxzYTM6Qrss2EhDt57FHv1TF5Q2w5NONd379nAi00ONCfuL5NDQVKxdqcLKzZL5GRRcjONZW7OCbkeNWEAL1MkJkmqJ4TkxQyiVjE9Fmfpvv8b6dg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XB9uzsd_1789702773;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XB9uzsd_1789702773 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Sep 2026 11:39:34 +0800
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
Subject: [PATCH 1/2] nvmet: return Invalid Field for invalid NSIDs in Set Features 82h
Date: Fri, 18 Sep 2026 11:39:31 +0800
Message-ID: <20260918033932.3864965-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260918033932.3864965-1-kanie@linux.alibaba.com>
References: <20260918033932.3864965-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260917_203937_501080_CD45D032 
X-CRM114-Status: GOOD (  12.90  )
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
 drivers/nvme/target/pr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
index 0948a690a1c0..927e3c44952b 100644
--- a/drivers/nvme/target/pr.c
+++ b/drivers/nvme/target/pr.c
@@ -51,8 +51,12 @@ u16 nvmet_set_feat_resv_notif_mask(struct nvmet_req *req, u32 mask)
 
 	if (nsid != U32_MAX) {
 		status = nvmet_req_find_ns(req);
-		if (status)
+		if (status) {
+			/* 82h is Invalid Field for invalid NSIDs, not Invalid NS */
+			if (status == (NVME_SC_INVALID_NS | NVME_STATUS_DNR))
+				status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 			return status;
+		}
 		if (!req->ns->pr.enable)
 			return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 
-- 
2.43.7


