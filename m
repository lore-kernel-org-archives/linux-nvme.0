Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F728C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 10:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QqPz2OWxGMD8uCb8jReBS97cNwDJ8EJVxZGORNAnUdo=; b=sPr3k3hVNL8QDZ5cjrt1pyZvEd
	/BAeBwjjDKsevgNvTPN2v4NDOa04jYOlClePPteRihASKmMev0RU49YUMPP3SD4fRNpfG3Fqldvr1
	QtLAg5p8sw0994gkdgVHIWI1jvRCD9OuLSTzW7la8nwd4G5V9JvwnruuTnBTD8HU52gl9u+5hhNjj
	5Pz/SP+WIcLoh8D9Juz9RJfbUchSPPtbnQxgQjBwT6Gi/xZ94oeJ+zVEatm12JZioBxnP7Uchuy82
	uNAWU1FbKKW4mmVzexJSQunkxBxx9861rqR9LS1c60fqbBJeBGtS7o8DQ+eCardWo+fZkMcd2UHsy
	jVWplbMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1QDn-00DopJ-86; Wed, 15 Jun 2022 10:25:59 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Q8E-00DmZW-OL
	for linux-nvme@lists.infradead.org; Wed, 15 Jun 2022 10:20:17 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220615102013euoutp018a8562712ab3872c1a0fd03e5c31cd50~4xAq-yFpo2579825798euoutp01f
	for <linux-nvme@lists.infradead.org>; Wed, 15 Jun 2022 10:20:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220615102013euoutp018a8562712ab3872c1a0fd03e5c31cd50~4xAq-yFpo2579825798euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1655288413;
	bh=QqPz2OWxGMD8uCb8jReBS97cNwDJ8EJVxZGORNAnUdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iLL5b2vtEgRJs2TbtMn9Tfo2u6mfRMBjIEUbDaAVM8O2ra6qhVb8CN7i92Syp285T
	 1tB3K29ZU3LEKvLqDz4oLxcPTQx1IpMHw1YactdVZmnKeExd01JhV71AzixJek0QV2
	 WGG578YKOhha7MRRlh8xxpC1DqdlyjjP/gd4eV8Y=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220615102011eucas1p27927ddf4d6c43741b27aa5073cb46fc2~4xApc1BVV1912519125eucas1p2M;
	Wed, 15 Jun 2022 10:20:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 10.5B.09664.B52B9A26; Wed, 15
	Jun 2022 11:20:11 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220615102011eucas1p220368db4a186181b1927dea50a79e5d4~4xAo7795N0710507105eucas1p2s;
	Wed, 15 Jun 2022 10:20:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220615102011eusmtrp2227b720bc5fb53cd1c83b1d6c4bc4bce~4xAo6uDdB0361403614eusmtrp2W;
	Wed, 15 Jun 2022 10:20:11 +0000 (GMT)
X-AuditID: cbfec7f2-d81ff700000025c0-4c-62a9b25bf383
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 2A.65.09095.B52B9A26; Wed, 15
	Jun 2022 11:20:11 +0100 (BST)
Received: from localhost (unknown [106.210.248.244]) by eusmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20220615102010eusmtip2dbad86de53e6f9e7136701b3cc5cabba~4xAnvRvtz0472904729eusmtip2g;
	Wed, 15 Jun 2022 10:20:09 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: hch@lst.de, snitzer@redhat.com, damien.lemoal@opensource.wdc.com,
	axboe@kernel.dk
Cc: bvanassche@acm.org, linux-kernel@vger.kernel.org,
	jiangbo.365@bytedance.com, hare@suse.de, pankydev8@gmail.com,
	dm-devel@redhat.com, jonathan.derrick@linux.dev, gost.dev@samsung.com,
	dsterba@suse.com, jaegeuk@kernel.org, linux-nvme@lists.infradead.org,
	Johannes.Thumshirn@wdc.com, linux-block@vger.kernel.org, Pankaj Raghav
	<p.raghav@samsung.com>, Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v7 13/13] dm: add non power of 2 zoned target
