Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7BEC433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  6 May 2022 08:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I6AyG+zKNeMaILZF7R/I3A5VoGI+O7z0EZ5WLMlZFWk=; b=GzszaMr5JuOSreCIhW3vFOkE80
	Ujgx67Y64muOSc1Bhqf3UWxncLxn5Ln3WQ5pqHCzcRxYC/lMtdn41dZKU6tagLWogsxkL20bNM/UP
	9lHCSzgoKtPZKc7mWDDTOlwTZL/4aycwBQvyNYBVLxB/sPFUGRDY5BgtD390B+5LUvFM98QX8nTXb
	WTcGYHE3yl+D3cB3t9T+335Qrj3s8dlqMvNZZgvfvLDL+P3Y4DNkbpHMMpuVl2DjiZdxTP9wAKhIf
	xqUYebi4j0w8PdXC4UyAo91goeqEZRW0dnEKDGFT2+qz+mf2kNUEosPaPSQHsngnPWUOvsBDo5z4c
	x5ZsdVDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmt55-001zc2-NU; Fri, 06 May 2022 08:12:55 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmt3c-001ygi-3G
 for linux-nvme@lists.infradead.org; Fri, 06 May 2022 08:11:26 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20220506081118euoutp02d32da9e9fa784717e37e1b1bb809b6d1~sdcr_DMbJ2385223852euoutp02l
 for <linux-nvme@lists.infradead.org>; Fri,  6 May 2022 08:11:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20220506081118euoutp02d32da9e9fa784717e37e1b1bb809b6d1~sdcr_DMbJ2385223852euoutp02l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1651824678;
 bh=I6AyG+zKNeMaILZF7R/I3A5VoGI+O7z0EZ5WLMlZFWk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=sTTVlEidW0f3AlZRQvh1llqBy84jhU4rVKsIosds+oN2+s4YJS4eJmN9OFLCXRhy0
 KR8J6IAMJ6y3bzwUi+Ujk8sxdGlcDKyznoSBpdAjZAkmMzm6To+enhf/iKIRcYCcpO
 834ncQQFyJtakdpuJbSNdPHZzIj6Za3FmeXNjqgs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20220506081116eucas1p19eb3fac87a4cf0dada0eaf469eeb58b7~sdcqUrLha1756417564eucas1p19;
 Fri,  6 May 2022 08:11:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 24.4C.10260.428D4726; Fri,  6
 May 2022 09:11:16 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20220506081115eucas1p2e7bed137c74be42a702732027581330e~sdcp30_v_0618806188eucas1p2m;
 Fri,  6 May 2022 08:11:15 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220506081115eusmtrp2bc23f57f1bf98bef55c841a5817639d5~sdcp18RxM2593625936eusmtrp2f;
 Fri,  6 May 2022 08:11:15 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-ef-6274d82460ce
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 1D.F2.09522.328D4726; Fri,  6
 May 2022 09:11:15 +0100 (BST)
