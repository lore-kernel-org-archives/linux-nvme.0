Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F841C4332F
	for <linux-nvme@archiver.kernel.org>; Fri,  6 May 2022 08:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lp2K3w6bYU/ZGZyfjOrT9sOG4NQYsIr+x+HLsdgsemk=; b=O0hfFE+ohyL2fft0ZL4xcLmPTV
	yewsWdilkFeG9vi4KTjyph5XKF+DxW/ssXOG4jYO0BNcDMJQP+XAIDSo/tp9jiMnqMo3thzV+hxj/
	Zh5ULKwdCcClDASBYiSbnNvDk4PAfuANv6ZAaMtFDMYaIce7VuryH0bGXdinecf3AQrF1ak9t0+Uk
	WorYZOny3/cVXTF7HLsc8gLo21dxwedk5VxTd7gJeD/K7c5NxIXt4FLwL1fLHOU1GKt92FqK7V213
	BN6SZWJFrHfB1cYOozJC9Vj/km4D5M880be9Oy8t/Jbix//YK4qCRk8CsByc+qahbVLLlMZjiKpRn
	FOWuMALQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmt3b-001ygq-Tb; Fri, 06 May 2022 08:11:23 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmt3X-001yc0-Pj
 for linux-nvme@lists.infradead.org; Fri, 06 May 2022 08:11:22 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20220506081109euoutp0165a7cc9a1182118196bfba6ecfea8786~sdckXr-HT2197721977euoutp01J
 for <linux-nvme@lists.infradead.org>; Fri,  6 May 2022 08:11:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20220506081109euoutp0165a7cc9a1182118196bfba6ecfea8786~sdckXr-HT2197721977euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1651824669;
 bh=lp2K3w6bYU/ZGZyfjOrT9sOG4NQYsIr+x+HLsdgsemk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aNqpMcogpuc5tfjjjLNuumV8GNg/Uw45SkvvNu1yO+WLh27yrexjjm3JPywU1zzTa
 dZaDfSDCq9aU67A6cp3UxE6QZOjVQ0MvwrJt9kJn92c9ifhXuqVWrS+u17WqbRhAON
 AWBDt5RBGCHgY8QQiQpnpohiLsQ4mQ2ncUbeVb+4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20220506081108eucas1p157bd0b3e2c1c9e95cb15481355714182~sdcioadXK1692416924eucas1p1u;
 Fri,  6 May 2022 08:11:08 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 93.3C.10260.B18D4726; Fri,  6
 May 2022 09:11:07 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20220506081107eucas1p1070e00b208e00090c235017435be1593~sdciCeg161979919799eucas1p1f;
 Fri,  6 May 2022 08:11:07 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220506081107eusmtrp2f9facb08d5d065dc059e123c7ff68edc~sdch_Ke7I2593625936eusmtrp2Q;
 Fri,  6 May 2022 08:11:07 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-cf-6274d81b13d3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id AA.E9.09404.B18D4726; Fri,  6
 May 2022 09:11:07 +0100 (BST)
Received: from localhost (unknown [106.210.248.174]) by eusmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20220506081106eusmtip18f256f486b1f42e6f968c5b64f6e9360~sdchn8WJL0467104671eusmtip1n;
 Fri,  6 May 2022 08:11:06 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: jaegeuk@kernel.org, hare@suse.de, dsterba@suse.com, axboe@kernel.dk,
 hch@lst.de, damien.lemoal@opensource.wdc.com, snitzer@kernel.org
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 bvanassche@acm.org, linux-fsdevel@vger.kernel.org, matias.bjorling@wdc.com,
 Jens Axboe <axboe@fb.com>, gost.dev@samsung.com, jonathan.derrick@linux.dev,
 jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
 dm-devel@redhat.com, Naohiro Aota <naohiro.aota@wdc.com>,
 linux-kernel@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>, Alasdair Kergon <agk@redhat.com>,
 linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>, Keith
 Busch <kbusch@kernel.org>, linux-btrfs@vger.kernel.org, Pankaj Raghav
 <p.raghav@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v3 01/11] block: make blkdev_nr_zones and blk_queue_zone_no
 generic for npo2 zsze
