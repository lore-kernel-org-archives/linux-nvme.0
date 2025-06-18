Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD8AC7115B
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Jun 2025 05:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=AOP00Fc2F9qiSQmOiA4tBYgC5vacOd3AhpFCbS+QFf0=; b=MZ9jv/XTpbzucJXsJH0SJFIw6H
	wZIhSgkA6QLj3+b1kGOt4bQw3DuiPf2uyvIbd1j9hxftHmQzPJ0Y8atHU8lDZoGgkr5bZFYgDOyWa
	M02d0NW51soBajT4f/qdzx3OkfwZKsDNp51CWZeiA+yK/vnmTB/74IRWCUncRAUcF/0oSs8VYT/ZG
	LkOW4NOzm08bUq3plgHgf7TVYkJ1jOGGiqP0uEXdDeJL+P1Ns7RT05q6f6/zyeZvNnDWtSzxb5RuW
	WVckh871rN9Zrvbo9b5oHqQUqamlkehoMxOH74jUej59bZQ20MYs8C8ERk8JcOppxEiKviptXTLVe
	fEzE1EZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRljB-000000097YK-1rh1;
	Wed, 18 Jun 2025 05:52:53 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRlj7-000000097WL-1T3Q
	for linux-nvme@lists.infradead.org;
	Wed, 18 Jun 2025 05:52:51 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250618055245epoutp040a89e69fe562fa3ebd1216808e11ce52~KDT4AZbqY3161031610epoutp04l
	for <linux-nvme@lists.infradead.org>; Wed, 18 Jun 2025 05:52:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250618055245epoutp040a89e69fe562fa3ebd1216808e11ce52~KDT4AZbqY3161031610epoutp04l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1750225965;
	bh=AOP00Fc2F9qiSQmOiA4tBYgC5vacOd3AhpFCbS+QFf0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=aAOLhqhy+8kWXebUX2kjKAUEbQ5eiAsM+bcM1mphbBNATPBN9roEinhTpWc8e+xz/
	 UTpiZ2eJxd14dkqv9fEUYEUxGwZa0ME2IHt5jYXPn2ddBCPNuLRiOsmMAtBWUDoKCd
	 EWfxugLF03L5Q6+c93IlKDImOpPBfGmkfqSjQudE=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20250618055244epcas5p21028bfe100b6e774490d4a7d06c69f84~KDT3GFXw92873428734epcas5p2W;
	Wed, 18 Jun 2025 05:52:44 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.180]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4bMXvZ34bfz3hhTJ; Wed, 18 Jun
	2025 05:52:42 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250618055210epcas5p397b5ca1dc472e3008af707391a5fa628~KDTXvhuhH2388423884epcas5p3N;
	Wed, 18 Jun 2025 05:52:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250618055208epsmtip25a760335121f4cf32d5bf2c18a82aad7~KDTVpu8533161231612epsmtip2S;
	Wed, 18 Jun 2025 05:52:08 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
	axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
	hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
	adilger@dilger.ca
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [PATCH for-next v4 0/4] add ioctl to query metadata and protection
 info capabilities
Date: Wed, 18 Jun 2025 11:21:49 +0530
Message-Id: <20250618055153.48823-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250618055210epcas5p397b5ca1dc472e3008af707391a5fa628
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250618055210epcas5p397b5ca1dc472e3008af707391a5fa628
References: <CGME20250618055210epcas5p397b5ca1dc472e3008af707391a5fa628@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250617_225250_037705_374DE5EB 
X-CRM114-Status: GOOD (  13.20  )
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
Patch_2 adds a pi_tuple_size field in blk_integrity struct which is later
used to export this value to the user as well.
Patch 3 allows computing right pi_offset value.
Patch 4 introduces a new ioctl to query integrity capability.

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
  set pi_offset only when checksum type is not BLK_INTEGRITY_CSUM_NONE
  fs: add ioctl to query metadata and protection info capabilities

 block/bio-integrity-auto.c        |  4 +--
 block/blk-integrity.c             | 54 ++++++++++++++++++++++++++++++-
 block/blk-settings.c              | 44 +++++++++++++++++++++++--
 block/ioctl.c                     |  4 +++
 block/t10-pi.c                    | 16 ++++-----
 drivers/md/dm-crypt.c             |  4 +--
 drivers/md/dm-integrity.c         | 12 +++----
 drivers/nvdimm/btt.c              |  2 +-
 drivers/nvme/host/core.c          |  7 ++--
 drivers/nvme/target/io-cmd-bdev.c |  2 +-
 drivers/scsi/sd_dif.c             |  3 +-
 include/linux/blk-integrity.h     | 11 +++++--
 include/linux/blkdev.h            |  3 +-
 include/uapi/linux/fs.h           | 45 ++++++++++++++++++++++++++
 14 files changed, 181 insertions(+), 30 deletions(-)

-- 
2.25.1


