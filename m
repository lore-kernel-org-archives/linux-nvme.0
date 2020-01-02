Return-Path: <SRS0=Pbb9=2X=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092E2C32771
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jan 2020 07:53:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7FDC20866
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jan 2020 07:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Uxq5eBYD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="f7xep59Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7FDC20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aNS20VjGfjqaEjuJ95B1X0PC1ifJUF8MY2S4qD+bnBI=; b=Uxq5eBYDLLHYnx
	MiACY9AJHjU3kfHViN899z69z5NdT3HNI0EugFAx8U8dbtnYHNVkRIHmubGP1q4Cj1i3noHogrMk+
	O+Ra8i8GsJqXrJ/1eUaz/+wp+rTquN4XPO/vuf8xCS/9BcHTS214V9gmrpOn8/SXCpiIEh3fbLVBm
	dd6Z3rpkdTJ88lOe/otNgtA//MJNHgo5qxOjQy764zdfOFrbkbU3UMfV9vVjzvYvMyeKzbe1hl63+
	I+ptjSjwJv9Hd86/voRnMtGS4ySQH5nfmIc+O5AddgRNZGGu+qatyMYWqFLidOhSoFWQ+AEy6thFu
	XZw5YR82gu/6eZkIHLtw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1imvIa-0001kE-Kd; Thu, 02 Jan 2020 07:53:40 +0000
Received: from smtp-fw-33001.amazon.com ([207.171.190.10])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1imvIU-0001d4-3f
 for linux-nvme@lists.infradead.org; Thu, 02 Jan 2020 07:53:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1577951615; x=1609487615;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=4qUj5u+oxc6hneYGlI2C/8YFgqo7dDcV2dUhIEALWZk=;
 b=f7xep59ZwiG361Yk0kby4xcLGlztNdcRePuACccPxOSXUXPHHi0G5HqI
 LcwcOwBzhbry0sUdGcStx6CkHkQ/aJ7mPzs2CwhWB+6BVIRqk7fAcJp+d
 0hyzlH1DUKr9EKjKXqf2JCOIh22YfTgvy6N2TPuoajV4E495rzEQ873O3 s=;
IronPort-SDR: DdkJEDsnq8BF7n8r5K3LtX4Lt3Cx0ND9gS41qTOlfsRwfIuOoR8+Aud6YpOvPng1lPX/lFdwEM
 rVXxoDTImHuw==
X-IronPort-AV: E=Sophos;i="5.69,385,1571702400"; d="scan'208";a="17779134"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO
 email-inbound-relay-1e-57e1d233.us-east-1.amazon.com) ([10.47.23.38])
 by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP;
 02 Jan 2020 07:53:23 +0000
Received: from EX13MTAUWA001.ant.amazon.com
 (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
 by email-inbound-relay-1e-57e1d233.us-east-1.amazon.com (Postfix) with ESMTPS
 id 003DF1416C4; Thu,  2 Jan 2020 07:53:19 +0000 (UTC)
Received: from EX13D01UWA004.ant.amazon.com (10.43.160.99) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 Jan 2020 07:53:19 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13d01UWA004.ant.amazon.com (10.43.160.99) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 2 Jan 2020 07:53:18 +0000
Received: from localhost (172.23.204.141) by mail-relay.amazon.com
 (10.43.61.243) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 2 Jan 2020 07:53:18 +0000
From: Balbir Singh <sblbir@amazon.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>
Subject: [resend v1 1/5] block/genhd: Notify udev about capacity change
Date: Thu, 2 Jan 2020 07:53:11 +0000
Message-ID: <20200102075315.22652-2-sblbir@amazon.com>
X-Mailer: git-send-email 2.16.5
In-Reply-To: <20200102075315.22652-1-sblbir@amazon.com>
References: <20200102075315.22652-1-sblbir@amazon.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200101_235334_192250_F1BB848E 
X-CRM114-Status: GOOD (  10.07  )
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

Allow block/genhd to notify user space (via udev) about disk size changes
using a new helper disk_set_capacity(), which is a wrapper on top
of set_capacity(). disk_set_capacity() will only notify via udev if
the current capacity or the target capacity is not zero.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Someswarudu Sangaraju <ssomesh@amazon.com>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 block/genhd.c         | 19 +++++++++++++++++++
 include/linux/genhd.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index ff6268970ddc..94faec98607b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -46,6 +46,25 @@ static void disk_add_events(struct gendisk *disk);
 static void disk_del_events(struct gendisk *disk);
 static void disk_release_events(struct gendisk *disk);
 
+/*
+ * Set disk capacity and notify if the size is not currently
+ * zero and will not be set to zero
+ */
+void disk_set_capacity(struct gendisk *disk, sector_t size)
+{
+	sector_t capacity = get_capacity(disk);
+
+	set_capacity(disk, size);
+	if (capacity != 0 && size != 0) {
+		char *envp[] = { "RESIZE=1", NULL };
+
+		kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
+	}
+}
+
+EXPORT_SYMBOL_GPL(disk_set_capacity);
+
+
 void part_inc_in_flight(struct request_queue *q, struct hd_struct *part, int rw)
 {
 	if (queue_is_mq(q))
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index a927829bb73a..f1a5ddcc781d 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -449,6 +449,7 @@ static inline int get_disk_ro(struct gendisk *disk)
 extern void disk_block_events(struct gendisk *disk);
 extern void disk_unblock_events(struct gendisk *disk);
 extern void disk_flush_events(struct gendisk *disk, unsigned int mask);
+extern void disk_set_capacity(struct gendisk *disk, sector_t size);
 extern unsigned int disk_clear_events(struct gendisk *disk, unsigned int mask);
 
 /* drivers/char/random.c */
-- 
2.16.5


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