Date: Fri,  6 May 2022 10:10:55 +0200
Message-Id: <20220506081105.29134-2-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506081105.29134-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1CTdRzH+z7Ps2eDa97j4PR7Ds/akSQeQ6PiW3JBR1cPanfaHxV5V83x
 hOg2bAOMVsqPheOH2xiXypT8ARZgMHH8cLARxzUQwcaBFDANyU1jFhDDaOBBjIcu/3t9Pp/3
 +/v+fO6+PFxQT27gpSkyGKVCIhORwURzl98ZJRzO2L+t53eEzDe6cLRk6yLR5Tt6Ep2c9uPI
 qD/NRQs3nTiyT57hoP5/cjE00mHFkO2iEUM1lx0YcptNOCrpmCZQjWYcR4/Ht6Px2VECGTt/
 BsgzZMKQfXQrGrhXzUU2ew+BBlvPkujctx4uMhQ8wtGwwQNQabeFg3yXNFxU/3CKQNdHhQkb
 6cFbu+jF69+TdGn+JJd2/tpA0IM3M+mrtYUkfSHna5y2VB2j20ZySPpE/iRJW78a49BT7UMk
 rWusBbS5cYigLb1q2mBp4OwRfBAcl8LI0rIYZfRrHwcf0FVeBIfLQz/r8JVhOWCUKgJBPEi9
 CKu8uZwAC6hqAEsdsUUgeJlnAfyt0gjYwgfg34VusgjwVhyLP7zD9r8D0PLLDS5bTADon8gB
 ARFJRcLcwpV+KFUMoH7sODcQgVMWDuyv+yTAIZQUNvQ/JgJMUM/Bxh99K8ynXoEXWqyAXW8T
 LB+YW/EGUa/CvLIJktWshT3lboJ9cxPMbzqDB8IgVRMMZyr0OGt+A7aOOEiWQ6C3u5HLchhc
 sp7DWFZDz/DCqlmzvKnVvHrmDqjrkwUQp7ZAc2s0K38d1t8b4rKKNXD4z7XsCmugsfkUzrb5
 UFsgYNUiaPW7V0MhHMw7S7BMQ1/vDMcAnjU9cYzpiWNM/+eeB3gtWM9kquSpjCpGwRwRqyRy
 VaYiVSxNl18Fy1+6d7H70TVQ7f1L3AkwHugEkIeLQvkhpoz9An6KJPtzRpn+kTJTxqg6gZBH
 iNbzpWlXJAIqVZLBHGKYw4zyvynGC9qQg0UNFL/cVyAOf+Aby450hyX0b4zXTC/E703KvS9t
 eZ97MM6ZPKY9OOKclza49uASpyNx95tTR44e25xc+c22aWZv0umBiLksjnihRfcgaeaPikMR
 JcMnRSZTeNNEaMlStXF+3xdTEdrz2c3Ccm1Y7O1Yl9zvbcubsctfOrGz6PiXKVb1UoX22k/z
 dZsVDyPq35MWW9a1v9vpciXv2lGljpMZIoOQuu721qfCKnY3l8UY1T6N55Lt1DNv7QN9XVnj
 XuzK0/cdd02qhFvqRFtblM2+xf7hvPZue8ydlDxXE5OunXthNt69M6rFsy5ZLz36vPbtsSa1
 8FPGnZiBosNndCMiQnVAsj0SV6ok/wLNHXx7QQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsVy+t/xu7rSN0qSDK7+5LFYf+oYs8X/PcfY
 LFbf7WezmPbhJ7PFpP4Z7Ba/z55nttj7bjarxYUfjUwWNw/sZLLYs2gSk8XK1UeZLJ6sn8Vs
 0XPgA4vFypaHzBZ/HhpaPPxyi8Vi0qFrjBZPr85isth7S9vi0uMV7BZ79p5ksbi8aw6bxfxl
 T9ktJrR9Zba4MeEpo8XE45tZLT4vbWG3WPf6PYvFiVvSDrIel694e/w7sYbNY2LzO3aP8/c2
 snhcPlvqsWlVJ5vHwoapzB6bl9R77L7ZwObR2/yOzWNn631Wj/f7rrJ59G1ZxeixfstVFo/N
 p6s9JmzeyBogFKVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mW
 WqRvl6CX0bd4EWPBTJGKA58nMzUw3hLoYuTgkBAwkfi3P6iLkYtDSGApo8TEb/vYuhg5geIS
 ErcXNjFC2MISf651sUEUPWeU6Hj/jxWkmU1AS6Kxkx0kLiIwlVHi0rqTLCAOs8BpVomtmw4w
 gRQJCyRKTH6iBTKIRUBVYsuRzywgNq+ApcTC7TuhFshLzLz0nR3E5hSwkmia/BLsCCGgmvlL
 9rBC1AtKnJz5BKyXGai+eets5gmMArOQpGYhSS1gZFrFKJJaWpybnltspFecmFtcmpeul5yf
 u4kRmFC2Hfu5ZQfjylcf9Q4xMnEwHmKU4GBWEuEVnlWSJMSbklhZlVqUH19UmpNafIjRFOju
 icxSosn5wJSWVxJvaGZgamhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXAJFFc
 pd2j01e94Lmozdn3p+L936yzjWHZ67vwFJ+XjtpdE77ru/NSvqV29leESywQay1Ru3H6b/ih
 r2fn7Jt0fYbg/G0pq3ucVjvNXXYv9W22trHKU/PYWXO/FywzKdNL9DNfs2K22ROnfRO2Oizs
 UrN6xa0Y3fKua/an0ILM+C3cn7oXt91It5aZ/Hxyu32s4xmjy22Xdh5LWX930dfclTWWr/60
 ylg8a+/f72u9+4PkpIzC4xbPOWbWWP+5xvVffreqc2PY8/ScxR0p86VXCsQuCj2ob/uBeZFY
 Hut+rmxX1bOlKbNfHLzP4h6/4Gz79SlxJksecT/bdFFvV+qsme+bgl6qme9kni5loxCySIml
 OCPRUIu5qDgRAH4I+hKxAwAA
