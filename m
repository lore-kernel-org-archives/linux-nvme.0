Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA36C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 07:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=tvvJMi+/XQ2LNp030IYE1axwkY7UG8gjiUdmUScVWUM=; b=JxPqeOe9WTwY0es0jhvlhaC7lI
	+DqdoJtjP3nyYKWX8ovXHavPshBwXp16KolCJUUp0DoCSkRt1HdF18TkAHNDK5WhIeIC92XAHtn8t
	HR6zzQ3Fm2fVb4/Dl7V3gocfWvDKXW8Zp8vLEEqRg9d8REHWCwaRBlzj3xPbKX5xreFrAcBMagypB
	7fl+FUEd6eZWgE94ZcZjl/GvjK1laMMG0ezkxAgyeFeNmlpj7lPZ0mjKHdDFAXYjPHv8nq8cSWM3r
	ibnVJyEJylcGDm3FEKPqkWRk0qdk5AF4wvKUDZyzfQUdJ/wUvA4eVRjqhTriVZ/ThVZ3kq95lDeqD
	SfC7Me8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3Xz3-003xCb-Kb; Tue, 21 Jun 2022 07:07:33 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3Xz0-003xB3-Py
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 07:07:32 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220621070725euoutp010db00db687ee5aabbe010cea1106b913~6kQCr-ZNc2758427584euoutp01L
	for <linux-nvme@lists.infradead.org>; Tue, 21 Jun 2022 07:07:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220621070725euoutp010db00db687ee5aabbe010cea1106b913~6kQCr-ZNc2758427584euoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1655795245;
	bh=tvvJMi+/XQ2LNp030IYE1axwkY7UG8gjiUdmUScVWUM=;
	h=From:To:CC:Subject:Date:References:From;
	b=Ua1vchQSliJ9Z2eWXAZtPVpkj7/NpdndPGGw0iSi4Q6EUzwPhG6qsLmUYovb2mW2R
	 I7gcOxF9nyhIXaFGHfHDvN0Cv70Stvlv4wNeAZpTbvY4X78Ln9CtD+elLBuW3I3wFy
	 YYV8cZNNi4a0/Mu35yM7yk+sQP9nVYb83LScHqhc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220621070724eucas1p2191850d947eb71742e1366f3f18eaa09~6kQClpvz52818428184eucas1p2z;
	Tue, 21 Jun 2022 07:07:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 10.7F.09580.C2E61B26; Tue, 21
	Jun 2022 08:07:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20220621070724eucas1p186a9c118c37b140e60c2d1f8cacf636a~6kQCT2FPw0726807268eucas1p1s;
	Tue, 21 Jun 2022 07:07:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220621070724eusmtrp18c1efc43c240b2eb71db1da76639e17e~6kQCTJume3227132271eusmtrp1i;
	Tue, 21 Jun 2022 07:07:24 +0000 (GMT)
X-AuditID: cbfec7f5-9adff7000000256c-37-62b16e2cc6e1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 89.E3.09038.C2E61B26; Tue, 21
	Jun 2022 08:07:24 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20220621070724eusmtip1a22349f018b38869d95a3e5a50dedda7~6kQCMcerT2662226622eusmtip1W;
	Tue, 21 Jun 2022 07:07:24 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 21 Jun 2022 08:07:24 +0100
From: Joel Granados <j.granados@samsung.com>
To: <hch@lst.de>, <kbusch@kernel.org>
CC: <gost.dev@samsung.com>, <linux-nvme@lists.infradead.org>,
	<joshi.k@samsung.com>, Joel Granados <j.granados@samsung.com>
