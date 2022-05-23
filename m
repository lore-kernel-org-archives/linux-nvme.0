Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C64C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 23 May 2022 16:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9W1pLbbKKEsanlon70WFxiL7DVRrcoEEPxlxXdEW3tc=; b=3hJzgo2MGF7zqbUSIsquPYLd/Q
	1e/63ml4bFFCt1PoDhUoUQUK4SFXXRQvhimgsih4/ZddH9LN8CmLi10P6Zy3P/KZONmgsP7f41Qow
	ubL6pX4mlwsNrTK3haJk0uP5j1KnVJbs+Dcjc7Rxr0u8+xp/Dg6aLyEdp0wz8Ssb2EGEP6tgOTcF6
	u4x91Wd6n4UkDeiXZIjFGW4YFGkVVJyVYcCtTOVXB6ZKSE03T/rURNs8FJFTP7T3LvOMZVlID4REf
	RDT/k23b8N2/TgyBhPtlmVYE5sjVxXoODBhc7X6oAxBjmdaS1KoGdzzOt2wej8YMJ19/JxWH4kMpS
	7SndoL6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntAjn-005BfF-6t; Mon, 23 May 2022 16:16:55 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntAj6-005BHL-Pb
 for linux-nvme@lists.infradead.org; Mon, 23 May 2022 16:16:16 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20220523161611euoutp02f47ca63d7e9d0e82b508efe4ff1bc989~xyB52IzpS1880118801euoutp02M
 for <linux-nvme@lists.infradead.org>; Mon, 23 May 2022 16:16:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20220523161611euoutp02f47ca63d7e9d0e82b508efe4ff1bc989~xyB52IzpS1880118801euoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1653322571;
 bh=9W1pLbbKKEsanlon70WFxiL7DVRrcoEEPxlxXdEW3tc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=j+5dSK/d7b8Ph6xvXX8Q9EWPyzlu0EkiNlxa2nXL8c38PkTt5omi8GUyXEMibAPFe
 CISBDh+DsKGy6VMi0fkMfjFqZEnJtM6q56Sa5Ee4xSbg5j0mTGEluy+uZ6jHkS6DAO
 mCegylTPqTYKnGCQm12kKriPUdale5Hm4p3jmfLg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20220523161609eucas1p27754a51739628374be85028f4954b683~xyB4VyB3q0957009570eucas1p2Z;
 Mon, 23 May 2022 16:16:09 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id E4.A4.10009.943BB826; Mon, 23
 May 2022 17:16:09 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20220523161609eucas1p16c381cd9438240905bfdb0a739132e65~xyB3z4X131867318673eucas1p1E;
 Mon, 23 May 2022 16:16:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220523161609eusmtrp2b6776808758c9ecadcc8ec5d2a7ac2a3~xyB3zBIlt0219002190eusmtrp2N;
 Mon, 23 May 2022 16:16:09 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-13-628bb3493b82
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 7D.19.09404.943BB826; Mon, 23
 May 2022 17:16:09 +0100 (BST)
Received: from localhost (unknown [106.210.248.20]) by eusmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20220523161608eusmtip23cd80bf73bf7fb5af10d44d04beb495e~xyB3eFHeK0812708127eusmtip2N;
 Mon, 23 May 2022 16:16:08 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: axboe@kernel.dk, hch@lst.de, snitzer@redhat.com,
 damien.lemoal@opensource.wdc.com, hare@suse.de, Johannes.Thumshirn@wdc.com
Cc: linux-nvme@lists.infradead.org, dm-devel@redhat.com, dsterba@suse.com,
 jiangbo.365@bytedance.com, linux-kernel@vger.kernel.org,
 gost.dev@samsung.com, linux-block@vger.kernel.org, jaegeuk@kernel.org,
 Pankaj Raghav <p.raghav@samsung.com>, Bart Van Assche <bvanassche@acm.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, Luis Chamberlain
 <mcgrof@kernel.org>
Subject: [PATCH v5 4/7] nvmet: Allow ZNS target to support non-power_of_2
 zone sizes
