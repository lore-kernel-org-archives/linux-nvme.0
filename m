Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B88C5321E
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Aug 2024 11:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=5Ur/i1fkiiMKNt/3i3r5iqSRaVHrtVz+f8q8/sDs/R0=; b=TOEgPFY9xnbCrKQRS0GoEvrD1d
	V4oPr9a2634dQJz4CO+SoZ3oH/izyWTXci7p0CjaAgBWAt7KR/IjLhPBfIr6jDIJPSmQ+Mqf4Ubd+
	33CzM76xsvLMccqIvlv/AP6HnGL8jgEX567gkqnzDWFpTXTT3/832mqgX4uUSl+hp8OvnnVas5AZa
	TDgzlYsnullh5JuAPWDzGn3JdIJSE+JjkIz7qRecAZ/ESu50WvBpPOCdRq84uQkn/xR6o1HyUVaAb
	yoKyp1/AYlEoXtBmctiKKQQhthlS3lCuNquDkky3YR1okTBezTbpsvflt7LH0xQrvCdf6rqlE9E52
	GVQbfAUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siY80-00000007BN6-1i0x;
	Mon, 26 Aug 2024 11:43:20 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siY7b-00000007BKB-3dwL
	for linux-nvme@lists.infradead.org;
	Mon, 26 Aug 2024 11:42:58 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240826114248epoutp043762b5f5a03eb36df33dcc2e5802807f~vRJA9U7ms0693806938epoutp04T
	for <linux-nvme@lists.infradead.org>; Mon, 26 Aug 2024 11:42:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240826114248epoutp043762b5f5a03eb36df33dcc2e5802807f~vRJA9U7ms0693806938epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724672568;
	bh=5Ur/i1fkiiMKNt/3i3r5iqSRaVHrtVz+f8q8/sDs/R0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=HPovN9boePtoYNSF8KcnXHBeKARqRzb3IQ9aojCW92O2s30jT98N4TszotSqpM2je
	 EZRLyIMu+R/CxAueEU644V9E6oW4r4HsgZQ2GS73SK5XGsV2Mg8jhzXijkETK68utr
	 MNMjzYyrw/FeD+N7Glbta1F6gLkCGZzu/Rzy+7AA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240826114247epcas5p3654794306ab9d1143029060e39086ee4~vRJAArjpU1484214842epcas5p33;
	Mon, 26 Aug 2024 11:42:47 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Wsph62xz2z4x9Py; Mon, 26 Aug
	2024 11:42:46 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8A.F4.09743.63A6CC66; Mon, 26 Aug 2024 20:42:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240826104721epcas5p2ed0968a3369d61762c8bfda767120e44~vQYmg8yq42426524265epcas5p2M;
	Mon, 26 Aug 2024 10:47:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240826104721epsmtrp253ad558bd6682a6c02184b00265ae17f~vQYmfkAC50519105191epsmtrp2_;
	Mon, 26 Aug 2024 10:47:21 +0000 (GMT)
X-AuditID: b6c32a4a-14fff7000000260f-af-66cc6a364143
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	53.8D.08964.93D5CC66; Mon, 26 Aug 2024 19:47:21 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240826104719epsmtip2128600fccb07f0db766a6331bd64c782~vQYk77Wqo0851108511epsmtip2f;
	Mon, 26 Aug 2024 10:47:19 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org, Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH] nvme: rename apptag and appmask to lbat and lbatm
