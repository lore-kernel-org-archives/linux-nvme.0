Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D895FC04A68
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jul 2022 16:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tQl5rw2LDIMq1G1hScOYC7NS5JJWI9Fw2sjQ6mA8xho=; b=XYV5bIuldvCge2UQijgH/qhyrW
	naG5lCTL883EK2l/HpWsMLxgfvGshutFjFlTNd4wEPbG46gRvhmgbbAjNyWh3gPKMkaSiOzEOl502
	7FKs2Q01nkORYS39+yYnb3yfha3bhRzvGuS4K9J7Ks0A2PiYDMSeTkKIU4g/wAaiBsqJKXtXNzEnr
	FmCaoSFt2DjQU26L+5QV2zLecPQAYqoJXRwNCn2qE0BD/oKEos++Nl8sRN9NNdlcFuFSZQwKKv2e7
	GiFRGJM2hv+QnQtYiEqfIBTQZta9XA3ZVy/ncFZ9Tx3hTi40oqF9lMd1TPMLpBNra3ybkqc2AE2IS
	UC89qdvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGjou-00FUzQ-RE; Wed, 27 Jul 2022 16:23:36 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGjoF-00FUUd-R7
	for linux-nvme@lists.infradead.org; Wed, 27 Jul 2022 16:22:57 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220727162254euoutp022f073bc8e8b83ea06163c09e15ab8955~FvDU1PW8v0949809498euoutp02i
	for <linux-nvme@lists.infradead.org>; Wed, 27 Jul 2022 16:22:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220727162254euoutp022f073bc8e8b83ea06163c09e15ab8955~FvDU1PW8v0949809498euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1658938974;
	bh=tQl5rw2LDIMq1G1hScOYC7NS5JJWI9Fw2sjQ6mA8xho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SuMfpjSk0TLEw0lJAMQzQ113uNiwhU7hVz7RCWrJ2oPY5zsaf+2rhq0CwsN8FgaLQ
	 hfgupktFiwMNaVYrDfdOKFIU99FA7OuSn5Y0RslRD3J7AUd/rmcGTUGEWKvYdW3YFl
	 E6spsxKxHWKDY0zSDACVU0PuRUYFlFqinvLkzDiY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220727162253eucas1p2a6bcc6cca5d6d1d4bf2b80cbf4d27b41~FvDTjs7Vb2238722387eucas1p2f;
	Wed, 27 Jul 2022 16:22:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 61.C3.09664.C5661E26; Wed, 27
	Jul 2022 17:22:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20220727162252eucas1p25be8b79231334fa0c759c2475859e93b~FvDTFOskz2220522205eucas1p23;
	Wed, 27 Jul 2022 16:22:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220727162252eusmtrp11fd545a5a67eb51354f0461a908b515d~FvDTEgYLZ0298902989eusmtrp1M;
	Wed, 27 Jul 2022 16:22:52 +0000 (GMT)
X-AuditID: cbfec7f2-d81ff700000025c0-ee-62e1665cbb98
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id D7.8D.09038.C5661E26; Wed, 27
	Jul 2022 17:22:52 +0100 (BST)
Received: from localhost (unknown [106.210.248.8]) by eusmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20220727162252eusmtip17ef798f82e8d69146375b573ae97431a~FvDSufloN0050700507eusmtip1g;
	Wed, 27 Jul 2022 16:22:52 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: damien.lemoal@opensource.wdc.com, hch@lst.de, axboe@kernel.dk,
	snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc: matias.bjorling@wdc.com, gost.dev@samsung.com,
	linux-kernel@vger.kernel.org, hare@suse.de, linux-block@vger.kernel.org,
	pankydev8@gmail.com, bvanassche@acm.org, jaegeuk@kernel.org,
	dm-devel@redhat.com, linux-nvme@lists.infradead.org, Pankaj Raghav
	<p.raghav@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v8 06/11] zonefs: allow non power of 2 zoned devices
