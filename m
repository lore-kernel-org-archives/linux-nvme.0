Return-Path: <SRS0=xptm=46=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D76DC2BB1D
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2020 05:30:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F210F2073E
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Mar 2020 05:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oLa4nLhX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="I4rHh8Oi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F210F2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1jD2+vvAM12XoXIq2GyhgTPY4AH+p1uqpEk9CgQrM2w=; b=oLa4nLhXnc3N2z
	FzTcD8blD/RhL4aZFB992slwVGnpdL40+kas3LIh9/uhqM4f1QaKNvF3AFjm+o4Xj20PmAgs9Jc0o
	9DgJDokgWWxdlVP2caZ54cIwIuy/+wwgezBc87T8XQOS4fN7Ts01RSWbwMnVJ9jzbkAQOoRMWOZZ3
	blhpquPcSVErlzmOLkBG/N31GDk4LZO9/Zc4Y7nlej6Ewz8dvc3VvrW4UPhZ8vwtHoI4N8BHMSJv/
	fHeJzNe6Q+opMzPGtBYZihq3LWYJT84BtLDJBbWs4SzQcDCD3GO0Ho0tHKgoGfpjDEgWPT4Mb6eWB
	mPERt/d7gh7gguO8HJvQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jCcuB-0005EN-71; Fri, 13 Mar 2020 05:30:43 +0000
Received: from smtp-fw-6002.amazon.com ([52.95.49.90])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jCcu8-0005DK-5X
 for linux-nvme@lists.infradead.org; Fri, 13 Mar 2020 05:30:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1584077440; x=1615613440;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=+sx6zgKfNvtU+khzgrLABKiu4S2pVtYCOg28mWKSsac=;
 b=I4rHh8Oi2ZlS9a0pvWIiwl/womRTCdhPNGKm2DTYW2f/ABIwov8Xxnbl
 EJhbHjbG/1a3t/BCeAr6MG9dd+Fi7wSGbkV7NochYtUZEF6fvi9I7YHvH
 5wbxs/yyttbrBDA+YdOy1PKwV0VkPxNkF8rmITQ3xwxriz2GfLb/T/2vN U=;
IronPort-SDR: sIRAFgLEzf8PaTIoMhqw3HVzHHRlKL2OjpIMVzinRWe6oGpdDdUYgoSqY1d8b3VGr/H+X3K0u9
 Ke2N60Y3NlLA==
X-IronPort-AV: E=Sophos;i="5.70,547,1574121600"; d="scan'208";a="20880414"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.43.8.6])
 by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP;
 13 Mar 2020 05:30:21 +0000
Received: from EX13MTAUWA001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
 by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS
 id 1B63BA2E92; Fri, 13 Mar 2020 05:30:18 +0000 (UTC)
Received: from EX13D01UWA001.ant.amazon.com (10.43.160.60) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 13 Mar 2020 05:30:18 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13d01UWA001.ant.amazon.com (10.43.160.60) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 13 Mar 2020 05:30:18 +0000
Received: from localhost (10.2.75.237) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 13 Mar 2020 05:30:18 +0000
From: Balbir Singh <sblbir@amazon.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>
Subject: [PATCH v3 2/5] virtio_blk.c: Convert to use
 set_capacity_revalidate_and_notify
Date: Fri, 13 Mar 2020 05:30:06 +0000
Message-ID: <20200313053009.19866-3-sblbir@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200313053009.19866-1-sblbir@amazon.com>
References: <20200313053009.19866-1-sblbir@amazon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200312_223040_331911_4E059A05 
X-CRM114-Status: UNSURE (   8.93  )
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
Cc: axboe@kernel.dk, Balbir
 Singh <sblbir@amazon.com>, hch@lst.de, Chaitanya.Kulkarni@wdc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

block/genhd provides set_capacity_revalidate_and_notify() for sending RESIZE
notifications via uevents.

Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 drivers/block/virtio_blk.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 0736248999b0..f9b1e70f1b31 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -388,18 +388,15 @@ static void virtblk_update_capacity(struct virtio_blk *vblk, bool resize)
 		   cap_str_10,
 		   cap_str_2);
 
-	set_capacity(vblk->disk, capacity);
+	set_capacity_revalidate_and_notify(vblk->disk, capacity, true);
 }
 
 static void virtblk_config_changed_work(struct work_struct *work)
 {
 	struct virtio_blk *vblk =
 		container_of(work, struct virtio_blk, config_work);
-	char *envp[] = { "RESIZE=1", NULL };
 
 	virtblk_update_capacity(vblk, true);
-	revalidate_disk(vblk->disk);
-	kobject_uevent_env(&disk_to_dev(vblk->disk)->kobj, KOBJ_CHANGE, envp);
 }
 
 static void virtblk_config_changed(struct virtio_device *vdev)
-- 
2.16.6


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
