Return-Path: <SRS0=zrHs=64=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3B6C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 01:55:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACF9C20575
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 01:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kPjIZKah";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KDHwQqTN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACF9C20575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=gU1qvOJHi0mZOm+/Oqfm5j3GJS6PFXbRVbaMpWDSlZE=; b=kPjIZKahJ0dPLZ
	/VPkEEr13Fw46ErMqGWqbvQuJ5GUuy+WxZbOq+XHXjkRTge9fJs1d1+MFjF0JXaBYuEvnzKj2Hwu+
	Zs4hP5JUKWB2PTBveernBlRfOtMN8Vs/1GeZkdolqFl7J/SRG4SbKYdbxDwH89dTGpMPX+fsOTZWi
	KDCw6x28q6g8HVO4fK8PwhcynlsOsS70gw4iAD7gxTNx+N1c1Ji2O/hlPrE5C7UKaI1tRQ6X8rg5o
	De3V9fDRRL8Cozc/TrkwtQXUJb2JaLYQxrgSrwi9fUn6kOj+Gf1M5vfqBz0uC+WPLYn3rmxrGQznv
	2/LNzybk37lLV56N4o/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZ35R-0002L7-FQ; Thu, 14 May 2020 01:55:01 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZ35O-0002K1-S1
 for linux-nvme@lists.infradead.org; Thu, 14 May 2020 01:55:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1589421298; x=1620957298;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=FT614p2Mr2ld8RdigBzkgb23b4eSYDETSYuA+u1mXj4=;
 b=KDHwQqTN+OMEqNzi4N1N3NO2k4Lq26YIQUjchem1C+jvc6nd6mHUy4CR
 3y01pKsUHpOOr2XX2wT+NBerSnLYxQm+fC3mHzugtoSscVu6pZyYfI4zS
 6ogx4+Sx7s3MnofzXB05nhl65P0W3POmKl7m5lbEdiBLpKLqC3pARjWri
 Utb43I5kSMd3XHlu4s7AAW4/PxJ8JFLw8WmHDFk3CyVRf6rzMlY/kYSyo
 +rpVrhzkInSTqLRgqh0vj5nhkrBvYi9gn4+ewScaPHye55afXTW0MaItO
 QRamKy6JFbFLMCjZsKqkMT8jhv6zt90fHhuxXoyfcISwEi2u0mNJrbTi1 g==;
IronPort-SDR: tKLgTzpwylvdritIBEJL/kxZwezRMydOVlVctYctwU7GfADb/RXGCPMxuQY2vL83nKXcGGoWyi
 /14emBOnYfnKd4eS7UwyhII0dpsLp/uCt5EhNS5GHfv/p/198H19ms0cTQrbN3x/LNfiMWKdRN
 ChxeO2An0asW9DHtuFaAGF0xIG2ssfPlbVBwGt91lqxaRbA11OgvCYHPMMimGxIwGUFmZHxvOx
 rsd9G1eMvITBW0A1ezs9iQ2AtisMCgrUlduFyquI1GZE5P5NqRXm4p206wmGZNboAn7SdbtVUV
 qGk=
X-IronPort-AV: E=Sophos;i="5.73,389,1583164800"; d="scan'208";a="139065276"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 14 May 2020 09:54:54 +0800
IronPort-SDR: WlQGX7zjkBV4N9ToJ/M4Q6ygJFK4DBQk8a3is1dNrOjOiL3m6qlbuZs7V2f+9V5f4NSgET7ArI
 Mp4zY8KDq96Hi49sDyHfk6rw28eoboXDI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 May 2020 18:44:34 -0700
IronPort-SDR: u3k/r/TOEVBK18KRUYuCnZBw4SprEq9lP2aNofssrfaxiYngjeRhIv/VO7N1Hr+PTlZxWLGnqd
 +IDtlPmXBfGw==
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip01.wdc.com with ESMTP; 13 May 2020 18:54:53 -0700
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] nvme: Fix io_opt limit setting
Date: Thu, 14 May 2020 10:54:52 +0900
Message-Id: <20200514015452.1055278-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200513_185458_988781_857614A0 
X-CRM114-Status: GOOD (  15.16  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Currently, a namespace io_opt queue limit is set by default to the
physical sector size of the namespace and to the the write optimal
size (NOWS) when the namespace reports this value. This causes problems
with block limits stacking in blk_stack_limits() when a namespace block
device is combined with an HDD which generally do not report any optimal
transfer size (io_opt limit is 0). The code:

/* Optimal I/O a multiple of the physical block size? */
if (t->io_opt & (t->physical_block_size - 1)) {
	t->io_opt = 0;
	t->misaligned = 1;
	ret = -1;
}

results in blk_stack_limits() to return an error when the combined
devices have different but compatible physical sector sizes (e.g. 512B
sector SSD with 4KB sector disks).

Fix this by not setting the optiomal IO size limit if the namespace does
not report an optimal write size value.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/nvme/host/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f3c037f5a9ba..0729173053ed 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1809,7 +1809,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 {
 	sector_t capacity = nvme_lba_to_sect(ns, le64_to_cpu(id->nsze));
 	unsigned short bs = 1 << ns->lba_shift;
-	u32 atomic_bs, phys_bs, io_opt;
+	u32 atomic_bs, phys_bs, io_opt = 0;
 
 	if (ns->lba_shift > PAGE_SHIFT) {
 		/* unsupported block size, set capacity to 0 later */
@@ -1832,12 +1832,11 @@ static void nvme_update_disk_info(struct gendisk *disk,
 		atomic_bs = bs;
 	}
 	phys_bs = bs;
-	io_opt = bs;
 	if (id->nsfeat & (1 << 4)) {
 		/* NPWG = Namespace Preferred Write Granularity */
 		phys_bs *= 1 + le16_to_cpu(id->npwg);
 		/* NOWS = Namespace Optimal Write Size */
-		io_opt *= 1 + le16_to_cpu(id->nows);
+		io_opt = bs * (1 + le16_to_cpu(id->nows));
 	}
 
 	blk_queue_logical_block_size(disk->queue, bs);
@@ -1848,7 +1847,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	 */
 	blk_queue_physical_block_size(disk->queue, min(phys_bs, atomic_bs));
 	blk_queue_io_min(disk->queue, phys_bs);
-	blk_queue_io_opt(disk->queue, io_opt);
+	if (io_opt)
+		blk_queue_io_opt(disk->queue, io_opt);
 
 	if (ns->ms && !ns->ext &&
 	    (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
-- 
2.25.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