X-CMS-MailID: 20220506081107eucas1p1070e00b208e00090c235017435be1593
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220506081107eucas1p1070e00b208e00090c235017435be1593
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220506081107eucas1p1070e00b208e00090c235017435be1593
References: <20220506081105.29134-1-p.raghav@samsung.com>
 <CGME20220506081107eucas1p1070e00b208e00090c235017435be1593@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220506_011120_220074_95260950 
X-CRM114-Status: GOOD (  15.61  )
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

Adapt blkdev_nr_zones and blk_queue_zone_no function so that it can
also work for non-power-of-2 zone sizes.

As the existing deployments of zoned devices had power-of-2
assumption, power-of-2 optimized calculation is kept for those devices.

There are no direct hot paths modified and the changes just
introduce one new branch per call.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-zoned.c      | 13 ++++++++++---
 include/linux/blkdev.h |  8 +++++++-
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 38cd840d8..140230134 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -111,16 +111,23 @@ EXPORT_SYMBOL_GPL(__blk_req_zone_write_unlock);
  * blkdev_nr_zones - Get number of zones
  * @disk:	Target gendisk
  *
- * Return the total number of zones of a zoned block device.  For a block
- * device without zone capabilities, the number of zones is always 0.
+ * Return the total number of zones of a zoned block device, including the
+ * eventual small last zone if present. For a block device without zone
+ * capabilities, the number of zones is always 0.
  */
 unsigned int blkdev_nr_zones(struct gendisk *disk)
 {
 	sector_t zone_sectors = blk_queue_zone_sectors(disk->queue);
+	sector_t capacity = get_capacity(disk);
 
 	if (!blk_queue_is_zoned(disk->queue))
 		return 0;
-	return (get_capacity(disk) + zone_sectors - 1) >> ilog2(zone_sectors);
+
+	if (is_power_of_2(zone_sectors))
+		return (capacity + zone_sectors - 1) >>
+		       ilog2(zone_sectors);
+
+	return div64_u64(capacity + zone_sectors - 1, zone_sectors);
 }
 EXPORT_SYMBOL_GPL(blkdev_nr_zones);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1b24c1fb3..22fe512ee 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -675,9 +675,15 @@ static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
 static inline unsigned int blk_queue_zone_no(struct request_queue *q,
 					     sector_t sector)
 {
+	sector_t zone_sectors = blk_queue_zone_sectors(q);
+
 	if (!blk_queue_is_zoned(q))
 		return 0;
-	return sector >> ilog2(q->limits.chunk_sectors);
+
+	if (is_power_of_2(zone_sectors))
+		return sector >> ilog2(zone_sectors);
+
+	return div64_u64(sector, zone_sectors);
 }
 
 static inline bool blk_queue_zone_is_seq(struct request_queue *q,
-- 
2.25.1


