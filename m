Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53C4C3DA7A
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Jan 2023 08:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=RdOD06wolOCIAicxPsN2ij6az3cOrx4wHkq03SQoR78=; b=Ja0D/xJ/3YULzDbZg/8/+xCVX3
	RVKNHotOskD6Zo4DlwZy0hnP7e/4+0yjoYp/e5LaHdKKkg3nODY5y24ruGr6sF2FqdhlaYy5IO0iY
	Mk5uZX/QTQZ59RmnCZXkaXRpBK+nwPc0IIcHnnFRq5FKTJp/MUTf8Wb9/d245MsTVqyZigoJ28bsq
	KPAbg/w+lyZK2MRWtb2wSx6ISv2XPU665mh2+NZaWrCOS6ecLjGKhQoJd3ZbeQOGTP27zj7hXL4gB
	mnEQ1bBgDIT1KXLmgy2XB/Ia5oq7+wXtKWtmR5MDWO41/HdTprtdj8q6NUcmEL/t0RqE95zVM5y2q
	BwoVWHqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDiAV-006e3n-9F; Fri, 06 Jan 2023 08:33:39 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pDiAK-006dvo-Ny
	for linux-nvme@lists.infradead.org; Fri, 06 Jan 2023 08:33:32 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230106083320euoutp013a1fb1ec82e4a9c5d60b2ab10a72e52c~3qy3k3v0z1733617336euoutp01a
	for <linux-nvme@lists.infradead.org>; Fri,  6 Jan 2023 08:33:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230106083320euoutp013a1fb1ec82e4a9c5d60b2ab10a72e52c~3qy3k3v0z1733617336euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1672994000;
	bh=RdOD06wolOCIAicxPsN2ij6az3cOrx4wHkq03SQoR78=;
	h=From:To:Cc:Subject:Date:References:From;
	b=CnbydIeAviAlGIk4cryN6Fw9u2a2gZ9Iw0a93SdRj7VF9YeCgT35PvF/tzreEOVES
	 CQb6UDuLO5AS84fwM2MmltZ6MNGcmAx0iLJKscebUu0j6MQwWzPfoDxZUlIiIX+cR0
	 XHp6zWo+sj9EcW4Q//b9bmK3Bf9pjdTnFNJUkQ8E=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20230106083319eucas1p2f07e06335cea133036a099678e5780c8~3qy2t7MAJ0992309923eucas1p26;
	Fri,  6 Jan 2023 08:33:19 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 96.14.61936.FCCD7B36; Fri,  6
	Jan 2023 08:33:19 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20230106083318eucas1p1a2ab71a95ab2906b4651538c63a94ae2~3qy2XZ6nJ1095210952eucas1p1E;
	Fri,  6 Jan 2023 08:33:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230106083318eusmtrp1a6df33b9d2377ba20b7a7b965d6a9e93~3qy2Wlb9c2166121661eusmtrp1f;
	Fri,  6 Jan 2023 08:33:18 +0000 (GMT)
X-AuditID: cbfec7f4-a2dff7000002f1f0-ce-63b7dccfbd0d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id E6.C6.23420.ECCD7B36; Fri,  6
	Jan 2023 08:33:18 +0000 (GMT)
Received: from localhost (unknown [106.210.248.66]) by eusmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20230106083318eusmtip1a6555075bf69d5e8699929cba0a653cc~3qy2Gbyys0159601596eusmtip1O;
	Fri,  6 Jan 2023 08:33:18 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: axboe@kernel.dk
Cc: kernel@pankajraghav.com, linux-kernel@vger.kernel.org, hare@suse.de,
	bvanassche@acm.org, snitzer@kernel.org, dm-devel@redhat.com,
	damien.lemoal@opensource.wdc.com, linux-nvme@lists.infradead.org,
	hch@lst.de, linux-block@vger.kernel.org, gost.dev@samsung.com, Pankaj Raghav
	<p.raghav@samsung.com>
