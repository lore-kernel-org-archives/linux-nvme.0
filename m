Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD8BC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Dec 2021 03:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mMtCI2RCEK+ZUNR58tFFC6bnhpSD5e53npox+XXYqX0=; b=liQ5RH+4thASrqOoejK9h86LPZ
	7Mb1iQiVD23DlWhduBjDyaT1n6hmKTc2eqhus+LKf36Ex/FsRLbihzR7T0JeEmocGm8kNPsrqCLR0
	RsqI/qQVomPHU63K3WKrONb2XRBYiDYxnRrWaLYImqBW+eh19dwVj/AMdSuoKCQh+e5cgByU6/T12
	q17937kWLW3QG3zcEpENOxzCce2IQ6T6gTz9pJIgx/Y74i3vxBbP+z3y+O5ODuoXUHgf4WjnfYw/M
	BSC1yfUL11JfG8aeP0ln3fNbYFyyxsoXRfPtCEfQeJ97AtlRON2CiDRatxgNeabxEfeC7+Xy0e0Fi
	15787tpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mzVQV-005LFC-Fn; Tue, 21 Dec 2021 03:02:55 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzVKy-005Jo3-9q
 for linux-nvme@lists.infradead.org; Tue, 21 Dec 2021 02:57:14 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20211221025710epoutp030df27072397e6097170da0c6fe6a789a~Cpbl_qbOS3190731907epoutp03R
 for <linux-nvme@lists.infradead.org>; Tue, 21 Dec 2021 02:57:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20211221025710epoutp030df27072397e6097170da0c6fe6a789a~Cpbl_qbOS3190731907epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1640055430;
 bh=mMtCI2RCEK+ZUNR58tFFC6bnhpSD5e53npox+XXYqX0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tTeu8nhYutWZCR4FdMqbK1JOxNtqftqD11u136+8At+IRf2VIDpeqvCgmpkEWr/En
 lCxrj87jfWzZSFRVA3Qx5yDdhMPXZP4DUDNi6PCGOBhcvdd0QPu1e0dwNrQNAjMQOP
 8b9lCnlZVORvI6B2A9m5Fvwhh7Nm4B+ZGHVP9yNk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTP id
 20211221025709epcas5p4974cf1ae578b63f8dd9cba6308f36ceb~CpblQ75NL0577005770epcas5p4N;
 Tue, 21 Dec 2021 02:57:09 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4JJ1MP73Jpz4x9Q0; Tue, 21 Dec
 2021 02:57:05 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 33.A9.05590.08241C16; Tue, 21 Dec 2021 11:57:04 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
 20211220142252epcas5p4611297f9970acbc8ee3b0e325ca5ceec~CfJAA85bE2261322613epcas5p4z;
 Mon, 20 Dec 2021 14:22:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20211220142252epsmtrp1a0f228186fc3afef9aa91b10473b3e52~CfJAALb8B2445924459epsmtrp1m;
 Mon, 20 Dec 2021 14:22:52 +0000 (GMT)
X-AuditID: b6c32a4b-723ff700000015d6-83-61c142804a57
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 49.85.29871.BB190C16; Mon, 20 Dec 2021 23:22:52 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20211220142250epsmtip143802eba4e3ea9f7728b4258c67d9eb5~CfI_JcFof0637906379epsmtip1r;
 Mon, 20 Dec 2021 14:22:50 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, javier@javigon.com,
 anuj20.g@samsung.com, joshiiitr@gmail.com, pankydev8@gmail.com