Date: Mon, 26 Aug 2024 16:09:43 +0530
Message-Id: <20240826103943.143962-1-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjk+LIzCtJLcpLzFFi42LZdlhTU9cs60yawY1uQYumCX+ZLVbf7Wez
	WLn6KJPF0f9v2SwmHbrGaPH06iwmi/nLnrJbrHv9nsWBw+P8vY0sHpfPlnpsWtXJ5rF5Sb3H
	7psNbB69ze/YPPq2rGIMYI/KtslITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshL
	zE21VXLxCdB1y8wBOkpJoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BSoFecmFtc
	mpeul5daYmVoYGBkClSYkJ3xY2kva0GjbMXvW62MDYyHJboYOTgkBEwkHl6r62Lk4hAS2M0o
	se7gD8YuRk4g5xOjRPcGWYjEN0aJo68us4EkQBpO/3/ICpHYyygxe1M3O0THZ0aJt2e9QWw2
	AXWJI89bwSaJCIRJHJg8kxXEZhbIkejZfwGsXljASWLBm51gcRYBVYk/F/6zgNi8AlYS714+
	YIZYJi8x89J3doi4oMTJmU9YIObISzRvnc0McoSEwCN2iTXH/rBANLhInL/RDmULS7w6voUd
	wpaS+PxuL9QH6RI/Lj9lgrALJJqP7WOEsO0lWk/1M4OChVlAU2L9Ln2IsKzE1FPrmCD28kn0
	/n4C1corsWMejK0k0b5yDpQtIbH3XAMTJHQ9JNYuUoEET6zE3dXHmCYwys9C8s0sJN/MQli8
	gJF5FaNkakFxbnpqsWmBUV5qOTxWk/NzNzGCE6aW1w7Ghw8+6B1iZOJgPMQowcGsJMIrd/lk
	mhBvSmJlVWpRfnxRaU5q8SFGU2AQT2SWEk3OB6bsvJJ4QxNLAxMzMzMTS2MzQyVx3tetc1OE
	BNITS1KzU1MLUotg+pg4OKUamJh2qlnqeP+J4bj6/u+zBsFp06sUTNfuZ18Wv2LXjY9/ur3u
	i3xO8WApW8nzRONm3knvDebBhisYDBdN7HdgrXgv/m2DqfnTZT7aEdfXbvRK+Rj2pm5HMMO8
	x1Fs4StWHL426YnF0Y0/zOU+2e5a8StwtdYSGdWbv+NWM3lW9Txqrb85j+v/jQ7OdxssXioo
	xsw+MI33Vkfn2ocJE77NebZmUeTr7CcGic51n7+yP+Vu/v4uuWeewaZXd26eF1tbd55ly3ZR
	w3DpmCpNmZMSVy2MFuYIXf/4yqnKgjlNKGinW/5k58KU9arnsire7ZY8sqzwTpnUopDuM9Wn
	zaqqnh9t1tZbb5a7ysNszZpvXSxKLMUZiYZazEXFiQBIqaSpIQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsWy7bCSvK5l7Jk0g607lC2aJvxltlh9t5/N
	YuXqo0wWR/+/ZbOYdOgao8XTq7OYLOYve8puse71exYHDo/z9zayeFw+W+qxaVUnm8fmJfUe
	u282sHn0Nr9j8+jbsooxgD2KyyYlNSezLLVI3y6BK+PH0l7WgkbZit+3WhkbGA9LdDFyckgI
	mEic/v+QtYuRi0NIYDejxINXZ5ghEhISp14uY4SwhSVW/nvODmILCXxklLi43RLEZhNQlzjy
	vBWsRkQgRmLL5N9MIDazQJ5E/+eTYHFhASeJBW92soLYLAKqEn8u/GcBsXkFrCTevXwAtUte
	Yual7+wQcUGJkzOfsEDMkZdo3jqbeQIj3ywkqVlIUgsYmVYxSqYWFOem5xYbFhjmpZbrFSfm
	Fpfmpesl5+duYgQHsJbmDsbtqz7oHWJk4mA8xCjBwawkwit3+WSaEG9KYmVValF+fFFpTmrx
	IUZpDhYlcV7xF70pQgLpiSWp2ampBalFMFkmDk6pBqYresZx8+YtEjDrDCoSUlt2qirtFxeL
	+bM2udzmPTKfmF3v6ravf3DeTs4zV0KDpTLoz8FzPGVbk3Y++X7md+/vpq/9BQoCzUl5isZ1
	Lnm3JO7tL/TfvlFAuKulW1ZL4tfyV5Prs6vZ0qOysqy3aeoFTLexCzHgOHg4O+nHrLlV3QGt
	/HoMX2wdLf4uv3A8Ystyn+03nh7Y/GLPlrspHT0efndKJWbv/+V11/nJMqsivcxv2Rdm9wQo
	iYbzHLAKelJXe7Xu5LEDDqetJ55K0FTcKpN397yy01VlA56Dyj8v/l8wWWP5CYOZRVbadv1v
	rty8VJ/zz7Hvx/Vtrx9J9Wy/+o5rxZM5UorHKmQmTFViKc5INNRiLipOBACDsLELzwIAAA==
