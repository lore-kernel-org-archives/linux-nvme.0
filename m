Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70799C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  6 May 2022 08:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vrYMM/cTOrW0/UYYWyRRUQC9LsDHx9p6dz/qEYyG7Ug=; b=ltMM+VK4qT1ZhKLzi41XB3fH/q
	iooeqNYidj4Qg64MEEH+qcgMyxQcwCKTE3Y/U031zPSlSK0jWa1WH43qhMrn+mYBU+CmExymkyNfB
	VX+AKPH65GCRxEssz484fVRMLnAsc7jSQbjb1FWAa1VMrUSvpCcmqNn0oGDYMtcoC+vEu50SelyH1
	OU1JNhyp1Cp9+tERbafXq6M/7wREWLCz/eD7afzjNn/wAUnJvrPlWJeE+eYuSQpfKHs4zURsxxiYr
	NrSCYrBTjqaIYOoGd6r9xMZUSlqfb2uvysUxYaZk+tc6jwPFRxzAaZo3jOd4m0zKogoR9XqbJhi5+
	BL4V/zKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmt3i-001ymx-IM; Fri, 06 May 2022 08:11:30 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmt3X-001yc6-Ph
 for linux-nvme@lists.infradead.org; Fri, 06 May 2022 08:11:22 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20220506081112euoutp026adb0d97f651ec3fd2b2261783850517~sdcnEua9I2384623846euoutp02Z
 for <linux-nvme@lists.infradead.org>; Fri,  6 May 2022 08:11:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20220506081112euoutp026adb0d97f651ec3fd2b2261783850517~sdcnEua9I2384623846euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1651824672;
 bh=vrYMM/cTOrW0/UYYWyRRUQC9LsDHx9p6dz/qEYyG7Ug=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YQ2/qosRczqbg9pWbAOHFxZDGCL5jh+uNCiAdiPbw0KjEv46e68tfBxQkS5Uv/Yso
 1/pQ9bM55lAAtDDCJUQZYMJX5PBhBQFEGx1o/hKLNrPGgyOK0hgNd6FApl/3rblH/A
 55VcR+dtUFE7jz/ay+tMdzfAQmKCkrNWrzUcpP74=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20220506081110eucas1p29f4ec4b6163302f91ffd1654e9132bc4~sdclV3MUy0616806168eucas1p2n;
 Fri,  6 May 2022 08:11:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id C8.05.09887.E18D4726; Fri,  6
 May 2022 09:11:10 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20220506081110eucas1p1b6c624ddca1c41b9838bb5b85f8ca5ff~sdck9wLVm1797017970eucas1p1B;
 Fri,  6 May 2022 08:11:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220506081110eusmtrp222f0eafc663deb2c7f6b2252e5b9e61c~sdck8jKjJ2593625936eusmtrp2X;
 Fri,  6 May 2022 08:11:10 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-31-6274d81ece15
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 82.F2.09522.E18D4726; Fri,  6
 May 2022 09:11:10 +0100 (BST)
Received: from localhost (unknown [106.210.248.174]) by eusmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20220506081110eusmtip15b4e6a476e2eada8a56f7f54296837f1~sdckpd6-70578205782eusmtip1b;
 Fri,  6 May 2022 08:11:10 +0000 (GMT)
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
Subject: [PATCH v3 04/11] nvmet: Allow ZNS target to support non-power_of_2
 zone sizes