Received: from localhost (unknown [106.210.248.174]) by eusmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20220506081115eusmtip299ffc807d988a4202c28888f957b97ea~sdcpgytSF2136221362eusmtip2I;
 Fri,  6 May 2022 08:11:15 +0000 (GMT)
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
Subject: [PATCH v3 09/11] zonefs: allow non power of 2 zoned devices
Date: Fri,  6 May 2022 10:11:03 +0200
Message-Id: <20220506081105.29134-10-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506081105.29134-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUxTVxjO6b29/djqLqXSM9xi1ukyMFDJWHami5ubk5vMH4S4LWPLXAt3
 QGjRtBQ/WGZLC4x2K4ggtrIh0xVaYBXKh1VqGK5AUQYRKojZlAmb4spHBBliYJRbM/897/M+
 z3mf983hYkInEcnNyMqmVVkyhYTg461di7/FbBrJlm81TT2LnL1dGFpp7yJQ3e/FBDoxs4ih
 0uKTHLTU148hz9QpNhr4V8dCNzrcLNT+YykL2eu8LDTutGLo244ZHNkNYxh6PBaHxuZGcVTa
 eR2gCb+VhTyjW9C1O7Uc1O7x4WjwQiWBqmwTHFRSMI+hkZIJgI51u9jowU8GDvr5/jSOekY3
 vPMiNTj0AbXcU09Qx/RTHKr/j0acGuzTUE2OIoKq1pZjlOvsUeriDS1BfaefIih3/i02NX3J
 T1DmZgegnM1+nHJdyaVKXI3sRGEy/61UWpGRQ6ukO77gpzcNFeEH2shDjoIGXAv6BEbA40Iy
 HtrLxzhGwOcKyVoALfW9BFPMAXjR/kuoeADg9XNe/InF4/0VYxo1APr+qgz57wFYXaZb7XC5
 BBkNdUVrvIg0AVh8q5ATdGOkiw0HGr4M4nByF/Te9hNBPU5uhoU+FKQF5DboWbzLZoZthJZr
 C2tW3iqfd/wewWjCoM8yjjNPboT6llNrgSDZwIeTAwMh8y54t66VYHA4nOxu5jD4BbjirmIx
 OBdOjCyFzIbVoG7nWiBIbofmq4ogxMgo6LwgZeQ74ey8K6RYB0cCYUyEdbC0tQJjaAH8pkDI
 qCXQvTgeGgrhYF5l6IQU7G17xC4BL1mfWsb61DLW/+eeBpgDiGmNWplGq1/Log/GqmVKtSYr
 LTZlv7IJrP7pK8vd8+dB7eRsbCdgcUEngFxMIhKEW7PlQkGq7PARWrV/n0qjoNWdYAMXl4gF
 KRnnZEIyTZZNZ9L0AVr1pMvi8iK1rOqFj2Z4e82xeUnrEw2v7zZ6MuMbaqj78cPdMc4pi+6O
 RV7I1xsOF1ESWcL6iCSb7dMcT4yJ83G9vH/3K+eThdUzPPLoGZ6+tUJ3JJlfNtNifFMz+kzj
 q2ZD16F9US1f9adK7ScvG4X94s3yjrSAo7zw5TEfPWt6v+eNiA91EYGyFFF7+jZvbrHy+fqh
 1LjLCW1XLdKdA74/k8izXz9qvVn1/day4Zt7YIAv/mQl58xntjipZDm/XGms3SESz2VGNq1c
 Ep14WPdu4u09/4QtvD3c8Tg/sH0ko+ZvbYTKdDBl03JFNJgXUT9sMRv9iudKfVG0570l2+cJ
 GeyHUF4RNS3B1emyuGhMpZb9BxyyJWlCBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsVy+t/xe7rKN0qSDOYv17JYf+oYs8X/PcfY
 LFbf7WezmPbhJ7PFpP4Z7Ba/z55nttj7bjarxYUfjUwWNw/sZLLYs2gSk8XK1UeZLJ6sn8Vs
 0XPgA4vFypaHzBZ/HhpaPPxyi8Vi0qFrjBZPr85isth7S9vi0uMV7BZ79p5ksbi8aw6bxfxl
 T9ktJrR9Zba4MeEpo8XE45tZLT4vbWG3WPf6PYvFiVvSDrIel694e/w7sYbNY2LzO3aP8/c2
 snhcPlvqsWlVJ5vHwoapzB6bl9R77L7ZwObR2/yOzWNn631Wj/f7rrJ59G1ZxeixfstVFo/N
 p6s9JmzeyBogFKVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mW
 WqRvl6CXselKJ0vBdoGKVW1rWRoYz/J2MXJySAiYSOw9eoS5i5GLQ0hgKaPExzfnWSESEhK3
 FzYxQtjCEn+udbFBFD1nlHh8uZ2pi5GDg01AS6Kxkx0kLiIwlVHi0rqTLCAOs8BpVomtmw4w
 gXQLC7hIHH1wlQ2kgUVAVaL9pAVImFfASmLvzxdQy+QlZl76zg5icwLFmya/ZAOxhQQsJeYv
 2cMKUS8ocXLmExYQmxmovnnrbOYJjAKzkKRmIUktYGRaxSiSWlqcm55bbKhXnJhbXJqXrpec
 n7uJEZhSth37uXkH47xXH/UOMTJxMB5ilOBgVhLhFZ5VkiTEm5JYWZValB9fVJqTWnyI0RTo
 7InMUqLJ+cCkllcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwCQq
 vZ6vqXgGj7FtqaDA/M2Lc/T618xOn/7C8/OUSJezU2dWlrDZy+7g3P68SW2SXtYSXyv33aFc
 kqmnZv0W4/i5SlKEq8uqY1rkzTc3vT682qLzXG2mTZ2d596nD35ND/zsIj3NsejVTo9dt/8U
 /XuqcWkSz6nfNXZLbkTvFqloSfymf/MuQ9puLvcjDw5FvzA2ruFpPtL/jJO5qsvvYIfKSnaf
 s2yL1xzUXqcutNWhLuDwV/uJ0ixzhOeZf+pLEbjdMWv6C6MSs9e1Hf43Gx+vzeHddTLUfLv4
 B7byOV8iNEUPJe3j2fQnw5I75NSjrUuMMmfyvg3/WH5nb6Rjb9r6/xOETRdssZAyePFS31OJ
 pTgj0VCLuag4EQBvUJ6csgMAAA==
