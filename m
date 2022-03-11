Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7980C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 20:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=IrnrivSWdBi1jbnqkYReex6gYJuSIXcG7oV15smmMuw=; b=4695zEZGwTHMZpJi01XYN/tpHQ
	OLvNEYr3mSFennCGEoOf3Ekr85g2ZivfeR4iW0fMTJx55fj9bU+WLx+quHam3r+W6Uzeq1e9BvZR9
	popq5bPQlDNjln76tSCn/s4bMGJ6Lx9e3lG26PEiVOp9HADJLIdkkxTmEcJFJKXbxQi0cYfkkX66u
	rOKVbDl8LC4s6QKHcSy8PrZ+tcCVlgyG+zzyG5T6qek6x+z5Gg4PWzp/QolEN0ZaEqK31x2iMUcMS
	peAQL/S7sY/6WyjigxU6IhGom/BAmC4kJy0F93OzY0oG4pRipIngAm2CWOULpqz2HgcsM7rHZZgQ/
	7CYRVMeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSlh1-000A4L-AR; Fri, 11 Mar 2022 20:16:55 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSlgx-000A3K-Ga
 for linux-nvme@lists.infradead.org; Fri, 11 Mar 2022 20:16:53 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20220311201640euoutp02c41d0fd2bd50248305b76478fb758ecd~bbOCgx7kk0325903259euoutp02F
 for <linux-nvme@lists.infradead.org>; Fri, 11 Mar 2022 20:16:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20220311201640euoutp02c41d0fd2bd50248305b76478fb758ecd~bbOCgx7kk0325903259euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1647029800;
 bh=IrnrivSWdBi1jbnqkYReex6gYJuSIXcG7oV15smmMuw=;
 h=From:To:Cc:Subject:Date:References:From;
 b=nbYZp/6zB3aA2Taor2HqUW9EjvucccwMsIow9QJHWl0JZCp1l7nuKugIsPw+IkWtQ
 UdKVFYDqIqOgpClSLuYiNQnfmDm6Pdnm44F+7Y6Be8gXSyWeH6p19JVAEmK4zGkDHr
 e+6sn2V2w89TiiODh1gmh73ZgidbRQuHaBLcSSwg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20220311201639eucas1p2efe40336097e6a0eb92ce580d9f64773~bbOBV6Gyi0427904279eucas1p25;
 Fri, 11 Mar 2022 20:16:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id 6B.EE.09887.72EAB226; Fri, 11
 Mar 2022 20:16:39 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20220311201638eucas1p18b9c5ecb3442b5a53bba233591d34db0~bbOAEkD8A0850408504eucas1p1l;
 Fri, 11 Mar 2022 20:16:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20220311201638eusmtrp1bc85ed072a659bf908afc07db2cba174~bbOADx4dJ1553715537eusmtrp1c;
 Fri, 11 Mar 2022 20:16:38 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-b6-622bae27ae75
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id E9.65.09404.52EAB226; Fri, 11
 Mar 2022 20:16:37 +0000 (GMT)
Received: from localhost (unknown [106.210.248.212]) by eusmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20220311201637eusmtip2c0f382ad4cd0c5a7f9b2090ca2507799~bbN-q9See2126221262eusmtip2C;
 Fri, 11 Mar 2022 20:16:37 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>, Keith
 Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Johannes Thumshirn <johannes.thumshirn@edc.com>, Chaitanya Kulkarni
 <chaitanya.kulkarni@wdc.com>, Jens Axboe <axboe@kernel.dk>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Adam Manzanares
 <a.manzanares@samsung.com>, kanchan Joshi <joshi.k@samsung.com>, Pankaj
 Raghav <pankydev8@gmail.com>, Kanchan Joshi <joshiiitr@gmail.com>,
 linux-nvme@lists.infradead.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH] nvme: Fix zns drives without append support to export
 correct permissions
