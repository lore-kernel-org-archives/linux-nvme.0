Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6D6C433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Mar 2022 17:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EVDf6R84igtJ/y3qEBnMjQVZ6aHLsjiJLYrL/j3arWY=; b=GsOZIZItI9D6i6uZWtI2p2djEX
	yr3N5U/BVZyG5PK+XiUWsyiMbLM2gm5MMG/VGP+p4lhbSoznuZmnxOQ+Shsdu95w+4ztxzXWLWYFA
	Oa2MFZKRnUV0JSNVkFjtNbEFjwwsZT+yvj6QP5zBdZR0WjvI4xO16ABra/J8PN/nPUhsaSCVGKXbq
	HeiE3Ryw+ukkdVBtZNQZNTzf+ghmGCmwyibtRryMbrgoFpj1QnpNIhEYHWMKHtUxFc9Qk9eS07oK5
	m1HueqE6gkXui/+SArc4oCoHAewDJ5nJHBB3Zz5ugozho5AFilK/zJBNbme0UJJq2x1jgU+s3Wkdn
	tstO038w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRdI3-005PsD-7A; Tue, 08 Mar 2022 17:06:27 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRd6V-005LhF-Ch
 for linux-nvme@lists.infradead.org; Tue, 08 Mar 2022 16:54:33 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20220308165429euoutp0238edad0587ff04305dae41112780103e~adhp-A3WZ1933719337euoutp02v
 for <linux-nvme@lists.infradead.org>; Tue,  8 Mar 2022 16:54:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20220308165429euoutp0238edad0587ff04305dae41112780103e~adhp-A3WZ1933719337euoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1646758469;
 bh=EVDf6R84igtJ/y3qEBnMjQVZ6aHLsjiJLYrL/j3arWY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LituMgqU9LIp3lnrMliwz6Y+7ktuI89sBo6Qc/X5fCTbbyggNk+Otx7tfjRI2+Avp
 DXxSCb7m8unbkR6+DeG1S+C/xRVUSX5M3ubJZs7F5g0kJLBjRFRab8HiY2Zh5lw7sV
 9cSvu3EXxRdyo7/qENLkodH7KaK7dSJopUE40ebM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20220308165429eucas1p211fb120efe0efa0a2a27a3ea3a400ff9~adhph4M3Q2912829128eucas1p2F;
 Tue,  8 Mar 2022 16:54:29 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 23.4B.10009.54A87226; Tue,  8
 Mar 2022 16:54:29 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20220308165428eucas1p14ea0a38eef47055c4fa41d695c5a249d~adhohIFSy0406404064eucas1p1l;
 Tue,  8 Mar 2022 16:54:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20220308165428eusmtrp17c3bb4cc2490d53f3a86cad323a434ae~adhogYd9f0526005260eusmtrp1S;
 Tue,  8 Mar 2022 16:54:28 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-cd-62278a457bf8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 0B.73.09522.44A87226; Tue,  8
 Mar 2022 16:54:28 +0000 (GMT)
Received: from localhost (unknown [106.210.248.181]) by eusmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20220308165428eusmtip140f2ab8c2fedd3e5358318dcff5517a4~adhoODwyn0418504185eusmtip1V;
 Tue,  8 Mar 2022 16:54:28 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Adam Manzanares
 <a.manzanares@samsung.com>, =?UTF-8?q?Javier=20Gonz=C3=A1lez?=
 <javier.gonz@samsung.com>, kanchan Joshi <joshi.k@samsung.com>, Jens Axboe
 <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
 <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Damien Le Moal
 <damien.lemoal@opensource.wdc.com>, =?UTF-8?q?Matias=20Bj=C3=B8rling?=
 <matias.bjorling@wdc.com>, jiangbo.365@bytedance.com
Cc: Pankaj Raghav <pankydev8@gmail.com>, Kanchan Joshi
 <joshiiitr@gmail.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 2/6] block: Add npo2_zone_setup callback to block device fops
