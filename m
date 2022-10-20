Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4366C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 07:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zHJKdoK0j+tBk5Hr9o0as1l9KQnd4N+x1CvZaigokmI=; b=kUShtFdFcu1HhWpJvwDQFDwPdp
	dsyNNZw9MP7yhIoqBcBUC1ila+3gW3eXAKz/cqO4p+w8yS6Zmqy2LFuDSzE58P2caoxHKE8O5WlM5
	7Ht4ZGtZs37DLWBFd3h9EUAU0JirBCPRLNuL3IfktPNN1L6uDdeVo6zzPbew3u5heafjmE/W+VM7L
	sODQrj9RHSP78oP+gLvLmm0OarjrifiAlnQxljPRU+2swlyHW6hUQEWtpjTOFsDzrZ3VQY+FTmVa4
	rylhTbLqMKOO6lOBvETVqZEOQg/c+b9e4TosiXI/gs4zVSzzxrhrvnvwS9H83w8GL91BOOT003moJ
	YqN51jaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olPkx-00BYNj-IR; Thu, 20 Oct 2022 07:14:19 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olPkm-00BYA7-HP
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 07:14:17 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221020071350epoutp01fb83c937f20bd0b5cd5253892c8908f1~ftZL80Yzk1554515545epoutp010
	for <linux-nvme@lists.infradead.org>; Thu, 20 Oct 2022 07:13:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221020071350epoutp01fb83c937f20bd0b5cd5253892c8908f1~ftZL80Yzk1554515545epoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1666250030;
	bh=zHJKdoK0j+tBk5Hr9o0as1l9KQnd4N+x1CvZaigokmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R8QuiK4/NpPoaxcd16DKik6VqaLpW9//3PTFca1SOR2NNQY6XMRyFw4p9P96uVezh
	 22fhUSafq9Je82zXAU0muLhQDeyp2+sIXP/7diHfdfh6x/7ACB3K7++Dr405tjW0l/
	 UgcCgoJoG2GnX3xkwfzD3dKDE9Gxe8fTecb1rVOg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20221020071349epcas5p31d1890226a4ba64629cf0b97ed1353a0~ftZLqJhfZ0164101641epcas5p36;
	Thu, 20 Oct 2022 07:13:49 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4MtJjl5dhjz4x9Q5; Thu, 20 Oct
	2022 07:13:47 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	60.A7.26992.A25F0536; Thu, 20 Oct 2022 16:13:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20221020071346epcas5p4c3b8da5e60f94947ad570cbd151eb38d~ftZIT7rIw0195301953epcas5p4p;
	Thu, 20 Oct 2022 07:13:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221020071346epsmtrp2d8dea24edb48772ac0da9395f7080c49~ftZITL2XU1526015260epsmtrp2H;
	Thu, 20 Oct 2022 07:13:46 +0000 (GMT)
X-AuditID: b6c32a49-0c7ff70000016970-ca-6350f52aded2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	BE.4E.14392.925F0536; Thu, 20 Oct 2022 16:13:46 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20221020071344epsmtip2d3977afa15b5cfacbc5bfdee0147ac16~ftZHEICzo2670526705epsmtip2L;
	Thu, 20 Oct 2022 07:13:44 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, gost.dev@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>
