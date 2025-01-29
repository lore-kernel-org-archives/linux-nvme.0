Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB34C02195
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2025 14:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ST7TI/y+PLKSL5LRzxWbv6tzS6BXzdbRGX2mF/YjYwg=; b=pwqhLM9tkBp8WGkPusjSSo6Dk0
	gv/zlU+yDGC35pCmkwcXEZ9Y+/ZgiO/Sjf12ByyqEjqANNpw+FBwLt4yP1M2q5vP4IX83H/sGp5z+
	RNVW+u5KWhA9/I/on5pGUy1CymmGm9PumGOV66qIZey27xTiNbSyklWR1OQI6UeTdqwSMKJZ/blNT
	I9806gqlSL3Gum+qlLZ+IUVo9vd5+JMHUD5THb9OWwCyYl5Hve0MqQfXx6PjW5seDh7ZM1IvVuVjJ
	zQbgYcgbL1o5fum/r5jP6uedcNguiE1M6hMiEgSYhN5t4Y+vJkqdVqdLwzAcle6zjwAlAmvS3Zv19
	V1iyKaTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1td8mN-000000075H0-37EF;
	Wed, 29 Jan 2025 14:10:55 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1td8mK-000000075Ed-3rbf
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jan 2025 14:10:54 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250129141047epoutp03638a7ffabde11f5ff09cfe1252fb89fe~fLywT-x1I0126401264epoutp03A
	for <linux-nvme@lists.infradead.org>; Wed, 29 Jan 2025 14:10:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250129141047epoutp03638a7ffabde11f5ff09cfe1252fb89fe~fLywT-x1I0126401264epoutp03A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738159847;
	bh=ST7TI/y+PLKSL5LRzxWbv6tzS6BXzdbRGX2mF/YjYwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sGEQobN0AF2XCIM9GZZwNH3d70TGLDWzdaOoplRnKiRs7rzPEHqQCxns2nq4tsi30
	 z25p4SHy1zFyZ67e1xTdH4CPYbNpkzD0sZ3sFSyDcBXSMkYxyj1m1bEhHbTE2pE2xM
	 mW5u8ZesysBNr8wdpkt0Y8ueyj0zp7xjS9Jm60Ck=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20250129141046epcas5p35eaafd908a19ad7c36fcdc9a75542852~fLyvdQ5lh2837028370epcas5p3U;
	Wed, 29 Jan 2025 14:10:46 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4YjkZs31rfz4x9Pp; Wed, 29 Jan
	2025 14:10:45 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	30.9F.29212.5E63A976; Wed, 29 Jan 2025 23:10:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250129141044epcas5p422461bd3630814884c91fc0f4207edde~fLyt7beoy1416814168epcas5p4m;
	Wed, 29 Jan 2025 14:10:44 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250129141044epsmtrp1ab9dd28959447241d4bccf0273e947d4~fLyt6hsYP0553305533epsmtrp18;
	Wed, 29 Jan 2025 14:10:44 +0000 (GMT)
X-AuditID: b6c32a50-7ebff7000000721c-8a-679a36e51763
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E2.F5.18949.4E63A976; Wed, 29 Jan 2025 23:10:44 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250129141043epsmtip2f7ed1e3bfa59072eb1baeff6ac801a89~fLysVmGYX2314623146epsmtip2R;
	Wed, 29 Jan 2025 14:10:43 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: josef@toxicpanda.com, dsterba@suse.com, clm@fb.com, axboe@kernel.dk,
	kbusch@kernel.org, hch@lst.de
