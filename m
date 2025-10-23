Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501F4CCD1AB
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Oct 2025 00:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Dd1jklD+S8irVu2tX84xXVQkiSABs90n85giYfi6uPc=; b=MxpKfEVyvUCCODpx02p3d2rlnM
	MBIdhNMuwzR1iouMHkAva+KAE4zX5r4T5XYBnUb9YNlmPfJzj6XcSalAvLU5EaEaTXheXMEFAG7G4
	Cu5bsYdn+uQj/fHk6YzEpdr45Vpb/DMlYoU6Ub3lMciEuxuQsjhv6OhHhxOl3VRwBZwTuL2w0/pdv
	cveDcoBa8T9LSM8ucDpXEQpAMfSnPtrMHaqvW6hFVdS6Nn2jqn55NeEH7yrm0YzI4K0j1c726xSB6
	tILuOc6TVH0aXqfSrJbWL0a/SCLnXbrik3e3UaUUe2lbaQnsfskMnhWbafd4KIKgb1Hxyf8j16pxV
	Ya7zJMXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBj3Z-00000004fKW-0ceK;
	Thu, 23 Oct 2025 00:19:53 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBj3Y-00000004fKQ-0Old
	for linux-nvme@bombadil.infradead.org;
	Thu, 23 Oct 2025 00:19:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Dd1jklD+S8irVu2tX84xXVQkiSABs90n85giYfi6uPc=; b=VC1VISWB6dmfjSY4VUiM/7NaUU
	QHxNi5lc67PrWVjoSlrbAYX5O3aqokYq26vJySpy4VVEKSqSCEFqsIjWFn+ltSqE7Ywenc/Gwo7oz
	U7N4h9EW2f63icWdvM7PfypZIZeZ1dBOP3Q/enRRlf9LRu4yJWZX2nKCdfhQZsUu3Xw6C/XCm3k5R
	wxUv0NfdFAP/FlXY36KD5CH5S1UVByfcOY//w4ZDnfA0azYMyFgT0uYB6No3YKIDKt7VFvTrF6Qvk
	Fvt6MvJeHCQL99d8+erfrS7FGs/hodIlAdiwACwWrLLWbmAYeZOhvobmjpnkQ4B3DUWCPbAJVnXZY
	OePJ832Q==;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBiBo-00000000wUt-0hKD
	for linux-nvme@lists.infradead.org;
	Wed, 22 Oct 2025 23:24:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1761178787; x=1792714787;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pYPZtbpmECptAtrBLdtDnDFHX/buUdsIR0QJLBYrr+Q=;
  b=Qwp9tkATC/DMyHa9PSNbofVZsVdNAq41LKYUDEjAkrwL3KgOBLKnWRx8
   gV3VlsJcO8AIbxzBw3ayBkMtIGZCMeIWIzPzyHItoa0wjHHVU33I7+zSQ
   6OMA2tB/+/dEoEJMgVUFhst/jSZ9uO4ZASlFcTw3N91Oa4mCLYYU4wl+L
   xtSg4h2M5+zSyzn4v0dhsu5hn6ZHLAGyyj/89+mIbp9/eV4uQP0ZEsSW+
   b/eLpunuyUSX/9qXkQvEeYfJAHA5W0j4mH1acrPZ+9oMWaHlDccvZXHvL
   tveqG3C0YW2Y2UFpytVJRgmgntOwkrGdRljut0NabJfNLgR8jwRBgZ3CZ
   w==;
X-CSE-ConnectionGUID: 8YBAOqyoT3a+jICSXY9x7w==
X-CSE-MsgGUID: 2olh04f2QZ+ksX7ISmEXrg==
X-IronPort-AV: E=Sophos;i="6.19,248,1754928000"; 
   d="scan'208";a="133639011"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2025 08:19:39 +0800
IronPort-SDR: 68f9749b_V7x/9SR/6ApZsyOV4UTiFyJCu+JWJZel+wLfVNK9aDA88AF
 D7Tb9m1y35WO05RV1PEffJDtGxU7pA2fB1x2nzA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Oct 2025 17:19:40 -0700
WDCIronportException: Internal
Received: from 5cg21741cp.ad.shared (HELO shinmob.wdc.com) ([10.224.105.138])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Oct 2025 17:19:38 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Yi Zhang <yi.zhang@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] nvme-multipath: fix lockdep WARN due to partition scan work
Date: Thu, 23 Oct 2025 09:19:37 +0900
Message-ID: <20251023001937.218014-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251023_002421_255822_9C348219 
X-CRM114-Status: GOOD (  12.19  )
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

Blktests test cases nvme/014, 057 and 058 fail occasionally due to a
lockdep WARN. As reported in the Closes tag URL, the WARN indicates that
a deadlock can happen due to the dependency among disk->open_mutex,
kblockd workqueue completion and partition_scan_work completion.

To avoid the lockdep WARN and the potential deadlock, cut the dependency
by running the partition_scan_work not by kblockd workqueue but by
nvme_wq.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Closes: https://lore.kernel.org/linux-block/CAHj4cs8mJ+R_GmQm9R8ebResKAWUE8kF5+_WVg0v8zndmqd6BQ@mail.gmail.com/
Link: https://lore.kernel.org/linux-block/oeyzci6ffshpukpfqgztsdeke5ost5hzsuz4rrsjfmvpqcevax@5nhnwbkzbrpa/
Fixes: 1f021341eef4 ("nvme-multipath: defer partition scanning")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 543e17aead12..e35eccacee8c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -793,7 +793,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 			return;
 		}
 		nvme_add_ns_head_cdev(head);
-		kblockd_schedule_work(&head->partition_scan_work);
+		queue_work(nvme_wq, &head->partition_scan_work);
 	}
 
 	nvme_mpath_add_sysfs_link(ns->head);
-- 
2.51.0