X-CMS-MailID: 20240826104721epcas5p2ed0968a3369d61762c8bfda767120e44
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240826104721epcas5p2ed0968a3369d61762c8bfda767120e44
References: <CGME20240826104721epcas5p2ed0968a3369d61762c8bfda767120e44@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_044256_650486_2D60CD5D 
X-CRM114-Status: GOOD (  16.20  )
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

Rename apptag and appmask to lbat and lbatm so that it matches the field
names used in NVMe spec.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Suggested-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c   | 4 ++--
 drivers/nvme/host/ioctl.c  | 4 ++--
 drivers/nvme/host/rdma.c   | 4 ++--
 drivers/nvme/target/rdma.c | 4 ++--
 include/linux/nvme.h       | 8 ++++----
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0dc8bcc664f2..f4d74e3dfc7f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -987,8 +987,8 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 	cmnd->rw.length =
 		cpu_to_le16((blk_rq_bytes(req) >> ns->head->lba_shift) - 1);
 	cmnd->rw.reftag = 0;
-	cmnd->rw.apptag = 0;
-	cmnd->rw.appmask = 0;
+	cmnd->rw.lbat = 0;
+	cmnd->rw.lbatm = 0;
 
 	if (ns->head->ms) {
 		/*
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index f1d58e70933f..850f81e08e7d 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -260,8 +260,8 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	c.rw.control = cpu_to_le16(io.control);
 	c.rw.dsmgmt = cpu_to_le32(io.dsmgmt);
 	c.rw.reftag = cpu_to_le32(io.reftag);
-	c.rw.apptag = cpu_to_le16(io.apptag);
-	c.rw.appmask = cpu_to_le16(io.appmask);
+	c.rw.lbat = cpu_to_le16(io.apptag);
+	c.rw.lbatm = cpu_to_le16(io.appmask);
 
 	return nvme_submit_user_cmd(ns->queue, &c, io.addr, length, metadata,
 			meta_len, lower_32_bits(io.slba), NULL, 0, 0);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2eb33842f971..bb52aa45ab47 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1363,8 +1363,8 @@ static void nvme_rdma_set_sig_domain(struct blk_integrity *bi,
 	if (control & NVME_RW_PRINFO_PRCHK_REF)
 		domain->sig.dif.ref_remap = true;
 
-	domain->sig.dif.app_tag = le16_to_cpu(cmd->rw.apptag);
-	domain->sig.dif.apptag_check_mask = le16_to_cpu(cmd->rw.appmask);
+	domain->sig.dif.app_tag = le16_to_cpu(cmd->rw.lbat);
+	domain->sig.dif.apptag_check_mask = le16_to_cpu(cmd->rw.lbatm);
 	domain->sig.dif.app_escape = true;
 	if (pi_type == NVME_NS_DPS_PI_TYPE3)
 		domain->sig.dif.ref_escape = true;
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 1eff8ca6a5f1..1b6264fa5803 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -578,8 +578,8 @@ static void nvmet_rdma_set_sig_domain(struct blk_integrity *bi,
 	if (control & NVME_RW_PRINFO_PRCHK_REF)
 		domain->sig.dif.ref_remap = true;
 
-	domain->sig.dif.app_tag = le16_to_cpu(cmd->rw.apptag);
-	domain->sig.dif.apptag_check_mask = le16_to_cpu(cmd->rw.appmask);
+	domain->sig.dif.app_tag = le16_to_cpu(cmd->rw.lbat);
+	domain->sig.dif.apptag_check_mask = le16_to_cpu(cmd->rw.lbatm);
 	domain->sig.dif.app_escape = true;
 	if (pi_type == NVME_NS_DPS_PI_TYPE3)
 		domain->sig.dif.ref_escape = true;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 7b2ae2e43544..b58d9405d65e 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -987,8 +987,8 @@ struct nvme_rw_command {
 	__le16			control;
 	__le32			dsmgmt;
 	__le32			reftag;
-	__le16			apptag;
-	__le16			appmask;
+	__le16			lbat;
+	__le16			lbatm;
 };
 
 enum {
@@ -1057,8 +1057,8 @@ struct nvme_write_zeroes_cmd {
 	__le16			control;
 	__le32			dsmgmt;
 	__le32			reftag;
-	__le16			apptag;
-	__le16			appmask;
+	__le16			lbat;
+	__le16			lbatm;
 };
 
 enum nvme_zone_mgmt_action {
-- 
2.25.1


