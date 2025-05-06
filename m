Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15889C3ABC3
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 16:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7ATaqVJvWdiWKn6eMPtaLeu5W/FDplC0dyl429xRM+k=; b=dFmvDf9GyEmgMYi+V3gjZFuwuS
	s/0zJBFiQQKWZHNDhAdMAe3CecqjN2cUb0bW/ofRBhpl0YvGkodT2AP3rd5pXCilWDImB3Oe6tJjB
	RsRrO7FJ6HkKdkG/fPKWISprYSjOlcrA27G44sK+j9iW7gXUcCLWWiU5n2Ea7dQhJIu47mOVVRywa
	DNXnGPRN9uyxuFzxkjPGfcxhLyRze0aGBlQKz8fVJWA/2jgHl6qCoPp8U6uBTlIXWOYJlGfHX8+xR
	mZ8Ey5Gh3eCaO+9TerILyj0fnw4H0uVUNPsfqWoOMJSgXaoFi0U/ANw/xGDHyXE7L7wORkrj/+nsW
	gse2TNWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCKjH-0000000CaEP-1cuH;
	Tue, 06 May 2025 16:01:11 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCHNq-0000000BuBO-1gg9
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 12:26:55 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250506122648epoutp02d713037b4eca85496271ddfc3bd49367~878qOHvFI0500105001epoutp02E
	for <linux-nvme@lists.infradead.org>; Tue,  6 May 2025 12:26:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250506122648epoutp02d713037b4eca85496271ddfc3bd49367~878qOHvFI0500105001epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1746534408;
	bh=7ATaqVJvWdiWKn6eMPtaLeu5W/FDplC0dyl429xRM+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U69fgEHtVaUhc/agPlPTqBs1Y7VSQpdyWZn7ZNO9WOId+clW3Q87I6CMpqSYhK0jY
	 WdVxetS0U/2Qxpms7Mxs2yjh3l90Hs0iVO+8rs6VPwgUETUk6/yVAKxgEcZ6fSfgWM
	 9jpVikiGDFeTFOfkjvTyiT6wZKLKOE6tdquP1wQY=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250506122648epcas5p388664a14e1a115b96002724a31d13592~878p5QEe_3215232152epcas5p3p;
	Tue,  6 May 2025 12:26:48 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.176]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4ZsHh65FY7z6B9m4; Tue,  6 May
	2025 12:26:46 +0000 (GMT)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250506122646epcas5p3bd2a00493c94d1032c31ec64aaa1bbb0~878nvp_Dw0387503875epcas5p3V;
	Tue,  6 May 2025 12:26:46 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250506122646epsmtrp252e1c36c726271d7c7659645d582b6d9~878nu6ONX0521905219epsmtrp2U;
	Tue,  6 May 2025 12:26:46 +0000 (GMT)
X-AuditID: b6c32a28-46cef70000001e8a-ef-681a0005b0fd
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2F.E5.07818.5000A186; Tue,  6 May 2025 21:26:45 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250506122644epsmtip233329f84d5a7ae3bd443942d83a39eeb~878mG750h1679416794epsmtip2d;
	Tue,  6 May 2025 12:26:44 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org, Hannes
	Reinecke <hare@suse.de>, Nitesh Shetty <nj.shetty@samsung.com>, Kanchan
	Joshi <joshi.k@samsung.com>