Date: Wed, 15 Jun 2022 12:19:20 +0200
Message-Id: <20220615101920.329421-14-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615101920.329421-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJKsWRmVeSWpSXmKPExsWy7djP87rRm1YmGezfr2mx+m4/m8W0Dz+Z
	LX6fPc9s0dr+jcli77vZrBYXfjQyWdw8sJPJYs+iSUwWK1cfZbJ4sn4Ws0XPgQ8sFn+77gHF
	Wh4yW+y9pW1xedccNov5y56yW3xe2sJusebmUxaLto1fGR2EPS5f8fb4d2INm8fOWXfZPS6f
	LfXYtKqTzWNhw1Rmj81L6j1232wAyrXeZ/V4v+8qm0ffllWMHuu3XGXx2Hy62uPzJjmP9gPd
	TAH8UVw2Kak5mWWpRfp2CVwZvV3rmAo6oyvObWplaWDc4NXFyMkhIWAicfrNfcYuRi4OIYEV
	jBJfdjezQThfGCX+n21kgXA+M0p0z73MCNNyaflpJojEckaJGU8WQzkvGSWmXf8I1MLBwSag
	JdHYyQ7SICIQLnF0zz2wGmaBw8wSt1d2gyWEBWwlNm59xAZiswioSmw884QFxOYVsJY48/M/
	O8Q2eYmZl76D2ZxA8R2ze1ghagQlTs6EqGcGqmneOpsZov4Sp8Smbh0I20Vi3q0DLBC2sMSr
	41ugZspI/N85nwnCrpZ4euM3M8hxEgItjBL9O9ezgTwgAbSs70wOiMksoCmxfpc+RLmjxKqW
	J4wQFXwSN94KQlzAJzFp23RmiDCvREebEES1ksTOn0+glkpIXG6aA3WMh8Sp80uYJjAqzkLy
	yywkv8xC2LuAkXkVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYOo8/e/4px2Mc1991DvE
	yMTBeIhRgoNZSYTXLHhlkhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe5MwNiUIC6YklqdmpqQWp
	RTBZJg5OqQYm5tgIo21fbAsyVdVWneL4rdvJZfjyyJ4C9y/FTq8PxW1mkU232jmb62+i4Uae
	M88rts3ZsHSTglpKrcoi3+tOurca8qys1IoTc+6fWnmovyfo1M/p+90TObX4Et3mb/zhdPE/
	468L3n/zZry7e3/Xjhu21ZL8CjcetwvPv8k3dcEm9rJZqbk7v4tVBIefXT55TsbVT78FbE6d
	6LOYm+Mo+KAk6HvYiQXzt//R1bE5KLMvSTjKrZu7z/xzuvcuzk+nJVfw6zpddOv/qMfEF/K3
	Mdk3Y+nua34bym+0zjq8YGNllka6Yv1bo8MOX17x3FWtXzXPaML3kEXBHNPSk2b0PCjn/pLh
	xCi2qpfH8PZOJZbijERDLeai4kQAT3SOQAwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsVy+t/xe7rRm1YmGcx5xmax+m4/m8W0Dz+Z
	LX6fPc9s0dr+jcli77vZrBYXfjQyWdw8sJPJYs+iSUwWK1cfZbJ4sn4Ws0XPgQ8sFn+77gHF
	Wh4yW+y9pW1xedccNov5y56yW3xe2sJusebmUxaLto1fGR2EPS5f8fb4d2INm8fOWXfZPS6f
	LfXYtKqTzWNhw1Rmj81L6j1232wAyrXeZ/V4v+8qm0ffllWMHuu3XGXx2Hy62uPzJjmP9gPd
	TAH8UXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZ
	vV3rmAo6oyvObWplaWDc4NXFyMkhIWAicWn5aaYuRi4OIYGljBKLXneyQCQkJG4vbGKEsIUl
	/lzrYgOxhQSeM0ocmS7axcjBwSagJdHYyQ4SFhGIlui8+Z4NZA6zwFVmie8N85hBEsICthIb
	tz4C62URUJXYeOYJ2HxeAWuJMz//s0PMl5eYeek7mM0JFN8xu4cVZL6QgJXErnfxEOWCEidn
	QrQyA5U3b53NPIFRYBaS1CwkqQWMTKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECY3zbsZ+b
	dzDOe/VR7xAjEwfjIUYJDmYlEV6z4JVJQrwpiZVVqUX58UWlOanFhxhNgc6eyCwlmpwPTDJ5
	JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1MLusnXT7wbF+fdX9z
	bOnsuTFXu3c7rQkRVUkTvBvSKJ7DveVO0Zm9Z6Yq28vtPDnvtqqLQcUkMT1LjhfnbaZ4CnF0
	ZZ+YuOCf8iqJU1EelhXvZta28v4+m3VbhHlS3xH2rsu5SvoWHQF9lzzkNzGVFk7gij+8Lt9S
	/UuK0GcNg9snWh4KJH9lP3Ne/ajFvl+JjUznE7+5z14jcS3pZYltaruhfeC21umzY2/29fba
	7+9a/8R3bt6eEBsZl4k9O6vuq57dOPcnO6/uTjb7J5sa86sbul6XK1f9Loq+Y/ezKPKdn6/V
	xd6jfW/Ot+/Zrb7ewDXVMDF+7/TzAfGvLjk9/BHp8vTx7hX1lTkJ5dFKLMUZiYZazEXFiQDr
	6t5jegMAAA==