Date: Tue,  8 Mar 2022 17:53:45 +0100
Message-Id: <20220308165349.231320-3-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308165349.231320-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsWy7djP87quXepJBlu7RC2mH1a0WH23n83i
 99nzzBYrVx9lsnh85zO7Rc+BDywWR/+/ZbM4//Ywk8WkQ9cYLfbe0raYv+wpu8WEtq/MFjcm
 PGW0+Ly0hd1izc2nLBbrXr9ncRDw+HdiDZvHzll32T3O39vI4nH5bKnHplWdbB6bl9R77L7Z
 AJRrvc/q0bdlFaPH501yHu0HupkCuKO4bFJSczLLUov07RK4Mm68XsRc0M1XsWn5R7YGxjPc
 XYycHBICJhIfp/1g6WLk4hASWMEoMXHXCiYI5wujxLKe82wQzmdGiVlPnjDDtNx8vY8dIrGc
 UeL6+bvsIAkhgZeMEptaS7oYOTjYBLQkGjvBwiICF5glftxUBKlnFtjMKPFh0gpWkISwgL/E
 vb5usKEsAqoS+2c1sYHYvAJWEgdmfGCDWCYvMfPSd7BBnALWEk87Z0LVCEqcnPmEBcRmBqpp
 3jqbGWSBhMByTonbm76xQzS7SKz+dZgJwhaWeHV8C1RcRuL05B4WiIZ+RompLX+YIJwZjBI9
 hzczgbwgAbSu70wOiMksoCmxfpc+RNRR4t40JwiTT+LGW0GIE/gkJm2bzgwR5pXoaBOCWKQk
 sfPnE6ilEhKXm+awQNgewCCczD6BUXEWkmdmIXlmFsLaBYzMqxjFU0uLc9NTiw3zUsv1ihNz
 i0vz0vWS83M3MQLT3ul/xz/tYJz76qPeIUYmDsZDjBIczEoivPfPqyQJ8aYkVlalFuXHF5Xm
 pBYfYpTmYFES503O3JAoJJCeWJKanZpakFoEk2Xi4JRqYBLe+Mf+n4Tf+fynO8RefD/y+Ezd
 6fvBLvHZAZ3nriddM+Wp54hr7i1r2if9qz04THTRFJfXKm94hFvfnpwxb8osm1b1rRnr/8gG
 Jf6RnPPfYCk/x+wdGqz6j5vfzPTuO37s4aFryw0XcCW3+bL7HmQ8OrEjsbxjl7nYnasf4pk3
 H7HeF6j9bbl7+vQf96LPbd2zK5Tp+r7FP9v49r9SDIttde26lHMgy/H8koee/XzC8vWzZfZU
 rbJ15fetmRZ86c/JKdssk3YFcFuoJR3N/J9lmnhqjWyR28UHT9ZY1ey87zh9OYdC+36NeS/L
 thzP29jyeU7Lc12XtZntCtctlpxdfef7pK1eWQm1mvoNGppKLMUZiYZazEXFiQC2OYlv6gMA
 AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xu7ouXepJBhuf8llMP6xosfpuP5vF
 77PnmS1Wrj7KZPH4zmd2i54DH1gsjv5/y2Zx/u1hJotJh64xWuy9pW0xf9lTdosJbV+ZLW5M
 eMpo8XlpC7vFmptPWSzWvX7P4iDg8e/EGjaPnbPusnucv7eRxePy2VKPTas62Tw2L6n32H2z
 ASjXep/Vo2/LKkaPz5vkPNoPdDMFcEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvH
 WhmZKunb2aSk5mSWpRbp2yXoZdx4vYi5oJuvYtPyj2wNjGe4uxg5OSQETCRuvt7H3sXIxSEk
 sJRR4m/bdCaIhITE7YVNjBC2sMSfa11sEEXPGSUmvVoBlODgYBPQkmjsBGsWEbjBLLFsahsj
 iMMssJ1RYsPKOWwgRcICvhJTtkWADGIRUJXYP6uJDcTmFbCSODDjAxvEAnmJmZe+s4PYnALW
 Ek87Z4LFhYBqfh1oZYKoF5Q4OfMJC4jNDFTfvHU28wRGgVlIUrOQpBYwMq1iFEktLc5Nzy02
 1CtOzC0uzUvXS87P3cQIjNFtx35u3sE479VHvUOMTByMhxglOJiVRHjvn1dJEuJNSaysSi3K
 jy8qzUktPsRoCnT3RGYp0eR8YJLIK4k3NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1I
 LYLpY+LglGpgig//+WaV+eao81fnBqiEu/4VX9dWu3z3nL+HhFIWvJ74L6nuaLPYLPFJS2oO
 LF6zJWzWGqO1FpKGi+79nLuyap/mv8mVvFvvCIS/T/K7YX981paZ0/VXBzm+WJuizbnT65qK
 mu60g5axVy422B7922jxZZ6UpvrUtr16XtOSbDqUsooi9keICz2zefb4/Mppr+xMlobIHmBd
 FCfskvz7mOu8ovX/FT/ENX2b+yLD1/3dRdb/cwsa4suPlT46te74TZZweaslaWdW/+07JTj9
 4px3X6qmTtOJ2JQSbvfB6F1Hfn7JVe+w77Y1KyfEnzNmzKhnEAlSmZ+imzU9etuKN9syumT1
 FZrnXDxhcF4+b6YSS3FGoqEWc1FxIgDCpdpDWgMAAA==
X-CMS-MailID: 20220308165428eucas1p14ea0a38eef47055c4fa41d695c5a249d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220308165428eucas1p14ea0a38eef47055c4fa41d695c5a249d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220308165428eucas1p14ea0a38eef47055c4fa41d695c5a249d
References: <20220308165349.231320-1-p.raghav@samsung.com>
 <CGME20220308165428eucas1p14ea0a38eef47055c4fa41d695c5a249d@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_085431_763202_C6B19A12 
X-CRM114-Status: GOOD (  15.66  )
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

A new fops is added to block device which will be used to setup the
necessary hooks when a non-power_of_2 zone size is detected in a zoned
device.

This fops will be called as a part of blk_revalidate_disk_zones.

The primary use case for this callback is to deal with zoned devices
that does not have a power_of_2 zone size such as ZNS drives.For e.g,
the current NVMe ZNS specification does not require zone size to be
power_of_2 but the linux block layer still expects a all zoned device to
have a power_of_2 zone size.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 block/blk-zoned.c      | 3 +++
 include/linux/blkdev.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 602bef54c813..d3d821797559 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -575,6 +575,9 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 	if (!get_capacity(disk))
 		return -EIO;
 
+	if (disk->fops->npo2_zone_setup)
+		disk->fops->npo2_zone_setup(disk);
+
 	/*
 	 * Ensure that all memory allocations in this context are done as if
 	 * GFP_NOIO was specified.
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a12c031af887..08cf039c1622 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1472,6 +1472,7 @@ struct block_device_operations {
 	void (*swap_slot_free_notify) (struct block_device *, unsigned long);
 	int (*report_zones)(struct gendisk *, sector_t sector,
 			unsigned int nr_zones, report_zones_cb cb, void *data);
+	void (*npo2_zone_setup)(struct gendisk *disk);
 	char *(*devnode)(struct gendisk *disk, umode_t *mode);
 	/* returns the length of the identifier or a negative errno: */
 	int (*get_unique_id)(struct gendisk *disk, u8 id[16],
-- 
2.25.1