Subject: [PATCH v16 07/11] nvme: add a nvme_get_log_lsi helper
Date: Tue,  6 May 2025 17:47:28 +0530
Message-Id: <20250506121732.8211-8-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250506121732.8211-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGLMWRmVeSWpSXmKPExsWy7bCSvC4rg1SGQcd7S4s5q7YxWqy+289m
	sWfRJCaLlauPMlm8az3HYnH0/1s2i0mHrjFa7L2lbbFn70kWi/nLnrJbbPs9n9mB22PnrLvs
	HpfPlnpsWtXJ5rF5Sb3H7psNbB59W1Yxemw+Xe3xeZNcAEcUl01Kak5mWWqRvl0CV8b9CQsZ
	Cx4KVlzvOsrUwHibr4uRk0NCwERiybYZbF2MXBxCArsZJTZ+7WSFSIhLNF/7wQ5hC0us/Pec
	HaLoI6PE3V0/gYo4ONgENCUuTC4FqRERCJB4ufgxM0gNs8AHRok9E2czgiSEBewkflw9BGaz
	CKhKtJ6ZALaAV8Bc4u3JnVAL5CVmXvoOZnMKWEgs3zMLrF4IqObF0SPsEPWCEidnPmEBsZmB
	6pu3zmaewCgwC0lqFpLUAkamVYySqQXFuem5yYYFhnmp5XrFibnFpXnpesn5uZsYwVGhpbGD
	8d23Jv1DjEwcjIcYJTiYlUR479+XzBDiTUmsrEotyo8vKs1JLT7EKM3BoiTOu9IwIl1IID2x
	JDU7NbUgtQgmy8TBKdXAVPZi1byeKbu/292w6T+VV2g8WyHTcIvTy7MNvyedDrFXX+koXmwp
	xrb0i+uZyM3Nxx5JJi9tYvmwPCmRf67sg19zsoPXKd7evKL8zVR/zkuxdzbUq++S9VGxD4rd
	an7bKjC36CXfqdYPZTxTxZ1Vjl2715SoJm+ece7s3OAuM58wFw9WQRazHzUbn7jImNhpX3I2
	Zvt0dO69g1ETRd5sfLR0LdOLnicsPS+WnQlbYNA5Qf7MQg79M439Pouk+n+4Ki069ZbTQPNx
	QOq9UovG6JSyjXLZ/0yu2LRsF1r7ymf9Sql9y186/rq795LU+dt9i4+3bYsyd01/1/Inbbmx
	CO/HvzO8tIr5JHxVNc0VlViKMxINtZiLihMBv9CmjPkCAAA=
X-CMS-MailID: 20250506122646epcas5p3bd2a00493c94d1032c31ec64aaa1bbb0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250506122646epcas5p3bd2a00493c94d1032c31ec64aaa1bbb0
References: <20250506121732.8211-1-joshi.k@samsung.com>
	<CGME20250506122646epcas5p3bd2a00493c94d1032c31ec64aaa1bbb0@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250506_052650_757388_151336AA 
X-CRM114-Status: GOOD (  15.53  )
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

From: Christoph Hellwig <hch@lst.de>

For log pages that need to pass in a LSI value, while at the same time
not touching all the existing nvme_get_log callers.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index eb6ea8acb3cc..0d834ca606d9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -150,6 +150,8 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					   unsigned nsid);
 static void nvme_update_keep_alive(struct nvme_ctrl *ctrl,
 				   struct nvme_command *cmd);
+static int nvme_get_log_lsi(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page,
+		u8 lsp, u8 csi, void *log, size_t size, u64 offset, u16 lsi);
 
 void nvme_queue_scan(struct nvme_ctrl *ctrl)
 {
@@ -3084,8 +3086,8 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	return ret;
 }
 
-int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
-		void *log, size_t size, u64 offset)
+static int nvme_get_log_lsi(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page,
+		u8 lsp, u8 csi, void *log, size_t size, u64 offset, u16 lsi)
 {
 	struct nvme_command c = { };
 	u32 dwlen = nvme_bytes_to_numd(size);
@@ -3099,10 +3101,18 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 	c.get_log_page.lpol = cpu_to_le32(lower_32_bits(offset));
 	c.get_log_page.lpou = cpu_to_le32(upper_32_bits(offset));
 	c.get_log_page.csi = csi;
+	c.get_log_page.lsi = cpu_to_le16(lsi);
 
 	return nvme_submit_sync_cmd(ctrl->admin_q, &c, log, size);
 }
 
+int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
+		void *log, size_t size, u64 offset)
+{
+	return nvme_get_log_lsi(ctrl, nsid, log_page, lsp, csi, log, size,
+			offset, 0);
+}
+
 static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
 				struct nvme_effects_log **log)
 {
-- 
2.25.1


