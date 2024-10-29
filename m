Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DBBD3A661
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 15:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KkMsdiy6+G613EM2iVNE1sWpzDf7A70uir1Q/qyFKn0=; b=fVn7ZXUdNifpJYlgSmglffpF4i
	R5cZFIPvmA58FBqNpLg1yv4ZrerMN3GEYa8RJGi7BGCGC00ARPk98/4ec6M/tzmKG3KT7ZzBtCKZK
	M0tug4mVnTqwNpAfNwKHIAAoX03eRjlKIfkvrLb5wpzZeRwC4AsQEUKBnLYxBGz0aHQc07CA/MvlE
	arpIqBPYHiEnw7wRi+FrfPJx266Jlztpc/b7HZ/JiVFzmxFDeEl+OINq+q0eBcxrmdovTWeha+ECa
	pYDbFQN9SIT/qpITFoNgM4s3AIPSrnwYzaQwfZsiQywg5jh2R8Vtf+97eixaRDdIY6Pmfs4RxLq9P
	1htg4jzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5o3W-0000000EtYv-1Jud;
	Tue, 29 Oct 2024 15:22:50 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5o0j-0000000EsgB-3msX
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 15:19:59 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 49TD7Fwj021662
	for <linux-nvme@lists.infradead.org>; Tue, 29 Oct 2024 08:19:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=KkMsdiy6+G613EM2iVNE1sWpzDf7A70uir1Q/qyFKn0=; b=GiVZVm5W+RXT
	zyP06X7gCJqRTFYdNORXxwmh6xw7VUUpi0VQfY3gwYgE/BB4Vzw5jFbrIiirlIAr
	+4VC7U26lB3w9WiUzypItJv0eIIUdYrwEhObziPttAgbNRDgVFXqR3xnWpNt4KZL
	Xq1U3pXWtcvZJX9ekGOEFXC+0w3Vz5cY2j7Y0I7eNk7gMXcci8Z6guhm9L1S+dUE
	Z8KwcmGKbQ6lIvKhEbc2IDrIgeCpY1PZTwIHNuqZNz6W2M+J+CDzvHG5U9vKsk01
	edMipsrm4IT1qZzh56uphZTAEqfmTqaLLFvus43Czjkt/AzdjokeAby1x5BnGFNk
	XSrm5Dan/A==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 42k0af13y2-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 29 Oct 2024 08:19:57 -0700 (PDT)
Received: from twshared23455.15.frc2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 29 Oct 2024 15:19:52 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id DFE2C14920E9C; Tue, 29 Oct 2024 08:19:43 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <hch@lst.de>, <joshi.k@samsung.com>,
        <javier.gonz@samsung.com>, <bvanassche@acm.org>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv10 1/9] block: use generic u16 for write hints
Date: Tue, 29 Oct 2024 08:19:14 -0700
Message-ID: <20241029151922.459139-2-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241029151922.459139-1-kbusch@meta.com>
References: <20241029151922.459139-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 4ijmMjG2JFkIyoZoL3_27Bdp3r0tA0xS
X-Proofpoint-ORIG-GUID: 4ijmMjG2JFkIyoZoL3_27Bdp3r0tA0xS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_081958_088073_C42AC7CA 
X-CRM114-Status: GOOD (  13.86  )
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

This is still backwards compatible with lifetime hints. It just doesn't
constrain the hints to that definition. Using this type doesn't change
the size of either bio or request.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/blk-mq.h    | 3 +--
 include/linux/blk_types.h | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2035fad3131fb..08ed7b5c4dbbf 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -8,7 +8,6 @@
 #include <linux/scatterlist.h>
 #include <linux/prefetch.h>
 #include <linux/srcu.h>
-#include <linux/rw_hint.h>
=20
 struct blk_mq_tags;
 struct blk_flush_queue;
@@ -156,7 +155,7 @@ struct request {
 	struct blk_crypto_keyslot *crypt_keyslot;
 #endif
=20
-	enum rw_hint write_hint;
+	unsigned short write_hint;
 	unsigned short ioprio;
=20
 	enum mq_rq_state state;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index dce7615c35e7e..6737795220e18 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -10,7 +10,6 @@
 #include <linux/bvec.h>
 #include <linux/device.h>
 #include <linux/ktime.h>
-#include <linux/rw_hint.h>
=20
 struct bio_set;
 struct bio;
@@ -219,7 +218,7 @@ struct bio {
 						 */
 	unsigned short		bi_flags;	/* BIO_* below */
 	unsigned short		bi_ioprio;
-	enum rw_hint		bi_write_hint;
+	unsigned short		bi_write_hint;
 	blk_status_t		bi_status;
 	atomic_t		__bi_remaining;
=20
--=20
2.43.5


