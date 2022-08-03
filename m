Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCD8C19F28
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Aug 2022 09:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T6uTF12t86W2Ord6JkqRUxShPwTcKbnN1jJM5mS3HZw=; b=iwnXs7RhB+Q/BjE6LEOFT7N//w
	CabPscMR287H5FUFCBt9GQtCj26V893ChuMtnF4ozY7BlHwiWvD7aQv8QBEhqskJjDDyqPuVYQ3Dl
	55W0mgzR8gpyZjbMpXOvHN0z2l4Yh71ukfGIjqKkpTZVj2u0e9QdYGp9X9yFWli48l3Cx7LmLb3yK
	wDPvQ4VbT3JLjLVzu7QbmGj78hNUoFMOVQt6RJtKIwOHomlrI4TaN9KZdMozgaQvHmfXwDfjC2TYv
	oozrq201ownnV6gQtqtr/uRG1xRGQbZQJfBqtVGramJsYBYnQGwqcUivt76W4jT0JdAcZ9yRhoVDm
	vrjz/DsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJAzY-004TVx-01; Wed, 03 Aug 2022 09:48:40 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oJAz4-004T8M-Dv
	for linux-nvme@lists.infradead.org; Wed, 03 Aug 2022 09:48:13 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220803094809euoutp01f197a5c6069f5b0a947abd46aaf0bbf4~HzLqGKn-u3234332343euoutp01Z
	for <linux-nvme@lists.infradead.org>; Wed,  3 Aug 2022 09:48:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220803094809euoutp01f197a5c6069f5b0a947abd46aaf0bbf4~HzLqGKn-u3234332343euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1659520089;
	bh=T6uTF12t86W2Ord6JkqRUxShPwTcKbnN1jJM5mS3HZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tj42y7q6xizQ6E2do1aoLsEu0hm33u3q5y6DgB32AqgF6DBCb1givbkyTCVD2hfAb
	 RZSF1tDFJMBNXzW0nZdSvNNFo3Z/YTcGIKZZd6W5FRiRqVstSvOdwUMqkw4UViuMr6
	 nGM0j8KaL4h7hEDumAszPJ3EfXOj8zNAGv1iPlec=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220803094807eucas1p224884eb226c7b424aed2ee5802687c73~HzLonXeKL2470524705eucas1p2m;
	Wed,  3 Aug 2022 09:48:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id B3.FF.09664.7544AE26; Wed,  3
	Aug 2022 10:48:07 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220803094806eucas1p24e1fd0f3a595e050d79c4315559d97ae~HzLn-ja4E1528815288eucas1p2h;
	Wed,  3 Aug 2022 09:48:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220803094806eusmtrp1f74e4c3e6a78656816aba9457baeed04~HzLn_o3YC2000320003eusmtrp1Q;
	Wed,  3 Aug 2022 09:48:06 +0000 (GMT)
X-AuditID: cbfec7f2-d97ff700000025c0-81-62ea44573f19
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 53.9B.09038.6544AE26; Wed,  3
	Aug 2022 10:48:06 +0100 (BST)
Received: from localhost (unknown [106.210.248.112]) by eusmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20220803094806eusmtip10b1dba597f608a76d1a515ca1f44a551~HzLnqIBVq2267222672eusmtip1h;
	Wed,  3 Aug 2022 09:48:06 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: Johannes.Thumshirn@wdc.com, snitzer@kernel.org, axboe@kernel.dk,
	damien.lemoal@opensource.wdc.com, agk@redhat.com, hch@lst.de
Cc: dm-devel@redhat.com, matias.bjorling@wdc.com, gost.dev@samsung.com,
	linux-kernel@vger.kernel.org, pankydev8@gmail.com, jaegeuk@kernel.org,
	hare@suse.de, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	bvanassche@acm.org, Pankaj Raghav <p.raghav@samsung.com>, Johannes Thumshirn
	<johannes.thumshirn@wdc.com>, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v9 04/13] nvmet: Allow ZNS target to support non-power_of_2
 zone sizes
