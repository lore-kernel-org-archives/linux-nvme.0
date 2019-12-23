Return-Path: <SRS0=n1R8=2N=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741F8C2D0C8
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Dec 2019 01:42:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4746F2067C
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Dec 2019 01:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CVDBWNqO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lIkF6AJJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4746F2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z8LQXCBoe8Ax10VnU0+7/roFv0ccemMzKkQqiPnGsaQ=; b=CVDBWNqOb0Rtz7
	BCw3sP3K27dk4jxvaNgP3lJzFM0wgoTPnWzdvHGwBrFkGnrJdExxEbrzmN0DBCjzjBHEFYaZX43bT
	jSpvmUBdic00H09/p14XEN73ssf5V4GMkK2MBFxOBwPqjwA1ksL3PnBsmiPAuG0ZdvTaGO+pPxW+A
	6NYbDsslXTQmY30p+uDvPR8LllMiq0tMWEcLAWN+vq3acoqx7LCWQnfDeVAdsHEuS1AINwPFUQiaB
	MCehuWRPHffLZH87/xNtkbMSCb6lLy0Q/qIyyLVu7oYhCKJPrh2fK6K2588qbVhD736kEiaWe4wdl
	nklkKVttAx4N7FBoeLSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ijCjR-0007eL-87; Mon, 23 Dec 2019 01:42:01 +0000
Received: from smtp-fw-4101.amazon.com ([72.21.198.25])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ijCiv-00072u-Ag
 for linux-nvme@lists.infradead.org; Mon, 23 Dec 2019 01:41:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1577065290; x=1608601290;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=bFqvuHtUJ2uTuBGE5u3MI0p2QpGGNs+AUqkx0RpdLvY=;
 b=lIkF6AJJrdbJIH0J66oFgXtihQwHeN9LAWgJWUfRhvJ4SUjXohc2eOtJ
 8ejRdta6xO9oiBD/IsU70+Eg4vSMB9Vm4biWmsVVinfpZqJWyBgAp3Lg7
 Ov2a8jwEKcW7y2eu08+lKc65nt5YGlQBWGzPCNUISys+B8T0V/rThcOWI 8=;
IronPort-SDR: BmUYN/KT4CukTWURlMR5RKt7lUs2YeLprQarmys0dgraudtB9gaGwwvDTxZdiHF5m0Wva254iV
 QviiXeeUmMGg==
X-IronPort-AV: E=Sophos;i="5.69,345,1571702400"; 
   d="scan'208";a="9641953"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-1d-98acfc19.us-east-1.amazon.com) ([10.43.8.6])
 by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP;
 23 Dec 2019 01:41:20 +0000
Received: from EX13MTAUWC001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
 by email-inbound-relay-1d-98acfc19.us-east-1.amazon.com (Postfix) with ESMTPS
 id EB2B8A22BC; Mon, 23 Dec 2019 01:41:16 +0000 (UTC)
Received: from EX13D11UWC001.ant.amazon.com (10.43.162.151) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 23 Dec 2019 01:41:16 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D11UWC001.ant.amazon.com (10.43.162.151) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 23 Dec 2019 01:41:15 +0000
Received: from localhost (172.23.204.141) by mail-relay.amazon.com
 (10.43.61.243) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Mon, 23 Dec 2019 01:41:14 +0000
From: Balbir Singh <sblbir@amazon.com>
To: <=linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>
Subject: [RFC PATCH 2/5] drivers/block/virtio_blk.c: Convert to use
 disk_set_capacity
Date: Mon, 23 Dec 2019 01:40:53 +0000
Message-ID: <20191223014056.17318-2-sblbir@amazon.com>
X-Mailer: git-send-email 2.16.5
In-Reply-To: <20191223014056.17318-1-sblbir@amazon.com>
References: <20191223014056.17318-1-sblbir@amazon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191222_174129_535307_73E5C845 
X-CRM114-Status: UNSURE (   8.17  )
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
Cc: axboe@kernel.dk, mst@redhat.com, jejb@linux.ibm.com, ssomesh@amazon.com,
 Balbir Singh <sblbir@amazon.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

block/genhd provides disk_set_capacity() for sending
RESIZE notifications via uevents.

Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 drivers/block/virtio_blk.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index fbbf18ac1d5d..9848c94a7eb4 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -479,18 +479,16 @@ static void virtblk_update_capacity(struct virtio_blk *vblk, bool resize)
 		   cap_str_10,
 		   cap_str_2);
 
-	set_capacity(vblk->disk, capacity);
+	disk_set_capacity(vblk->disk, capacity);
 }
 
 static void virtblk_config_changed_work(struct work_struct *work)
 {
 	struct virtio_blk *vblk =
 		container_of(work, struct virtio_blk, config_work);
-	char *envp[] = { "RESIZE=1", NULL };
 
 	virtblk_update_capacity(vblk, true);
 	revalidate_disk(vblk->disk);
-	kobject_uevent_env(&disk_to_dev(vblk->disk)->kobj, KOBJ_CHANGE, envp);
 }
 
 static void virtblk_config_changed(struct virtio_device *vdev)
-- 
2.16.5


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