X-CMS-MailID: 20220615102011eucas1p220368db4a186181b1927dea50a79e5d4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220615102011eucas1p220368db4a186181b1927dea50a79e5d4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220615102011eucas1p220368db4a186181b1927dea50a79e5d4
References: <20220615101920.329421-1-p.raghav@samsung.com>
	<CGME20220615102011eucas1p220368db4a186181b1927dea50a79e5d4@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_032015_160223_07299317 
X-CRM114-Status: GOOD (  28.83  )
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

Only power of 2(po2) zoned devices were supported in linux but now non
power of 2(npo2) zoned device support has been added to the block layer.

Filesystems such as F2FS and btrfs have support for zoned devices with
po2 zone size assumption. Before adding native support for npo2 zoned
devices, it was suggested to create a dm target for npo2 zoned device to
appear as po2 device so that file systems can initially work without any
explicit changes by using this target.

The design of this target is very simple: introduce gaps between the zone
capacity and the po2 zone size of the underlying device. All IOs will be
remapped from target to the actual device location. For devices that use
zone append, the bi_sector is remapped from device to target's layout.

The read IOs that fall in the "emulated" gap area will return 0 and all
the other IOs in that area will result in an error. If an read IO span
across the zone capacity boundary, then the IOs are split between the
boundary. All other IO operations that span across a zone capacity
boundary will result in an error.

The target can be easily updated as follows:
dmsetup create <label> --table '0 <size_sects> zoned-npo2 /dev/nvme<id>'

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Suggested-by: Damien Le Moal <damien.lemoal@wdc.com>
Suggested-by: Hannes Reinecke <hare@suse.de>
---
 drivers/md/Kconfig                |   9 +
 drivers/md/Makefile               |   2 +
 drivers/md/dm-zone.c              |   9 +
 drivers/md/dm-zoned-npo2-target.c | 268 ++++++++++++++++++++++++++++++
 4 files changed, 288 insertions(+)
 create mode 100644 drivers/md/dm-zoned-npo2-target.c

diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index 998a5cfdb..773314536 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -518,6 +518,15 @@ config DM_FLAKEY
 	help
 	 A target that intermittently fails I/O for debugging purposes.
 
+config DM_ZONED_NPO2
+	tristate "Zoned non power of 2 target"
+	depends on BLK_DEV_DM
+	depends on BLK_DEV_ZONED
+	help
+	A target that converts a zoned device with non power of 2 zone size to
+	be power of 2. This is done by introducing gaps in between the zone
+	capacity and the power of 2 zone size.
+
 config DM_VERITY
 	tristate "Verity target support"
 	depends on BLK_DEV_DM
diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index 0454b0885..2863a94a7 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -26,6 +26,7 @@ dm-era-y	+= dm-era-target.o
 dm-clone-y	+= dm-clone-target.o dm-clone-metadata.o
 dm-verity-y	+= dm-verity-target.o
 dm-zoned-y	+= dm-zoned-target.o dm-zoned-metadata.o dm-zoned-reclaim.o
