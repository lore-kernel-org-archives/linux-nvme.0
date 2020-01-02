Return-Path: <SRS0=Pbb9=2X=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910E1C32770
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jan 2020 07:53:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55C1D20866
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jan 2020 07:53:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LuGrxu3R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vyG0nosZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C1D20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z8LQXCBoe8Ax10VnU0+7/roFv0ccemMzKkQqiPnGsaQ=; b=LuGrxu3RL0WFyb
	f0Fv64olP3FZnYuVuCp5lxzRzg9xIfLJHDfcEIayJFoA/HGkqJ/T8D9QVgJEkYDHMaNyugxIUl3Yq
	/Cie0JPK54j3hwthjbTIIA8VFVOVU/N3h8jCnRV6XYyQ6U0NpMpKllbYs9kLQNkjhO5dy3wX5zIrq
	F7SkeXcEWEqGtYD02peYkVvgkOApfC2kEORJi1jAH8TeVhaoCis0z8aGtAAzws9hs+4zCNPAIDW9D
	g9gkzTAeYQZkP5hYwUncGlyFqjon+aJ8fzZQnsX80d0XpitCXWRl4hSGJ7sBVP8KhFz8TIvXo7zNY
	FMxZ6HRtCr5Or9bJMwjA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1imvIW-0001dt-05; Thu, 02 Jan 2020 07:53:36 +0000
Received: from smtp-fw-6002.amazon.com ([52.95.49.90])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1imvIS-0001bY-Pf
 for linux-nvme@lists.infradead.org; Thu, 02 Jan 2020 07:53:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1577951613; x=1609487613;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=bFqvuHtUJ2uTuBGE5u3MI0p2QpGGNs+AUqkx0RpdLvY=;
 b=vyG0nosZl1q7n29qEqJGl+66r7dJMGvGpiM+CF8fX2CsqK3u4rCRKTHR
 fT1iQGwfntw+H8s0mBNw/bIh4H0Hv70rzDyWHsKtbBt4cmzvkDprqQFj8
 HmCzW/9kMTzZ5n7+MtwWjDOXEYf49JwJ38I19YDbH5bSxDSzNYVxylrQe 0=;
IronPort-SDR: RNTC/4q3xGWHPIh9vssYnvrzBZGJuP19UJzRbqvoIonGLncvhmcp0JXo+YaHAWgnXjsCY0bewp
 oZ4tNqPWAC5A==
X-IronPort-AV: E=Sophos;i="5.69,386,1571702400"; 
   d="scan'208";a="9797737"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-2a-e7be2041.us-west-2.amazon.com) ([10.43.8.6])
 by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP;
 02 Jan 2020 07:53:22 +0000
Received: from EX13MTAUWB001.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
 by email-inbound-relay-2a-e7be2041.us-west-2.amazon.com (Postfix) with ESMTPS
 id 438D1A1E23; Thu,  2 Jan 2020 07:53:21 +0000 (UTC)
Received: from EX13D11UWB003.ant.amazon.com (10.43.161.206) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 Jan 2020 07:53:20 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D11UWB003.ant.amazon.com (10.43.161.206) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 Jan 2020 07:53:20 +0000
Received: from localhost (172.23.204.141) by mail-relay.amazon.com
 (10.43.61.243) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 2 Jan 2020 07:53:19 +0000
From: Balbir Singh <sblbir@amazon.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>
Subject: [resend v1 2/5] drivers/block/virtio_blk.c: Convert to use
 disk_set_capacity
Date: Thu, 2 Jan 2020 07:53:12 +0000
Message-ID: <20200102075315.22652-3-sblbir@amazon.com>
X-Mailer: git-send-email 2.16.5
In-Reply-To: <20200102075315.22652-1-sblbir@amazon.com>
References: <20200102075315.22652-1-sblbir@amazon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200101_235332_959418_E86E8B6B 
X-CRM114-Status: UNSURE (   8.40  )
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
Cc: axboe@kernel.dk, Chaitanya.Kulkarni@wdc.com, mst@redhat.com,
 jejb@linux.ibm.com, ssomesh@amazon.com, Balbir Singh <sblbir@amazon.com>,
 hch@lst.de
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
