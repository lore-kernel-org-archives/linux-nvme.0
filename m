Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7A8C7EE39
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jun 2025 09:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QaGuEMvkKlwN1ihT1o08PdW/fRKP7gO6quxDhwV3Up4=; b=4JOQss4VccMsEC0HH5T2wI/C58
	+sQtVV9od5bmy6vqifd4/h7w8OTV0lHTZZyz69N5EmhwnW7H3kn3WNQlHmxotZLBfqeRO0xhDXIM9
	IYe4iFPMel8qD6m/N+tN++L1qMkTTjj4NPPP0B83UENSgabPNOZi45AYIvQSua0TbY6eCkzS4eTZg
	Z1rMQ8Z5LPN/WDX2ubvOq+NBvea/BxrHnhfvGcl4cghgwpWD4M9UjOGaDJzLapuD/nIEJvHOL85GK
	da+9dh+pJrRYQz15fPNh++f44n1O7S9egynKKjwBt62MiptSyCCce9Ii/kqmeScD5Nbk7WRniEPaP
	ic9s773A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWAVW-00000001hfu-2O1B;
	Mon, 30 Jun 2025 09:08:58 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWAVT-00000001hd4-2bxU
	for linux-nvme@lists.infradead.org;
	Mon, 30 Jun 2025 09:08:56 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250630090853epoutp027520e2200897d7a59fdd28bfc987ba0f~NxujxJcHQ0816208162epoutp02b
	for <linux-nvme@lists.infradead.org>; Mon, 30 Jun 2025 09:08:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250630090853epoutp027520e2200897d7a59fdd28bfc987ba0f~NxujxJcHQ0816208162epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751274533;
	bh=QaGuEMvkKlwN1ihT1o08PdW/fRKP7gO6quxDhwV3Up4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XI9hQOMD5txMojDNVEG0NAI/Tdnp4uMFNIG6Npw49xiF152nHRoHhp9WPc8pswoMF
	 YAr8PyPJ2WTgoi27FBZhNUxvzwf6fG3I+i9H73UuiJmj1BT511e+NLJ/KyIYgcGoj3
	 1XRjnfqh996fMidldKQNpySyEJR/c3ZBR+fEA1Oc=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250630090853epcas5p1360ee3b7344287ef895816d6562b1bc0~NxujSI1nJ2452924529epcas5p1_;
	Mon, 30 Jun 2025 09:08:53 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.178]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4bW0hM5ljyz3hhT7; Mon, 30 Jun
	2025 09:08:51 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250630090614epcas5p383dde7cef99658083e2ff520f6fac994~NxsO7Wrgv0768807688epcas5p3n;
	Mon, 30 Jun 2025 09:06:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250630090611epsmtip28622666e788ca5dc32705c76f0d8b72b~NxsMuP0-51089210892epsmtip22;
	Mon, 30 Jun 2025 09:06:11 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH for-next v5 3/4] nvme: set pi_offset only when checksum type
 is not BLK_INTEGRITY_CSUM_NONE
Date: Mon, 30 Jun 2025 14:35:47 +0530
Message-Id: <20250630090548.3317-4-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250630090548.3317-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250630090614epcas5p383dde7cef99658083e2ff520f6fac994
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250630090614epcas5p383dde7cef99658083e2ff520f6fac994
References: <20250630090548.3317-1-anuj20.g@samsung.com>
	<CGME20250630090614epcas5p383dde7cef99658083e2ff520f6fac994@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250630_020855_812306_944DE8B4 
X-CRM114-Status: GOOD (  13.85  )
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/nvme/host/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 685dea0f23a3..500a9e82d60e 100644
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


