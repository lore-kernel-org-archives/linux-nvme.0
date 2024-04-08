Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A6BC67861
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 10:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=g+AHepmRl/AXf/P+gQC0RCGjnHjVMwTi7g3btD+c9C8=; b=Wuff9aKLWBoga5/0XJheV3GiKh
	Z2IQH04xmBF99CnUXVy8NckaFGcEA0i10kz7NLkZEvA8ZbcpIsUnFgXI+vwnudENltfsIdzb6OJFM
	2/+gNpfr1k2aLcSPBSPjZOJOO01RlCdfd8qR0Cqr73KJGfHRvvqi3ThtqGjcMWUjKFtC9oNEuCNGL
	pRr23XxYSakBpj5w/3yEGrIU3DTZOaUzqZPvh4y9kaMI6KwdYxw7a0iet+gEKGokgOWHrQ1N9iSn2
	2ehar2I1ws1C482EoNc/kLAgr+j246Fz49UHi6sKwyTFRecyvrYoWHktEombpJVvJTHQlWB+OopQJ
	3t/PQpHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtmAP-0000000FFgL-1dkr;
	Mon, 08 Apr 2024 10:23:57 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtmAN-0000000FFfD-179v
	for linux-nvme@bombadil.infradead.org;
	Mon, 08 Apr 2024 10:23:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
	bh=g+AHepmRl/AXf/P+gQC0RCGjnHjVMwTi7g3btD+c9C8=; b=G6QEgncgRSjsQpfmeqGia/vTn1
	eAgflTkK2O+BKKyaR+S06YGeBuLskCyW2jRPMWuGpn8N3AsFBQo16Qfh93mHn42Q04XcUzjIVQBew
	Rc/hNPVkT2PE3rnACYymPRYvZViqc1Tf2jpHinGZRVeNZaKhcSrXfZsM1rtTm7E6MA11h1PSPqLZT
	tF8nTQ24b4PQ/43mmcNsrfjWMX6b/BO5hqaqJFppbnbv0GA9dAb/2qJ5xiSdjQtuc70qMHavWHI4m
	Vx64cvoXZ6Op8v/EKB+g7a/B8RYErrdh9tb/T9m0jVXd9meYt+BMnedY6g1pexNAr4UPamCoytXwj
	1WHv6mDw==;
Received: from mailout1.samsung.com ([203.254.224.24])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtmAI-000000075Ke-2hkx
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 10:23:53 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240408102340epoutp01490536a47cafef689a5bf3ac455b7d9f~ERv9eZjx12083120831epoutp019
	for <linux-nvme@lists.infradead.org>; Mon,  8 Apr 2024 10:23:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240408102340epoutp01490536a47cafef689a5bf3ac455b7d9f~ERv9eZjx12083120831epoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1712571820;
	bh=g+AHepmRl/AXf/P+gQC0RCGjnHjVMwTi7g3btD+c9C8=;
	h=From:To:Cc:Subject:Date:References:From;
	b=jebCe20zs9+pY13mYLAlO0sqLvzi+3lIoaxkwJ7w99lMjitLTie+W6/vLCveRfHGQ
	 kuAZ72b2KL9rZY9sNRM2i2zqpdWCwLY75oPKRrESZ7I9qSAnlO6zKtINVbroynhptl
	 +GOLAOZfiEp5VBOXahKpznMgLQe3Jqd52EnQ1IPA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240408102339epcas5p393a7ddd1be4bc1442cd2351d8125d9c3~ERv8btZ3S1480414804epcas5p3r;
	Mon,  8 Apr 2024 10:23:39 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VClYQ0LV5z4x9Px; Mon,  8 Apr
	2024 10:23:38 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2D.78.08600.9A5C3166; Mon,  8 Apr 2024 19:23:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240408102150epcas5p2d5b4c3460fca7fe58520254a2466271b~ERuWj_OEP0462704627epcas5p2s;
	Mon,  8 Apr 2024 10:21:50 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240408102150epsmtrp164e13cabe39b92417404d6c4cd37a54c~ERuWiNLYS0590505905epsmtrp1g;
	Mon,  8 Apr 2024 10:21:50 +0000 (GMT)
