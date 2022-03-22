Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0D8C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Mar 2022 09:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=m7Vm9WT9TQU4kTN7lvkBAYW1/x/ZwaS1FS3Af1pzMR8=; b=GG9ar3CFsfhV1vVCl37vwO3zEp
	GBi+Fc4TMyqRHjag4bZZPLM+38BNlRa+1DlhfnNUiSx5x/x9PZOhushy2wkeoarbeUzbVf2VoHPmv
	VYYaZT/g8Kwr/QeY6wNmJ9N/undPSuVuq2UXYVybP68b+gGF86szNrBCm8jW4y2+CXLyfr3iB2d0s
	+gBn6jPGBgj6lSiD+Xv6Yrs9RfzfzDrrQvHqbE6V4z6k1ylDSyuf/sDFjI0XJs1gzlOTBimrQqPcw
	86c/se3KeVt42zPkDCH4QfSlfXWgeg//ciSR4O5JZs9YKuoaU6qtcSZFh9jZMBTuzSd1BJbt3CoH+
	n4BLdBZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWahL-00AZRE-OJ; Tue, 22 Mar 2022 09:21:03 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWahH-00AZOZ-1P
 for linux-nvme@lists.infradead.org; Tue, 22 Mar 2022 09:21:01 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20220322092054euoutp02c0d8dbec7175c5ca0d378797bbf81525~eqXm-GBXO1642516425euoutp02P
 for <linux-nvme@lists.infradead.org>; Tue, 22 Mar 2022 09:20:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20220322092054euoutp02c0d8dbec7175c5ca0d378797bbf81525~eqXm-GBXO1642516425euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1647940854;
 bh=m7Vm9WT9TQU4kTN7lvkBAYW1/x/ZwaS1FS3Af1pzMR8=;
 h=From:To:Cc:Subject:Date:References:From;
 b=nXck58A967guB6BEmdL9lcfMNtRI4N3DNwEj/QG6k3MagneUUT6JCCD0dZYGvO6Pb
 /Y7uaQXFHVcijs8IWzDqI/aaY+G/Ri1sSEpLPCFe4HnVsdLGq6OUblz8qhddFFf5PT
 OlYzqrTEPjf+rsbMSt3dfSPEWjq6U53pwT1cMp5A=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20220322092053eucas1p12291348e4cf0c109436e464d66a19e3d~eqXmivnTY1018910189eucas1p1Z;
 Tue, 22 Mar 2022 09:20:53 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id A6.AA.09887.5F499326; Tue, 22
 Mar 2022 09:20:53 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20220322092053eucas1p16f2311a54b7c82c47352fca5db6277e6~eqXmDHRuh0902309023eucas1p1c;
 Tue, 22 Mar 2022 09:20:53 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220322092053eusmtrp237c4d6c65e0d658fcadb76d32e375c9e~eqXmCPGbN0491104911eusmtrp2f;
 Tue, 22 Mar 2022 09:20:53 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-86-623994f5b738
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id E7.0B.09522.4F499326; Tue, 22
 Mar 2022 09:20:52 +0000 (GMT)
Received: from localhost (unknown [106.210.248.55]) by eusmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20220322092052eusmtip175713643a77bb0e3c5760bd8a417f8a7~eqXlvykEd0710307103eusmtip1Y;
 Tue, 22 Mar 2022 09:20:52 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>, Keith
 Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, Damien Le Moal <damien.lemoal@opensource.wdc.com>, Jens
 Axboe <axboe@kernel.dk>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Adam Manzanares
 <a.manzanares@samsung.com>, kanchan Joshi <joshi.k@samsung.com>, Johannes
 Thumshirn <johannes.thumshirn@wdc.com>, Pankaj Raghav <pankydev8@gmail.com>,
 Kanchan Joshi <joshiiitr@gmail.com>, linux-nvme@lists.infradead.org, Pankaj
 Raghav <p.raghav@samsung.com>
Subject: [PATCH v3] nvme: Fix zns drives without append support to export
 correct permissions
