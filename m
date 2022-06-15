Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDE5C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 10:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2x4a7MWIZaoS9EpNftzI215np6IWsBpMSE6yLnny6oA=; b=3MAZbM8GCyXKbP+BVHUPqsN81L
	sUhKvIqDTROOReYzZSj+WPMQlb92T9tIiDiWIQJ7Cfhq6lJ4xrpicbcvMvl6Yp5y8xizdYkOkQWSh
	XoIAvn/otiC8q0Lzh4og4s4qz8XLfCNIeuU6yR9LOQ8KGAy/ZORCEp8/6Gqygrpvf/an3rGuf6DUM
	LgWwTGmSsi/Rg0JUQdxRzQuFCkcCH0X7vsh8jSfJ0WKjHQNarQUpfou/IoxVPykkwe9pc8YfXml1t
	+LCFkWULilyNtZwooNl8oQzGevpMElGFXau5a95H5eSYW76lJCQcaCL5It6nX7fGNt3l76fNtJ6Td
	JFq19SRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1QCt-00DoSY-Rc; Wed, 15 Jun 2022 10:25:03 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1Q88-00DmVf-8C
	for linux-nvme@lists.infradead.org; Wed, 15 Jun 2022 10:20:10 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220615102006euoutp02d24685d2e9364e377c1650a5e306d229~4xAk34UZe2870528705euoutp02h
	for <linux-nvme@lists.infradead.org>; Wed, 15 Jun 2022 10:20:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220615102006euoutp02d24685d2e9364e377c1650a5e306d229~4xAk34UZe2870528705euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1655288406;
	bh=2x4a7MWIZaoS9EpNftzI215np6IWsBpMSE6yLnny6oA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HvOKTpF0gcYXTQFUHVWObESetTm0SUQ9Q/ndhpOoCadEHBn0P/H7ccBuPqAzDa6l8
	 xKZD704izj6V1bryyYmjd/L/X0I/Tl0pvFIoi9ilOUw27JUt+CTy4qEZkWh3XLjzpP
	 +j6BsHn8rjcuTt1zKs5yHlkTV2usHdeRgUEsv7+M=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220615102005eucas1p2e51799f03f95acf5c1f7703f8351de94~4xAjFUQzG2114721147eucas1p2r;
	Wed, 15 Jun 2022 10:20:04 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 6A.4B.09664.452B9A26; Wed, 15
	Jun 2022 11:20:04 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20220615102004eucas1p1e458ea097d381058b16fc6daa3eec998~4xAipn0SG1175911759eucas1p1l;
	Wed, 15 Jun 2022 10:20:04 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220615102004eusmtrp2ba89836fb0aa21ef02b3525c2b0f566c~4xAiouw-J0361403614eusmtrp2F;
	Wed, 15 Jun 2022 10:20:04 +0000 (GMT)
X-AuditID: cbfec7f2-d97ff700000025c0-37-62a9b254e53c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 63.34.09038.452B9A26; Wed, 15
	Jun 2022 11:20:04 +0100 (BST)
Received: from localhost (unknown [106.210.248.244]) by eusmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20220615102003eusmtip1d5651274b4871f0239331522fba58745~4xAhxZ7w90653206532eusmtip1U;
	Wed, 15 Jun 2022 10:20:03 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: hch@lst.de, snitzer@redhat.com, damien.lemoal@opensource.wdc.com,
	axboe@kernel.dk
Cc: bvanassche@acm.org, linux-kernel@vger.kernel.org,
	jiangbo.365@bytedance.com, hare@suse.de, pankydev8@gmail.com,
	dm-devel@redhat.com, jonathan.derrick@linux.dev, gost.dev@samsung.com,
	dsterba@suse.com, jaegeuk@kernel.org, linux-nvme@lists.infradead.org,
	Johannes.Thumshirn@wdc.com, linux-block@vger.kernel.org, Pankaj Raghav
	<p.raghav@samsung.com>