Date: Mon, 23 May 2022 18:15:58 +0200
Message-Id: <20220523161601.58078-5-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523161601.58078-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7djPc7qem7uTDA73aVisvtvPZjHtw09m
 i99nzzNb7H03m9Xiwo9GJoubB3YyWexZNInJYuXqo0wWT9bPYrboOfCBxeJv1z0mi723tC0u
 75rDZjF/2VN2ixsTnjJafF7awm7RtvEro4Ogx+Ur3h7/Tqxh87h8ttRj06pONo/NS+o9dt9s
 YPPY2Xqf1eP9vqtsHn1bVjF6rN9ylcVj8+lqj8+b5DzaD3QzBfBGcdmkpOZklqUW6dslcGWc
 XGNZcJK/Yte5x+wNjPN4uxg5OSQETCQ+bPrB1sXIxSEksIJR4tGD/2wgCSGBL4wS3+bxQSQ+
 M0pcfzeJDaaj8eFdZojEckaJ75vWs0I4Lxgljl//w97FyMHBJqAl0djJDhIXEWhklHh/dB5Y
 EbPANyaJu/M2MYMUCQuESVy+nA4ylUVAVeLU4QfMIDavgKXE3BmPmCG2yUvMvPSdHcTmFLCS
 uH71KhtEjaDEyZlPWEBsZqCa5q2zwS6SENjOKdHwcztUs4vE8XuvGSFsYYlXx7ewQ9gyEv93
 zmeCsKslnt74DdXcwijRv3M9G8hxEgLWEn1nckBMZgFNifW79CHKHSVOvpzNBFHBJ3HjrSDE
 CXwSk7ZNZ4YI80p0tAlBVCtJ7Pz5BGqphMTlpjksELaHxJM1M1knMCrOQvLMLCTPzELYu4CR
 eRWjeGppcW56arFhXmq5XnFibnFpXrpecn7uJkZgQjz97/inHYxzX33UO8TIxMF4iFGCg1lJ
 hHd7YkeSEG9KYmVValF+fFFpTmrxIUZpDhYlcd7kzA2JQgLpiSWp2ampBalFMFkmDk6pBqbF
 Hz4xp+ystG5mrZn7wnXNZqNfkVc3NbFJBt73ZtgwS//ga8kpj/NXn/JpbpUUf5Dx57rp+9om
 udnuXLd/LhBpnHzZKe/F4tc60x5IVdn+8Z820ZZ/26I6wTizstk+PnNer79+9NubL3aJ92Q2
 eR05JbLwVWmR6AfDYwFf3n14qvbo+1WLfn41qT+1xyuVsurMPliuLP3SKaMd+5+n4ljP8013
 qlcsbRFpirIPZTjK0v8pcvfrmW8eL1Go/ulxuGTmparNJ4UzxCLlPhzw+7b/2+LdzHoiH6Z3
 T/rbXrpn+dp9nFHMlp8PJT3kO+vZwfmkWsLYVC1KsGLZxGyPScqF7DPWNrxju9GkbMT/nGOC
 EktxRqKhFnNRcSIAuQmgVvcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsVy+t/xe7qem7uTDLoa2S1W3+1ns5j24Sez
 xe+z55kt9r6bzWpx4Ucjk8XNAzuZLPYsmsRksXL1USaLJ+tnMVv0HPjAYvG36x6Txd5b2haX
 d81hs5i/7Cm7xY0JTxktPi9tYbdo2/iV0UHQ4/IVb49/J9aweVw+W+qxaVUnm8fmJfUeu282
 sHnsbL3P6vF+31U2j74tqxg91m+5yuKx+XS1x+dNch7tB7qZAnij9GyK8ktLUhUy8otLbJWi
 DS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DJOrrEsOMlfsevcY/YGxnm8XYyc
 HBICJhKND+8ydzFycQgJLGWUmHD2BCNEQkLi9sImKFtY4s+1LjYQW0jgGaPE4Wf5XYwcHGwC
 WhKNnewgvSICnYwSR1ecYgFxmAWamCXeT90D1iAsECJxePpHVhCbRUBV4tThB8wgNq+ApcTc
 GY+YIRbIS8y89J0dxOYUsJK4fvUq1DJLiVPrJ7BD1AtKnJz5hAXEZgaqb946m3kCo8AsJKlZ
 SFILGJlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBEbvtmM/t+xgXPnqo94hRiYOxkOMEhzM
 SiK82xM7koR4UxIrq1KL8uOLSnNSiw8xmgLdPZFZSjQ5H5g+8kriDc0MTA1NzCwNTC3NjJXE
 eT0LOhKFBNITS1KzU1MLUotg+pg4OKUamMRqY/aauLR+bci+4n6kZ3NGJKeO/vI5S/W85oX7
 s3l8u60cnb/TTmS2ROqKvayCp/b7TPasP/tvtb+r1c67y8+URZtxK53x3OKgEulkasukfPbr
 nTlW66ZPNS1f7X96P0vRxLfyNnINnq92ThFpz3PitDvWys7YKcT++1e7ibGPgtD+Zd/nRtT8
 ucJSlV+9TC9FQl1RfmP9F+trbtdmz5vjcHdmX6H0rNdxz5Qvvr+78qNdc4LHJvHv6XnC7fMl
 wpdr6D20jD0bovKN/UsZu6TMnPIU2zrxlwufvc3zk3nL9mn3btd/XKttdmXeCclf+0rhzGXV
 yKn/2m7d+Bh4956FXqzxnnafPdv89K8fV2Ipzkg01GIuKk4EACpvuzJnAwAA
X-CMS-MailID: 20220523161609eucas1p16c381cd9438240905bfdb0a739132e65
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220523161609eucas1p16c381cd9438240905bfdb0a739132e65
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220523161609eucas1p16c381cd9438240905bfdb0a739132e65
References: <20220523161601.58078-1-p.raghav@samsung.com>
 <CGME20220523161609eucas1p16c381cd9438240905bfdb0a739132e65@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220523_091613_155126_1B6033A2 
X-CRM114-Status: GOOD (  15.33  )
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
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/target/zns.c | 2 +-
 include/linux/blkdev.h    | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index e34718b09550..e41b6a6ef048 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -243,7 +243,7 @@ static unsigned long nvmet_req_nr_zones_from_slba(struct nvmet_req *req)
 	unsigned int sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
 
 	return blkdev_nr_zones(req->ns->bdev->bd_disk) -
-		(sect >> ilog2(bdev_zone_sectors(req->ns->bdev)));
+	       bdev_zone_no(req->ns->bdev, sect);
 }
 
 static unsigned long get_nr_zones_from_buf(struct nvmet_req *req, u32 bufsize)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f5c7a41032ba..ed8742a72dcb 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1382,6 +1382,13 @@ static inline sector_t bdev_zone_sectors(struct block_device *bdev)
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


