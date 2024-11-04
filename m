Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C87D111A1
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2024 15:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=og22ywRlDp0pEXMrdTg3MkhTF5pEsbsojrZbbFE+yGQ=; b=xoy7TgCQrj/PQAszTPvTYr0Xv1
	+Dm2obuaViwFkuztcxZqugRndTq+y3hMCyaZsFrYZQsCrRIjxNO3Abu28t1Vf9X4v6K7lgbCOTqdf
	W2Iay5gCJCvKefOW0UR1cYp7A+iK13CN3R8Yrh8BB/2QVxvuy9L08A8HfJjJwk79vvnNWTRCaJPZn
	44+cEmej3qprfD2EDLikS9nt8Q/F26+kLZc8fS8CnatHuZGNiav3Pop/psm5E3r56aMlZlRts7AFH
	M9hnpw0zyWTq5goH6+FVg0OJH7ZDN+kb6GW3TSSpNb+hxcc1dW/6l9YJAHTbXWxtTHK3FyNzvsJW9
	TouVf8Sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7zRX-0000000EHg4-1xaY;
	Mon, 04 Nov 2024 15:56:39 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7zRM-0000000EHVY-2g0C
	for linux-nvme@lists.infradead.org;
	Mon, 04 Nov 2024 15:56:33 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241104155626epoutp0358d585d9bcd787d9b7d3c68b050e6feb~Ezwc24gK81886218862epoutp03P
	for <linux-nvme@lists.infradead.org>; Mon,  4 Nov 2024 15:56:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241104155626epoutp0358d585d9bcd787d9b7d3c68b050e6feb~Ezwc24gK81886218862epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730735786;
	bh=og22ywRlDp0pEXMrdTg3MkhTF5pEsbsojrZbbFE+yGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rhYiLOLfEXaNFT6lEgIy2XX6KLnbjK+5MumuDnORZ4Eea3yY+XVBySHDtUdBPf3Nh
	 fcQTmvrdkdIej2wZDZzmzBig1iuC05323EBKEub/9+miOjCIkbcw4mlravqKMLeyb9
	 WXUWhHjGNVx879JtrrGp4aBsnIcADWjmukN4DlkM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20241104155626epcas5p10383c972697100e6e05280210168dfa5~EzwcaolWj1113211132epcas5p1r;
	Mon,  4 Nov 2024 15:56:26 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Xhx0S3nxWz4x9Pv; Mon,  4 Nov
	2024 15:56:24 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EA.A7.09420.8AEE8276; Tue,  5 Nov 2024 00:56:24 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20241104141507epcas5p161e39cef85f8fa5f5ad59e959e070d0b~EyX_4hxKZ2157721577epcas5p10;
	Mon,  4 Nov 2024 14:15:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241104141507epsmtrp267492ec32aa1e84b08c069a0c6fa19d5~EyX_3soeQ1987119871epsmtrp2R;
	Mon,  4 Nov 2024 14:15:07 +0000 (GMT)
X-AuditID: b6c32a49-33dfa700000024cc-1d-6728eea8dd62
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A6.78.35203.AE6D8276; Mon,  4 Nov 2024 23:15:07 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241104141504epsmtip29fc75f4f83ca57006c5c9a63d7dd3b1f~EyX8hKVv-3128131281epsmtip24;
	Mon,  4 Nov 2024 14:15:04 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, anuj1072538@gmail.com,
	brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	linux-fsdevel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH v7 09/10] scsi: add support for user-meta interface
