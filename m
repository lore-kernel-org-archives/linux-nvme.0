Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E267FA3740
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Oct 2022 16:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O7alrBg9Cpc13ZCBcNJc5Dv8mHvGI7TQXOzrAtuLV4Y=; b=GKMzc0LLmMcrkAX9YfDquv/ldc
	nlQfSq5LcDoCkuwzo2tRAZlNeaEnLnC8G9txMJMxH7Sh6lLpHvQwUc1vvtyvX3bunOvNXRtKI01Yp
	TFDmYwkV8fJxYPgt7cPitdCF9baWUnCuk6UpahzjKMY4IWpQpk/fzN11rgjyL2Kbqvf3UeunqEcSn
	bi8cZvlbK/9XPDfzgpyxPi4SiUXp/j6MKwZMiPHfkxPV/cE/ba+pk9jl7sfTu1HCT+Hw7zUAtUmTb
	0u0guANcieUrBr7NBrzsnuNPtCuj8pjtHO39G15pORbBbdMjo/NHF5Q03ZhaE/HkwhI+/Qs6Jodtt
	CQOU0fEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo5KJ-00E9z0-8m; Thu, 27 Oct 2022 16:01:51 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo5Ji-00E9bo-8p
	for linux-nvme@lists.infradead.org; Thu, 27 Oct 2022 16:01:19 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221027160108euoutp02dec3dde9ef1c8edf2f7cf8cab9288416~h_GlpjsvF2946729467euoutp02L
	for <linux-nvme@lists.infradead.org>; Thu, 27 Oct 2022 16:01:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221027160108euoutp02dec3dde9ef1c8edf2f7cf8cab9288416~h_GlpjsvF2946729467euoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1666886468;
	bh=O7alrBg9Cpc13ZCBcNJc5Dv8mHvGI7TQXOzrAtuLV4Y=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=V9sKPp5pGsXy0Nc2ZfcvTvWsDjkxC7YOUeIX50l7uSz5Soo/MmB8bEUBvssENJ91p
	 60GPqQKYRyzIVu/s4eXAaUWHIY2IyFaPJs3uJjFJARfW9HmLw089NMYl7rbJGk0I7h
	 ObIgcIQA/kceRygPnPBqT+IYSeQEybyxJGRL2VNs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20221027160108eucas1p2fc1a480717c24d386e38c8d8bc4ef225~h_GleekTF2416424164eucas1p2x;
	Thu, 27 Oct 2022 16:01:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id C0.89.29727.44BAA536; Thu, 27
	Oct 2022 17:01:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20221027160108eucas1p1cc1351fd8bf35ef6e5220e0cdc865ff4~h_GlGTuJL3111231112eucas1p1D;
	Thu, 27 Oct 2022 16:01:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221027160108eusmtrp11f30a93c55ef1aa56458bf749a000705~h_GlFsgiD2493424934eusmtrp1Y;
	Thu, 27 Oct 2022 16:01:08 +0000 (GMT)
X-AuditID: cbfec7f2-205ff7000001741f-1f-635aab446494
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 19.B7.07473.44BAA536; Thu, 27
	Oct 2022 17:01:08 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20221027160107eusmtip2fe4ea5ceadab4e2f9e7160555881289e~h_Gk9D0vK1597815978eusmtip2V;
	Thu, 27 Oct 2022 16:01:07 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Thu, 27 Oct 2022 17:01:03 +0100
From: Joel Granados <j.granados@samsung.com>
To: <kbusch@kernel.org>, <sagi@grimberg.me>, <hch@lst.de>
CC: <linux-nvme@lists.infradead.org>, <gost.dev@samsung.com>,
	<joshi.k@samsung.com>, <javier.gonz@samsung.com>, <p.raghav@samsung.com>,
	Joel Granados <j.granados@samsung.com>