Cc: linux-btrfs@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [RFC 3/3] btrfs: add checksum offload
Date: Wed, 29 Jan 2025 19:32:07 +0530
Message-Id: <20250129140207.22718-4-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250129140207.22718-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBJsWRmVeSWpSXmKPExsWy7bCmlu5Ts1npBh/+CVqsvtvPZjGpfwa7
	xYUfjUwWNw/sZLJYufook8Wfh4YWR/+/BUoeusZosfeWtsWlxyvYLeYve8ruwO0xsfkdu8fl
	s6Uem1Z1snlsXlLvsftmA5tH35ZVjB7rt1xl8ZiweSOrx+dNcgGcUdk2GamJKalFCql5yfkp
	mXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUCnKimUJeaUAoUCEouLlfTtbIry
	S0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM/qnHWEpuCNf0bJjJ3sD
	4xmpLkZODgkBE4lzzYfYuhi5OIQE9jBKvN54nxHC+cQo8WX5OTaQKiGBb4wSf3ZxwHQsPHuA
	BaJoL6PEtb75UO2fGSWm3twDlOHgYBPQlLgwuRSkQUQgQ+L46VnMIDXMArMZJda1/mcGSQgL
	6En0zmhkArFZBFQlGi6+B9vGK2Ah8WvSEyaIbfISMy99ZwexOQUsJXa/m8sEUSMocXLmExYQ
	mxmopnnrbLAFEgJzOSRutn1gh2h2kZh0fz0zhC0s8er4Fqi4lMTL/jYoO1viwaMHLBB2jcSO
	zX2sELa9RMOfG6wgzzADPbN+lz7ELj6J3t8gt3EAlfBKdLQJQVQrStyb9BSqU1zi4YwlULaH
	xOM/DayQ8OlhlDi9uYttAqP8LCQvzELywiyEbQsYmVcxSqUWFOempyabFhjq5qWWw2M2OT93
	EyM4yWoF7GBcveGv3iFGJg7GQ4wSHMxKIryx52akC/GmJFZWpRblxxeV5qQWH2I0BQbyRGYp
	0eR8YJrPK4k3NLE0MDEzMzOxNDYzVBLnbd7Zki4kkJ5YkpqdmlqQWgTTx8TBKdXAlOFT8n/Z
	y6X8wmItK73umop+NDsy3/C1ouje6as4DlSqr1jDOy9n4rrAhCjBNt+PN5s3MRn+bio2YzxY
	b+N2+2Pu0ezCAIZ+EY1C91P8+/iDd5m8s8zhYHeNqInLYE7xn5L38OJj5+3cP56d2nclbpXB
	hP/by/o3vtteeZvXdkPTYYUj3FObAqw1XTvCbjV3q6zdJWm1Lsmx6v4UVqHdc9/lX69lfO1X
	HPA1o6z754sHcgvirGbvWCzAzcU8s1at+4t61psF8UH8K+QUtzqwrr/d8/W4i+Az51PL9znb
	37R484Fxv1HClPONh1N8bnH1q3n5t2w1uGixcqL95a/Lc7zdWZV4r4hNZHy0QOO9EktxRqKh
	FnNRcSIABOScPTsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsWy7bCSvO4Ts1npBk+Pm1msvtvPZjGpfwa7
	xYUfjUwWNw/sZLJYufook8Wfh4YWR/+/BUoeusZosfeWtsWlxyvYLeYve8ruwO0xsfkdu8fl
	s6Uem1Z1snlsXlLvsftmA5tH35ZVjB7rt1xl8ZiweSOrx+dNcgGcUVw2Kak5mWWpRfp2CVwZ
	/dOOsBTcka9o2bGTvYHxjFQXIyeHhICJxMKzB1i6GLk4hAR2M0rsfPicFSIhLtF87Qc7hC0s
	sfLfc3aIoo+MEvPm7AVyODjYBDQlLkwuBakRESiQmLj/CdggZoH5jBLHN+xiAUkIC+hJ9M5o
	ZAKxWQRUJRouvmcDsXkFLCR+TXrCBLFAXmLmpe9gyzgFLCV2v5vLBDJfCKhmw5QkiHJBiZMz
	n4CNZAYqb946m3kCo8AsJKlZSFILGJlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIE
	R4eW1g7GPas+6B1iZOJgPMQowcGsJMIbe25GuhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeb697
	U4QE0hNLUrNTUwtSi2CyTBycUg1Mwn6M7zQPie1OerCqzidX6an866Y87ddtMr7vW+YFxxn+
	jjDgWXf67dFXc+f8UTmkV8gprq1/4uPy+c/LYhLOWnke9QnaErjG80d735rJBSG+ExWmNn52
	PxEjuPXpqXdbL2VciywO03h7R7frRb50+UnjXn6zhG2VIQcXZfwLiStIUdZxYQn6lGXZfuWF
	orLVxJPqSZZ56lUbnrUpKBy0ed58lfPnrSUTJQ5Nby5MXT2NK+L7eiX2ZZ8/l/GtF5xzQ0px
	33mTxf6vJL+k3rz24NG6iIfRrft0nj9aXbR8dpX8tlcmG4ur9Wc8ik9/e/botvPnGdmuHzG8
	uWUGR/CUOGs74+8av0QK561asb3TX4mlOCPRUIu5qDgRACWg5cX9AgAA
X-CMS-MailID: 20250129141044epcas5p422461bd3630814884c91fc0f4207edde
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250129141044epcas5p422461bd3630814884c91fc0f4207edde
References: <20250129140207.22718-1-joshi.k@samsung.com>
	<CGME20250129141044epcas5p422461bd3630814884c91fc0f4207edde@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250129_061053_293833_09BEE2E1 
X-CRM114-Status: GOOD (  17.79  )
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

Add new mount option 'datsum_offload'.

