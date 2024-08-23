Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD42C52D7C
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Aug 2024 10:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gXHtlknFE9nvxeqNKkR2iIn97pKvOQEYOliJebKXNkQ=; b=B5lwizGPYdaUEfG3iFqgFOYRhv
	a76FDUgABkjX0VAWBskQlSlekFmhCie4Cidcn72kEQC+c5grVlfTwlpxjaD9XHxtAaUl+QJ8gHhdD
	AfKu5H6VAQcfGkA37VkQ16XKFENQxtmCMFCW77XK5ZYjb7TmxbFmZP/K+w2PWa9FMWcXUz8dFbnrl
	myw+DrTLywq9iC81bpL6IyM8TuiYFODr06EXFhVqB/IxfwtRGlkR3uFI7/3ARINUzjw1g/IfT9IiM
	NuQ71xN49tilcceiEVNGpd4nv3qlHbKBDds2TcFehnCfl63WjX44Sz2EikXj62svsKED/BIqN/T4v
	/1ST9vsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shRqt-0000000GPPL-3EM3;
	Fri, 23 Aug 2024 10:49:07 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shRqc-0000000GP5N-25z7
	for linux-nvme@lists.infradead.org;
	Fri, 23 Aug 2024 10:48:53 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240823104848epoutp03aab575c2467e1fcad30cdefdad3fb3d7~uVeAR2Fms1016010160epoutp03F
	for <linux-nvme@lists.infradead.org>; Fri, 23 Aug 2024 10:48:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240823104848epoutp03aab575c2467e1fcad30cdefdad3fb3d7~uVeAR2Fms1016010160epoutp03F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724410128;
	bh=gXHtlknFE9nvxeqNKkR2iIn97pKvOQEYOliJebKXNkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fNd+sOs/aZ6FYPx6i/ZvLjCvRhnZgWWvEEm3FJZR8YvSWsJd263P6D5WiG8JF6vkK
	 XdKArXpeaD8BEklmU6v++tx/TyIsUpMU9yD8FPXZoXTJBHY8m05cvPyWO4VnVu7qzu
	 13Z+1OlCOlIZXRafX2yL4O0yN85fcOOib+emJy2Y=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240823104847epcas5p16806045158f31a0435af199a300942a0~uVd-793x92850228502epcas5p1H;
	Fri, 23 Aug 2024 10:48:47 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4WqxdB189bz4x9Pq; Fri, 23 Aug
	2024 10:48:46 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CA.30.08855.E0968C66; Fri, 23 Aug 2024 19:48:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240823104636epcas5p4825a6d2dd9e45cfbcc97895264662d30~uVcFscXsf1394713947epcas5p4Q;
	Fri, 23 Aug 2024 10:46:36 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240823104636epsmtrp23a2d147a0fe123c333c0fe910e8f9b7b~uVcFnczlI0163301633epsmtrp2W;
	Fri, 23 Aug 2024 10:46:36 +0000 (GMT)