Subject: [PATCH 2/2] nvme: identify-namespace without CAP_SYS_ADMIN
Date: Thu, 20 Oct 2022 12:32:05 +0530
Message-Id: <20221020070205.57366-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221020070205.57366-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjk+LIzCtJLcpLzFFi42LZdlhTQ1fra0CywZNWcYvVd/vZLG4e2Mlk
	sXL1USaLo//fsllMOnSN0WL+sqfsFutev2dxYPc4f28ji8fls6Uem1Z1snlsXlLvsftmA5tH
	35ZVjAFsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6Z
	OUCnKCmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0M
	jEyBChOyM/Yf/c5esJqzYsLXPvYGxlPsXYycHBICJhIH1h9g62Lk4hAS2M0ocWPbSWYI5xOj
	xPVpM6Ey3xglzvycwQbT8nNDO1i7kMBeRol5re4QRZ8ZJWY9P87YxcjBwSagKXFhcilIjYiA
	i8TnngusIDazQLzEzb+bweYICzhLdFyaxQJiswioSrzseQQ2k1fAQuLaxL0sELvkJWZe+g4W
	5xSwlFh4bB4zRI2gxMmZT1ggZspLNG+dDXa1hMBbdolrzU+YIJpdJHa92MEKYQtLvDq+Bepn
	KYnP7/ZCPZMscWnmOaj6EonHew5C2fYSraf6mUF+YQb6Zf0ufYhdfBK9v0HGcwCV8Ep0tAlB
	VCtK3Jv0FGqTuMTDGUugbA+J5z3rWCDB08MoMePjRZYJjPKzkLwwC8kLsxC2LWBkXsUomVpQ
	nJueWmxaYJiXWg6P1+T83E2M4ASp5bmD8e6DD3qHGJk4GA8xSnAwK4nwFrwLSBbiTUmsrEot
	yo8vKs1JLT7EaAoM44nMUqLJ+cAUnVcSb2hiaWBiZmZmYmlsZqgkzrt4hlaykEB6Yklqdmpq
	QWoRTB8TB6dUA1Ozl19SuWDvMf8jjruuhN8TdtrkYCB6eM5icTn/0+v5prd/kNliwnVKc+7E
	G/+7th//cPpLV9f8RwHX18jd1r/c+/PrspWLFhvKuP1eLNwbwbfp/bUzxl3BvFsMorpC2wvc
	S7XPujIvveaidM0r/kbx8Wr/4L9MjHunfGn13Shk8ZS1tK5+Yebzz1p/j1ae452nH7pxt6/x
	0p1vlnJx/LtnzKnac23apaeefeIHbYyUd+T+aWWO85p3k2/vCqHDV99ee/h6ypKXO6rbPJ3Z
	90vdqBFim/Z3fdIhlcSNmY4zlp4z982WTj+h17tJiilJNWnJs4KvK7Z13ZhdzWJ/m4VbRO/9
	v4A4xnSGqtaIFUlKLMUZiYZazEXFiQAthqkNGQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSvK7W14Bkg+uXmCxW3+1ns7h5YCeT
	xcrVR5ksjv5/y2Yx6dA1Rov5y56yW6x7/Z7Fgd3j/L2NLB6Xz5Z6bFrVyeaxeUm9x+6bDWwe
	fVtWMQawRXHZpKTmZJalFunbJXBl7D/6nb1gNWfFhK997A2Mp9i7GDk5JARMJH5uaAeyuTiE
	BHYzSvye2gCVEJdovvYDyhaWWPnvOVTRR0aJM+s3sHYxcnCwCWhKXJhcClIjIuAlcfvlc2YQ
	m1kgUeL90cesILawgLNEx6VZLCA2i4CqxMueR2AzeQUsJK5N3MsCMV9eYual72BxTgFLiYXH
	5oHNEQKq+TTrCwtEvaDEyZlPWCDmy0s0b53NPIFRYBaS1CwkqQWMTKsYJVMLinPTc4sNCwzz
	Usv1ihNzi0vz0vWS83M3MYKDW0tzB+P2VR/0DjEycTAeYpTgYFYS4S14F5AsxJuSWFmVWpQf
	X1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA9PeJ6HpXQcc69qfPJb56/Fl
	+sEWs5c/Ny5N0v3VE7Lie0PtmsWci7Mz5H8vdXnTvqaGx+orS1ICx4ZXDodfn856dnCFxrZr
	BYeZ9C3cWi1WJn+RZBUwUH2TOHFTRLWB/LRtmfZHGvqmObjx/Gnd9jD5WVLE5S97QrWnGZ/5
	GzFhjvBUpX/OLhYq5011a0p+Ri+PWLd72b6YHs80w0OSJ3/r85k5X12muiB3b8Ouk/qbgh7P
	srlyly/kipdSuNOm5HS+45Ps+6blZTOqz3a5nLJUMCs1XJc7Z9e2PTc+9j7OCb7JoPWiIny5
	2PdniULf6v5bmruFL9g83ffK1R+7qnNvp/pkSnVLbZ3903e3ZoUSS3FGoqEWc1FxIgA32rS4
	3QIAAA==
X-CMS-MailID: 20221020071346epcas5p4c3b8da5e60f94947ad570cbd151eb38d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221020071346epcas5p4c3b8da5e60f94947ad570cbd151eb38d
References: <20221020070205.57366-1-joshi.k@samsung.com>
	<CGME20221020071346epcas5p4c3b8da5e60f94947ad570cbd151eb38d@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_001413_075455_5EC9D8CD 
X-CRM114-Status: GOOD (  18.40  )
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

Allow all identify-namespace variants (CNS 00h, 05h and 08h) without
requiring CAP_SYS_ADMIN. The information (retrieved using id-ns) is
needed to form IO commands for passthrough interface.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/ioctl.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 9c581b1a8956..9273db147872 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -15,9 +15,19 @@ bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c, fmode_t mode)
 	if (capable(CAP_SYS_ADMIN))
 		return true;
 
-	/* admin commands are not allowed */
-	if (!ns)
+	/* policy for admin commands */
+	if (!ns) {
+		if (opcode == nvme_admin_identify) {
+			switch (c->identify.cns) {
+			case NVME_ID_CNS_NS:
+			case NVME_ID_CNS_CS_NS:
+			case NVME_ID_CNS_NS_CS_INDEP:
+				return true;
+			}
+		}
+		/* other admin commands are not allowed */
 		return false;
+	}
 
 	/* exclude vendor-specific io and fabrics commands */
 	if (opcode >= nvme_cmd_vendor_start || opcode == nvme_fabrics_command)
-- 
2.25.1


