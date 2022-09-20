Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34CAC6FA82
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 09:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VLoCFLXBp82iOTzKgyetXtUrw6dZfbKcf6Fwvb6vl3E=; b=tFuCikV0UAhTrUT/uSKngHK9YU
	Ij4W3FpyyQZ1AiwiIrZq8dMrkQPGzQCbXdh29ToOaSBdp4rdOu/UMpZJZ/HH0rpNTQoWXp+VWNcOh
	Or+VyY73LsBDvUeP5mR4P8RSAC0PZI7nmcNRxFnWYRgTTnvHncuwPTW9SXiDH31fuEgJ6T7aVhojp
	B/s/2JYky0+69Dwr/QO9p5dvYVBSKQmYTl5atQs36vdysEErYnr3hjuYlb7HdLjci3Q5a4bR5elH6
	fu5k64bsD+r3c/qE7EfnFFre5XO9IUsZV0zTehQtqzv5SFR9d9ZS1OOA65i6+GBsAJWX0kpcpssoI
	K1loXBMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaZS8-002Kka-3l; Tue, 20 Sep 2022 09:22:04 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaZI0-002F1h-4Y
	for linux-nvme@lists.infradead.org; Tue, 20 Sep 2022 09:11:47 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220920091134euoutp011d2a32ecd31efe03e228ea0b05ee3f31~Whpbc7KET1026310263euoutp01c
	for <linux-nvme@lists.infradead.org>; Tue, 20 Sep 2022 09:11:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220920091134euoutp011d2a32ecd31efe03e228ea0b05ee3f31~Whpbc7KET1026310263euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1663665094;
	bh=VLoCFLXBp82iOTzKgyetXtUrw6dZfbKcf6Fwvb6vl3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QUMstUpL30FGnJVIpPdbjqJVwvKeCxfZjY1xA1R1T+ZD2JdduzXIj+KEiZNtzvcHd
	 VdCqIPD8cFgweKo+9I44IgMEHQfeyF7hOA51v7543S6flFcnkBUb5kUPI1nx8irE0v
	 +B+GxqUaheV8wnAog4LI9c+d5K730RWnszvijIJA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220920091132eucas1p258906bd9e7c9bcde2cddfce391c4a8d5~WhpZanmJ73137931379eucas1p2P;
	Tue, 20 Sep 2022 09:11:32 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 5E.98.19378.4C389236; Tue, 20
	Sep 2022 10:11:32 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220920091132eucas1p2e98ce6f411f1c3e8e10c4eae81aba296~WhpY6EFIs3137931379eucas1p2M;
	Tue, 20 Sep 2022 09:11:32 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220920091132eusmtrp18c66e0aef4e2083a5eb7781af15d74e1~WhpY4-1NW0212802128eusmtrp15;
	Tue, 20 Sep 2022 09:11:32 +0000 (GMT)
X-AuditID: cbfec7f5-a4dff70000014bb2-d1-632983c471be
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id F9.0E.07473.3C389236; Tue, 20
	Sep 2022 10:11:32 +0100 (BST)
Received: from localhost (unknown [106.210.248.192]) by eusmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20220920091131eusmtip1e6641e79ecaaeeccfd239bb6f758759d~WhpYkCkHT1070710707eusmtip1t;
	Tue, 20 Sep 2022 09:11:31 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
	damien.lemoal@opensource.wdc.com, hch@lst.de
Cc: gost.dev@samsung.com, jaegeuk@kernel.org, Johannes.Thumshirn@wdc.com,
	hare@suse.de, bvanassche@acm.org, dm-devel@redhat.com,
	matias.bjorling@wdc.com, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, pankydev8@gmail.com,
	linux-block@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v14 11/13] dm: call dm_zone_endio after the target endio
 callback for zoned devices