Subject: [PATCH 0/7] block zoned cleanups
Date: Fri,  6 Jan 2023 09:33:10 +0100
Message-Id: <20230106083317.93938-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMKsWRmVeSWpSXmKPExsWy7djP87rn72xPNth1gcdi9d1+NotpH34y
	W/w+e57ZYu+72awWNw/sZLLYs2gSk8XK1UeZLM68/MxisfeWtsXlXXPYLOYve8pu8XlpC7vF
	iVvSDrwel694e1w+W+qxaVUnm8fmJfUeu282sHnsbL3P6nF2paPH+31X2Tz6tqxi9Nh8utrj
	8ya5AO4oLpuU1JzMstQifbsEroy1x8+zF3TwVNzZ0M7UwDiHs4uRk0NCwESi/30LWxcjF4eQ
	wApGiYerW1lAEkICXxgl1s+CSnxmlDh/7gwbTMeZYxPZIRLLgRIrPrJCOC8YJV59nsnUxcjB
	wSagJdHYyQ7SICIgLLG/A2QqFwezwGYmidu/1zKC1AgLaEr8fx4OYrIIqEo87LABKecVsJT4
	2LeYBWKXvMTMS9/ZIeKCEidnPgGLMwPFm7fOZgYZKSHwg0Ni45d1UA0uEjsPXIKyhSVeHd/C
	DmHLSJye3AMVr5Z4euM3VHMLo0T/zvVsIEdICFhL9J3JATGZgU5bv0sfotxRoufiUWaICj6J
	G28FIU7gk5i0bTpUmFeio00IolpJYufPJ1BLJSQuN82BWuoh8WVFDxskaGMlWhb2Mk5gVJiF
	5LFZSB6bhXDDAkbmVYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIHp7PS/4192MC5/9VHv
	ECMTB+MhRgkOZiUR3rL+bclCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeWdsnZ8sJJCeWJKanZpa
	kFoEk2Xi4JRqYFpTVC2lGbfpo8OmiQsl2ubMCU72/JxgV9j3Stv0zWmezTYffmpadSht6by9
	2z+reed560nbK/5yC3UIM7Jp3Mjc4j6vhPfZst+qOasFE5P9pE0nOSYy3fmWdMZIles78575
	OsFfzmdu21MV/dVEkdlC4vHUnax53wWd5hxIqFqTecS317Lxs6xBjk6l+oH1C/ze+/XbC5ga
	BWdeuXRUqWZL4877Myv7NrKaP1cuXng6afrtP0yJQvveRtXMmxIQ6qGR3SNuvtuzetm6m9f+
	5lg/vnPlqNmNVTu2Fi7g5r86La6eY7ZrWr8151Lr/uT1k0t/n5mc815smzWny7w8De9b/tHh
	Ev0PTQ8aLTllrsRSnJFoqMVcVJwIAEX1jw/WAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsVy+t/xu7rn7mxPNmieo2ex+m4/m8W0Dz+Z
	LX6fPc9ssffdbFaLmwd2MlnsWTSJyWLl6qNMFmdefmax2HtL2+LyrjlsFvOXPWW3+Ly0hd3i
	xC1pB16Py1e8PS6fLfXYtKqTzWPzknqP3Tcb2Dx2tt5n9Ti70tHj/b6rbB59W1Yxemw+Xe3x
	eZNcAHeUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqRvl2C
	Xsba4+fZCzp4Ku5saGdqYJzD2cXIySEhYCJx5thEdhBbSGApo8SfMzoQcQmJ2wubGCFsYYk/
	17rYuhi5gGqeMUqcOTUHqIGDg01AS6KxE6xXBKhmf0crC0gNs8BBJolnU74zg9QIC2hK/H8e
	DmKyCKhKPOywASnnFbCU+Ni3mAVivLzEzEvfwSYyA1Wv36UPUSIocXLmE7ASZqCS5q2zmScw
	8s9CqJqFpGoWkqoFjMyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxAqNu27Gfm3cwznv1Ue8Q
	IxMH4yFGCQ5mJRHesv5tyUK8KYmVValF+fFFpTmpxYcYTYGOnsgsJZqcD4z7vJJ4QzMDU0MT
	M0sDU0szYyVxXs+CjkQhgfTEktTs1NSC1CKYPiYOTqkGplp7ptQXvK+UEyoSXVeY7BYU3nWe
	KVXhSLfAvcNbKpsvHO7JO8B0YxJny4VFOWtevw1r7kn7UvzZ0/hWA0fuuunh76LmFj84qrXJ
	a6dCYdDT71IbZ3StqeAXybj26q9xSEjLmqL/f2vMPrLv5WRXqotwjknYIuacW1bel55VZ2FU
	b3T82jz21TfTf+d0CqwzeHbj8u7Pa1b931YvuODjl2Wvtd7OMb75Z/bDsAJxZs4/rulfO9MW
	fAq+pjK55WxD5YVGg9/7+o3ZXt8omBUUzBHTOG335Vaz89Nv3zrTGibBY/JzDd//Rr7v+Rya
	L3VEetNushrKTbrNvvPE6nvOvo4x+0P0FuudPxBw0DFURImlOCPRUIu5qDgRAD3Q8I9DAwAA
X-CMS-MailID: 20230106083318eucas1p1a2ab71a95ab2906b4651538c63a94ae2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230106083318eucas1p1a2ab71a95ab2906b4651538c63a94ae2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230106083318eucas1p1a2ab71a95ab2906b4651538c63a94ae2
References: <CGME20230106083318eucas1p1a2ab71a95ab2906b4651538c63a94ae2@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230106_003329_477977_7FD21184 
X-CRM114-Status: GOOD (  14.15  )
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

Hi Jens,
  It is still unclear whether the support for non-po2 zone size devices
  will be added anytime soon [1]. I have extracted out the cleanup
  patches that doesn't do any functional change but improves the
  readability by adding helpers. This also helps a bit to
  maintain off-tree support as there is an interest to have this feature
  in some companies.

I have retained the reviewed by tags for the commits that did not change
from the main patches I sent before[1].

[1] https://lore.kernel.org/lkml/20220923173618.6899-1-p.raghav@samsung.com/

Luis Chamberlain (1):
  dm-zoned: ensure only power of 2 zone sizes are allowed

Pankaj Raghav (6):
  block: remove superfluous check for request queue in bdev_is_zoned
  block: add a new helper bdev_{is_zone_start, offset_from_zone_start}
  nvmet: introduce bdev_zone_no helper
  zonefs: use bdev_zone_no helper to calculate the zone index
  dm-zone: use generic helpers to calculate offset from zone start
  dm: call dm_zone_endio after the target endio callback for zoned
    devices

 block/blk-core.c             |  2 +-
 block/blk-zoned.c            |  4 ++--
 drivers/md/dm-zone.c         |  8 +++-----
 drivers/md/dm-zoned-target.c |  8 ++++++++
 drivers/md/dm.c              |  8 ++++----
 drivers/nvme/target/zns.c    |  3 +--
 fs/zonefs/super.c            |  8 +++-----
 fs/zonefs/zonefs.h           |  1 -
 include/linux/blkdev.h       | 28 +++++++++++++++++++++++-----
 9 files changed, 45 insertions(+), 25 deletions(-)

-- 
2.25.1