+dm-zoned-npo2-y       += dm-zoned-npo2-target.o
 
 md-mod-y	+= md.o md-bitmap.o
 raid456-y	+= raid5.o raid5-cache.o raid5-ppl.o
@@ -60,6 +61,7 @@ obj-$(CONFIG_DM_CRYPT)		+= dm-crypt.o
 obj-$(CONFIG_DM_DELAY)		+= dm-delay.o
 obj-$(CONFIG_DM_DUST)		+= dm-dust.o
 obj-$(CONFIG_DM_FLAKEY)		+= dm-flakey.o
+obj-$(CONFIG_DM_ZONED_NPO2)	+= dm-zoned-npo2.o
 obj-$(CONFIG_DM_MULTIPATH)	+= dm-multipath.o dm-round-robin.o
 obj-$(CONFIG_DM_MULTIPATH_QL)	+= dm-queue-length.o
 obj-$(CONFIG_DM_MULTIPATH_ST)	+= dm-service-time.o
diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index af36d33f9..5efb31ba0 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -210,6 +210,11 @@ static int dm_zone_revalidate_cb(struct blk_zone *zone, unsigned int idx,
 		}
 		md->zwp_offset[idx] = dm_get_zone_wp_offset(zone);
 
+		if (q->limits.chunk_sectors != zone->len) {
+			blk_queue_chunk_sectors(q, zone->len);
+			q->nr_zones = blkdev_nr_zones(md->disk);
+		}
+
 		break;
 	default:
 		DMERR("Invalid zone type 0x%x at sectors %llu",
@@ -307,6 +312,9 @@ int dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q)
 	if (dm_table_supports_zone_append(t)) {
 		clear_bit(DMF_EMULATE_ZONE_APPEND, &md->flags);
 		dm_cleanup_zoned_dev(md);
+
+		if (!is_power_of_2(blk_queue_zone_sectors(q)))
+			goto revalidate_zones;
 		return 0;
 	}
 
@@ -318,6 +326,7 @@ int dm_set_zones_restrictions(struct dm_table *t, struct request_queue *q)
 	if (!get_capacity(md->disk))
 		return 0;
 
+revalidate_zones:
 	return dm_revalidate_zones(md, t);
 }
 