Subject: [RFC 12/13] nvme: allow user passthrough commands to poll
Date: Mon, 20 Dec 2021 19:47:33 +0530
Message-Id: <20211220141734.12206-13-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211220141734.12206-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFJsWRmVeSWpSXmKPExsWy7bCmhm6D08FEg9PHpC2aJvxltlh9t5/N
 YuXqo0wW71rPsVh0nr7AZHH+7WEmi0mHrjFa7L2lbTF/2VN2izU3n7I4cHnsnHWX3aN5wR0W
 j8tnSz02repk89i8pN5j980GNo++LasYPT5vkgvgiMq2yUhNTEktUkjNS85PycxLt1XyDo53
 jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAG6UEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xi
 q5RakJJTYFKgV5yYW1yal66Xl1piZWhgYGQKVJiQnXFl9R3GgufuFdNeT2FuYNxt3cXIySEh
 YCKxZ/YZpi5GLg4hgd2MEt/Wr2OBcD4xSpy7f5sZwvnGKLH96BYWmJazXX1QVXsZJb7P2scI
 4XxmlHjdeIy9i5GDg01AU+LC5FKQBhGBaIkLz6+xgdjMAh2MEju7bUFsYQEniQ1908GGsgio
 ShxZcpURxOYVsJS4ua+dGWKZvMTMS9/ZQWxOoPjh2cvYIGoEJU7OfMICMVNeonnrbLBLJQR6
 OSTaX7QyQjS7SPxpXs0KYQtLvDq+hR3ClpJ42d8GZRdL/LpzFKoZ6LjrDTOh3rSXuLjnLxPI
 M8xAz6zfpQ8RlpWYemodE8RiPone30+YIOK8EjvmwdiKEvcmPYXaKy7xcMYSVpAxEgIeEo+7
 eEDCQgI9wHC4LjKBUWEWkndmIXlnFsLiBYzMqxglUwuKc9NTi00LjPNSy+GRnJyfu4kRnGi1
 vHcwPnrwQe8QIxMH4yFGCQ5mJRHeLbP3JwrxpiRWVqUW5ccXleakFh9iNAWG90RmKdHkfGCq
 zyuJNzSxNDAxMzMzsTQ2M1QS5z2VviFRSCA9sSQ1OzW1ILUIpo+Jg1OqgWndiUNPH6qaeE/i
 ZRTlkLS36RDIsF30+Ha5e/YspajrWpnLfRikk+dU+7MKWlZaZPa8frxNKKmHZ6XjpG6Zzyec
 pDpaTPUvTp26+HufgJbA/S2tDw9pcWyOZjT7ts585ce3P1s2p9annmnPKbxrZGqXsGbTlvar
 uwQfez9NUw1856d0cMpc2dsz1i/qWXawMd2tPFptquP7WbMkmaoVwx59WtPdXNClGbpVsMhq
 l35EwhaDTN9PpSF/3FZ1exT6fQuf5iAQ+Ng07unb0FsnuSO+cy1w/xXtczHK7+GOk1bdy39P
 vnJz1sJw45pVMU38E2oy7VSyL/30YK09eDPui+pLgaPaxseP/ZjtxDT1vxJLcUaioRZzUXEi
 AN0E3l89BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsWy7bCSnO6eiQcSDeZNZLJomvCX2WL13X42
 i5WrjzJZvGs9x2LRefoCk8X5t4eZLCYdusZosfeWtsX8ZU/ZLdbcfMriwOWxc9Zddo/mBXdY
 PC6fLfXYtKqTzWPzknqP3Tcb2Dz6tqxi9Pi8SS6AI4rLJiU1J7MstUjfLoEr48rqO4wFz90r
 pr2ewtzAuNu6i5GTQ0LAROJsVx8LiC0ksJtRYuV+Zoi4uETztR/sELawxMp/z4FsLqCaj4wS
 cx+0MXUxcnCwCWhKXJhcClIjIhAr8eHXMSaQGmaBSYwSG/ofgDULCzhJbOibDraARUBV4siS
 q4wgNq+ApcTNfe1Qy+QlZl76DlbPCRQ/PHsZG8RBFhInPnxhgagXlDg58wmYzQxU37x1NvME
 RoFZSFKzkKQWMDKtYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjgUtzR2M21d90DvE
 yMTBeIhRgoNZSYR3y+z9iUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1I
 LYLJMnFwSjUwufOFhua27n25dSpX6YuFQZu/HT91vqZZfpJ5kKn7hmmCuds6G774XV8VJJCq
 usJg/v0/L5cv5mOKj/0/9cZejtyijM0dcjYHOSLXPxb82Rqj7D4lZsoG9inPVcu6rrUU3Vew
 6TyjVj/NpvCE+Db50hnt/5Pu3GT+beUuafLd+brG30l/WeUYis+c/P/19fOCI3IBV7wNvD4y
 LF/fHKaiMzlZRm7pdOGMx4lxc5SaGtXe8LYpH8mpS9P8vXL2j88r177Qab3R9mJncWlTqfnZ
 xM7fnEdOT/Y0jNwq+lDm05rY92dKNHKZan6HLynbs/ZLvtY/1quilk+PNSVl6zP06D44MHWj
 Dk9B/9w714U3K7EUZyQaajEXFScCADhDwzL0AgAA
X-CMS-MailID: 20211220142252epcas5p4611297f9970acbc8ee3b0e325ca5ceec
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211220142252epcas5p4611297f9970acbc8ee3b0e325ca5ceec
References: <20211220141734.12206-1-joshi.k@samsung.com>
 <CGME20211220142252epcas5p4611297f9970acbc8ee3b0e325ca5ceec@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211220_185712_753700_8059CD24 