X-AuditID: b6c32a44-6c3ff70000002198-1a-6613c5a9c67b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	B7.1D.19234.E35C3166; Mon,  8 Apr 2024 19:21:50 +0900 (KST)
Received: from localhost.sa.corp.samsungelectronics.net (unknown
	[107.99.41.223]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240408102148epsmtip2f5c69a6f197117fbcb46004ccd7aa46a~ERuUtHO-02456924569epsmtip2A;
	Mon,  8 Apr 2024 10:21:48 +0000 (GMT)
From: soni.ankit@samsung.com
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, sathya.m@samsung.com,
	d.palani@samsung.com, prakash.bv@samsung.com, anshul@samsung.com,
	ankitvvsoni@gmail.com, Ankit Soni <soni.ankit@samsung.com>
Subject: [PATCH 1/1] nvme-tcp: check for invalid request
Date: Mon,  8 Apr 2024 10:23:28 +0530
Message-ID: <20240408045328.542327-1-soni.ankit@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmhu7Ko8JpBlvvW1q0z7nFZvF7+hRW
	i/97jrFZvP36gM1i5eqjTBaTDl1jtJi/7Cm7xb0ZXewW616/Z7HYenkBu8XRpe+ZHbg9Jja/
	Y/fYOesuu8f5extZPDat6mTz2Lyk3mP3zQY2j74tqxgD2KOybTJSE1NSixRS85LzUzLz0m2V
	vIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAjlRSKEvMKQUKBSQWFyvp29kU5ZeWpCpk
	5BeX2CqlFqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZAhUmZGe8a97NWvBWtGLv1FMsDYwzhLoY
	OTkkBEwkpl7dyNrFyMUhJLCbUWJN61M2COcTo8SP2ZNZ4ZxZjzexwrS8OnWKHSKxk1Hi6u11
	UE4bk8T/G58ZQarYBGQknsw5wgxiiwg4Srxa8RxsLrPALkaJ259awUYJC1hITO1oBCtiEVCV
	mHHsCAuIzStgIzF5x2eodfISi3csZ4aIC0qcnPkErIYZKN68dTYzyFAJga/sEo//zwPawAHk
	uEi8XF8J0Sss8er4FnYIW0riZX8blJ0tMfPEFzYIu0Bi85TTzBC2vcTFPX+ZQMYwC2hKrN+l
	DxGWlZh6ah0TxFo+id7fT5gg4rwSO+bB2CoSa9a/YYJZ9fvhGSjbQ+LdoalgJwsJxEq0ftrJ
	NIFRfhaSb2Yh+WYWwuYFjMyrGCVTC4pz01OTTQsM81LL4TGbnJ+7iRGcWLVcdjDemP9P7xAj
	EwfjIUYJDmYlEd5gU8E0Id6UxMqq1KL8+KLSnNTiQ4ymwCCeyCwlmpwPTO15JfGGJpYGJmZm
	ZiaWxmaGSuK8r1vnpggJpCeWpGanphakFsH0MXFwSjUwxa1L2fqh6pVi+KFVLNphc5ZOlO4Q
	k8pT5Pu9oPWIw2W1DEvd358ttY+1Mn5YyDvzkW/+8dl333r+d2I///Xj5V7bSdcXSu95cCZX
	QdfrJe/83llp++78bmavqrfizSqeyiy0ddnVV8ViuRtcHi6XnxVUFnnMbvcsH7VnX84FKzMY
	n9x4c2Ii79IjKV4l7pxPNrMIfJ1czdFeEcP7dKUmS+LW23Fnzta3COpXpD8VvXcqKSO/w6S/
	rXnSBufnjLekVepY/152tUw5zPfOJexT1zVRgx3sf42sbG28wx48/W7duumW/KPCUrvgh4VH
	VzgLbZ/54kFJ0aQZj5/U7uZ7Hzkxp0lzahqjg8PJJxIBSizFGYmGWsxFxYkASGRN+TUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSvK7dUeE0g1d9whbtc26xWfyePoXV
	4v+eY2wWb78+YLNYufook8WkQ9cYLeYve8pucW9GF7vFutfvWSy2Xl7AbnF06XtmB26Pic3v
	2D12zrrL7nH+3kYWj02rOtk8Ni+p99h9s4HNo2/LKsYA9igum5TUnMyy1CJ9uwSujHfNu1kL
	3opW7J16iqWBcYZQFyMnh4SAicSrU6fYuxi5OIQEtjNKbPrzjREiISWxYPUOVghbWGLlv+dQ
	RS1MEtOfnWQCSbAJyEg8mXOEGcQWEXCXOPqygQmkiFngEKPE+g3XwBLCAhYSUzsawWwWAVWJ
	GceOsIDYvAI2EpN3fIbaIC+xeMdyZoi4oMTJmU/AapiB4s1bZzNPYOSbhSQ1C0lqASPTKkbR
	1ILi3PTc5AJDveLE3OLSvHS95PzcTYzg4NYK2sG4bP1fvUOMTByMQIdxMCuJ8AabCqYJ8aYk
	VlalFuXHF5XmpBYfYpTmYFES51XO6UwREkhPLEnNTk0tSC2CyTJxcEo1MC2d/fWpwYPtbRZ/
	TkyPVjGU8WuQTlhlfcXJteRog96D36snq/UXX/k89+WXvzubUl6VGFyZvIV7Vd4a5q9trpXV
	i+zXlx0NeH/l3iPu2VP8J95z3fRCwKTmmqGZfMVlrUPzNzF1c8s/PC1T8vJ22P7fix823Dbz
	VrV/m/kxcpd6mcyytmuCNwQeKB2dU/GvxinK8XD4peReb4WF//xttx+uMPzQMq0x0ejftzf7
	o4+8DJ7KfPLP4w1fOKouLIgWZQ/O2/GG/WT5LKe6x+0PVRcam+77c2stU9nVyhn54RxfLNK3
	vT0pfjwq5GJIf1rY+WRllReFbxM2Mh47mHrd+8Ca34YR4d4JE+PrF5yo2LNJiaU4I9FQi7mo
	OBEAUClXkt0CAAA=
X-CMS-MailID: 20240408102150epcas5p2d5b4c3460fca7fe58520254a2466271b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240408102150epcas5p2d5b4c3460fca7fe58520254a2466271b
References: <CGME20240408102150epcas5p2d5b4c3460fca7fe58520254a2466271b@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_112351_568549_8F513040 
X-CRM114-Status: GOOD (  18.80  )
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

From: Ankit Soni <soni.ankit@samsung.com>

The blk_mq_tag_to_rq() returns NULL for invalid tag.
Added check condition to prevent NULL Pointer derefernece.

Signed-off-by: Ankit Soni <soni.ankit@samsung.com>
---
 drivers/nvme/host/tcp.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index fdbcdcedcee9..01a90bbed70b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -801,9 +801,17 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 			      unsigned int *offset, size_t *len)
 {
 	struct nvme_tcp_data_pdu *pdu = (void *)queue->pdu;
-	struct request *rq =
-		nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
-	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	struct nvme_tcp_request *req;
+	struct request *rq;
+
+	rq = nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
+	if (unlikely(!rq)) {
+		pr_err("could not locate request for tag %#x\n",
+			pdu->command_id);
+		return -EFAULT;
+	}
+
+	req = blk_mq_rq_to_pdu(rq);
 
 	while (true) {
 		int recv_len, ret;
@@ -875,6 +883,8 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 	char *ddgst = (char *)&queue->recv_ddgst;
 	size_t recv_len = min_t(size_t, *len, queue->ddgst_remaining);
 	off_t off = NVME_TCP_DIGEST_LENGTH - queue->ddgst_remaining;
+	struct nvme_tcp_request *req;
+	struct request *rq;
 	int ret;
 
 	ret = skb_copy_bits(skb, *offset, &ddgst[off], recv_len);
@@ -887,13 +897,17 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 	if (queue->ddgst_remaining)
 		return 0;
 
-	if (queue->recv_ddgst != queue->exp_ddgst) {
-		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
-					pdu->command_id);
-		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+	rq = nvme_cid_to_rq(nvme_tcp_tagset(queue), pdu->command_id);
+	if (unlikely(!rq)) {
+		pr_err("could not locate request for tag %#x\n",
+			pdu->command_id);
+		return -EFAULT;
+	}
 
-		req->status = cpu_to_le16(NVME_SC_DATA_XFER_ERROR);
+	req = blk_mq_rq_to_pdu(rq);
 
+	if (queue->recv_ddgst != queue->exp_ddgst) {
+		req->status = cpu_to_le16(NVME_SC_DATA_XFER_ERROR);
 		dev_err(queue->ctrl->ctrl.device,
 			"data digest error: recv %#x expected %#x\n",
 			le32_to_cpu(queue->recv_ddgst),
@@ -901,10 +915,6 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 	}
 
 	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
-		struct request *rq = nvme_cid_to_rq(nvme_tcp_tagset(queue),
-					pdu->command_id);
-		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
-
 		nvme_tcp_end_request(rq, le16_to_cpu(req->status));
 		queue->nr_cqe++;
 	}
-- 
2.43.0


