Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39008C8302D
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jun 2025 09:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=GgS+k17VlS3z5f+lStV0zi9JYkR/O/BiLDiSucjLPyA=; b=F4KnUYwYDGz7wHA3H1mDkt6lwU
	88FaKJwVTPOrf0IMmFSC2VHlg/PpQ3FRymqAAhPPnZNB7DrAzHmLXoK3C8L6zsyeYEL7jP7WDStdC
	XFIkDQn14Am+cncsvIOoIkgw7aNlqBjrM+2/10ZyGckaO2anm/77Or1LmryMKtiwXHCO7PW1alQHH
	Bwiyb6JYwWbtFFyZqh4pNlCKnxEOmICMK8AaNdWxUTilzMXoa4pycOg/l+rib+vlkvRAt28RCsUUX
	fdkqi2H7J7Hba0tJflCHK3koG5nhE3oGlQ1mB2UprlpM5zofZzt6od2vnQpS3YYyJ49NLi/lr0IFS
	Nul/ZbRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWAVU-00000001hds-00bj;
	Mon, 30 Jun 2025 09:08:56 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWAVO-00000001hYV-3LMp
	for linux-nvme@lists.infradead.org;
	Mon, 30 Jun 2025 09:08:53 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250630090842epoutp02530bf55cc0ad312a83a6c24fd1b9a185~NxuZSBBzv0816208162epoutp02P
	for <linux-nvme@lists.infradead.org>; Mon, 30 Jun 2025 09:08:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250630090842epoutp02530bf55cc0ad312a83a6c24fd1b9a185~NxuZSBBzv0816208162epoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1751274522;
	bh=GgS+k17VlS3z5f+lStV0zi9JYkR/O/BiLDiSucjLPyA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=AkxU8CAnHa1JkUGk9Sr6h5b2fSI7LyS86MEPkxgOB9QbGJRQrTLwvaQLCJdDWOppT
	 pTfq3iHN1mC+AZpio0d0Q2wg23Ix6IYrkSEJ2klo+X2KC+ngrOBfYtygB4Ix5Z15HT
	 CdKNlVwU1pCOaJSx6k4m6QLLNHoz0+l4O98DNnBM=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250630090841epcas5p4d240f5b83654cef1436b16dc399f8cb3~NxuYr60gy2849528495epcas5p43;
	Mon, 30 Jun 2025 09:08:41 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.174]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4bW0h84NnGz3hhT9; Mon, 30 Jun
	2025 09:08:40 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250630090606epcas5p42edec1dfe34f53c9f1448acb0964bb8f~NxsHinA8m1010310103epcas5p4O;
	Mon, 30 Jun 2025 09:06:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250630090603epsmtip2ad17b3a3e395080ea4a974cffd9163a8~NxsFZLARt1109511095epsmtip2X;
	Mon, 30 Jun 2025 09:06:03 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [PATCH for-next v5 0/4] add ioctl to query metadata and protection
 info capabilities
Date: Mon, 30 Jun 2025 14:35:44 +0530
Message-Id: <20250630090548.3317-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250630090606epcas5p42edec1dfe34f53c9f1448acb0964bb8f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250630090606epcas5p42edec1dfe34f53c9f1448acb0964bb8f
References: <CGME20250630090606epcas5p42edec1dfe34f53c9f1448acb0964bb8f@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250630_020851_320777_90E83518 
X-CRM114-Status: GOOD (  14.52  )
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

Hi all,

This patch series adds a new ioctl to query metadata and integrity
capability.

Patch 1 renames tuple_size field to metadata_size
Patch 2 adds a pi_tuple_size field in blk_integrity struct which is later
used to export this value to the user as well.
Patch 3 allows computing right pi_offset value.
Patch 4 introduces a new ioctl to query integrity capability.

v4->v5
add a pad field in the user structure to align it (Christoph)
get rid of overly long lines (Christoph)
add missing nvme prefix to the patch desc (Christoph)

v3->v4
rename tuple_size to metadata_size to inflect right meaning (Martin)
rectify the condition in blk_validate_integrity_limits when csum type is
none (Christoph)
change uapi field comment to more friendly formats (Christoph)
add comments regarding ioctl behaviour when bi is NULL (Christoph)
remove the reserved fields and use different scheme for extensibility
(Christian)
Other misc code improvements (Christoph)
set pi_tuple_size and pi_offset in NVMe only if csum type is not NONE

v2->v3
better naming for uapi struct fields (Martin)
validate integrity fields in blk-settings.c (Christoph)

v1 -> v2
introduce metadata_size, storage_tag_size and ref_tag_size field in the
uapi struct (Martin)
uapi struct fields comment improvements (Martin)
add csum_type definitions to the uapi file (Martin)
add fpc_* prefix to uapi struct fields (Andreas)
bump the size of rsvd and hence the uapi struct to 32 bytes (Andreas)
use correct value for ioctl (Andreas)
use clearer names for CRC (Eric)


Anuj Gupta (4):
  block: rename tuple_size field in blk_integrity to metadata_size
  block: introduce pi_tuple_size field in blk_integrity
  nvme: set pi_offset only when checksum type is not
    BLK_INTEGRITY_CSUM_NONE
  fs: add ioctl to query metadata and protection info capabilities

 block/bio-integrity-auto.c        |  4 +--
 block/blk-integrity.c             | 54 +++++++++++++++++++++++++++-
 block/blk-settings.c              | 44 +++++++++++++++++++++--
 block/ioctl.c                     |  4 +++
 block/t10-pi.c                    | 16 ++++-----
 drivers/md/dm-crypt.c             |  4 +--
 drivers/md/dm-integrity.c         | 12 +++----
 drivers/nvdimm/btt.c              |  2 +-
 drivers/nvme/host/core.c          |  7 ++--
 drivers/nvme/target/io-cmd-bdev.c |  2 +-
 drivers/scsi/sd_dif.c             |  3 +-
 include/linux/blk-integrity.h     | 11 ++++--
 include/linux/blkdev.h            |  3 +-
 include/uapi/linux/fs.h           | 59 +++++++++++++++++++++++++++++++
 14 files changed, 195 insertions(+), 30 deletions(-)

-- 
2.25.1