X-AuditID: b6c32a44-15fb870000002297-d0-66c8690e4604
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	29.0B.08456.C8868C66; Fri, 23 Aug 2024 19:46:36 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240823104634epsmtip2046c9f44c5cbd54c2a0c28b10004bbb0~uVcDpDd3N1442714427epsmtip2x;
	Fri, 23 Aug 2024 10:46:34 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, krisman@suse.de
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [PATCH v3 09/10] nvme: add handling for app_tag
Date: Fri, 23 Aug 2024 16:08:10 +0530
Message-Id: <20240823103811.2421-11-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823103811.2421-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLJsWRmVeSWpSXmKPExsWy7bCmli5f5ok0g8adLBZNE/4yW8xZtY3R
	YvXdfjaLmwd2MlmsXH2UyeJd6zkWi6P/37JZTDp0jdFi+5mlzBZ7b2lbzF/2lN2i+/oONovl
	x/8xOfB67Jx1l93j8tlSj02rOtk8Ni+p99h9s4HN4+PTWywefVtWMXpsPl3t8XmTXABnVLZN
	RmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtDRSgpliTml
	QKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK94sTc4tK8dL281BIrQwMDI1OgwoTsjEXH
	2pkL5nNXbPjp38C4lLOLkZNDQsBEovHxJEYQW0hgN6PEkW0FXYxcQPYnRokzL5awQDjfGCX+
	b37ADtNxuOUmVGIvo8S+vweYIZzPjBINf08wg1SxCahLHHneCjZXRKBS4vmuH2AdzAI3GSWa
	j+1j6mLk4BAWsJB402cIUsMioCqx6vw8FhCbV8BS4ljLGSaIbfISMy99B9vMCRRvmt0AVSMo
	cXLmEzCbGaimeetssCMkBFZySDxY1s8I0ewisXjZU1YIW1ji1fEtUC9ISXx+t5cNwk6X+HH5
	KdSyApDboHrtJVpP9TOD3MksoCmxfpc+RFhWYuqpdUwQe/kken8/gWrlldgxD8ZWkmhfOQfK
	lpDYe64ByvaQuLriLhsksHoYJZ4s7mKewKgwC8k/s5D8Mwth9QJG5lWMkqkFxbnpqcmmBYZ5
	qeXwSE7Oz93ECE7HWi47GG/M/6d3iJGJg/EQowQHs5IIb9K9o2lCvCmJlVWpRfnxRaU5qcWH
	GE2BAT6RWUo0OR+YEfJK4g1NLA1MzMzMTCyNzQyVxHlft85NERJITyxJzU5NLUgtgulj4uCU
	amB6MSN2x5Ubk9ZwHZSpmLGM+2pm7pU+T2GOK7ImL/3ELaYVWN4WfN36d6Ly9m86U3Z7p3wK
	mqcq264yK90i+NTOG/sks96de9e8JdLTfuX1h655DzeVP1vF/6pFY3fNhzY7Y1HVUmM1k2ec
	5wXWPeDlnPk2yZd55yeZXQ7Ppdnl3s/iENi57s0WfuMrTbtcY3hFD95zefjxX/RS3vBFK927
	fQ/sXOHQZfdvQVqjjMrm/r4lHVsfbn7ovqcsf0tSwDz3K4s+59/MvNPNl9TA9lz94xwBIcP7
	U8Ryg/8km1zQm71tiy5bwt1/34Vbt+xg+ui1p/To05TbVpnlvW3Td2XFbvJZUGM293C7doP6
	4T38SizFGYmGWsxFxYkAksp/elAEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWy7bCSvG5Pxok0g4sdkhZNE/4yW8xZtY3R
	YvXdfjaLmwd2MlmsXH2UyeJd6zkWi6P/37JZTDp0jdFi+5mlzBZ7b2lbzF/2lN2i+/oONovl
	x/8xOfB67Jx1l93j8tlSj02rOtk8Ni+p99h9s4HN4+PTWywefVtWMXpsPl3t8XmTXABnFJdN
	SmpOZllqkb5dAlfGomPtzAXzuSs2/PRvYFzK2cXIySEhYCJxuOUmSxcjF4eQwG5GiTdPZjBB
	JCQkTr1cxghhC0us/PecHaLoI6PElOuH2UESbALqEkeetzKCJEQEGhkltjR/ARvFLHCfUeJt
	824gh4NDWMBC4k2fIUgDi4CqxKrz81hAbF4BS4ljLWegtslLzLz0HWwoJ1C8aXYDWI0QUOuy
	5WcYIeoFJU7OfAIWZwaqb946m3kCo8AsJKlZSFILGJlWMUqmFhTnpucWGxYY5aWW6xUn5haX
	5qXrJefnbmIEx4yW1g7GPas+6B1iZOJgPMQowcGsJMKbdO9omhBvSmJlVWpRfnxRaU5q8SFG
	aQ4WJXHeb697U4QE0hNLUrNTUwtSi2CyTBycUg1MXPuWaE//+MMw1udO4oUGRucZO8t27H3K
	t1vduo7V2S1omeb11gt7lETMBVbtYr2VXmWqLavp5M+0v3JP8vxbYZHmKXqzLHxdWNkPnLc7
	HXX0D5tO7MkV0Xvs2i0PxxT9+7plbW+d+iHd5M6W1UtVX//c8XPjlGlvJi2ezhLIOM109SZ+
	01BbP/kPOwQv+czI7z6ituC7vDOTPiP/Vp5XDAw9T7/8Vp9Y9Vmg9bvt9gSXybqFeY6P7+0P
	LRK1rWl+Xvz4CE/+jIKiKa5SBlXuCyK4Tu/eKjBtvkPKS52yt2G3TJNn3Gjdudbt3rvbwfza
	065bxdzS4lstE/Pkw04uiYsaLce79ZmF2RJYZZmVWIozEg21mIuKEwFmrOzyCAMAAA==
X-CMS-MailID: 20240823104636epcas5p4825a6d2dd9e45cfbcc97895264662d30
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240823104636epcas5p4825a6d2dd9e45cfbcc97895264662d30
References: <20240823103811.2421-1-anuj20.g@samsung.com>
	<CGME20240823104636epcas5p4825a6d2dd9e45cfbcc97895264662d30@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240823_034851_090953_77B9619F 
X-CRM114-Status: GOOD (  14.98  )
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

From: Kanchan Joshi <joshi.k@samsung.com>

With user integrity buffer, there is a way to specify the app_tag.
Set the corresponding protocol specific flags and send the app_tag down.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d4c366df8f12..af6940ec6e3c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -871,6 +871,13 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	return BLK_STS_OK;
 }
 
+static void nvme_set_app_tag(struct nvme_command *cmnd, u16 apptag)
+{
+	cmnd->rw.apptag = cpu_to_le16(apptag);
+	/* use 0xfff as mask so that apptag is used in entirety */
+	cmnd->rw.appmask = cpu_to_le16(0xffff);
+}
+
 static void nvme_set_ref_tag(struct nvme_ns *ns, struct nvme_command *cmnd,
 			      struct request *req)
 {
@@ -1010,6 +1017,11 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 				control |= NVME_RW_APPEND_PIREMAP;
 			nvme_set_ref_tag(ns, cmnd, req);
 		}
+		if (bio_integrity_flagged(req->bio, BIP_CHECK_APPTAG)) {
+			control |= NVME_RW_PRINFO_PRCHK_APP;
+			nvme_set_app_tag(cmnd,
+					 bio_integrity(req->bio)->app_tag);
+		}
 	}
 
 	cmnd->rw.control = cpu_to_le16(control);
-- 
2.25.1


