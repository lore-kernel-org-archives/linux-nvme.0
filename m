Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54572D374BC
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 16:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F8aJRbYmwU4rV7+ts4Kj/9zivoR8gg/b0xX0kqcFNzw=; b=uAx7MUVyS3Ke8Awu+MgfHu/8NT
	BcEWySec+8v4RYRCv5mi+hRt4acbifubHdd7B8hsqcZ/Jb2tsPp5TUfvmicArRHbPdsv55DIkp6po
	bX++negDDnl5tvjDIhEq+eeKDNuSgxerjL46br2SVQ39jc3LfuO7hYNgfPYQrqPW7gAksrXkY7jsq
	9uixEKk3pUcHS3J1ooWdwJVPJV/Vo3QB3YV+8vI/+EYmxiw2YffyBSoUkMnYJgm/ncxOv1oJhDZxO
	tcMYphAonzE5AlTDU0aJlbNKciBij5PX2BbLaX2P93z4Sa2az1bxMCfqDAGC8OH57rMGtXo6YHzWH
	KfzCYk7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1T5l-0000000FQlC-2Wtg;
	Thu, 17 Oct 2024 16:11:13 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1T4t-0000000FQS0-1yv9
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 16:10:23 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 49HChDZd024730
	for <linux-nvme@lists.infradead.org>; Thu, 17 Oct 2024 09:10:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=F8aJRbYmwU4rV7+ts4Kj/9zivoR8gg/b0xX0kqcFNzw=; b=c31A6XtIm9Ci
	gcYKQ3yho/Rzn03fosS0zovJ8pJxkiDkTSxJ159qOZNIwJxcwVflTWKo9WDoAC66
	4x1hvBwCv0zqpUOLVYfMIVOhFzhbbi2aaAlPXRIZ5mLfqrjGooGC3BATWk07ACgF
	ISkgHrk0D9MzomGroaLmlrROTq1Kud2GwcAQNVgT4tSLjY3rAUzN74yqTNAGL7Nt
	Nu5aaGNgCVhnoUZjbClcnQ+vfc/OHNWN3j0a3NKrUkPCj0DVq3Ohvl7n5HnU5Hm0
	N/pDuGDEvvpQ5S+1z3MpjIKULRoFcErSyOhneyx/PoJIEOqE+HtgYBy5X8Mq+fHA
	Vy02XrAjUQ==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 42a8wmb1fd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 17 Oct 2024 09:10:18 -0700 (PDT)
Received: from twshared16035.07.ash9.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Thu, 17 Oct 2024 16:10:17 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 2D3EF143A4AB4; Thu, 17 Oct 2024 09:10:01 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <axboe@kernel.dk>, <hch@lst.de>, <io-uring@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <joshi.k@samsung.com>,
        <javier.gonz@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv8 2/6] block: use generic u16 for write hints
Date: Thu, 17 Oct 2024 09:09:33 -0700
Message-ID: <20241017160937.2283225-3-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241017160937.2283225-1-kbusch@meta.com>
References: <20241017160937.2283225-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 2ftjzcv90Mr1LLoOwSuGCExX5vCM6CgM
X-Proofpoint-ORIG-GUID: 2ftjzcv90Mr1LLoOwSuGCExX5vCM6CgM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_091019_666873_A8165C2C 
X-CRM114-Status: GOOD (  13.46  )
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
constrain the hints to that definition.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/blk-mq.h    | 3 +--
 include/linux/blk_types.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 59e9adf815a49..bf007a4081d9b 100644
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
index dce7615c35e7e..56b7fb961e0c7 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -219,7 +219,7 @@ struct bio {
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