Date: Tue, 22 Mar 2022 10:20:48 +0100
Message-Id: <20220322092048.81622-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsWy7djPc7pfp1gmGdxulrWYfljRYvXdfjaL
 32fPM1usXH2UyeLxnc/sFn+77jFZHP3/ls3i/NvDTBaTDl1jtJi/7Cm7xY0JTxktPi9tYbdY
 c/Mpi8W61+9ZHPg8ds66y+5x/t5GFo/LZ0s9Nq3qZPPYvKTeY/fNBjaPna33WT36tqxi9Gg/
 0M0UwBnFZZOSmpNZllqkb5fAlXG526/guETF/nUZDYyXRLoYOTkkBEwktt06ytLFyMUhJLCC
 UWL30R4mCOcLo8TDCd1sEM5nRomdjRNZYVpm7fsJVbWcUeLn0rnsEM4LRokX9w4wdzFycLAJ
 aEk0doLFRQR+MUr8a70GNopZ4BCTxK7LD9hBRgkLxEu0rWkFG8sioCox//QnMJtXwFJi3vTd
 LBDr5CVmXvrODhEXlDg58wlYnBko3rx1NjPIUAmBDxwSn/Y+Y4docJGYcKeTCcIWlnh1fAtU
 XEbi/875TBAN/YwSU1v+QDkzGCV6Dm9mArlbQsBaou9MDojJLKApsX6XPkSvo8SmOwvZICr4
 JG68FYS4gU9i0rbpzBBhXomONiGIaiWJnT+fQG2VkLjcNAfqFQ+JO+vOgF0mJBArcfvBLuYJ
 jAqzkHw2C8lnsxBuWMDIvIpRPLW0ODc9tdgoL7Vcrzgxt7g0L10vOT93EyMwqZ3+d/zLDsbl
 rz7qHWJk4mA8xCjBwawkwrv4g3mSEG9KYmVValF+fFFpTmrxIUZpDhYlcd7kzA2JQgLpiSWp
 2ampBalFMFkmDk6pBqaK0M8To5iefVkuNuH/xg6l3s7excFzJivwHDhu3WEjs4DJ1OP76lA/
 J4azz6sqvvOFbc58ZWCsKaPGcX2NX5ygH6t0+ze+ebbKuqIXXO5rH5g862TtxACpDNvqM0ci
 j9bcZV150bXaqfF5lq3px07rHbmn5u11esoatMV8YdvNKdauoZsOLSheVZCiUbK7pbjI4afV
 w56Li+qOHA50KmKV3+gxR9Kmbd/qGU2ifeGVkxUYk2Y9/Kmb1Z8u7W6lurfQ/4X/31UzPvdc
 58tgXtDRuyrjbtqus1eyJ4bIXn1coeO1M6XmxszGafOWKx2w39gWvSRs1eMmfWfJuNKsaSZH
 VK4mq5j9WHBwOeONiUosxRmJhlrMRcWJALxQJuLZAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xu7pfplgmGVxqsLKYfljRYvXdfjaL
 32fPM1usXH2UyeLxnc/sFn+77jFZHP3/ls3i/NvDTBaTDl1jtJi/7Cm7xY0JTxktPi9tYbdY
 c/Mpi8W61+9ZHPg8ds66y+5x/t5GFo/LZ0s9Nq3qZPPYvKTeY/fNBjaPna33WT36tqxi9Gg/
 0M0UwBmlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5eg
 l3G526/guETF/nUZDYyXRLoYOTkkBEwkZu37ydTFyMUhJLCUUWLJ0ydsEAkJidsLmxghbGGJ
 P9e62CCKnjFK7PyylKWLkYODTUBLorGTHSQuIvCPUeJtywMWEIdZ4ASTxIRbh8C6hQViJaau
 2cwMYrMIqErMP/2JFcTmFbCUmDd9NwvEBnmJmZe+s0PEBSVOznwCFmcGijdvnc08gZFvFpLU
 LCSpBYxMqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQKjaduxn5t3MM579VHvECMTB+MhRgkO
 ZiUR3sUfzJOEeFMSK6tSi/Lji0pzUosPMZoC3TeRWUo0OR8Yz3kl8YZmBqaGJmaWBqaWZsZK
 4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUwaSx2KE6d+j1CszLj06eeE3Rd0pd2mv5p7/Kab
 yJnQijsi8Xu7/llHR1XFHXRQnnhW8PVjcZFdL2rE1OzDu9SSVymvkFHb7y69NiRtdfzDzZ3L
 9nQ/ljovkH7yftSsO2Jl1w+qbWXy5CpZYhIRm/LP8PkEr+mViQKKEUnBgZq62hPf3Tqu4rb7
 xf14vaWqvtbceyua511tN930KG3Fx88C/x7UKTxwF+GbuphbeukZrt1rc9a+ermy9k5o98ft
 2rKcaqI5nyXWzepWsDT9u5Mv4DhHxrkcLunug14VVlFsepPi8nd8vL9Q68rUjRk5Rle6z85L
 mZV4Q69Oeo/XhalCUYzPG//sDlvDkOn2+IwSS3FGoqEWc1FxIgB4QxkvLwMAAA==
