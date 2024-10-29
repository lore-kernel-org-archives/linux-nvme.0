Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F45D3A678
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 17:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8JozZTu1XSCEABsX3TkivbzX6vM8WnvmIwslWwYHbLA=; b=COoqkeF3nhZI6M5fxzGbmxM1dv
	wYEmMHKEtX/Avl4tfpU5fVS+zS19OoYThJJMA5cxX/v2xlMNtqFK4QxIdFRkJFre/0CR8/9io0TZ5
	lx67DlnkMM/UoRQ9vBxaFLKJcyPbSU2K6j8KYGvmuG4NHbUVZVchfCuaNb6fTZVd2CrSsDQpqEV81
	bsmi5Q96yI8MM9HzGqGp59Zj2titTIzF3IsqbXirpBMPZKLt5Ifw6dzORssBQQ2QTy4HlbGpRpNuu
	h+NEqamg59ChjbDYHVR4DciictY4Dx6qvO4xnLTx75/1RU2rxF+91uZjKtwFheFLD+roQD8L7RV5f
	ooymkY4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5qQE-0000000FP64-2aG7;
	Tue, 29 Oct 2024 17:54:26 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5pyX-0000000FFS2-40SO
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 17:25:51 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241029172547epoutp01041f6f35bfd0a7acf9d3b65ff808812e~C-GvskNFI2983329833epoutp015
	for <linux-nvme@lists.infradead.org>; Tue, 29 Oct 2024 17:25:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241029172547epoutp01041f6f35bfd0a7acf9d3b65ff808812e~C-GvskNFI2983329833epoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1730222747;
	bh=8JozZTu1XSCEABsX3TkivbzX6vM8WnvmIwslWwYHbLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r7ivlmECaV8wf5QrHiLPI+XMiUlv1fnlU4mGueqZn92jyQhmcCRe240PO3jBlj1Bc
	 vy4Q5EVH1OXMus+/oS1O+ouFM+NmS80Vw5AFLXVPQEICRq2aBQsr0YgEmtiovubdnH
	 jxNNeizemzNBOoj2IgYDTFmDiJ69UDSEMaNjmlJg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20241029172546epcas5p3bec90d67d624ce23cd583d1956e0b8ce~C-Gu44GIQ2484924849epcas5p3P;
	Tue, 29 Oct 2024 17:25:46 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4XdHGK1qJTz4x9Pq; Tue, 29 Oct
	2024 17:25:45 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	00.1A.09420.99A11276; Wed, 30 Oct 2024 02:25:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20241029163233epcas5p497b3c81dcdf3c691a6f9c461bf0da7ac~C_YQ3_uT52670526705epcas5p4X;
	Tue, 29 Oct 2024 16:32:33 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241029163233epsmtrp1799296227aa898eaa6db6202340f0d68~C_YQ3LOAg0723107231epsmtrp10;
	Tue, 29 Oct 2024 16:32:33 +0000 (GMT)
X-AuditID: b6c32a49-0d5ff700000024cc-2a-67211a99c54a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0D.4B.07371.02E01276; Wed, 30 Oct 2024 01:32:33 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241029163230epsmtip2b37587e74672e6bf9f7f3d746f1ccbb8~C_YOnT_e90998409984epsmtip2c;
	Tue, 29 Oct 2024 16:32:30 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, anuj1072538@gmail.com,
	brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	linux-fsdevel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH v5 09/10] scsi: add support for user-meta interface