Date: Wed, 27 Jul 2022 18:22:40 +0200
Message-Id: <20220727162245.209794-7-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220727162245.209794-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPKsWRmVeSWpSXmKPExsWy7djP87oxaQ+TDJ7121isvtvPZjHtw09m
	i99nzzNb7H03m9Xi5oGdTBZ7Fk1isli5+iiTxZP1s5gt/nbdY7LYe0vb4vKuOWwW85c9ZbeY
	0PaV2eLGhKeMFp+XtrBbrLn5lMXixC1pB0GPy1e8PXbOusvucflsqcemVZ1sHpuX1HvsvtnA
	5rGz9T6rx/t9V9k8+rasYvTYfLra4/MmOY/2A91MATxRXDYpqTmZZalF+nYJXBkTJ0xgKTgu
	UPGw7zZrA+Nt3i5GDg4JAROJQ5+kuxi5OIQEVjBKvGy6wAThfGGUuPVlKyuE85lR4vXXh+xd
	jJxgHX9ut0NVLWeU6Hx/hB3Cec4osWD+VGaQuWwCWhKNnWANIgLFEg/ftbKA1DALHGCSeHC7
	hQ0kISzgIrH39QMwm0VAVeLpsTfMIDavgJXEr0MfmSG2yUvMvPQdbBCngLXE5inzmCBqBCVO
	znzCAmIzA9U0b53NDLJAQmA9p8TVNWtZIJpdJA5c72CDsIUlXh3fAvWCjMTpyT1QNdUST2/8
	hmpuYZTo37meDRIy1hJ9Z3JATGYBTYn1u/Qhyh0l7t+6ygpRwSdx460gxAl8EpO2TWeGCPNK
	dLQJQVQrSez8+QRqqYTE5aY5UEs9JM7f3Mk0gVFxFpJnZiF5ZhbC3gWMzKsYxVNLi3PTU4sN
	81LL9YoTc4tL89L1kvNzNzEC0+Dpf8c/7WCc++qj3iFGJg7GQ4wSHMxKIrwJ0feThHhTEiur
	Uovy44tKc1KLDzFKc7AoifMmZ25IFBJITyxJzU5NLUgtgskycXBKNTBxfX6s9PPWmnMf/dkz
	IlzPptezeO+oPz5J6JQQu8QkT7bCGWabXb7d+c7WMSeWQX3p1GkeHB9jVuSZ3BKQfmgysdCz
	cJVU0sm3+wJ43tnF/2u6YMP2ZfLGsl88Kr+ji58lR75yVlHjszW6c/375blLS2cmzpq5rtvi
	lOpN1WuvdGfk6u6/qV0jMDObfZe4Xfr16spNzcGT76zK2MBTnW8Xkv35+cmTNy16inwOfN8T
	/vlTW9rZyfzJX2bzffmlfKyvxdKHo+nbOvHUmtgutt81RQxrtNY0bpQNsWc6+4JZRp9x7a/I
	s69mO0lGnfql3lF9z3OJsvAjvknHd0jYTXy7gTFjV3bO672s93J3b1ZVYinOSDTUYi4qTgQA
	FFGOwPIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xu7oxaQ+TDM7/l7VYfbefzWLah5/M
	Fr/Pnme22PtuNqvFzQM7mSz2LJrEZLFy9VEmiyfrZzFb/O26x2Sx95a2xeVdc9gs5i97ym4x
	oe0rs8WNCU8ZLT4vbWG3WHPzKYvFiVvSDoIel694e+ycdZfd4/LZUo9NqzrZPDYvqffYfbOB
	zWNn631Wj/f7rrJ59G1Zxeix+XS1x+dNch7tB7qZAnii9GyK8ktLUhUy8otLbJWiDS2M9Awt
	LfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DImTpjAUnBcoOJh323WBsbbvF2MnBwSAiYS
	f263M3UxcnEICSxllNhy4yYbREJC4vbCJkYIW1jiz7UuNoiip4wSZ2+vAerg4GAT0JJo7GQH
	MUUEKiXOfpEFKWEWOMckcfPiNbA5wgIuEntfPwCzWQRUJZ4ee8MMYvMKWEn8OvSRGWK+vMTM
	S9/ZQWxOAWuJzVPmMYHYQkA1zx58ZIOoF5Q4OfMJC4jNDFTfvHU28wRGgVlIUrOQpBYwMq1i
	FEktLc5Nzy020itOzC0uzUvXS87P3cQIjNhtx35u2cG48tVHvUOMTByMhxglOJiVRHgTou8n
	CfGmJFZWpRblxxeV5qQWH2I0Bbp7IrOUaHI+MGXklcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJ
	pCeWpGanphakFsH0MXFwSjUwhXY3NORf8LUoOtQ6Y/m+q2Ut05qORPsd+KYaLVJ4LH2KGdu8
	PRpLNyUHMS9k+LJQ+dpK78OS+29duHxj21QPd8ZbcxoV/uy6phW7/b92k5rRAYm3XZZeJl1P
	VW3OnN+wlt13rfuDghPzZGb88TcovbSGiVe4SX/yRC6jjWHGpe+nnCzzrkjxrNwu+CPcuP3T
	AnaXUn/30zbbfe+d+b3+9T/ZaS1/97pKrs9LMNtl2N0genfNmVf3Mtq3RGx6U1x+0FtJMZ45
	3WhX5G7D/raPS45nrNo7x45N7Pr0Kuf9JRybDxw74Pbe2Kxl7XOHtce9jl9IKFO+vojnuCWf
	42UuxRYD4z/rt5xTZj3hpD3joRJLcUaioRZzUXEiAHUhaWZhAwAA
X-CMS-MailID: 20220727162252eucas1p25be8b79231334fa0c759c2475859e93b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220727162252eucas1p25be8b79231334fa0c759c2475859e93b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220727162252eucas1p25be8b79231334fa0c759c2475859e93b
References: <20220727162245.209794-1-p.raghav@samsung.com>
	<CGME20220727162252eucas1p25be8b79231334fa0c759c2475859e93b@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_092256_472960_3818C533 
X-CRM114-Status: GOOD (  15.09  )
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
index 860f0b1032c6..e549ef16738c 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -476,10 +476,9 @@ static void __zonefs_io_error(struct inode *inode, bool write)
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
@@ -1401,7 +1400,7 @@ static int zonefs_init_file_inode(struct inode *inode, struct blk_zone *zone,
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	int ret = 0;
 
-	inode->i_ino = zone->start >> sbi->s_zone_sectors_shift;
+	inode->i_ino = bdev_zone_no(sb->s_bdev, zone->start);
 	inode->i_mode = S_IFREG | sbi->s_perm;
 
 	zi->i_ztype = type;
@@ -1776,7 +1775,6 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
 	 * interface constraints.
 	 */
 	sb_set_blocksize(sb, bdev_zone_write_granularity(sb->s_bdev));
-	sbi->s_zone_sectors_shift = ilog2(bdev_zone_sectors(sb->s_bdev));
 	sbi->s_uid = GLOBAL_ROOT_UID;
 	sbi->s_gid = GLOBAL_ROOT_GID;
 	sbi->s_perm = 0640;
diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
index 4b3de66c3233..39895195cda6 100644
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