X-CMS-MailID: 20220322092053eucas1p16f2311a54b7c82c47352fca5db6277e6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220322092053eucas1p16f2311a54b7c82c47352fca5db6277e6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220322092053eucas1p16f2311a54b7c82c47352fca5db6277e6
References: <CGME20220322092053eucas1p16f2311a54b7c82c47352fca5db6277e6@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220322_022059_559038_E44F1FB1 
X-CRM114-Status: GOOD (  17.22  )
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

This commit 2f4c9ba23b88 ("nvme: export zoned namespaces without Zone
Append support read-only") exported zoned namespaces without append support
to be marked as ro. It does it by setting NVME_NS_FORCE_RO to the
ns->flags in nvme_update_zone_info and later nvme_update_disk_info will
check for this flag and set the disk as ro.

But later this commit 73d90386b559 ("nvme: cleanup zone information
initialization") rearranged nvme_update_disk_info to be called before
nvme_update_zone_info thereby not marking the disk as ro. The call order
cannot be just reverted because nvme_update_zone_info sets certain queue
parameters such as zone_write_granularity that depend on the prior call
to nvme_update_disk_info.

Remove the call to set_disk_ro in nvme_update_disk_info.
Call set_disk_ro after nvme_update_zone_info and nvme_update_disk_info
to set the permission for ZNS drives correctly. The same applies to the
multipath disk path.

Fixes: 73d90386b559 ("nvme: cleanup zone information initialization")
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
Changes since v1:
- Add a new helper to set permission directly from nvme_update_zone_info
  instead of calling nvme_update_disk_info again (Damien)

Changes since v2
- Adding a new call to set_disk_ro in nvme_update_zone_info will create
  a race window, and set the disk to write if all Zone requirements are
  satisfied even when id->nsattr has ro bit set. Call set_disk_ro
  directly after the calls to nvme_update_disk_info and
  nvme_update_zone_info to avoid incorrect behaviour. (Christoph)

- Open code the call to set_disk_ro as there are no other
  users(Chaitanya and Christoph)

 drivers/nvme/host/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 677fa4bf76d3..75c9c4fa9049 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1830,9 +1830,6 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	nvme_config_discard(disk, ns);
 	blk_queue_max_write_zeroes_sectors(disk->queue,
 					   ns->ctrl->max_zeroes_sectors);
-
-	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO) ||
-		test_bit(NVME_NS_FORCE_RO, &ns->flags));
 }
 
 static inline bool nvme_first_scan(struct gendisk *disk)
@@ -1891,6 +1888,8 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 			goto out_unfreeze;
 	}
 
+	set_disk_ro(ns->disk, (id->nsattr & NVME_NS_ATTR_RO) ||
+		test_bit(NVME_NS_FORCE_RO, &ns->flags));
 	set_bit(NVME_NS_READY, &ns->flags);
 	blk_mq_unfreeze_queue(ns->disk->queue);
 
@@ -1903,6 +1902,9 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 	if (nvme_ns_head_multipath(ns->head)) {
 		blk_mq_freeze_queue(ns->head->disk->queue);
 		nvme_update_disk_info(ns->head->disk, ns, id);
+		set_disk_ro(ns->head->disk,
+			    (id->nsattr & NVME_NS_ATTR_RO) ||
+				    test_bit(NVME_NS_FORCE_RO, &ns->flags));
 		nvme_mpath_revalidate_paths(ns);
 		blk_stack_limits(&ns->head->disk->queue->limits,
 				 &ns->queue->limits, 0);
-- 
2.25.1