When passed
- Data checksumming at the FS level is disabled.
- Data checksumming at the device level is enabled. This is done by
setting REQ_INTEGRITY_OFFLOAD flag for data I/O if the underlying device is
capable.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 fs/btrfs/bio.c   | 12 ++++++++++++
 fs/btrfs/fs.h    |  1 +
 fs/btrfs/super.c |  9 +++++++++
 3 files changed, 22 insertions(+)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 7ea6f0b43b95..811d89c64991 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/bio.h>
+#include <linux/blk-integrity.h>
 #include "bio.h"
 #include "ctree.h"
 #include "volumes.h"
@@ -424,6 +425,15 @@ static void btrfs_clone_write_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
+static void btrfs_prep_csum_offload_hw(struct btrfs_device *dev, struct bio *bio)
+{
+	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
+
+	if (btrfs_test_opt(dev->fs_info, DATASUM_OFFLOAD) &&
+	    bi && bi->offload_type != BLK_INTEGRITY_OFFLOAD_NONE)
+		bio->bi_opf |= REQ_INTEGRITY_OFFLOAD;
+}
+
 static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
 {
 	if (!dev || !dev->bdev ||
@@ -435,6 +445,8 @@ static void btrfs_submit_dev_bio(struct btrfs_device *dev, struct bio *bio)
 	}
 
 	bio_set_dev(bio, dev->bdev);
+	if (!(bio->bi_opf & REQ_META))
+		btrfs_prep_csum_offload_hw(dev, bio);
 
 	/*
 	 * For zone append writing, bi_sector must point the beginning of the
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 79a1a3d6f04d..88e493967100 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -228,6 +228,7 @@ enum {
 	BTRFS_MOUNT_NOSPACECACHE		= (1ULL << 30),
 	BTRFS_MOUNT_IGNOREMETACSUMS		= (1ULL << 31),
 	BTRFS_MOUNT_IGNORESUPERFLAGS		= (1ULL << 32),
+	BTRFS_MOUNT_DATASUM_OFFLOAD		= (1ULL << 33),
 };
 
 /*
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 7dfe5005129a..d0d5b35c2df9 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -121,6 +121,7 @@ enum {
 	Opt_treelog,
 	Opt_user_subvol_rm_allowed,
 	Opt_norecovery,
+	Opt_datasum_offload,
 
 	/* Rescue options */
 	Opt_rescue,
@@ -223,6 +224,7 @@ static const struct fs_parameter_spec btrfs_fs_parameters[] = {
 	fsparam_string("compress-force", Opt_compress_force_type),
 	fsparam_flag_no("datacow", Opt_datacow),
 	fsparam_flag_no("datasum", Opt_datasum),
+	fsparam_flag_no("datasum_offload", Opt_datasum_offload),
 	fsparam_flag("degraded", Opt_degraded),
 	fsparam_string("device", Opt_device),
 	fsparam_flag_no("discard", Opt_discard),
@@ -323,6 +325,10 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			btrfs_clear_opt(ctx->mount_opt, NODATASUM);
 		}
 		break;
+	case Opt_datasum_offload:
+		btrfs_set_opt(ctx->mount_opt, NODATASUM);
+		btrfs_set_opt(ctx->mount_opt, DATASUM_OFFLOAD);
+		break;
 	case Opt_datacow:
 		if (result.negated) {
 			btrfs_clear_opt(ctx->mount_opt, COMPRESS);
@@ -1057,6 +1063,8 @@ static int btrfs_show_options(struct seq_file *seq, struct dentry *dentry)
 		seq_puts(seq, ",degraded");
 	if (btrfs_test_opt(info, NODATASUM))
 		seq_puts(seq, ",nodatasum");
+	if (btrfs_test_opt(info, DATASUM_OFFLOAD))
+		seq_puts(seq, ",datasum_offload");
 	if (btrfs_test_opt(info, NODATACOW))
 		seq_puts(seq, ",nodatacow");
 	if (btrfs_test_opt(info, NOBARRIER))
@@ -1434,6 +1442,7 @@ static void btrfs_emit_options(struct btrfs_fs_info *info,
 	btrfs_info_if_set(info, old, NODATASUM, "setting nodatasum");
 	btrfs_info_if_set(info, old, DEGRADED, "allowing degraded mounts");
 	btrfs_info_if_set(info, old, NODATASUM, "setting nodatasum");
+	btrfs_info_if_set(info, old, DATASUM_OFFLOAD, "setting datasum offload to the device");
 	btrfs_info_if_set(info, old, SSD, "enabling ssd optimizations");
 	btrfs_info_if_set(info, old, SSD_SPREAD, "using spread ssd allocation scheme");
 	btrfs_info_if_set(info, old, NOBARRIER, "turning off barriers");
-- 
2.25.1