Date: Mon,  4 Nov 2024 19:36:00 +0530
Message-Id: <20241104140601.12239-10-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241104140601.12239-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFJsWRmVeSWpSXmKPExsWy7bCmpu6KdxrpBicOSFp8/PqbxaJpwl9m
	izmrtjFarL7bz2bx+vAnRoubB3YyWaxcfZTJ4l3rORaL2dObmSwmHbrGaLH3lrbFnr0nWSzm
	L3vKbtF9fQebxfLj/5gszv89zmpxftYcdgdBj52z7rJ7XD5b6rFpVSebx+Yl9R67bzaweXx8
	eovFo2/LKkaPMwuOsHt83iTnsenJW6YArqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwND
	XUNLC3MlhbzE3FRbJRefAF23zBygd5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5
	BSYFesWJucWleel6eaklVoYGBkamQIUJ2RlTv/WwF5wXrWh43cvewHhFsIuRk0NCwERi6qqJ
	jF2MXBxCArsZJdpXL2AGSQgJfGKU+DvRASLxjVFi+oJFTDAdc19/herYyyjx/sRBVgjnM6PE
	xf1fWUCq2ATUJY48bwWrEhHYwyjRu/A0C4jDLPCSUWLpqkVgVcICzhIvzu4Em8sioCqx9PBd
	NhCbV8BK4tbxy8wQ++QlZl76zg5icwLF5/y9ywJRIyhxcuYTMJsZqKZ562xmkAUSAlc4JC70
	foE61kWi/2UPI4QtLPHq+BZ2CFtK4vO7vWwQdrrEj8tPoeoLJJqP7YOqt5doPdUPNJQDaIGm
	xPpd+hBhWYmpp9YxQezlk+j9/QSqlVdixzwYW0mifeUcKFtCYu+5BijbQ+LK4pXQsOtllDjy
	Yx7zBEaFWUj+mYXkn1kIqxcwMq9ilEwtKM5NTy02LTDMSy2Hx3Nyfu4mRnAi1/LcwXj3wQe9
	Q4xMHIyHGCU4mJVEeOelqqcL8aYkVlalFuXHF5XmpBYfYjQFBvhEZinR5HxgLskriTc0sTQw
	MTMzM7E0NjNUEud93To3RUggPbEkNTs1tSC1CKaPiYNTqoHJifFqxGPb8v6mmlLVi9mxi23i
	lkpWq+8+4cfEczSq8+O1t7pMEy8+F3AoLE4RNLsbo8ZeGP7sRxzn84Y5ISnntkh3nhTntk7y
	7FvZ4CTduFd7itz8t2lna48tnNvD5yrvyp9/405mvuovjgMBv9dHNnLXra5KSA/RFft2bLNn
	7PtPEp9Mlj50+X2rSHajunQIj3tnQWulcvickm0fmW6fuLvdbNW3ox7c529uCZqq3mjy5GvR
	fr0ogTeyT66KWb/5vb/52z+DRx9+LMuNnll9+8he2xmCm++v8lJZ+ej8/VVTwtZNCJu544SU
	05JXHTvOVM+Jjfgn0XXBNKfeyPNkWM7B9XbTTesndtSFiDAosRRnJBpqMRcVJwIAkNrP8W0E
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCSvO7raxrpBj//M1l8/PqbxaJpwl9m
	izmrtjFarL7bz2bx+vAnRoubB3YyWaxcfZTJ4l3rORaL2dObmSwmHbrGaLH3lrbFnr0nWSzm
	L3vKbtF9fQebxfLj/5gszv89zmpxftYcdgdBj52z7rJ7XD5b6rFpVSebx+Yl9R67bzaweXx8
	eovFo2/LKkaPMwuOsHt83iTnsenJW6YArigum5TUnMyy1CJ9uwSujKnfetgLzotWNLzuZW9g
	vCLYxcjJISFgIjH39VfGLkYuDiGB3YwSuz9vZIVISEicermMEcIWllj57zk7RNFHRomOm1eZ
	QRJsAuoSR563ghWJCJxglJg/0Q2kiBmkaMKX2SwgCWEBZ4kXZ3cygdgsAqoSSw/fZQOxeQWs
	JG4dv8wMsUFeYual7+wgNidQfM7fu2C9QgKWEpuaLrFA1AtKnJz5BMxmBqpv3jqbeQKjwCwk
	qVlIUgsYmVYxSqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgRHmpbmDsbtqz7oHWJk4mA8
	xCjBwawkwjsvVT1diDclsbIqtSg/vqg0J7X4EKM0B4uSOK/4i94UIYH0xJLU7NTUgtQimCwT
	B6dUA1M269Klq3aa3ZusK+a26Jdt2ub3u/8YHGTny/70PGfZ9twreR9EJ2RZLE5PmHXW5rDX
	llsaRwweSAb9YLO+cH5G9mm5XKWuhvkP/sp5x9m2fpi8dXLJzWg/4dBlOxwcdzXzvTJWXVQi
	OvU34xoNVrfaK80HZ/258E5BPmdjdolaoRB3t/azyf3bGbtC1vI2hddvjdohOetQNvMs50/1
	Np2fJpgdO5Sz5dIUyVtXSo+YbTj4T4BjA3fNrleb03/lJm/PZWLYVD1fbge74EXxp6qJSd0S
	6R8Lj7/7w7k+7f2KkrAH7m4Ja7lebdJ/JXbh8l+5xf+f2LkLVz1hM3NLmtGt778vX6VKMZXT
	pujnZWElluKMREMt5qLiRAC0JXdRIwMAAA==