Date: Fri, 11 Mar 2022 21:16:08 +0100
Message-Id: <20220311201608.275384-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsWy7djPc7rq67STDA4fELeYfljRYvXdfjaL
 Wbdfs1j8Pnue2WLl6qNMFo/vfGa3mHJ1KZPF0f9v2SzOvz3MZDHp0DVGi/nLnrJb3JjwlNHi
 89IWdos1N5+yWKx7/Z7Fgd/j8p/9TB47Z91l9zh/byOLx+WzpR6bVnWyeWxeUu+x+2YDm8fO
 1vusHn1bVjF6tB/oZgrgiuKySUnNySxLLdK3S+DKuHZ/OXPBIt6KUy/2sjUw9nN3MXJySAiY
 SDy8+5Kli5GLQ0hgBaPEmxdnGSGcL4wSV7pPsUI4nxklNrSsZIFpOd3xDKpqOaPE/2k/mCGc
 l4wSlx9/BcpwcLAJaEk0drKDxEUE7jFJXP1zBsxhFuhnkpgy8SQTyChhgRiJxsmvwWwWAVWJ
 OVPesYA08wpYSTyY4Q+xTV5i5qXv7CA2r4CgxMmZT8CuYAaKN2+dDbZYQqCdU+Ly0RPMEA0u
 Euv3n2eHsIUlXh3fAmXLSJye3MMC0dDPKDG15Q8ThDODUaLn8GYmkM0SAtYSfWdyQExmAU2J
 9bv0IXodJVrfnGWDqOCTuPFWEOIGPolJ26YzQ4R5JTrahCCqlSR2/nwCtVVC4nLTHGjAeUj0
 XVzACGILCcRK3L1zjWUCo8IsJJ/NQvLZLIQbFjAyr2IUTy0tzk1PLTbKSy3XK07MLS7NS9dL
 zs/dxAhMdaf/Hf+yg3H5q496hxiZOBgPMUpwMCuJ8DaFaiQJ8aYkVlalFuXHF5XmpBYfYpTm
 YFES503O3JAoJJCeWJKanZpakFoEk2Xi4JRqYLKbfOv9M97D6cdv961Tj+I++L3tQ4G25OrF
 m76L7Czs2sQpt+dE+dPyS5kcPz9arf5Y8a1BZfdpu+dGTbeY1A/l5haf+m78Yc/qWWtmTbZR
 2/9j5oKlrxxPnV83gyvugOpq9SyV/JjgZ03TexJEn88sCq+5Z+d4KCn8RuYc/8riwL5qhsu7
 ORqj+bplI6xib+VceNi0yIxXZHlaR86Lub67b9WUpXptMM55VKgW0csot1Biz6bfF3QeVz5X
 Pbsi9lXtcu5b/S13XjqWR3nWPZxldKZD/vO1Yv4HlodYnR/O6EvTNnmi1RAVseFM4mGdVec5
 OzYyf1Sfed9VaoZ3Br/qzoNctUsO1gZ3bD8ScFOJpTgj0VCLuag4EQDzJ1Bb5AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsVy+t/xe7qq67STDN5ttLGYfljRYvXdfjaL
 Wbdfs1j8Pnue2WLl6qNMFo/vfGa3mHJ1KZPF0f9v2SzOvz3MZDHp0DVGi/nLnrJb3JjwlNHi
 89IWdos1N5+yWKx7/Z7Fgd/j8p/9TB47Z91l9zh/byOLx+WzpR6bVnWyeWxeUu+x+2YDm8fO
 1vusHn1bVjF6tB/oZgrgitKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rez
 SUnNySxLLdK3S9DLuHZ/OXPBIt6KUy/2sjUw9nN3MXJySAiYSJzueMbYxcjFISSwlFGidWEj
 K0RCQuL2wiZGCFtY4s+1LjYQW0jgOaPEn7t8XYwcHGwCWhKNnewgvSICT5gkvm5YwQriMAtM
 ZZJ4NPkCO0iRsECUxNIrSSC9LAKqEnOmvGMBCfMKWEk8mOEPMV5eYual7+wgNq+AoMTJmU9Y
 QGxmoHjz1tnMExj5ZiFJzUKSWsDItIpRJLW0ODc9t9hIrzgxt7g0L10vOT93EyMwvrYd+7ll
 B+PKVx/1DjEycTAeYpTgYFYS4W0K1UgS4k1JrKxKLcqPLyrNSS0+xGgKdN5EZinR5HxghOeV
 xBuaGZgamphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTBFfZ4ZxLH92QP+p8bP
 N4hP9BC9fEDjVM7v6e9fiDK/8nLwc1lXd7rNc43XchYFZS/XtmP+07wnTnlwa2nWcvkN7if+
 FiizCnJN2WMkwj3d4s/xF2YTyqxE0hQ5hSNK0nWz7Hb1ZUidD9au+8tiNl/1dXRa6nrRfe8W
 PWUP/B/qvN37xscb0UxVyz1bVBcqCxxqfzE96p/GAoftE/veX3jNNW/elvkthl8mlvbZ/M+U
 Fk5gijJXudR1kmtZq8UClZW1smtESi/de7vExFnQenfQ+U0c3L9Nj3f0SB0q7FES8hXSWb53
 lsvW4nNLz2T4+zDWKnq9//l1j9nFzctX1X1M41nldew8z9d0OTm+zVlKLMUZiYZazEXFiQBa
 1TBrOAMAAA==
X-CMS-MailID: 20220311201638eucas1p18b9c5ecb3442b5a53bba233591d34db0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220311201638eucas1p18b9c5ecb3442b5a53bba233591d34db0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220311201638eucas1p18b9c5ecb3442b5a53bba233591d34db0
References: <CGME20220311201638eucas1p18b9c5ecb3442b5a53bba233591d34db0@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220311_121651_934655_BA61C639 
X-CRM114-Status: GOOD (  14.69  )
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

Call nvme_update_disk_info after nvme_update_zone_info again so that the
permission for ZNS drives are marked correctly.

Fixes: 73d90386b559 ("nvme: cleanup zone information initialization")
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/host/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 51c08f206cbf..67a78653b07c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1913,6 +1913,11 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 		ret = nvme_update_zone_info(ns, lbaf);
 		if (ret)
 			goto out_unfreeze;
+		/* nvme_update_zone_info might set the namespace to be marked
+		 * as read-only. Call nvme_update_disk_info so that the disk
+		 * is updated with the appropriate permission.
+		 */
+		nvme_update_disk_info(ns->disk, ns, id);
 	}
 
 	set_bit(NVME_NS_READY, &ns->flags);
-- 
2.25.1