Date: Tue, 20 Sep 2022 11:11:17 +0200
Message-Id: <20220920091119.115879-12-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920091119.115879-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0wTVwDOu2uvR6V4HDjewIxQwyYYEadLXgZxGme5xQSnGUtm/EFTbtjQ
	ImmtsmE2NstvEaw4oBAGzAEDYxELpVCQNJOqaApWkxasGqUOEERWmRIjjnI1+t/3vh/ve1/y
	SJy+zw8n5ZlHWFWmVCEmhLyuwQX7+r9PxMjiLzujkeH6II7a3GUE+u3ZAo5e3bTjqO9pDR+5
	BswYsjTqMPRX2xUMjRv0OHpdfA9DfaPrkKOnlkC/N3kEqDx/HkfeP7UCdN7l4aGroxFbgxnH
	7Z2MWe8WMI6bGqajtYhgLp37mel15RKMOe8+n5ntv0Mwp4ytgLk0lMN4Oz5iCgZKsK8D9woT
	01iF/Cir2rAlVXjIYGnHsuqCsisaTUQuGFlRDAJISG2G1pEavBgISZpqAfDBtXKMOzwHsG1i
	2q94ARzwzGFvI7kVTj4nNAPY132a8Ak0NQngI903xYAkCSoW/lIk8NGhVDqcn28HPj9OdWGw
	sqIR9wkhFAvHXs8uZ3lUNDR19izzIioBOvr/43NlkbD61ovliwKW+NpeLcF5guG16nGeD+NL
	nhOd3AZIGQKg867RH/4SjowWAg6HwCmbUcDh1XDozEkeh3Ogx/nKH9YCWGY2EL4FcKnt1A2F
	D+JUDDT0bODs2+C/N27hnCMIOmeCuScEQV1XpZ8WwcJ8mnOLoXlh3F8KoePXWn8pA51TVlAO
	ovTvjdG/N0b/rrce4K0gjNWolemselMmeyxOLVWqNZnpcbLDyg6w9AeHFm3z3aBlai7OCjAS
	WAEkcXGoSLsrRkaL0qQ//MiqDh9UaRSs2goiSJ44TCSTt0tpKl16hM1g2SxW9VbFyIDwXCxs
	p8s8k3RHfkEpe/msuzIuuy7j05RVZ+ojvy/rPvYiZqNx+HrJVx+f++cnlXuCdsSbarSx7qGo
	OmSik6syjMrJZFeWZ9+iqeDAtF46UfhZwdNZu61UkfxF1OIbSYP3ZXRV8/ZPGlPGdqfs0Goj
	tk4mFiaV2PIekgV5qjdNXY8lylXiPU8Gv3twVG+020sVkrDw4SRvKd9iD5yJHiwz0TXVwrQ5
	pn7L8UcJCWzz2LeBkhadUz6t+zyx3ZJky46aPdtwceWUcY0t4oPzitQPHY/jO/Jvszv259c3
	8eRVVzYnWqjszsvDdyVr/zjwpKgh8rk75/RxwcDeEY1NES7vFV8V89SHpBtjcZVa+j/ndTSZ
	8gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xu7pHmjWTDX69ZbJYf+oYs8Xqu/1s
	FtM+/GS2+H32PLPF3nezWS1uHtjJZLFn0SQmi5WrjzJZPFk/i9nib9c9Jou9t7QtLu+aw2Yx
	f9lTdosJbV+ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
	zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAnii9GyK8ktLUhUy8otLbJWiDS2M9Awt
	LfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DLW79nAVDCPr2LKou1sDYwXubsYOTkkBEwk
	GqbcYO1i5OIQEljKKHF52zc2iISExO2FTYwQtrDEn2tdbBBFzxklXs47BtTBwcEmoCXR2MkO
	UiMikCtxePMEJhCbWeAIk8TiqTEgtrBAssSL5TNZQWwWAVWJ7Vt3MYPYvALWEpf3fWOFmC8v
	MfPSd7A5nEDxObtbwG4QErCS6Ji1mQ2iXlDi5MwnLBDz5SWat85mnsAoMAtJahaS1AJGplWM
	IqmlxbnpucWGesWJucWleel6yfm5mxiBEbvt2M/NOxjnvfqod4iRiYPxEKMEB7OSCG+Lv2ay
	EG9KYmVValF+fFFpTmrxIUZToLsnMkuJJucDU0ZeSbyhmYGpoYmZpYGppZmxkjivZ0FHopBA
	emJJanZqakFqEUwfEwenVAPT5lPleUsOp/OzVwmYzTUr/Kd9xvnFpKKAy1rCL3euObRCeaPn
	mrgN7etzn07s1DUM85XKCLVcf1V8W9aXJ5vnaaz5OCGO4VhAa1rkG5ldLRe925mCwj/y/Xvw
	49qjwAdrjjwq2RAjfG6i7fUb2xd8dmY61bq7cbGtXPrdWwy3K2wi3tWpON9Ws59/1ry9Sz6m
	pE3vM9tTw2DPwMo/G+98ETTXMwo88uULX9YXnTTujit8Hbs6HnwNzXB1kjn7xGLLq+tfun5x
	Z/7sDdl24RTT5rBgO845bo9Cz5w/0/b6Z5t3/W+1qUddTya8eWh2vCVm0lFd9/sTdrec3M8l
	f+1/607vsC7N+JCjm79t5Pq0T4mlOCPRUIu5qDgRALvGQYBhAwAA
X-CMS-MailID: 20220920091132eucas1p2e98ce6f411f1c3e8e10c4eae81aba296
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220920091132eucas1p2e98ce6f411f1c3e8e10c4eae81aba296
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220920091132eucas1p2e98ce6f411f1c3e8e10c4eae81aba296
References: <20220920091119.115879-1-p.raghav@samsung.com>
	<CGME20220920091132eucas1p2e98ce6f411f1c3e8e10c4eae81aba296@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_021144_408246_CEE6356D 
X-CRM114-Status: GOOD (  16.43  )
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

dm_zone_endio() updates the bi_sector of orig bio for zoned devices that
uses either native append or append emulation, and it is called before the
endio of the target. But target endio can still update the clone bio
after dm_zone_endio is called, thereby, the orig bio does not contain
the updated information anymore.

Currently, this is not a problem as the targets that support zoned devices
such as dm-zoned, dm-linear, and dm-crypt do not have an endio function,
and even if they do (such as dm-flakey), they don't modify the
bio->bi_iter.bi_sector of the cloned bio that is used to update the
orig_bio's bi_sector in dm_zone_endio function.

This is a prep patch for the new dm-po2zoned target as it modifies
bi_sector in the endio callback.

Call dm_zone_endio for zoned devices after calling the target's endio
function.

Reviewed-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/md/dm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 7c35dea88ed1..874e1dc9fc26 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1122,10 +1122,6 @@ static void clone_endio(struct bio *bio)
 			disable_write_zeroes(md);
 	}
 
-	if (static_branch_unlikely(&zoned_enabled) &&
-	    unlikely(bdev_is_zoned(bio->bi_bdev)))
-		dm_zone_endio(io, bio);
-
 	if (endio) {
 		int r = endio(ti, bio, &error);
 		switch (r) {
@@ -1154,6 +1150,10 @@ static void clone_endio(struct bio *bio)
 		}
 	}
 
+	if (static_branch_unlikely(&zoned_enabled) &&
+	    unlikely(bdev_is_zoned(bio->bi_bdev)))
+		dm_zone_endio(io, bio);
+
 	if (static_branch_unlikely(&swap_bios_enabled) &&
 	    unlikely(swap_bios_limit(ti, bio)))
 		up(&md->swap_bios_semaphore);
-- 
2.25.1