Subject: [RFC 2/3] nvme: Move nvme identify CS to separate function
Date: Thu, 27 Oct 2022 17:57:23 +0200
Message-ID: <20221027155724.1161670-3-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221027155724.1161670-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsWy7djPc7ouq6OSDR5elLFYufook8WkQ9cY
	LeYve8puse71exYHFo/z9zayeGxa1cnmsXlJvcfumw1sASxRXDYpqTmZZalF+nYJXBk9DVMY
	Cy7xV3yfuYWxgfETTxcjJ4eEgInExcmtLF2MXBxCAisYJSa9fskK4XxhlLi3fRo7hPOZUaLt
	2xJmmJZ5ZxdBtSxnlDi0bCobXNXrReuhWjYzShw+dJUNpIVNQEfi/Js7YO0iApYSE978B2tn
	FtjEKHFr4zImkISwgLPEv4XrwBpYBFQlJu27xghi8wrYSnQdvscCsVteou36dKA4BwengJ1E
	x3lziBJBiZMzn4CVMAOVNG+dzQxhS0gcfPEC6mxFiS1zvrNC2LUSp7bcYgK5QULgCofE36nt
	UEUuEv3tB9ghbGGJV8e3QNkyEqcn90DdkC2xc8ouqPoCiVknQd7nALKtJfrO5ECEHSWWP9rP
	DhHmk7jxVhDiHD6JSdumM0OEeSU62oQmMKrMQvLALCQPzELywAJG5lWM4qmlxbnpqcWGeanl
	esWJucWleel6yfm5mxiBaeT0v+OfdjDOffVR7xAjEwfjIUYJDmYlEd6zN8KThXhTEiurUovy
	44tKc1KLDzFKc7AoifOyzdBKFhJITyxJzU5NLUgtgskycXBKNTDNWjtRTe1plduLn4tuqlns
	fxRysaFZ+LCdpYufR/ZbpU3HZA5bsPy3awvKUjjaI5q0nWnZr85Z2lpGLFviih8f/3hhm/Ir
	viPqpz0EVmgYHFn4Stz7V8pp09+cLfv2d7k+zb0XWLzWKS9jbuEUTbXgotUR/vd4v4VP6e1O
	Pfy77KCG+m7zsHKRcMvuhEfOSVvSpycL6/HnvjhzStwiTmpD5vKaKxVVM1SSz2R3xZ2uYuZS
	mvTlcnVyf/xUp5KuJRvsd5t666zyX7zoy717F++95m4yZ+C9tuLq4071cNbn3UpZilJvQpiT
	GfOu8M+Zv/6LiufHmzFmEssvFbEfjZ72fYWkwI2Mw57PjhQnTFZiKc5INNRiLipOBADpubeH
	kgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsVy+t/xe7ouq6OSDX4tYrVYufook8WkQ9cY
	LeYve8puse71exYHFo/z9zayeGxa1cnmsXlJvcfumw1sASxRejZF+aUlqQoZ+cUltkrRhhZG
	eoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehk9DVMYCy7xV3yfuYWxgfETTxcjJ4eE
	gInEvLOLWLoYuTiEBJYySnw69pkRIiEj8enKR3YIW1jiz7UuNoiij4wS1+bNAUsICWxmlLix
	yQrEZhPQkTj/5g4ziC0iYCkx4c1/sKnMApsYJW5tXMYEkhAWcJb4t3AdG4jNIqAqMWnfNbBt
	vAK2El2H77FAbJOXaLs+HSjOwcEpYCfRcd4cYpetxI9JG5ghygUlTs58AlbODFTevHU2M4Qt
	IXHwxQtmiDGKElvmfGeFsGslPv99xjiBUWQWkvZZSNpnIWlfwMi8ilEktbQ4Nz232FCvODG3
	uDQvXS85P3cTIzDKth37uXkH47xXH/UOMTJxMB5ilOBgVhLhPXsjPFmINyWxsiq1KD++qDQn
	tfgQoynQmxOZpUST84FxnlcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fE
	wSnVwGTzfed8W4bvd+ZcucT3WSgh3vyuVM4bqzSZlG1/OfZrPFg2KbH4W5/AvdLSLV8+bTmW
	PGOKpYAj8wEh1Uc7TyvtexAkfS6tpedeD4vEwoXB60wzLmbHZDgddF36q9d3z5QZrMWslhsV
	j91rEXJeYne+UX9Fxu9TQZclUyd9WavHX7hm9ceNLk8KWXYvnP3/lpJusUHZ0vu5/BNf/zL6
	c8FKhdNtgZAWE/tFwy97FeRfl98vqzaaqCvcKNL9ZsfNJYL8FxM9387qeLyU94KQGCvTP/n4
	P85vDh3iW5vxskQ/Jpp7qbJ6n8vNavOz83O4DqY2hTCorfm/uJNtbaeN5j+N+WeKmCPX6i/X
	yW4PzVJiKc5INNRiLipOBAAgjNwaOwMAAA==
