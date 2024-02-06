Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD258C4828D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 07:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=AKsKhbuVCSQIt7s6+76HGOSn3pgv2VPuA7mibF/Sj0w=; b=viLrSXQZm92tHT
	L7aMChqiefjOe0+RlxbnTBWiujynuIS3jvv/2hoa4Z6bHv2zNRmtWwsCnHYOdMgXLgEabvIcTaAIQ
	HlOm1+pcGqgAC2N2SInNhmjIBMnnwmrMadnTpCu6OyZViM4f2rTI3/Bgk5fRp8NGBdzPWql8FXFWi
	NUKz5ur5WN3w5tdZuTC8SYgE5O3RA56wtvzt/y2PA3ZbNSbQmc9NZy3FAy9NCXHSCGfUsjAXJEUI2
	LBfyTdRaFMnguw3Rn7xhalgSLFXQTMkdAiq9WhWu3OFU+Z915wai47Q/V3mfrrY+E75477Ji6Fbqv
	qPflOcECe0Vog4s4kUKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXbyX-00000009tnW-04XJ;
	Wed, 07 Feb 2024 07:04:05 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXbyQ-00000009tma-2DuS
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 07:04:03 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240207070351epoutp04f32bb3d9195d534cb0314558dc7c8928~xgrEx-bpY1444914449epoutp04X
	for <linux-nvme@lists.infradead.org>; Wed,  7 Feb 2024 07:03:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240207070351epoutp04f32bb3d9195d534cb0314558dc7c8928~xgrEx-bpY1444914449epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707289431;
	bh=AKsKhbuVCSQIt7s6+76HGOSn3pgv2VPuA7mibF/Sj0w=;
	h=From:To:Cc:Subject:Date:References:From;
	b=sIL/N5KwGS+sYU0qwej+jr5/hH92mO9uNYPCUX2AcHlr5KMXt4c+T5UcWZ6YpDD5s
	 +Z32fPnUa7D3hE6530hHRRjuM7waQL4NT2ZqZoYd+1K2ElCYw1tW13DlvZSd0KXzP9
	 XsJfNqDKkrBrgfVTDjXa3LYhWEhYR7/MCm6Q99o8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240207070350epcas5p145ef6d5648575c339b2650383c846915~xgrEKZZ2G1947319473epcas5p1E;
	Wed,  7 Feb 2024 07:03:50 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TVB106m1Tz4x9Pt; Wed,  7 Feb
	2024 07:03:48 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	55.B8.10009.45B23C56; Wed,  7 Feb 2024 16:03:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240207050232epcas5p4f6fcd56e72f6b25fe44123df4597a770~xfBKUuxWv0560405604epcas5p4_;
	Wed,  7 Feb 2024 05:02:32 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240207050232epsmtrp1804e66d20051a2a3296a70dfa4824b09~xfBKOLDaa1578315783epsmtrp14;
	Wed,  7 Feb 2024 05:02:32 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-4d-65c32b546cab
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	7E.0D.18939.8EE03C56; Wed,  7 Feb 2024 14:02:32 +0900 (KST)
Received: from localhost.sa.corp.samsungelectronics.net (unknown
	[107.99.41.223]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240207050231epsmtip24b52a9f87d6e5b74fcd75d4205531cbb~xfBIwU1oS1803018030epsmtip2H;
	Wed,  7 Feb 2024 05:02:31 +0000 (GMT)
From: francis.p@samsung.com
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, sathya.m@samsung.com,
	d.palani@samsung.com, prakash.bv@samsung.com, anshul@samsung.com, Francis
	Pravin <francis.p@samsung.com>
Subject: [PATCH] nvme: use ns->head->pi_size instead of t10_pi_tuple
 structure size
Date: Wed,  7 Feb 2024 05:04:17 +0530
Message-Id: <1707262457-20904-1-git-send-email-francis.p@samsung.com>
X-Mailer: git-send-email 1.8.3.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7bCmhm6I9uFUg5uTjC1+T5/CavF/zzE2
	i7dfH7BZHFu0hdli5eqjTBaTDl1jtJi/7Cm7xb0ZXewW616/Z7HYenkBuwOXx8Tmd+we5+9t
	ZPHYtKqTzWPzknqP3Tcb2Dz6tqxiDGCLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1
	tLQwV1LIS8xNtVVy8QnQdcvMATpNSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNg
	UqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdsXldA3vBLvaKz8fPsDUwzmbrYuTkkBAwkTiz7CNT
	FyMXh5DAbkaJnsONLBDOJ0aJM4+WscM53068AnI4wFoOrPCGiO9klFjd08sG4bQxScxuusgO
	MpdNQFpi05LPYDtEBBwlXq14DlbELLCMUeLA6StMIAlhgVCJV727wBpYBFQl/vyZwAxi8wq4
	Sjzq/MMIcaCCxJSH75lBmiUEjrFLPGs9xASRcJHY/Oo7lC0s8er4FnYIW0riZX8blJ0v8Wr3
	c6iaContu25D2fYSF/f8ZQJ5h1lAU2L9Ln2IsKzE1FPrwEqYBfgken8/gSrnldgxD8ZWltj0
	ZD0rhC0p0dx4B2qVh8SVOz/BbCGBWIneI01MExhlZyFsWMDIuIpRMrWgODc9tdi0wCgvtRwe
	U8n5uZsYwUlOy2sH48MHH/QOMTJxMB5ilOBgVhLhNdtxIFWINyWxsiq1KD++qDQntfgQoykw
	zCYyS4km5wPTbF5JvKGJpYGJmZmZiaWxmaGSOO/r1rkpQgLpiSWp2ampBalFMH1MHJxSDUzO
	LWt79s66ktP5/n4XY8FZkdpbP+4oPr47sYdTfVFaW2WNYq5jf++l9uO/uq41TQyu130V+UdD
	q+zRX/nl06UcVq1rVs1pYdpkN3vzt++djWfs5+ov1JGNPckyU4DfMJH5rbCOxPRawbPcx1u8
	av7dO3fdQNl+c+eWLrHps203HPSUnMn3XcOB3ddx+r/a5T136v0KQw1Xsq+ffVaCa8btNVaz
	ErXDxYReNfBV/vsw65al2tNlmZNz5R7dXMNzPWmDrqL/u9s3fp/gyn31767svCsZ3OKSgULi
	fqLN3Pu/s6fcu//344LQGd62vT6snEq3kzrzLhwNbl1edU3m3t0fk+9/3XCMv+OFATfr7j1K
	LMUZiYZazEXFiQBfuxL2+wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnluLIzCtJLcpLzFFi42LZdlhJXvcF3+FUg40v9Cx+T5/CavF/zzE2
	i7dfH7BZHFu0hdli5eqjTBaTDl1jtJi/7Cm7xb0ZXewW616/Z7HYenkBuwOXx8Tmd+we5+9t
	ZPHYtKqTzWPzknqP3Tcb2Dz6tqxiDGCL4rJJSc3JLEst0rdL4MrYvK6BvWAXe8Xn42fYGhhn
	s3UxcnBICJhIHFjh3cXIxSEksJ1RYunSHUBxTqC4pMSxaYvYIWxhiZX/nrNDFLUwSbTe6AMr
	YhOQlti05DOYLSLgLnH0ZQMTSBGzwBpGib57vWDdwgLBEst/N7CC2CwCqhJ//kxgBrF5BVwl
	HnX+YYTYoCAx5eF75gmMPAsYGVYxiqYWFOem5yYXGOoVJ+YWl+al6yXn525iBIeZVtAOxmXr
	/+odYmTiYDzEKMHBrCTCa7bjQKoQb0piZVVqUX58UWlOavEhRmkOFiVxXuWczhQhgfTEktTs
	1NSC1CKYLBMHp1QD01KxjR/eXUhhYNgkl58Y075hxT6jeUkbbgWv11VJYJHonMe4RUppQWqp
	m/mEdQvVTzqF5tn58q+0yFtzVG+3pgRLk92co8y7te5d6Z9WHLqsLMvp5Q/b7cu3VeaeDkzv
	FOievnBRnNSNtVJy080DpoXu8mQ5s9n4X2lpQ0xy4SWO2SmH/JaZvFPyYT77k7XGLaJhcebd
	poVmD5oaChM8rTnfpDpd2R2blXhfqmSCnp8qp/adcEYpiS06Ri+Pyk312Hlv0/Sf//pN5XJL
	7vYI/siJerC54vnRB0sv7jjZeXrHs7wmgRlq4UlFEfPnbZ7JnVPpf+bUfyPRTe7L7A6FPr3m
	ypNvICPf/SmhPO+pEktxRqKhFnNRcSIAnZhWHKICAAA=
X-CMS-MailID: 20240207050232epcas5p4f6fcd56e72f6b25fe44123df4597a770
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240207050232epcas5p4f6fcd56e72f6b25fe44123df4597a770
References: <CGME20240207050232epcas5p4f6fcd56e72f6b25fe44123df4597a770@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240206_230400_839854_79DCEFE6 
X-CRM114-Status: GOOD (  16.24  )
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

From: Francis Pravin <francis.p@samsung.com>

Currently kernel supports 8 byte and 16 byte protection information.
So, use ns->head->pi_size instead of sizeof(struct t10_pi_tuple).

Signed-off-by: Francis Pravin <francis.p@samsung.com>
Signed-off-by: Sathyavathi M <sathya.m@samsung.com>
---
 drivers/nvme/host/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 18f5c1be..3dfd5ae9 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -228,7 +228,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	length = (io.nblocks + 1) << ns->head->lba_shift;
 
 	if ((io.control & NVME_RW_PRINFO_PRACT) &&
-	    ns->head->ms == sizeof(struct t10_pi_tuple)) {
+	    (ns->head->ms == ns->head->pi_size)) {
 		/*
 		 * Protection information is stripped/inserted by the
 		 * controller.
-- 
1.8.3.1