Date: Fri,  6 May 2022 10:10:58 +0200
Message-Id: <20220506081105.29134-5-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506081105.29134-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTZxTGee+9vf2IhUsx8I6KbE38A9AqCyHv3MJcYrYbF3XZ5sY+xBW5
 KwQorB8ONZlFEAU2Cjj5KCwwMq1QRylldYWiWGOBOQZrh2mZwxFoNqlUhmWTyGSUi5n//d5z
 nuc950kODxeZyFhejkLNKBWyPAkpIKzOpZ+2bfaoM3fYXCnI9IMTRyt2J4mMv+lIVDe/hKNa
 XQMXPRoZxVF/oImDxh4WY8g7YMOQva0WQ+3GGxiaMelx9PnAPIHaS6dwtDyVjKaCEwSqddwC
 yDeux1D/RBJyTV/kInv/MIHcvc0karng46LqskUceap9ANUMWjjowflSLur03yfQ0IR4Vxzt
 /uV1+vHQJZKuKQlw6dFJM0G7RzR0d0c5SX+tPYfTlm9O0H1eLUl/URIgadupOxz6/pVxkq7q
 6QC0qWecoC03j9PVFjPnDdH7gpeymLycI4xye9pHguzRuTGscCW8qNE7CbTAu6EC8HmQSoHX
 7ee5IRZRFwH0GndUAMEqBwH0BTtw9vEAwFOuL7lPHP7pWYJtGACsCbasq+4CWD+s41QAHo+k
 EmFxOTdU30hVAqi7c3rNjVMWDhz79uMQR1Hp8EabA4SYoLbAleILeIiF1Avwz7lJDjstHja6
 /lnz8qmd8OTZuySriYTDjTME+2c8LPmuaW0JSLUL4Omys+vm3bB6QIuzHAVnB3vWI2yCK7YW
 jOXj0Od5tG4uXd3UZiJDCSD1Iqz6MS+EOJUATb3bWfkr8O/Wa4BVhEPPXCS7QjistdbjbFkI
 z5SJWLUE2pZm1odC6D7ZTLBMw4WuK2Q1eE7/VBj9U2H0/89tBXgHiGE0qnw5o3pewXwqVcny
 VRqFXHq4IL8brN70zceDwe+BYfYvqQNgPOAAkIdLNgqj9OpMkTBLdvQYoyw4pNTkMSoHEPMI
 SYzwcE6XTETJZWoml2EKGeWTLsbjx2qxjF3vGqRZ0fHSpA/S2nTl5xaj34zYKmxXfCYVH3UG
 Ot17mH3Wd7wjEwcv31tIPwBeuy09sbnyKiqb69TVmypTwu7tHPRsoxPNL/fz+xr3120NuxY9
 vf/YkYjmQ6NXnTXZ3SXaZyczvGpRqsuYkBvm3lcnDiQdjH3vkp/j35Tx4YZke3hu+eKWhoaY
 fyeWL3cV/RppDBoc4z+n9jpbsd2jaU65/C1r3ZRZY5jXwczpRdycWMA8RCsHqnSxYqaG3BuH
 RpLyFUUx/E863TPP1F1veru471aL/fbynq/0fzhsCb/vDbcOtaf7o+J8EeLxwjOvauYWdJI+
 X31etLSwIZgqIVTZsuREXKmS/QdttR9ZQgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsVy+t/xu7pyN0qSDC4flbRYf+oYs8X/PcfY
 LFbf7WezmPbhJ7PFpP4Z7Ba/z55nttj7bjarxYUfjUwWNw/sZLLYs2gSk8XK1UeZLJ6sn8Vs
 0XPgA4vFypaHzBZ/HhpaPPxyi8Vi0qFrjBZPr85isth7S9vi0uMV7BZ79p5ksbi8aw6bxfxl
 T9ktJrR9Zba4MeEpo8XE45tZLT4vbWG3WPf6PYvFiVvSDrIel694e/w7sYbNY2LzO3aP8/c2
 snhcPlvqsWlVJ5vHwoapzB6bl9R77L7ZwObR2/yOzWNn631Wj/f7rrJ59G1ZxeixfstVFo/N
 p6s9JmzeyBogFKVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mW
 WqRvl6CXcf7tBaaC/3wVM2/eY2xgvMnTxcjJISFgIvH68SuWLkYuDiGBpYwSZ+/0skIkJCRu
 L2xihLCFJf5c62KDKHrOKHF0xWHmLkYODjYBLYnGTnaQuIjAVEaJS+tOgk1iFjjNKrF10wEm
 kG5hgTCJK28/gE1iEVCV+N+4jBnE5hWwlHjx9h7UNnmJmZe+s4PYnAJWEk2TX7KB2EJANfOX
 7GGFqBeUODnzCQuIzQxU37x1NvMERoFZSFKzkKQWMDKtYhRJLS3OTc8tNtQrTswtLs1L10vO
 z93ECEwq24793LyDcd6rj3qHGJk4GA8xSnAwK4nwCs8qSRLiTUmsrEotyo8vKs1JLT7EaAp0
 90RmKdHkfGBayyuJNzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnNTk0tSC2C6WPi4JRqYDr2
 PHHpwSvPW/YWXRGZuOLZruxaqZBKSXGJpry7BRmdi8/2sussnObANj3jmKR27dyYo2FW9nPe
 Kxg+83my3yj2QBCP6vKKh/cPLL50uD5ApnPz26VMv4IETk7lqhDRuXPzke68vn29jqsDmpyX
 h81emz/DqGrSjdu5T7rnaPXUmPuGLyjV1A4VPz1N5db6V1LpYV9yHRZWCLOtu17/10nBr97g
 zLnosx/e+bTL+LsdVXaNt01oaj/Z+D76WL6GhLrhPDf2V4H5jmKV99gNAydtWZhsdnHJoh5h
 7dYHL263X50gX3L35OwdMS6Cyfe+rkl3es9nxT01UfnC57jEt9zbeqQicg7bPU+w2b0oSoml
 OCPRUIu5qDgRABxkWpSzAwAA
X-CMS-MailID: 20220506081110eucas1p1b6c624ddca1c41b9838bb5b85f8ca5ff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220506081110eucas1p1b6c624ddca1c41b9838bb5b85f8ca5ff
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220506081110eucas1p1b6c624ddca1c41b9838bb5b85f8ca5ff
References: <20220506081105.29134-1-p.raghav@samsung.com>
 <CGME20220506081110eucas1p1b6c624ddca1c41b9838bb5b85f8ca5ff@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220506_011120_234138_C9244C7E 
X-CRM114-Status: GOOD (  15.13  )
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

A generic bdev_zone_no helper is added to calculate zone number for a given
sector in a block device. This helper internally uses blk_queue_zone_no to
find the zone number.

Use the helper bdev_zone_no() to calculate nr of zones. This let's us
make modifications to the math if needed in one place and adds now
support for npo2 zone devices.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/target/zns.c | 2 +-
 include/linux/blkdev.h    | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 82b61acf7..5516dd6cc 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -242,7 +242,7 @@ static unsigned long nvmet_req_nr_zones_from_slba(struct nvmet_req *req)
 	unsigned int sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
 
 	return blkdev_nr_zones(req->ns->bdev->bd_disk) -
-		(sect >> ilog2(bdev_zone_sectors(req->ns->bdev)));
+	       bdev_zone_no(req->ns->bdev, sect);
 }
 
 static unsigned long get_nr_zones_from_buf(struct nvmet_req *req, u32 bufsize)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 32d7bd7b1..967790f51 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1370,6 +1370,13 @@ static inline sector_t bdev_zone_sectors(struct block_device *bdev)
 	return 0;
 }
 
+static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	return blk_queue_zone_no(q, sec);
+}
+
 static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
-- 
2.25.1


