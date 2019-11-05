Return-Path: <SRS0=AJHE=Y5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97458C5DF60
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 16:23:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 626212087E
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 16:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uFyiyJ61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 626212087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MVMKYByZxxK8tcghOFSoBafJLZj3L+3a8f7k6vSKAlc=; b=uFyiyJ611sbAt5
	yBN3RyocnkLAOXwgfu75yuLSwdVRAFn6HJb3RTUNNZAnAUy/OZMOodQi9zsxnIpB4ScIKqTnqaVZz
	ORJX6E9/UVvGFlMFtFqEf8z0sTCtuTqldOqGLLixfKtsdJxQCV6wxbXvglWuQ1r9Uooo9w4a9ghSw
	SL5Gr5fBeVbz6vy0l3BqxBPPVzVsHyRfAY4fDG/ERR5jr9JfRlvHh+WZ5yJ7zcidPp7dC+sHN5Eru
	/uFDpRSV1HBUUMDSrajYuVBZeRoMBWY2h7g5G42OE4/30r4Cxy6Tf1OzxnHO4WTItzN37y53d9INn
	0HFGUd/k5UqDG3IWI6fg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iS1bn-0005eX-Es; Tue, 05 Nov 2019 16:23:07 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iS1ZR-0003SI-NB
 for linux-nvme@lists.infradead.org; Tue, 05 Nov 2019 16:20:49 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 5 Nov 2019 18:20:28 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id xA5GKQm3013132;
 Tue, 5 Nov 2019 18:20:27 +0200
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me
Subject: [PATCH 06/15] block: Introduce BIP_NOMAP_INTEGRITY bip_flag
Date: Tue,  5 Nov 2019 18:20:17 +0200
Message-Id: <20191105162026.183901-8-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191105162026.183901-1-maxg@mellanox.com>
References: <20191105162026.183901-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191105_082042_262620_F5D21741 
X-CRM114-Status: UNSURE (   7.65  )
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
Cc: vladimirk@mellanox.com, idanb@mellanox.com, israelr@mellanox.com,
 shlomin@mellanox.com, oren@mellanox.com, maxg@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Israel Rukshin <israelr@mellanox.com>

It means that reftag shouldn't be remapped. This flag will be used in
case some other layer did the reftag remapping (e.g. in NVMe/RDMA the
initiator controller performs the remapping so target side shouldn't
map it again).

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 block/t10-pi.c      | 7 +++++++
 include/linux/bio.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/block/t10-pi.c b/block/t10-pi.c
index f4907d9..6de380b 100644
--- a/block/t10-pi.c
+++ b/block/t10-pi.c
@@ -144,6 +144,9 @@ static void t10_pi_type1_prepare(struct request *rq)
 		/* Already remapped? */
 		if (bip->bip_flags & BIP_MAPPED_INTEGRITY)
 			break;
+		/* No need to remap */
+		if (bip->bip_flags & BIP_NOMAP_INTEGRITY)
+			break;
 
 		bip_for_each_vec(iv, bip, iter) {
 			void *p, *pmap;
@@ -193,6 +196,10 @@ static void t10_pi_type1_complete(struct request *rq, unsigned int nr_bytes)
 		struct bio_vec iv;
 		struct bvec_iter iter;
 
+		/* No need to remap */
+		if (bip->bip_flags & BIP_NOMAP_INTEGRITY)
+			break;
+
 		bip_for_each_vec(iv, bip, iter) {
 			void *p, *pmap;
 			unsigned int j;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 3cdb84c..2ba09e6 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -299,6 +299,7 @@ enum bip_flags {
 	BIP_CTRL_NOCHECK	= 1 << 2, /* disable HBA integrity checking */
 	BIP_DISK_NOCHECK	= 1 << 3, /* disable disk integrity checking */
 	BIP_IP_CHECKSUM		= 1 << 4, /* IP checksum */
+	BIP_NOMAP_INTEGRITY	= 1 << 5, /* ref tag shouldn't be remapped */
 };
 
 /*
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