X-CMS-MailID: 20221027160108eucas1p1cc1351fd8bf35ef6e5220e0cdc865ff4
X-Msg-Generator: CA
X-RootMTR: 20221027160108eucas1p1cc1351fd8bf35ef6e5220e0cdc865ff4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221027160108eucas1p1cc1351fd8bf35ef6e5220e0cdc865ff4
References: <20221027155724.1161670-1-j.granados@samsung.com>
	<CGME20221027160108eucas1p1cc1351fd8bf35ef6e5220e0cdc865ff4@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221027_090114_624313_49BA1B70 
X-CRM114-Status: GOOD (  14.21  )
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

This is a preparation commit to be able to use the NVME identify command
space controller command from two places without duplication.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/nvme/host/core.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7dbf221247f7..d76be125dc49 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3019,9 +3019,27 @@ static inline u32 nvme_mps_to_sectors(struct nvme_ctrl *ctrl, u32 units)
 	return val;
 }
 
+int nvme_identify_cs_ctrl(struct nvme_ctrl *ctrl, struct nvme_id_ctrl_nvm **id)
+{
+	struct nvme_command c = { };
+	int err;
+
+	c.identify.opcode = nvme_admin_identify;
+	c.identify.cns = NVME_ID_CNS_CS_CTRL;
+	c.identify.csi = NVME_CSI_NVM;
+
+	*id = kzalloc(sizeof(**id), GFP_KERNEL);
+	if (!(*id))
+		return -ENOMEM;
+
+	err = nvme_submit_sync_cmd(ctrl->admin_q, &c, *id, sizeof(**id));
+	if (err)
+		kfree(*id);
+	return err;
+}
+
 static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 {
-	struct nvme_command c = { };
 	struct nvme_id_ctrl_nvm *id;
 	int ret;
 
@@ -3048,17 +3066,9 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 	if (nvme_ctrl_limited_cns(ctrl))
 		return 0;
 
-	id = kzalloc(sizeof(*id), GFP_KERNEL);
-	if (!id)
-		return -ENOMEM;
-
-	c.identify.opcode = nvme_admin_identify;
-	c.identify.cns = NVME_ID_CNS_CS_CTRL;
-	c.identify.csi = NVME_CSI_NVM;
-
-	ret = nvme_submit_sync_cmd(ctrl->admin_q, &c, id, sizeof(*id));
+	ret = nvme_identify_cs_ctrl(ctrl, &id);
 	if (ret)
-		goto free_data;
+		return ret;
 
 	if (id->dmrl)
 		ctrl->max_discard_segments = id->dmrl;
@@ -3066,7 +3076,6 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 	if (id->wzsl)
 		ctrl->max_zeroes_sectors = nvme_mps_to_sectors(ctrl, id->wzsl);
 
-free_data:
 	kfree(id);
 	return ret;
 }
-- 
2.30.2


