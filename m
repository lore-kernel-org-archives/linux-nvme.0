Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C6EC2BB3F
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 22:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M8htFuQxJZG8po3RKf01MkNCd95IOJcyvkzSlqSB8p8=; b=fWoW5Up6JjVUoY7WRy6mhOrK45
	aahoFoPMZrmkeKwGrrYLOa4yaM0raBPDiUBC+FQgdobf/t8xTQQ62LWhup1X8aRi13vNA0s2+TpYU
	j6/NaGBBFeFr3uU5gCfi6k8GepMCTVNMAdl85qqkldWNSoPYXU2hIn2j2hcRISngW5elGB9+NBJJL
	sHNtFK3r1mAYTwBiitNtXvxzq3OSI+JAvdayYIU1SVLoOUNuAWzhuxYWoc6zj7IKpDMXoiZmGK74T
	KhtndZkVwh2Nf5tFmFCzWxMZOf84fDLAqns+sqPom0yf/Ao7lTYcBEwbhooeK+e2ju+cJPubcx3fa
	/F0t6pow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5CxB-00EzYq-0J;
	Mon, 20 Nov 2023 22:41:17 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5Cx6-00EzWP-2C
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 22:41:15 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AKMU69S019936
	for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 14:41:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=M8htFuQxJZG8po3RKf01MkNCd95IOJcyvkzSlqSB8p8=;
 b=hz+peIQeEw8s600s1PMM1jXSo7qiyIicDQcL8d6fEIOp/kLCERoxeGhtGcbyg/M+qWh9
 zIN2oNHRJy3ASLw3Vx8p8E3fUyfQN+BGI0ldsXLdC1OvvbW9Fwrt6wGjrYiaWdYVe0QM
 SeARvza7NZS1Sj9S0/dkjR7miEPADxcI9oGi/hDRyo4fe0EFnCKnkdL7Fgg419oQQqWD
 wUFW3cB1ULtnaSaxh0VabgFGD4kdjJ3a+0obn6Q5/3RuL0fSfLZNZERymHvl8k0JiT+H
 NfJ/U7NMj8ycETi3iLsuVEptlOJsT7IRF8YMAzsfp1KkhdA4UKJl50KY1m1n/8fMo2ms Dg== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ugg9xr3ck-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 14:41:10 -0800
Received: from twshared22605.07.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 14:41:09 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 8AA0521F1B1A8; Mon, 20 Nov 2023 14:40:59 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <io-uring@vger.kernel.org>
CC: <axboe@kernel.dk>, <hch@lst.de>, <joshi.k@samsung.com>,
        <martin.petersen@oracle.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 1/5] bvec: introduce multi-page bvec iterating
Date: Mon, 20 Nov 2023 14:40:54 -0800
Message-ID: <20231120224058.2750705-2-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120224058.2750705-1-kbusch@meta.com>
References: <20231120224058.2750705-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: hryYD1Abq3uKE_z8nhnKaFfpilvknI90
X-Proofpoint-GUID: hryYD1Abq3uKE_z8nhnKaFfpilvknI90
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_22,2023-11-20_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_144112_743570_E62D0985 
X-CRM114-Status: GOOD (  12.73  )
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

Some bio_vec iterators can handle physically contiguous memory and have
no need to split bvec consideration on page boundaries.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/bvec.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 555aae5448ae4..9364c258513e0 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -184,6 +184,12 @@ static inline void bvec_iter_advance_single(const st=
ruct bio_vec *bv,
 		((bvl =3D bvec_iter_bvec((bio_vec), (iter))), 1);	\
 	     bvec_iter_advance_single((bio_vec), &(iter), (bvl).bv_len))
=20
+#define for_each_mp_bvec(bvl, bio_vec, iter, start)			\
+	for (iter =3D (start);						\
+	     (iter).bi_size &&						\
+		((bvl =3D mp_bvec_iter_bvec((bio_vec), (iter))), 1);	\
+	     bvec_iter_advance_single((bio_vec), &(iter), (bvl).bv_len))
+
 /* for iterating one bio from start to end */
 #define BVEC_ITER_ALL_INIT (struct bvec_iter)				\
 {									\
--=20
2.34.1