Subject: [PATCH v3] nvme: Fix CRMS masks for TP4084 - Time-to-ready
Date: Tue, 21 Jun 2022 09:05:00 +0200
Message-ID: <20220621070500.1381155-1-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsWy7djPc7o6eRuTDE7OsrRYufook8WkQ9cY
	LeYve8ruwOyxaVUnm8fmJfUeu282sAUwR3HZpKTmZJalFunbJXBlzD/UzlbQxFZx8f4i9gbG
	HyxdjBwcEgImEqvme3cxcnIICaxglJj7UKyLkQvI/sIoceLTNBYI5zOjxJpV79lBqkAaJn2Z
	xwqRWM4osezzK1a4qi3PF0O1bGaUODDnKVgLm4COxPk3d5hB9okIqErsa7EFCTML1Eqc2LmB
	BcQWFnCW2DinhxXEZgEq6Zt7DMzmFbCV2H6gkQlis7xE2/XpjBBxQYmTM5+wQMyRl2jeOpsZ
	wpaQOPjiBTNEvaLEljnfWSHsWolTW24xgdwmIbCUQ2LSm0VsEP+7SCw8qAJRIyzx6vgWqC9l
	JE5P7mGBsLMldk7ZBTWzQGLWyalQrdYSfWdyIMKOErvWfYSGKJ/EjbeCENfwSUzaNp0ZIswr
	0dEmBFGtJrGjaSvjBEblWUh+mYXkl1lIflnAyLyKUTy1tDg3PbXYOC+1XK84Mbe4NC9dLzk/
	dxMjMFWc/nf86w7GFa8+6h1iZOJgPMQowcGsJMJrw70hSYg3JbGyKrUoP76oNCe1+BCjNAeL
	kjhvcuaGRCGB9MSS1OzU1ILUIpgsEwenVAOTvOCF62WW7LYlq+8clN8a0Gpg8He1TcWMrKfX
	f/9eGnIjs7i+qe+9mvW5D5fP3j4/5bzCLpVNTaev9z2wMrmRf4z3QqND9PLlUo5m1n+v/ZQO
	c+C1yTVqEz23pHGr7tUd/lNa/A4va5l/MlMvzSL/936hta8vbFXxuNb64/ztCZmt5hbBW5dp
	320zr5hmyNvzpTDHrTRQcU4a67m8sjyW6LvquzrUvHzibK27POIZRDI4VGQcEmOeC7fFzT7z
	RrI/Z5XZjmmn53E6f0+vmcAut8LjcWLU7dTG/yznYuo0Kj13yjz68Oyxsu66bUpJzOvn/vtq
	XMWUotL667TgiUo+G4X9nnxtJXpRCy9OSVdiKc5INNRiLipOBAD4x+qghAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjkeLIzCtJLcpLzFFi42I5/e/4XV2dvI1JBt1X1CxWrj7KZDHp0DVG
	i/nLnrI7MHtsWtXJ5rF5Sb3H7psNbAHMUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG
	5rFWRqZK+nY2Kak5mWWpRfp2CXoZ8w+1sxU0sVVcvL+IvYHxB0sXIyeHhICJxKQv81i7GLk4
	hASWMkrs3fOJGSIhI/Hpykd2CFtY4s+1LjaIoo+MEnOWP2OEcDYzSixcOQ2sik1AR+L8mztA
	3RwcIgKqEvtabEHCzAK1Eid2bgDbJizgLLFxTg8riM0CVNI39xiYzStgK7H9QCMTxDJ5ibbr
	0xkh4oISJ2c+YYGYIy/RvHU2M4QtIXHwxQuoQxUltsz5zgph10p8/vuMcQKj0Cwk7bOQtM9C
	0r6AkXkVo0hqaXFuem6xkV5xYm5xaV66XnJ+7iZGYIRsO/Zzyw7Gla8+6h1iZOJgPMQowcGs
	JMJrw70hSYg3JbGyKrUoP76oNCe1+BCjKdA/E5mlRJPzgTGaVxJvaGZgamhiZmlgamlmrCTO
	61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXA1NZhrNZwuN324iYL7YbkNfo7lny6fer1C7v5ixZO
	2PqAYyPTMuG7TFuVVt2R/9gjnixXnvdv/5bVzid2CT+zP2CWWOUjcOzrJw+799OLmRtX1fbX
	sOuHtGdFLDvP+uDVzPsfVI7ctDF4L5ecOeNcyPoVR9mLv/nXTLhnyLq05zDPdv8UHaELwgHM
	0yYnWey6++fT/ilbE++sPWFcK/+Hb4O72PM982o7ZQIlLsz6Xfera7M1k+j8s0f1Hu+6pyR4
	0uj4VOk5R7kqOSzWLbx1hrFo59sQ/TlsXK7nmjKFpzxuF7HkEnxiujLwrPv2q3mpd1d8SOOq
	WbnU4J1GdHzx8j/LCo+v5z6nz7Ji+rzv3IxKLMUZiYZazEXFiQBb27nUGQMAAA==
X-CMS-MailID: 20220621070724eucas1p186a9c118c37b140e60c2d1f8cacf636a
X-Msg-Generator: CA
X-RootMTR: 20220621070724eucas1p186a9c118c37b140e60c2d1f8cacf636a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220621070724eucas1p186a9c118c37b140e60c2d1f8cacf636a
References: <CGME20220621070724eucas1p186a9c118c37b140e60c2d1f8cacf636a@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_000731_299988_0702868B 
X-CRM114-Status: GOOD (  12.47  )
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

Adjust the values of NVME_CAP_CRMS_CRIMS and NVME_CAP_CRMS_CRWMS masks as
they are different from the ones in TP4084 - Time-to-ready.

Fixes: 354201c53e61 ("nvme: add support for TP4084 - Time-to-Ready Enhancements").

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 include/linux/nvme.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 29ec3e3481ff..e3934003f239 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -233,8 +233,8 @@ enum {
 };
 
 enum {
-	NVME_CAP_CRMS_CRIMS	= 1ULL << 59,
-	NVME_CAP_CRMS_CRWMS	= 1ULL << 60,
+	NVME_CAP_CRMS_CRWMS	= 1ULL << 59,
+	NVME_CAP_CRMS_CRIMS	= 1ULL << 60,
 };
 
 struct nvme_id_power_state {
-- 
2.30.2


