Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D232EC43211
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jun 2026 05:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TdMp+kUDXzcCHRaLfP/G+q/ZKBuIsQ8XItHm4El4CqI=; b=dUHeXSh4c9GLpZJFnMooW0cbqf
	xfa1VCgv9zKbXpkIBGn6MIQj7a7+Kn0B5+1qcSKHM8UXlzhAwr2Xg5U23L7eY0n4FfsGNReSvTn1q
	LDvXmvw625HAYx7Z09svSKdcHGRHg/YjODqWlLPqasZ6zWfI+Vp0BbA8ugy0Dhk9Lr3bEFgT5ivCC
	kvAde/X4EmTfJ8hAbmwzoagyKSuW60887Cbj45PkGZR/k4U3yMm4Fd0p7j5hK++fpov2Ih+j5gYoh
	pt9w4eZm/hSfrHpsfLAhVCaXRqSehjfsGcH1m/E8AAjiTqiOQT+Vp7sMtgMf24PEfvOxU1mbsnWHh
	B3LH2Y3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdLoe-0000000CA9R-1MBk;
	Sat, 27 Jun 2026 05:42:56 +0000
Received: from mail-wm1-x368.google.com ([2a00:1450:4864:20::368])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdLoa-0000000CA5T-0aMl
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jun 2026 05:42:53 +0000
Received: by mail-wm1-x368.google.com with SMTP id 5b1f17b1804b1-49243366b9bso693905e9.1
        for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2026 22:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782538968; x=1783143768; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TdMp+kUDXzcCHRaLfP/G+q/ZKBuIsQ8XItHm4El4CqI=;
        b=XACB9wAP5NhG7CJxGMQEaQt/xTDw2eoyjM8wViOty0E/cs3/WaPj9+Kf7+hBB+j2gO
         0kN9bMENVYN6bB3Kz2xXyJWwQzXl9jxvCrkgPikJ1FDD5vehpwon5ZBb6zqdfxdQxS5Z
         M9W5IUqV9C3+ba/w3HTItSh4S38c5JEtCKshoIdP+8keRH9n2txylMzUJmcN+2xjrUeF
         g9bRMtpPTVJ/C5nA+GwLfTqyjXXJvUYiNAXSRysyinAywNBoFQNp/kgzJlctnLZoM2Mp
         DAMamHSTrYgE1E0yh06EdfjlOC+pcYXDLpwxaQqt4jKmXvhVWCeUooB4w5aeoXphponI
         Dcug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782538968; x=1783143768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TdMp+kUDXzcCHRaLfP/G+q/ZKBuIsQ8XItHm4El4CqI=;
        b=lGVDJpC3nm9S1JXQzmYX3iTBJZv3sYgW9CIxILPCKNn5a6hhBLBZqsqqrUW6uu8ma6
         qAyD67Qw/2fAKEUgMU3x4lmVMhhF+ONkmPowkFjTw0NTfpiw5gxNv3jDN6m/J/xrFH2M
         q28pIoC3Gg9RsQ/sCIZpQ/ZCht96q3O1vKBXNy51SrIDCDXCGgaS7WyiSTb6jP0Ur0As
         JMf9x0wlzwk8iFAz4yQAjPhvSHexMKa8ezHmAbJxkvOGxFBAfd0KwbVTqpXVhtCWyoqm
         SmcknBLXLrpnBXyxkGXYDCGSx0JtAABCWASUZk2l5zRL25l0eKTdqges9FHUjRmQAzNM
         Ocbw==
X-Forwarded-Encrypted: i=1; AFNElJ/pRcZJL2L0oc7B9NU4QcyxrYNzV2/3L1VlI60O/wn1G4zS1JFkbRe+bRymt9oc/LWgdxwLO4gEpsId@lists.infradead.org
X-Gm-Message-State: AOJu0Yz5pWjhyEgWv07Nftpwxug/ZnrFoNui7KnP5tUFUii257v1aCmE
	KywCWs92hvs+QPYcgaQ4tDIZ6vv2RCEPBmc/Zz17DeB1GLKPl8bPPmHAewmwe7LZ+dSVH33EFWK
	MCjlPuybLvUO0NFFJCgVMfP3S39a6HwDcSqxQ
X-Gm-Gg: AfdE7clqVsanpCFKcRY+gDdNTBwwJll+zHY/ufxzM51GaToRWNPd+ORY2wE1mV8YdwD
	hArpgUJg2p1ue4qUzPnGwNSZlxlWdGnY74bzZnM+EymzWwBWTHR9CHnhHDMX3j9JreaypFYJvOj
	F5nUyKI0Z1rq2w+bMbHtr9Nabnkogrtzh+PTw53f8jqfY+Eg8Qr0CvaU3xVixahVBpNV3J1YlTn
	59UQOBIrWpssoHx3XEPmit0bjwnIOpVUvo0YE20tfdgB6yNwRo0g7RR8Ipi1Xn5ZGiDa+j9Ftau
	ytbL2kDeW2Krtgxp2spHykPso3DKHWKaDpXuxmwn+xddo86e8VBzGWm60bhTbG2bQnywaJvtdi8
	D2h4HsRRiDngztJPVN3Q++2doeWwgB2pnOdmfDqK3wIw=
X-Received: by 2002:a05:600c:c043:b0:492:4708:d73d with SMTP id 5b1f17b1804b1-4926686b471mr48451735e9.1.1782538968091;
        Fri, 26 Jun 2026 22:42:48 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-4926902d9b4sm2356335e9.14.2026.06.26.22.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 22:42:48 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id B2CB8402B4;
	Fri, 26 Jun 2026 23:42:46 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id B0913E40712; Fri, 26 Jun 2026 23:42:46 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 3/5] bio-integrity-fs: use integrity interval instead of sector as seed
Date: Fri, 26 Jun 2026 23:42:18 -0600
Message-ID: <20260627054220.2174166-4-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260627054220.2174166-1-csander@purestorage.com>
References: <20260627054220.2174166-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_224252_200226_68AAC7B4 
X-CRM114-Status: GOOD (  14.28  )
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

bip_iter.bi_sector is meant to be in units of integrity intervals rather
than 512-byte sectors. bio_integrity_verify() doesn't actually use it
currently (it uses the passed in struct bvec_iter's bi_sector instead).
But let's set it to the expected value for consistency.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity-fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio-integrity-fs.c b/block/bio-integrity-fs.c
index 9c5fe5fa8f0d..770eacb2220f 100644
--- a/block/bio-integrity-fs.c
+++ b/block/bio-integrity-fs.c
@@ -65,11 +65,11 @@ int fs_bio_integrity_verify(struct bio *bio, sector_t sector, unsigned int size)
 	 *
 	 * This is for use in the submitter after the driver is done with the
 	 * bio.  Requires the submitter to remember the sector and the size.
 	 */
 	memset(&bip->bip_iter, 0, sizeof(bip->bip_iter));
-	bip->bip_iter.bi_sector = sector;
+	bip->bip_iter.bi_sector = bio_integrity_intervals(bi, sector);
 	bip->bip_iter.bi_size = bio_integrity_bytes(bi, size >> SECTOR_SHIFT);
 	return blk_status_to_errno(bio_integrity_verify(bio, &data_iter));
 }
 
 static int __init fs_bio_integrity_init(void)
-- 
2.54.0


