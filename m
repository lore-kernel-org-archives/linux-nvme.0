Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B0EC7115B
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Jun 2025 05:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P9rhI3M7s6EbOCh7ZiCRSWzpm7qAxT8KWdNbiPOdVhg=; b=V1L/+GUwfuqJ9BLU5rX6uagyoU
	ehlHM2AFMEAGm1rpdaFkS6ePKDDA4kFi2Pi2EhYCBOpXK/FYNPbkaKk/irmQedhcmf633Ekn+Lhdu
	p/7rvmGs9iJj14qd+gLQv6yOaPDyEH5ajeE0cHvlzU+N9bup3k7ndrpwhlKViR1/KiVWktni5IUAn
	kVKfhxe73bU4Mn+3d+/lOZ5wOvpwg/jf0IdIxJxiuJ4ZzcI2uMkeLDQHP6/vSXCFVgFI525CtvsSC
	pgSvTY/7RN9K6feZsfTxAvEXLCDv7fxHXfax7nQn6ameNeZW2aAM81jzpNw0nQlVP8I8BCWHKpIj4
	rWWLDefg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRljG-000000097dv-0aot;
	Wed, 18 Jun 2025 05:52:58 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRljD-000000097a2-2Lne
	for linux-nvme@lists.infradead.org;
	Wed, 18 Jun 2025 05:52:56 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250618055251epoutp0165bbbf5a7efc25b3c07aa2d822327abd~KDT9oN9Yh1155211552epoutp01U
	for <linux-nvme@lists.infradead.org>; Wed, 18 Jun 2025 05:52:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250618055251epoutp0165bbbf5a7efc25b3c07aa2d822327abd~KDT9oN9Yh1155211552epoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750225971;
	bh=P9rhI3M7s6EbOCh7ZiCRSWzpm7qAxT8KWdNbiPOdVhg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nBMS94McR4AwItNl0UtFDZIg22YeJdyw99JhCgRYGwqJ3IZe6zfBkzjfIPXkQX0kM
	 LGxT5BgmZW35ViDkUIC7pu5dAg3AfjlOX9w6Wmr709M2pI5La2Sz4IMWFBLHzxoviR
	 S7guo31o6MEbAYGIlmgWU7ZqAvz3D1OJpkZNsEzs=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250618055250epcas5p15320c75e8f4734fa471555600d9ef004~KDT9KVtMg1875218752epcas5p1i;
	Wed, 18 Jun 2025 05:52:50 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.182]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bMXvh4QM9z2SSKw; Wed, 18 Jun
	2025 05:52:48 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250618055218epcas5p13a69c6cbb36108a34379148a4f8d0a20~KDTe2xqUa0262902629epcas5p1S;
	Wed, 18 Jun 2025 05:52:18 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250618055215epsmtip270a800a0d09f720d08a95d921a3fbbdf~KDTcxWJrd3156031560epsmtip2f;
	Wed, 18 Jun 2025 05:52:15 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [PATCH for-next v4 3/4] set pi_offset only when checksum type is
 not BLK_INTEGRITY_CSUM_NONE
Date: Wed, 18 Jun 2025 11:21:52 +0530
Message-Id: <20250618055153.48823-4-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250618055153.48823-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250618055218epcas5p13a69c6cbb36108a34379148a4f8d0a20
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250618055218epcas5p13a69c6cbb36108a34379148a4f8d0a20
References: <20250618055153.48823-1-anuj20.g@samsung.com>
	<CGME20250618055218epcas5p13a69c6cbb36108a34379148a4f8d0a20@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250617_225255_771126_2DB73A5B 
X-CRM114-Status: GOOD (  15.14  )
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

protection information is treated as opaque when checksum type is
BLK_INTEGRITY_CSUM_NONE. In order to maintain the right metadata
semantics, set pi_offset only in cases where checksum type is not
BLK_INTEGRITY_CSUM_NONE.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 drivers/nvme/host/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fe72accab516..806b6e73276d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1867,9 +1867,10 @@ static bool nvme_init_integrity(struct nvme_ns_head *head,
 	}
 
 	bi->metadata_size = head->ms;
-	if (bi->csum_type)
+	if (bi->csum_type) {
 		bi->pi_tuple_size = head->pi_size;
-	bi->pi_offset = info->pi_offset;
+		bi->pi_offset = info->pi_offset;
+	}
 	return true;
 }
 
-- 
2.25.1