X-CMS-MailID: 20241104141507epcas5p161e39cef85f8fa5f5ad59e959e070d0b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241104141507epcas5p161e39cef85f8fa5f5ad59e959e070d0b
References: <20241104140601.12239-1-anuj20.g@samsung.com>
	<CGME20241104141507epcas5p161e39cef85f8fa5f5ad59e959e070d0b@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_075629_302932_ABFAE2FC 
X-CRM114-Status: GOOD (  18.23  )
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

Add support for sending user-meta buffer. Set tags to be checked
using flags specified by user/block-layer.
With this change, BIP_CTRL_NOCHECK becomes unused. Remove it.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sd.c             |  4 ++--
 include/linux/bio-integrity.h | 16 +++++++---------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index ca4bc0ac76ad..d1a2ae0d4c29 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -814,14 +814,14 @@ static unsigned char sd_setup_protect_cmnd(struct scsi_cmnd *scmd,
 		if (bio_integrity_flagged(bio, BIP_IP_CHECKSUM))
 			scmd->prot_flags |= SCSI_PROT_IP_CHECKSUM;
 
-		if (bio_integrity_flagged(bio, BIP_CTRL_NOCHECK) == false)
+		if (bio_integrity_flagged(bio, BIP_CHECK_GUARD))
 			scmd->prot_flags |= SCSI_PROT_GUARD_CHECK;
 	}
 
 	if (dif != T10_PI_TYPE3_PROTECTION) {	/* DIX/DIF Type 0, 1, 2 */
 		scmd->prot_flags |= SCSI_PROT_REF_INCREMENT;
 
-		if (bio_integrity_flagged(bio, BIP_CTRL_NOCHECK) == false)
+		if (bio_integrity_flagged(bio, BIP_CHECK_REFTAG))
 			scmd->prot_flags |= SCSI_PROT_REF_CHECK;
 	}
 
diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index fe2bfe122db2..2195bc06dcde 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -7,13 +7,12 @@
 enum bip_flags {
 	BIP_BLOCK_INTEGRITY	= 1 << 0, /* block layer owns integrity data */
 	BIP_MAPPED_INTEGRITY	= 1 << 1, /* ref tag has been remapped */
-	BIP_CTRL_NOCHECK	= 1 << 2, /* disable HBA integrity checking */
-	BIP_DISK_NOCHECK	= 1 << 3, /* disable disk integrity checking */
-	BIP_IP_CHECKSUM		= 1 << 4, /* IP checksum */
-	BIP_COPY_USER		= 1 << 5, /* Kernel bounce buffer in use */
-	BIP_CHECK_GUARD		= 1 << 6, /* guard check */
-	BIP_CHECK_REFTAG	= 1 << 7, /* reftag check */
-	BIP_CHECK_APPTAG	= 1 << 8, /* apptag check */
+	BIP_DISK_NOCHECK	= 1 << 2, /* disable disk integrity checking */
+	BIP_IP_CHECKSUM		= 1 << 3, /* IP checksum */
+	BIP_COPY_USER		= 1 << 4, /* Kernel bounce buffer in use */
+	BIP_CHECK_GUARD		= 1 << 5, /* guard check */
+	BIP_CHECK_REFTAG	= 1 << 6, /* reftag check */
+	BIP_CHECK_APPTAG	= 1 << 7, /* apptag check */
 };
 
 struct bio_integrity_payload {
@@ -33,8 +32,7 @@ struct bio_integrity_payload {
 	struct bio_vec		bip_inline_vecs[];/* embedded bvec array */
 };
 
-#define BIP_CLONE_FLAGS (BIP_MAPPED_INTEGRITY | BIP_CTRL_NOCHECK | \
-			 BIP_DISK_NOCHECK | BIP_IP_CHECKSUM | \
+#define BIP_CLONE_FLAGS (BIP_MAPPED_INTEGRITY | BIP_IP_CHECKSUM | \
 			 BIP_CHECK_GUARD | BIP_CHECK_REFTAG | BIP_CHECK_APPTAG)
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
-- 
2.25.1