X-CRM114-Status: GOOD (  23.19  )
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

From: Keith Busch <kbusch@kernel.org>

The block layer knows how to deal with polled requests. Let the NVMe
driver use the previously reserved user "flags" fields to define an
option to allocate the request from the polled hardware contexts. If
polling is not enabled, then the block layer will automatically fallback
to a non-polled request.[1]

[1] https://lore.kernel.org/linux-block/20210517171443.GB2709391@dhcp-10-100-145-180.wdc.com/
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c        | 10 ++++++----
 drivers/nvme/host/ioctl.c       | 33 +++++++++++++++++++--------------
 drivers/nvme/host/nvme.h        |  3 ++-
 drivers/nvme/host/pci.c         |  4 ++--
 drivers/nvme/target/passthru.c  |  2 +-
 include/uapi/linux/nvme_ioctl.h |  4 ++++
 6 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0c231946a310..5199adf7ae92 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -633,11 +633,13 @@ static inline void nvme_init_request(struct request *req,
 }
 
 struct request *nvme_alloc_request(struct request_queue *q,
-		struct nvme_command *cmd, blk_mq_req_flags_t flags)
+		struct nvme_command *cmd, blk_mq_req_flags_t flags,
+		unsigned int rq_flags)
 {
+	unsigned int cmd_flags = nvme_req_op(cmd) | rq_flags;
 	struct request *req;
 
-	req = blk_mq_alloc_request(q, nvme_req_op(cmd), flags);
+	req = blk_mq_alloc_request(q, cmd_flags, flags);
 	if (!IS_ERR(req))
 		nvme_init_request(req, cmd);
 	return req;
@@ -1081,7 +1083,7 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	int ret;
 
 	if (qid == NVME_QID_ANY)
-		req = nvme_alloc_request(q, cmd, flags);
+		req = nvme_alloc_request(q, cmd, flags, 0);
 	else
 		req = nvme_alloc_request_qid(q, cmd, flags, qid);
 	if (IS_ERR(req))
@@ -1277,7 +1279,7 @@ static void nvme_keep_alive_work(struct work_struct *work)
 	}
 
 	rq = nvme_alloc_request(ctrl->admin_q, &ctrl->ka_cmd,
-				BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+				BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, 0);
 	if (IS_ERR(rq)) {
 		/* allocation failure, reset the controller */
 		dev_err(ctrl->device, "keep-alive failed: %ld\n", PTR_ERR(rq));
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 013ff9baa78e..bdaf8f317aa8 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -142,7 +142,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 		struct nvme_command *cmd, u64 ubuffer,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
 		u32 meta_seed, u64 *result, unsigned timeout,
-		struct io_uring_cmd *ioucmd)
+		struct io_uring_cmd *ioucmd, unsigned int rq_flags)
 {
 	bool write = nvme_is_write(cmd);
 	struct nvme_ns *ns = q->queuedata;
@@ -152,7 +152,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	void *meta = NULL;
 	int ret;
 
-	req = nvme_alloc_request(q, cmd, 0);
+	req = nvme_alloc_request(q, cmd, 0, rq_flags);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
@@ -212,11 +212,13 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	struct nvme_command c;
 	unsigned length, meta_len;
 	void __user *metadata;
+	unsigned int rq_flags = 0;
 
 	if (copy_from_user(&io, uio, sizeof(io)))
 		return -EFAULT;
-	if (io.flags)
-		return -EINVAL;
+
+	if (io.flags & NVME_HIPRI)
+		rq_flags |= REQ_POLLED;
 
 	switch (io.opcode) {
 	case nvme_cmd_write:
@@ -254,7 +256,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 
 	memset(&c, 0, sizeof(c));
 	c.rw.opcode = io.opcode;
-	c.rw.flags = io.flags;
+	c.rw.flags = 0;
 	c.rw.nsid = cpu_to_le32(ns->head->ns_id);
 	c.rw.slba = cpu_to_le64(io.slba);
 	c.rw.length = cpu_to_le16(io.nblocks);
@@ -266,7 +268,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 
 	return nvme_submit_user_cmd(ns->queue, &c,
 			io.addr, length, metadata, meta_len,
-			lower_32_bits(io.slba), NULL, 0, NULL);
+			lower_32_bits(io.slba), NULL, 0, NULL, rq_flags);
 }
 
 static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