Date: Wed,  3 Aug 2022 11:47:52 +0200
Message-Id: <20220803094801.177490-5-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220803094801.177490-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7djPc7rhLq+SDLr3K1qsP3WM2WL13X42
	i2kffjJb/D57ntli77vZrBY3D+xkstizaBKTxcrVR5ksnqyfxWzxt+sek8XeW9oWl3fNYbOY
	v+wpu8WEtq/MFjcmPGW0+Ly0hd1izc2nLBYnbkk7CHlcvuLtsXPWXXaPy2dLPTat6mTz2Lyk
	3mP3zQY2j52t91k93u+7yubRt2UVo8fm09UenzfJebQf6GYK4InisklJzcksSy3St0vgyvg7
	+zxzwSn+iobHF5kbGJfwdjFyckgImEh8XbeOrYuRi0NIYAWjRNvPqcwQzhdGiQXrJ7GCVAkJ
	fGaUmPE3AKZjzaKpUB3LGSUuz//EDlH0klHiaaN9FyMHB5uAlkRjJztIjYhAM6PE3b89rCAO
	s8BHJolH2zcygRQJC0RIfDkhBNLLIqAqsXHrbSYQm1fASuLKpW9sEMvkJWZe+g42n1PAWmLK
	v3/MEDWCEidnPmEBsZmBapq3zga7WkJgO6fE3b2/WSCaXSTmL7/GCGELS7w6voUdwpaROD25
	B6qmWuLpjd9QzS2MEv0717OBHCcBtK3vTA6IySygKbF+lz5EuaPE9YPHWSAq+CRuvBWEOIFP
	YtK26cwQYV6JjjYhiGoliZ0/n0AtlZC43DQHaqmHxONJ7UwTGBVnIXlmFpJnZiHsXcDIvIpR
	PLW0ODc9tdgwL7Vcrzgxt7g0L10vOT93EyMwHZ7+d/zTDsa5rz7qHWJk4mA8xCjBwawkwnvH
	5XmSEG9KYmVValF+fFFpTmrxIUZpDhYlcd7kzA2JQgLpiSWp2ampBalFMFkmDk6pBqZpkjYM
	wUe6FRQNVgln/fraVflylbxolYW4RGfeJP7Ne+PnTwkRWdT85N+v9fXhsorO2XO/hnZW5F34
	drrq0d93Ae9fVMe79vD/zA1XOVhdrH1TTZ2nTlTS2OLRb1aOvosx636c/RizuWzBS9cJQiYh
	j13eJCrJ7tARsO3dLOQY9XLpp4niNk1/1jw53DC33pxh40eeXan/rRQ2Jdfq5QsGuPKI8H7w
	0BMQF7u7UPBD3ab1eZ908q3XH3EVP/eiUnErQ+vpxrs694+7vOY9vv6KlWv08o8CgibM62Oa
	p9+34gnuT76p7Pe/56po/WvObV0eV2dXPrVLMPXgNLXsq+K/67HWqu/j89uP49cyKrEUZyQa
	ajEXFScCAM/6kkf2AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xu7phLq+SDFq2mlisP3WM2WL13X42
	i2kffjJb/D57ntli77vZrBY3D+xkstizaBKTxcrVR5ksnqyfxWzxt+sek8XeW9oWl3fNYbOY
	v+wpu8WEtq/MFjcmPGW0+Ly0hd1izc2nLBYnbkk7CHlcvuLtsXPWXXaPy2dLPTat6mTz2Lyk
	3mP3zQY2j52t91k93u+7yubRt2UVo8fm09UenzfJebQf6GYK4InSsynKLy1JVcjILy6xVYo2
	tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy/g7+zxzwSn+iobHF5kbGJfwdjFy
	ckgImEisWTSVrYuRi0NIYCmjxNwlDcwQCQmJ2wubGCFsYYk/17qgip4zSkxdfwWoiIODTUBL
	orGTHSQuItDNKHH5zDlWkAZmgUZmiW+bSkFsYYEwic1bjoENZRFQldi49TYTiM0rYCVx5dI3
	NogF8hIzL31nB7E5Bawlpvz7B1YvBFSz7u8sVoh6QYmTM5+wQMyXl2jeOpt5AqPALCSpWUhS
	CxiZVjGKpJYW56bnFhvpFSfmFpfmpesl5+duYgRG77ZjP7fsYFz56qPeIUYmDsZDjBIczEoi
	vHdcnicJ8aYkVlalFuXHF5XmpBYfYjQFunsis5Rocj4wfeSVxBuaGZgamphZGphamhkrifN6
	FnQkCgmkJ5akZqemFqQWwfQxcXBKNTB53yqW52b7XGnK/jvFpjH79KblU49NqFkrd3sr/6fs
	I3nbd3PGp8V59zFMscixCfrynydv+oHqqtfyS4/pPrrct2uOSM8Gh2f+vX8ui802nPl+XXt0
	nxuT54/eW+xvGZ8l7Thm6lD2Sf4oW+Tn1en528QtKixj+tbn/OmZLRU3a+OBayE8i3ddinsr
	envCyZrKF0LeDfarU3hbps472vJJX563vX9CiN+vdeHKDu+uGGi/ntapZVjiYNdVnt920PPb
	BoGoXF3bRlbRX0mPBC3fH1y6xFvomPEEP+4NYnfXHzYrtjXoPvIh91/dFK8fYpVsjsWbfj48
	f/DIzUVq6w07ihXK7dbVPtghfXS7IZMSS3FGoqEWc1FxIgAwwu7wZwMAAA==
X-CMS-MailID: 20220803094806eucas1p24e1fd0f3a595e050d79c4315559d97ae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220803094806eucas1p24e1fd0f3a595e050d79c4315559d97ae
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220803094806eucas1p24e1fd0f3a595e050d79c4315559d97ae
References: <20220803094801.177490-1-p.raghav@samsung.com>
	<CGME20220803094806eucas1p24e1fd0f3a595e050d79c4315559d97ae@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220803_024810_882940_EF7EF22A 
X-CRM114-Status: GOOD (  14.86  )
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

A generic bdev_zone_no() helper is added to calculate zone number for a
given sector in a block device. This helper internally uses disk_zone_no()
to find the zone number.

Use the helper bdev_zone_no() to calculate nr of zones. This let's us
make modifications to the math if needed in one place and adds now
support for zoned devices with non po2 zone size.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/target/zns.c | 3 +--
 include/linux/blkdev.h    | 5 +++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index c7ef69f29fe4..662f1a92f39b 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -241,8 +241,7 @@ static unsigned long nvmet_req_nr_zones_from_slba(struct nvmet_req *req)
 {
 	unsigned int sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
 
-	return bdev_nr_zones(req->ns->bdev) -
-		(sect >> ilog2(bdev_zone_sectors(req->ns->bdev)));
+	return bdev_nr_zones(req->ns->bdev) - bdev_zone_no(req->ns->bdev, sect);
 }
 
 static unsigned long get_nr_zones_from_buf(struct nvmet_req *req, u32 bufsize)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5aa15172299d..ead848a15946 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1345,6 +1345,11 @@ static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
 	return BLK_ZONED_NONE;
 }
 
+static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
+{
+	return disk_zone_no(bdev->bd_disk, sec);
+}
+
 static inline int queue_dma_alignment(const struct request_queue *q)
 {
 	return q ? q->dma_alignment : 511;
-- 
2.25.1


