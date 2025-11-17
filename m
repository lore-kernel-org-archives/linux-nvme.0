Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A95CD4F3E
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Nov 2025 02:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Qo6TP6PRl5kzpOGONUJDHtJTm/OuDN2Q1Pbtbvwqhhc=; b=S0U0qdRYQJbZ7JoDgfoVhYsAoZ
	QqE6Nvu870ZyK5FGcqRRwg6jtkL0ExNodG7lMl/frXktbI93CHXwBObzWYD8MLwnYTtw/KV7NG0DW
	fMFbfwoDd9EzAxJAY1AHXorAZ0GBHxMZBKqNhu1aZIp9gP4MPuDCV8fYrleHmezE5Pv5QenZXpAn+
	OwjXbCPoIN4X74PZY0e9qPxBLvQFGBLMcdCn8dkJxy/DP4QRx8IH88jnjfKbYxsdtDj6XEpJhIjWo
	DbJH93oIvMRTwRwmldOFxrKaJUYZy1zR3TxvShxny8gIywUXfUEWoF1YivK8PnLtcRAUnzzlV731I
	XrapouaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKouB-0000000FIsH-24TJ;
	Mon, 17 Nov 2025 02:23:47 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKou7-0000000FIrn-08vD
	for linux-nvme@lists.infradead.org;
	Mon, 17 Nov 2025 02:23:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763346223; x=1794882223;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UaOAG826x6i+QtCy4GO+KclGibMPS7ZbvRBEDOusMR8=;
  b=ifPAKsm6Xng9jm7COo1bk518aUATdJrpBO6Mp7uLt2MMZa6DX0NkmBb4
   DH/OEW+TsHOP9OzaH930JWWUheAyI+oicftoIEM0CB/scFfUaWQAqMm6h
   4iDdcI4vxkAOMDTw5CbOidIkZceqdXBgYUOU5J9Iph9wK9sRcLaSEE07T
   czv1icEg/YEFYxqhMwP1Xr/TsXQJJUlEO6TNWhPxMF0AHkUoofm0WvKgZ
   lmRdh4W+xvali9bwxjQGKQcjnbKFdOQVsLjN+CjV7aRMpx047Sc/d0+QJ
   AukORpHs0o9SEq8nKLtXlQmog1Ztdm8/pCKXbjKPoSVS5cLCOdeu2gcJh
   w==;
X-CSE-ConnectionGUID: BHM7oeYlRKq7bIvdcgSaig==
X-CSE-MsgGUID: pA6/OuG/QxGk0Ev5K4zmLA==
X-IronPort-AV: E=Sophos;i="6.19,310,1754928000"; 
   d="scan'208";a="135216061"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Nov 2025 10:23:42 +0800
IronPort-SDR: 691a872d_GUexTT5C1QmDm6aNyiw+beF4sNsTnNZWJe5sRTH0kSoCtOe
 GnlRqz3wh9s8PDO2R8+XQNqwS1hszHUO1k/1/9w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Nov 2025 18:23:41 -0800
WDCIronportException: Internal
Received: from 5cg217428q.ad.shared (HELO shinmob.wdc.com) ([10.224.109.66])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Nov 2025 18:23:40 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Yi Zhang <yi.zhang@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2] nvme-multipath: fix lockdep WARN due to partition scan work
Date: Mon, 17 Nov 2025 11:23:39 +0900
Message-ID: <20251117022339.35992-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251116_182343_125007_5193ED96 
X-CRM114-Status: GOOD (  12.22  )
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
Changes from v1:
* Added Reviewed-by tags

Link to the v1 thread:
 https://lore.kernel.org/linux-nvme/20251023001937.218014-1-shinichiro.kawasaki@wdc.com/

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
2.51.1