@@ -288,6 +290,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 {
 	struct nvme_passthru_cmd cmd;
 	struct nvme_command c;
+	unsigned int rq_flags = 0;
 	unsigned timeout = 0;
 	u64 result;
 	int status;
@@ -296,14 +299,14 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		return -EACCES;
 	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
 		return -EFAULT;
-	if (cmd.flags)
-		return -EINVAL;
+	if (cmd.flags & NVME_HIPRI)
+		rq_flags |= REQ_POLLED;
 	if (!nvme_validate_passthru_nsid(ctrl, ns, cmd.nsid))
 		return -EINVAL;
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = cmd.opcode;
-	c.common.flags = cmd.flags;
+	c.common.flags = 0;
 	c.common.nsid = cpu_to_le32(cmd.nsid);
 	c.common.cdw2[0] = cpu_to_le32(cmd.cdw2);
 	c.common.cdw2[1] = cpu_to_le32(cmd.cdw3);
@@ -319,7 +322,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			cmd.addr, cmd.data_len, nvme_to_user_ptr(cmd.metadata),
-			cmd.metadata_len, 0, &result, timeout, NULL);
+			cmd.metadata_len, 0, &result, timeout, NULL, rq_flags);
 
 	if (status >= 0) {
 		if (put_user(result, &ucmd->result))
@@ -335,6 +338,7 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 {
 	struct nvme_passthru_cmd64 cmd;
 	struct nvme_command c;
+	unsigned int rq_flags = 0;
 	unsigned timeout = 0;
 	int status;
 
@@ -342,14 +346,15 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		return -EACCES;
 	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
 		return -EFAULT;
-	if (cmd.flags)
-		return -EINVAL;
+	if (cmd.flags & NVME_HIPRI)
+		rq_flags |= REQ_POLLED;
+
 	if (!nvme_validate_passthru_nsid(ctrl, ns, cmd.nsid))
 		return -EINVAL;
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = cmd.opcode;
-	c.common.flags = cmd.flags;
+	c.common.flags = 0;
 	c.common.nsid = cpu_to_le32(cmd.nsid);
 	c.common.cdw2[0] = cpu_to_le32(cmd.cdw2);
 	c.common.cdw2[1] = cpu_to_le32(cmd.cdw3);
@@ -365,7 +370,7 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			cmd.addr, cmd.data_len, nvme_to_user_ptr(cmd.metadata),
-			cmd.metadata_len, 0, &cmd.result, timeout, ioucmd);
+			cmd.metadata_len, 0, &cmd.result, timeout, ioucmd, rq_flags);
 
 	if (!ioucmd && status >= 0) {
 		if (put_user(cmd.result, &ucmd->result))
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 6bbb8ed868eb..56a7cc8421fc 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -696,7 +696,8 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl);
 
 #define NVME_QID_ANY -1
 struct request *nvme_alloc_request(struct request_queue *q,
-		struct nvme_command *cmd, blk_mq_req_flags_t flags);
+		struct nvme_command *cmd, blk_mq_req_flags_t flags,
+		unsigned int rq_flags);
 void nvme_cleanup_cmd(struct request *req);
 blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req);
 blk_status_t nvme_fail_nonready_command(struct nvme_ctrl *ctrl,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 50deb8b69c40..3d013a88af9d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1429,7 +1429,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		 req->tag, nvmeq->qid);
 
 	abort_req = nvme_alloc_request(dev->ctrl.admin_q, &cmd,
-			BLK_MQ_REQ_NOWAIT);
+			BLK_MQ_REQ_NOWAIT, 0);
 	if (IS_ERR(abort_req)) {
 		atomic_inc(&dev->ctrl.abort_limit);
 		return BLK_EH_RESET_TIMER;
@@ -2475,7 +2475,7 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 	cmd.delete_queue.opcode = opcode;
 	cmd.delete_queue.qid = cpu_to_le16(nvmeq->qid);
 
-	req = nvme_alloc_request(q, &cmd, BLK_MQ_REQ_NOWAIT);
+	req = nvme_alloc_request(q, &cmd, BLK_MQ_REQ_NOWAIT, 0);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 9e5b89ae29df..2a9e2fd3b137 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -253,7 +253,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		timeout = nvmet_req_subsys(req)->admin_timeout;
 	}
 
-	rq = nvme_alloc_request(q, req->cmd, 0);
+	rq = nvme_alloc_request(q, req->cmd, 0, 0);
 	if (IS_ERR(rq)) {
 		status = NVME_SC_INTERNAL;
 		goto out_put_ns;
diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index d99b5a772698..df2c138c38d9 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -9,6 +9,10 @@
 
 #include <linux/types.h>
 
+enum nvme_io_flags {
+	NVME_HIPRI      = 1 << 0, /* use polling queue if available */
+};
+
 struct nvme_user_io {
 	__u8	opcode;
 	__u8	flags;
-- 
2.25.1


