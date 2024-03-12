Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B4CC54E66
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Mar 2024 07:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0c+TVe2myEYKvz5lDzAg2PhnBFRqjM4C8AhxJr7HICw=; b=wZy0rFHk0u4kgJ/3ysiUmjWc8B
	gtwUfvNQanPRBVxpFjY3A2Ro13xUzH0MhYId6tLqx5IsnSx3RzqGVUostzI3iv3t06gS76286PGSB
	54us7/GxLP//b/8AseLNU2GWBIGC6pFS5QuDUIFLeDtS/m8ZyUBbWQj7vSDgPrwgPD908ai2LcUFz
	nRUi6NGsUygvs54P9AFcE+1WEJhF1i/vdP8dJ23MwGiuG54w1sW4Cdb+bop/XlqAQfksfkmqaPrAF
	j2pGFkzAWdIRx/S2S9BRifG36p1O+m/yPYQc6/MGxHnQFCx/OA4DRIuGW9cf4d0qShslYygEEB136
	jtwjV7tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjwwT-00000004mIw-13a8;
	Tue, 12 Mar 2024 07:52:57 +0000
Received: from out30-99.freemail.mail.aliyun.com ([115.124.30.99])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjwwP-00000004mFa-0D7q
	for linux-nvme@lists.infradead.org;
	Tue, 12 Mar 2024 07:52:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710229970; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=0c+TVe2myEYKvz5lDzAg2PhnBFRqjM4C8AhxJr7HICw=;
	b=JPrZj2U8C8FlHMBgLDWnLQMSbfdVm0TwFYMjJgPD6FZeeaZj8OizInB0ZqsL2Hjwt7P5k0tKKu2hHfzg18Rh8RKcllsQYFltYUlvNwnvqXfffjhq5M7AAUHTIVFWAcfqxg4KPvpl7ymJ+Q1Hvu0A7xVp+/Y2UCbRaxrWxGGMc10=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W2L-1Mo_1710229963;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W2L-1Mo_1710229963)
          by smtp.aliyun-inc.com;
          Tue, 12 Mar 2024 15:52:47 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: parse zns command's zsa and zrasf to string
Date: Tue, 12 Mar 2024 15:52:43 +0800
Message-ID: <20240312075243.91742-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240312_005253_307514_AF95D0B8 
X-CRM114-Status: UNSURE (   8.30  )
X-CRM114-Notice: Please train this message.
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

Parse zone mgmt send commands's zsa and receive command's
zrasf to string to make the trace log more human-readable.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/trace.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 1c36fcedea20..5e94b3c6d58a 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -164,12 +164,27 @@ static const char *nvme_trace_dsm(struct trace_seq *p, u8 *cdw10)
 
 static const char *nvme_trace_zone_mgmt_send(struct trace_seq *p, u8 *cdw10)
 {
+	static const char * const zsa_strs[] = {
+		[0x01] = "close zone",
+		[0x02] = "finish zone",
+		[0x03] = "open zone",
+		[0x04] = "reset zone",
+		[0x05] = "offline zone",
+		[0x10] = "set zone descriptor extension"
+	};
 	const char *ret = trace_seq_buffer_ptr(p);
 	u64 slba = get_unaligned_le64(cdw10);
+	const char *zsa_str;
 	u8 zsa = cdw10[12];
 	u8 all = cdw10[13];
 
-	trace_seq_printf(p, "slba=%llu, zsa=%u, all=%u", slba, zsa, all);
+	if (zsa < ARRAY_SIZE(zsa_strs) && zsa_strs[zsa])
+		zsa_str = zsa_strs[zsa];
+	else
+		zsa_str = "reserved";
+
+	trace_seq_printf(p, "slba=%llu, zsa=%u:%s, all=%u",
+		slba, zsa, zsa_str, all);
 	trace_seq_putc(p, 0);
 
 	return ret;
@@ -177,15 +192,32 @@ static const char *nvme_trace_zone_mgmt_send(struct trace_seq *p, u8 *cdw10)
 
 static const char *nvme_trace_zone_mgmt_recv(struct trace_seq *p, u8 *cdw10)
 {
+	static const char * const zrasf_strs[] = {
+		[0x00] = "list all zones",
+		[0x01] = "list the zones in the ZSE: Empty state",
+		[0x02] = "list the zones in the ZSIO: Implicitly Opened state",
+		[0x03] = "list the zones in the ZSEO: Explicitly Opened state",
+		[0x04] = "list the zones in the ZSC: Closed state",
+		[0x05] = "list the zones in the ZSF: Full state",
+		[0x06] = "list the zones in the ZSRO: Read Only state",
+		[0x07] = "list the zones in the ZSO: Offline state",
+		[0x09] = "list the zones that have the zone attribute"
+	};
 	const char *ret = trace_seq_buffer_ptr(p);
 	u64 slba = get_unaligned_le64(cdw10);
 	u32 numd = get_unaligned_le32(cdw10 + 8);
 	u8 zra = cdw10[12];
 	u8 zrasf = cdw10[13];
+	const char *zrasf_str;
 	u8 pr = cdw10[14];
 
-	trace_seq_printf(p, "slba=%llu, numd=%u, zra=%u, zrasf=%u, pr=%u",
-			 slba, numd, zra, zrasf, pr);
+	if (zrasf < ARRAY_SIZE(zrasf_strs) && zrasf_strs[zrasf])
+		zrasf_str = zrasf_strs[zrasf];
+	else
+		zrasf_str = "reserved";
+
+	trace_seq_printf(p, "slba=%llu, numd=%u, zra=%u, zrasf=%u:%s, pr=%u",
+		slba, numd, zra, zrasf, zrasf_str, pr);
 	trace_seq_putc(p, 0);
 
 	return ret;
-- 
2.43.0