X-CMS-MailID: 20220506081115eucas1p2e7bed137c74be42a702732027581330e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220506081115eucas1p2e7bed137c74be42a702732027581330e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220506081115eucas1p2e7bed137c74be42a702732027581330e
References: <20220506081105.29134-1-p.raghav@samsung.com>
 <CGME20220506081115eucas1p2e7bed137c74be42a702732027581330e@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220506_011124_497895_6DD6D730 
X-CRM114-Status: GOOD (  15.23  )
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

The zone size shift variable is useful only if the zone sizes are known
to be power of 2. Remove that variable and use generic helpers from
block layer to calculate zone index in zonefs.

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 fs/zonefs/super.c  | 6 ++----
 fs/zonefs/zonefs.h | 1 -
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 978a35c45..50a1e000c 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -451,10 +451,9 @@ static void __zonefs_io_error(struct inode *inode, bool write)
 {
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	struct super_block *sb = inode->i_sb;
-	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
 	unsigned int noio_flag;
 	unsigned int nr_zones =
-		zi->i_zone_size >> (sbi->s_zone_sectors_shift + SECTOR_SHIFT);
+		bdev_zone_no(sb->s_bdev, zi->i_zone_size >> SECTOR_SHIFT);
 	struct zonefs_ioerr_data err = {
 		.inode = inode,
 		.write = write,
@@ -1375,7 +1374,7 @@ static int zonefs_init_file_inode(struct inode *inode, struct blk_zone *zone,
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	int ret;
 
-	inode->i_ino = zone->start >> sbi->s_zone_sectors_shift;
+	inode->i_ino = bdev_zone_no(sb->s_bdev, zone->start);
 	inode->i_mode = S_IFREG | sbi->s_perm;
 
 	zi->i_ztype = type;
@@ -1752,7 +1751,6 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
 	 * interface constraints.
 	 */
 	sb_set_blocksize(sb, bdev_zone_write_granularity(sb->s_bdev));
-	sbi->s_zone_sectors_shift = ilog2(bdev_zone_sectors(sb->s_bdev));
 	sbi->s_uid = GLOBAL_ROOT_UID;
 	sbi->s_gid = GLOBAL_ROOT_GID;
 	sbi->s_perm = 0640;
diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
index 4b3de66c3..39895195c 100644
--- a/fs/zonefs/zonefs.h
+++ b/fs/zonefs/zonefs.h
@@ -177,7 +177,6 @@ struct zonefs_sb_info {
 	kgid_t			s_gid;
 	umode_t			s_perm;
 	uuid_t			s_uuid;
-	unsigned int		s_zone_sectors_shift;
 
 	unsigned int		s_nr_files[ZONEFS_ZTYPE_MAX];
 
-- 
2.25.1