Date: Tue, 29 Oct 2024 21:54:01 +0530
Message-Id: <20241029162402.21400-10-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241029162402.21400-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJJsWRmVeSWpSXmKPExsWy7bCmhu5MKcV0g6aX7BYfv/5msWia8JfZ
	Ys6qbYwWq+/2s1m8PvyJ0eLmgZ1MFitXH2WyeNd6jsVi9vRmJotJh64xWuy9pW2xZ+9JFov5
	y56yW3Rf38Fmsfz4PyaL83+Ps1qcnzWH3UHQY+esu+wel8+Wemxa1cnmsXlJvcfumw1sHh+f
	3mLx6NuyitHjzIIj7B6fN8l5bHrylimAKyrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ
	19DSwlxJIS8xN9VWycUnQNctMwfoHSWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpO
	gUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsasHyEFyzkq/v74wNzA+JWti5GTQ0LAROLPmgtM
	XYxcHEICuxkldpzvZ4NwPjFK/FlymQXC+cYo8bXpJVzLnJVNUC17GSW2v//OCuF8ZpS4su8C
	C0gVm4C6xJHnrYwgCRGBPYwSvQtPg81iFnjJKLF01SKwKmEBZ4n2zx+YQGwWAVWJO6/3M4PY
	vAJWEq+3XGGF2CcvMfPSd3YQmxMofuzoHiaIGkGJkzOfgM1hBqpp3jqbGWSBhMAFDol1c28C
	FXEAOS4Sc1vTIOYIS7w6voUdwpaSeNnfBmWnS/y4/JQJwi6QaD62jxHCtpdoPdXPDDKGWUBT
	Yv0ufYiwrMTUU+uYINbySfT+fgLVyiuxYx6MrSTRvnIOlC0hsfdcA5TtIbHh50RoaPUySjT+
	2ss6gVFhFpJ3ZiF5ZxbC6gWMzKsYJVMLinPTU4tNCwzzUsvh0Zycn7uJEZzGtTx3MN598EHv
	ECMTB+MhRgkOZiUR3tWxsulCvCmJlVWpRfnxRaU5qcWHGE2B4T2RWUo0OR+YSfJK4g1NLA1M
	zMzMTCyNzQyVxHlft85NERJITyxJzU5NLUgtgulj4uCUamCafn+m+pwl649denbUPeEfc9uu
	BSr/627dbYus3vfi7JrIgMOCyyR+Tr7S/Hfi6rqz8oeXuh9f4yk6+UMoi9nljN78g44uAfI8
	nm92VL37XH6eOeaShsX93uVFZj/+rnSpE7lm7OUY+tjz4J7CH1Ol/l8MbvheaxaV2K9y6u7K
	J29U04p3TVF8p3tI8GXmvFec/ZM9f4kJzzX+ErdLPfun/q7NO6+7L2ZP8T/D+UJ0lRVf0pZN
	X/TeuDJ4MbkqF33jq3T+phw1gTecN/2Vdbze7YdS0y3np96r/PfXYeEWSf/W9x5fGaaULLx5
	IWNmUspUgf1/pu+533Tx8CODtOctAcUK+rov523ZdJQjPfNurBJLcUaioRZzUXEiACTaXNJs
	BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42LZdlhJXleRTzHd4MB2JouPX3+zWDRN+Mts
	MWfVNkaL1Xf72SxeH/7EaHHzwE4mi5WrjzJZvGs9x2Ixe3ozk8WkQ9cYLfbe0rbYs/cki8X8
	ZU/ZLbqv72CzWH78H5PF+b/HWS3Oz5rD7iDosXPWXXaPy2dLPTat6mTz2Lyk3mP3zQY2j49P
	b7F49G1ZxehxZsERdo/Pm+Q8Nj15yxTAFcVlk5Kak1mWWqRvl8CVMetHSMFyjoq/Pz4wNzB+
	Zeti5OSQEDCRmLOyiamLkYtDSGA3o8Tlf99ZIBISEqdeLmOEsIUlVv57zg5R9JFR4tbal2Dd
	bALqEkeet4IViQicYJSYP9ENpIgZpGjCl9lgk4QFnCXaP39gArFZBFQl7rzezwxi8wpYSbze
	coUVYoO8xMxL39lBbE6g+LGje4DqOYC2WUqcnOQGUS4ocXLmE7CRzEDlzVtnM09gFJiFJDUL
	SWoBI9MqRsnUguLc9NxkwwLDvNRyveLE3OLSvHS95PzcTYzgKNPS2MF4b/4/vUOMTByMhxgl
	OJiVRHhXx8qmC/GmJFZWpRblxxeV5qQWH2KU5mBREuc1nDE7RUggPbEkNTs1tSC1CCbLxMEp
	1cB0K/vn1RopATEJjlsKT5Qe5k5/M9HD7cvDVy7CU2davft8PHcaC/O9N59+n7584PgifSmp
	W81Mjg9F1Hkq020vsKWeOCu34tSfne9+WwdN1bUwiDxyjuH17i1bovbnT3nueMu7+N3dkwKR
	XD8avPdJpleay8UwLRKPKj+R8WvmoZnT/9Qm5H7UOfPg9IqgtG9MWjP18gx7X11MuSxlU6/3
	JmLNu2c/PpbaCrg+m/SBjXOJH7+Z+OnpVmzcj1UfCWzL3LczUtmze2f6x3CRs+4LKjvnHOiV
	qo84Zc1hoXzlntAb0yCPLUvKSj65WPzN6PgmKa4wac+1WQ5xp3af+ufi7zjrSsmWoJ64Tasu
	n/z3UomlOCPRUIu5qDgRAM91qNEhAwAA
X-CMS-MailID: 20241029163233epcas5p497b3c81dcdf3c691a6f9c461bf0da7ac
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241029163233epcas5p497b3c81dcdf3c691a6f9c461bf0da7ac
References: <20241029162402.21400-1-anuj20.g@samsung.com>
	<CGME20241029163233epcas5p497b3c81dcdf3c691a6f9c461bf0da7ac@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_102550_345710_0D8AF9E0 
X-CRM114-Status: GOOD (  18.10  )
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

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 drivers/scsi/sd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

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
 
-- 
2.25.1


