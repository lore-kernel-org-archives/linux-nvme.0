Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD2BC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jun 2022 20:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MLry2TNqyft+XNkOpEGpBVNauRHTTVwTy2e0E5j67+M=; b=IYJHqW93yc62XX8jLuSLVadObT
	0uVA2DEhFx3KQYaDVPmiE8GmisnBXjc8cknIoKjGdgW9eVO2rQdwvm6sf+EzRK9mVkv5/73XdEmWK
	9Tou3Ed3lzxCKP031Suh/dSf1mLnOSNtL1cCAhwnkocJc2aVfDBxhnTMbQWbj3shCws9cUxctZ5ar
	8Yxmw06fJPOdyCnhkP4AA0TVYTxYpXmXgCP+4AJSgvRnHCZ4LAS86QlNDNEzEHBaokY9xAEnH/s2/
	xzYQu2SeQxTIUWCWct+xr80LbVsOTZkZlmTkI1uDtCYcIsFjzR0wruj9io1X/b5RvUUHPTDkDpW6P
	Jmw2oD9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o712J-001UB3-Fm; Thu, 30 Jun 2022 20:45:15 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o710A-001TBN-UA
	for linux-nvme@lists.infradead.org; Thu, 30 Jun 2022 20:43:04 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UGPrff032045
	for <linux-nvme@lists.infradead.org>; Thu, 30 Jun 2022 13:43:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=MLry2TNqyft+XNkOpEGpBVNauRHTTVwTy2e0E5j67+M=;
 b=DwxWtWwGgFomaFybjRMT97ik8YpL3s0/Qz6AgnhYRPFdXHvpkrJYEUV+9TvUsaOOJ0Mb
 p7uhsvXOnQX5abwLNjBZmaoRllu8kdF7+iHyZJiqHsz2ynI9ZJjx5mp77leIIe5V6TuE
 xnQ+LuJ3WkELTNC7lZEayKWJ7LZw3IOhF8E= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h12ug6g16-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 30 Jun 2022 13:43:02 -0700
Received: from twshared5640.09.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 13:43:00 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 228B15932DC4; Thu, 30 Jun 2022 13:42:30 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <willy@infradead.org>, <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 12/12] block: export and document bit_bucket attribute
Date: Thu, 30 Jun 2022 13:42:12 -0700
Message-ID: <20220630204212.1265638-13-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220630204212.1265638-1-kbusch@fb.com>
References: <20220630204212.1265638-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: uPwCwSWGBj21qj7xyde9QeUqo046d__t
X-Proofpoint-ORIG-GUID: uPwCwSWGBj21qj7xyde9QeUqo046d__t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_14,2022-06-28_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220630_134303_002090_6AE7CCE5 
X-CRM114-Status: GOOD (  15.69  )
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

From: Keith Busch <kbusch@kernel.org>

Now that user space applications can make use of partial sector reads,
export and document the queue attribute that indicates if the capability
is supported.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 Documentation/ABI/stable/sysfs-block | 9 +++++++++
 block/blk-sysfs.c                    | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/sta=
ble/sysfs-block
index cd14ecb3c9a5..defc056690d0 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -142,6 +142,15 @@ Description:
 		Default value of this file is '1'(on).
=20
=20
+What:		/sys/block/<disk>/queue/bit_bucket
+Date:		June 2022
+Contact:	linux-block@vger.kernel.org
+Description:
+		[RO] This file indicates if the device supports partial sector
+		reads.  If set to '1', user space can issue direct IO reads at
+		dma_alignment granularity.
+
+
 What:		/sys/block/<disk>/queue/chunk_sectors
 Date:		September 2016
 Contact:	Hannes Reinecke <hare@suse.com>
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 85ea43eff094..0c1f1c2fbb30 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -309,6 +309,7 @@ QUEUE_SYSFS_BIT_FNS(nonrot, NONROT, 1);
 QUEUE_SYSFS_BIT_FNS(random, ADD_RANDOM, 0);
 QUEUE_SYSFS_BIT_FNS(iostats, IO_STAT, 0);
 QUEUE_SYSFS_BIT_FNS(stable_writes, STABLE_WRITES, 0);
+QUEUE_SYSFS_BIT_FNS(bit_bucket, BIT_BUCKET, 0);
 #undef QUEUE_SYSFS_BIT_FNS
=20
 static ssize_t queue_zoned_show(struct request_queue *q, char *page)
@@ -627,6 +628,7 @@ QUEUE_RW_ENTRY(queue_nonrot, "rotational");
 QUEUE_RW_ENTRY(queue_iostats, "iostats");
 QUEUE_RW_ENTRY(queue_random, "add_random");
 QUEUE_RW_ENTRY(queue_stable_writes, "stable_writes");
+QUEUE_RW_ENTRY(queue_bit_bucket, "bit_bucket");
=20
 static struct attribute *queue_attrs[] =3D {
 	&queue_requests_entry.attr,
@@ -653,6 +655,7 @@ static struct attribute *queue_attrs[] =3D {
 	&queue_zone_append_max_entry.attr,
 	&queue_zone_write_granularity_entry.attr,
 	&queue_nonrot_entry.attr,
+	&queue_bit_bucket_entry.attr,
 	&queue_zoned_entry.attr,
 	&queue_nr_zones_entry.attr,
 	&queue_max_open_zones_entry.attr,
--=20
2.30.2