Subject: [PATCH v7 11/13] dm-table: allow non po2 zoned devices
Date: Wed, 15 Jun 2022 12:19:18 +0200
Message-Id: <20220615101920.329421-12-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615101920.329421-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7djP87ohm1YmGfT8trBYfbefzWLah5/M
	Fr/Pnme22PtuNqvFhR+NTBY3D+xkstizaBKTxcrVR5ksnqyfxWzRc+ADi8XfrntAsZaHQMW3
	tC0u75rDZjF/2VN2i89LW9gt1tx8ymLRtvEro4OQx+Ur3h7/Tqxh89g56y67x+WzpR6bVnWy
	eSxsmMrssXlJvcfumw1Audb7rB7v911l8+jbsorRY/2Wqywem09Xe3zeJOfRfqCbKYA/issm
	JTUnsyy1SN8ugSuj7+VjloLJvBVbNyxgaWC8xtXFyMkhIWAisbZnIWsXIxeHkMAKRontP3uh
	nC+MEvfmb2aCcD4zSjzfep0VpuX/nW6oxHJGidYt/6Ccl4wS/18uZOxi5OBgE9CSaOxkB2kQ
	EQiXOLrnHlgNs8ALJonFt+eCTRIWsJc4fPchWBGLgKrE08nvGEFsXgFriRXTvjBDbJOXmHnp
	O1gNJ1B8x+weVogaQYmTM5+wgNjMQDXNW2czgyyQEDjFKTHn8yuoU10krmx7DTVIWOLV8S3s
	ELaMxP+d85kg7GqJpzd+QzW3MEr071zPBvKBBNC2vjM5ICazgKbE+l36EOWOErdmP2eCqOCT
	uPFWEOIEPolJ26YzQ4R5JTrahCCqlSR2/nwCtVRC4nLTHBaIEg+JzbOYJzAqzkLyyywkv8xC
	WLuAkXkVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYMI8/e/4px2Mc1991DvEyMTBeIhR
	goNZSYTXLHhlkhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe5MwNiUIC6YklqdmpqQWpRTBZJg5O
	qQamKK/9um/e/jupPGOmQ/LsBLupL8/Ec7DWNEUmFd2ZWVD7T2mTFofy67+37m/WFhUunaXv
	EL7/R2z9JuPvPu9XPChTXfhiWo1w06cmz+wtQtPePg379ffLsy8Kl+1i7ERbY/Y5Rs+fdlzL
	8pb2VEsG/uVF74KNeTdt9tCqZ5maG641q/ralE1ZOXJlT8JL2QUW6zGcnmz5s/9Bj+bkC/5z
	bbeLSmWvUm0+MeE7r7psX+Ht5aWqckWG985716zdWXtePsVv4+Nc9VpziekWBQ6HP73LWvd9
	aaeeKo/Jb0lGdpuF9g5S7r7/9RKLd/2x3rdhttnnxqiyp5y8mZ/l9zrxfvxsbFiareagec4s
	/Z4SS3FGoqEWc1FxIgBugslvBwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsVy+t/xu7ohm1YmGfz+L22x+m4/m8W0Dz+Z
	LX6fPc9ssffdbFaLCz8amSxuHtjJZLFn0SQmi5WrjzJZPFk/i9mi58AHFou/XfeAYi0PgYpv
	aVtc3jWHzWL+sqfsFp+XtrBbrLn5lMWibeNXRgchj8tXvD3+nVjD5rFz1l12j8tnSz02repk
	81jYMJXZY/OSeo/dNxuAcq33WT3e77vK5tG3ZRWjx/otV1k8Np+u9vi8Sc6j/UA3UwB/lJ5N
	UX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl5G38vHLAWT
	eSu2bljA0sB4jauLkZNDQsBE4v+dbqYuRi4OIYGljBK9X5uZIBISErcXNjFC2MISf651sUEU
	PWeUmLTwF5DDwcEmoCXR2MkOUiMiEC3RefM9WA2zwA8miQmL1oIlhAXsJQ7ffQhmswioSjyd
	/A5sKK+AtcSKaV+YIRbIS8y89B2shhMovmN2DyvIfCEBK4ld7+IhygUlTs58wgJiMwOVN2+d
	zTyBUWAWktQsJKkFjEyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAmN727GfW3Ywrnz1Ue8Q
	IxMH4yFGCQ5mJRFes+CVSUK8KYmVValF+fFFpTmpxYcYTYHOnsgsJZqcD0wueSXxhmYGpoYm
	ZpYGppZmxkrivJ4FHYlCAumJJanZqakFqUUwfUwcnFINTGE1fct12DbUWbio1Cz6x3t4ncua
	GUItl5xyTF5/07x3uVKMR981dD9faUhh3v6XRiutYuJ9fl9ZI9DC5PEssnxitvdfYa/bvpfe
	v/1VZPr291u2fRdv/bvKdMkmc/3PmnuZDkHPt++ut7FVsSg+8Vs1s3TD6gfXXq99tf9i8Prf
	tlK/yz7v5vC9szB3y6qOzeGBH6O8L0pdydm9jndC4J3zJeydhYEm02/5f2wKv7XA00BLLz3E
	Qs/ts//pWZGpYjy/WQ9+/vnkjvXdz/+S7Hs1Su4aBuqFp0x7PmUtJ8u0wLc7Nbvi+VIennvu
	qL3q5dWlqUs9p/I3bBD+de70vRiPWd0Tzmyqbea8wbTDoUGJpTgj0VCLuag4EQDxEq7qdgMA
	AA==
X-CMS-MailID: 20220615102004eucas1p1e458ea097d381058b16fc6daa3eec998
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220615102004eucas1p1e458ea097d381058b16fc6daa3eec998
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220615102004eucas1p1e458ea097d381058b16fc6daa3eec998
References: <20220615101920.329421-1-p.raghav@samsung.com>
	<CGME20220615102004eucas1p1e458ea097d381058b16fc6daa3eec998@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_032008_623182_D8454836 
X-CRM114-Status: GOOD (  12.74  )
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

As the block layer now supports non po2 zoned devices, allow dm to
support non po2 zoned device.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/md/dm-table.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index b553cdb6d..ec77e7830 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -251,7 +251,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
 	if (bdev_is_zoned(bdev)) {
 		unsigned int zone_sectors = bdev_zone_sectors(bdev);
 
-		if (blk_queue_is_zone_start(bdev_get_queue(bdev), start)) {
+		if (!blk_queue_is_zone_start(bdev_get_queue(bdev), start)) {
 			DMWARN("%s: start=%llu not aligned to h/w zone size %u of %pg",
 			       dm_device_name(ti->table->md),
 			       (unsigned long long)start,
@@ -268,7 +268,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
 		 * devices do not end up with a smaller zone in the middle of
 		 * the sector range.
 		 */
-		if (blk_queue_is_zone_start(bdev_get_queue(bdev), len)) {
+		if (!blk_queue_is_zone_start(bdev_get_queue(bdev), len)) {
 			DMWARN("%s: len=%llu not aligned to h/w zone size %u of %pg",
 			       dm_device_name(ti->table->md),
 			       (unsigned long long)len,
@@ -1648,7 +1648,7 @@ static int validate_hardware_zoned_model(struct dm_table *table,
 	}
 
 	/* Check zone size validity and compatibility */
-	if (!zone_sectors || !is_power_of_2(zone_sectors))
+	if (!zone_sectors)
 		return -EINVAL;
 
 	if (dm_table_any_dev_attr(table, device_not_matches_zone_sectors, &zone_sectors)) {
-- 
2.25.1