diff --git a/drivers/md/dm-zoned-npo2-target.c b/drivers/md/dm-zoned-npo2-target.c
new file mode 100644
index 000000000..c1373d3ea
--- /dev/null
+++ b/drivers/md/dm-zoned-npo2-target.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Samsung Electronics Co., Ltd.
+ */
+
+#include <linux/device-mapper.h>
+
+#define DM_MSG_PREFIX "zoned-npo2"
+
+struct dmz_npo2_target {
+	struct dm_dev *dev;
+	sector_t zsze;
+	sector_t zsze_po2;
+	sector_t zsze_diff;
+	u32 nr_zones;
+};
+
+enum dmz_npo2_io_cond {
+	DMZ_NPO2_IO_INSIDE_ZONE,
+	DMZ_NPO2_IO_ACROSS_ZONE,
+	DMZ_NPO2_IO_OUTSIDE_ZONE,
+};
+
+static inline u32 npo2_zone_no(struct dmz_npo2_target *dmh, sector_t sect)
+{
+	return div64_u64(sect, dmh->zsze);
+}
+
+static inline u32 po2_zone_no(struct dmz_npo2_target *dmh, sector_t sect)
+{
+	return sect >> ilog2(dmh->zsze_po2);
+}
+
+static inline sector_t target_to_device_sect(struct dmz_npo2_target *dmh,
+					     sector_t sect)
+{
+	u32 zone_idx = po2_zone_no(dmh, sect);
+
+	sect -= (zone_idx * dmh->zsze_diff);
+
+	return sect;
+}
+
+static inline sector_t device_to_target_sect(struct dmz_npo2_target *dmh,
+					     sector_t sect)
+{
+	u32 zone_idx = npo2_zone_no(dmh, sect);
+
+	sect += (zone_idx * dmh->zsze_diff);
+
+	return sect;
+}
+
+/*
+ * <dev-path>
+ * This target works on the complete zoned device. Partial mapping is not
+ * supported
+ */
+static int dmz_npo2_ctr(struct dm_target *ti, unsigned int argc, char **argv)
+{
+	struct dmz_npo2_target *dmh = NULL;
+	int ret = 0;
+	sector_t zsze;
+	sector_t disk_size;
+
+	if (argc < 1)
+		return -EINVAL;
+
+	dmh = kmalloc(sizeof(*dmh), GFP_KERNEL);
+	if (!dmh)
+		return -ENOMEM;
+
+	ret = dm_get_device(ti, argv[0], dm_table_get_mode(ti->table),
+			    &dmh->dev);
+
+	zsze = blk_queue_zone_sectors(bdev_get_queue(dmh->dev->bdev));
+
+	disk_size = get_capacity(dmh->dev->bdev->bd_disk);
+
+	if (ti->len != disk_size || ti->begin) {
+		DMERR("%pg Partial mapping of the target not supported",
+		      dmh->dev->bdev);
+		return -EINVAL;
+	}
+
+	if (is_power_of_2(zsze)) {
+		DMERR("%pg zone size is power of 2", dmh->dev->bdev);
+		return -EINVAL;
+	}
+
+	dmh->zsze = zsze;
+	dmh->zsze_po2 = 1 << get_count_order_long(zsze);
+	dmh->zsze_diff = dmh->zsze_po2 - dmh->zsze;
+
+	ti->private = dmh;
+	ti->num_flush_bios = 1;
+	ti->num_discard_bios = 1;
+	ti->num_secure_erase_bios = 1;
+	ti->num_write_zeroes_bios = 1;
+
+	dmh->nr_zones = npo2_zone_no(dmh, ti->len);
+	ti->len = dmh->zsze_po2 * dmh->nr_zones;
+
+	return 0;
+}
+
+static int dmz_npo2_report_zones_cb(struct blk_zone *zone, unsigned int idx,
+				    void *data)
+{
+	struct dm_report_zones_args *args = data;
+	struct dmz_npo2_target *dmh = args->tgt->private;
+
+	zone->start = device_to_target_sect(dmh, zone->start);
+	zone->wp = device_to_target_sect(dmh, zone->wp);
+	zone->len = dmh->zsze_po2;
+	args->next_sector = zone->start + zone->len;
+
+	return args->orig_cb(zone, args->zone_idx++, args->orig_data);
+}
+
+static int dmz_npo2_report_zones(struct dm_target *ti,
+				 struct dm_report_zones_args *args,
+				 unsigned int nr_zones)
+{
+	struct dmz_npo2_target *dmh = ti->private;
+	int ret = 0;
+	sector_t sect = po2_zone_no(dmh, args->next_sector) * dmh->zsze;
+
+	ret = blkdev_report_zones(dmh->dev->bdev, sect, nr_zones,
+				  dmz_npo2_report_zones_cb, args);
+	if (ret < 0)
+		DMERR("report zones error");
+
+	return ret;
+}
+
+static int check_zone_boundary_violation(struct dmz_npo2_target *dmh,
+					 sector_t sect, sector_t size)
+{
+	u32 zone_idx = po2_zone_no(dmh, sect);
+	sector_t relative_sect = 0;
+
+	sect = target_to_device_sect(dmh, sect);
+	relative_sect = sect - (zone_idx * dmh->zsze);
+
+	if ((relative_sect + size) <= dmh->zsze)
+		return DMZ_NPO2_IO_INSIDE_ZONE;
+	else if (relative_sect >= dmh->zsze)
+		return DMZ_NPO2_IO_OUTSIDE_ZONE;
+
+	return DMZ_NPO2_IO_ACROSS_ZONE;
+}
+
+static void split_io_across_zone_boundary(struct dmz_npo2_target *dmh,
+					  struct bio *bio)
+{
+	sector_t sect = bio->bi_iter.bi_sector;
+	sector_t sects_from_zone_start;
+
+	sect = target_to_device_sect(dmh, sect);
+	div64_u64_rem(sect, dmh->zsze, &sects_from_zone_start);
+	dm_accept_partial_bio(bio, dmh->zsze - sects_from_zone_start);
+	bio->bi_iter.bi_sector = sect;
+}
+
+static int handle_zone_boundary_violation(struct dmz_npo2_target *dmh,
+					  struct bio *bio,
+					  enum dmz_npo2_io_cond cond)
+{
+	/* Read should return zeroed page */
+	if (bio_op(bio) == REQ_OP_READ) {
+		if (cond == DMZ_NPO2_IO_ACROSS_ZONE) {
+			split_io_across_zone_boundary(dmh, bio);
+			return DM_MAPIO_REMAPPED;
+		}
+		zero_fill_bio(bio);
+		bio_endio(bio);
+		return DM_MAPIO_SUBMITTED;
+	}
+	return DM_MAPIO_KILL;
+}
+
+static int dmz_npo2_end_io(struct dm_target *ti, struct bio *bio,
+			   blk_status_t *error)
+{
+	struct dmz_npo2_target *dmh = ti->private;
+
+	if (bio->bi_status == BLK_STS_OK && bio_op(bio) == REQ_OP_ZONE_APPEND)
+		bio->bi_iter.bi_sector =
+			device_to_target_sect(dmh, bio->bi_iter.bi_sector);
+
+	return DM_ENDIO_DONE;
+}
+
+static int dmz_npo2_map(struct dm_target *ti, struct bio *bio)
+{
+	struct dmz_npo2_target *dmh = ti->private;
+	enum dmz_npo2_io_cond cond;
+
+	bio_set_dev(bio, dmh->dev->bdev);
+	if (bio_sectors(bio) || op_is_zone_mgmt(bio_op(bio))) {
+		cond = check_zone_boundary_violation(dmh, bio->bi_iter.bi_sector,
+						     bio->bi_iter.bi_size >> SECTOR_SHIFT);
+
+		/*
+		 * If the starting sector is in the emulated area then fill
+		 * all the bio with zeros. If bio is across boundaries,
+		 * split the bio across boundaries and fill zeros only for the
+		 * bio that is outside the zone capacity
+		 */
+		switch (cond) {
+		case DMZ_NPO2_IO_INSIDE_ZONE:
+			bio->bi_iter.bi_sector = target_to_device_sect(dmh,
+								       bio->bi_iter.bi_sector);
+			break;
+		case DMZ_NPO2_IO_ACROSS_ZONE:
+		case DMZ_NPO2_IO_OUTSIDE_ZONE:
+			return handle_zone_boundary_violation(dmh, bio, cond);
+		}
+	}
+	return DM_MAPIO_REMAPPED;
+}
+
+static int dmz_npo2_iterate_devices(struct dm_target *ti,
+				    iterate_devices_callout_fn fn, void *data)
+{
+	struct dmz_npo2_target *dmh = ti->private;
+	sector_t len = 0;
+
+	len = dmh->nr_zones * dmh->zsze;
+	return fn(ti, dmh->dev, 0, len, data);
+}
+
+static struct target_type dmz_npo2_target = {
+	.name = "zoned-npo2",
+	.version = { 1, 0, 0 },
+	.features = DM_TARGET_ZONED_HM,
+	.map = dmz_npo2_map,
+	.end_io = dmz_npo2_end_io,
+	.report_zones = dmz_npo2_report_zones,
+	.iterate_devices = dmz_npo2_iterate_devices,
+	.module = THIS_MODULE,
+	.ctr = dmz_npo2_ctr,
+};
+
+static int __init dmz_npo2_init(void)
+{
+	int r = dm_register_target(&dmz_npo2_target);
+
+	if (r < 0)
+		DMERR("register failed %d", r);
+
+	return r;
+}
+
+static void __exit dmz_npo2_exit(void)
+{
+	dm_unregister_target(&dmz_npo2_target);
+}
+
+/* Module hooks */
+module_init(dmz_npo2_init);
+module_exit(dmz_npo2_exit);
+
+MODULE_DESCRIPTION(DM_NAME " non power 2 zoned target");
+MODULE_AUTHOR("Pankaj Raghav <p.raghav@samsung.com>");
+MODULE_LICENSE("GPL");
+
-- 
2.25.1


