Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2117C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Mar 2022 15:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=70vfAyIFdHg4l3b5yOr4vSbOCrH9gUU5cNk0pS+RxM0=; b=MmDYtHyGY+/W79F8ehX1UijdZz
	uSO3944+loTX5Jb/Z8hLyugv5IJPb+Qkfi2lEragBQ5CWW+yGk3hg40HtGuJ3R0SGPXeqsjjGV98K
	awznc4bBcpLsJ6kgUrNTHOfILaSwb99fEGGknxXvLgzosfTHHWifjyX7TQVXE0XxaL4DKk/+IBsDf
	MNxsZ2GqWYu88H5UGm/FEjh123+GJKRAEN9hLn9ooLWgcQUGMzg9r3/7fRRkdhxCYIsj1OLbP52/p
	AdLZN+2woaH+mf3HlcfHLifF201vhUpeto0GOYRFwpQPFiIrIiOXEuVlY2NijoNBGihcmScu8JIpR
	sRExhgJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRc8F-0053av-1N; Tue, 08 Mar 2022 15:52:15 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRbzQ-00512J-1J
 for linux-nvme@lists.infradead.org; Tue, 08 Mar 2022 15:43:10 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20220308154306epoutp03d6dc4967f94c41efc8c6d1fa811f143a~acjUgfnmO2451824518epoutp03H
 for <linux-nvme@lists.infradead.org>; Tue,  8 Mar 2022 15:43:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20220308154306epoutp03d6dc4967f94c41efc8c6d1fa811f143a~acjUgfnmO2451824518epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1646754186;
 bh=70vfAyIFdHg4l3b5yOr4vSbOCrH9gUU5cNk0pS+RxM0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CYK1GEZyE4Jl78jfYgerBsAlOZF6gmli3yCgpxx/zGyFwYFSNAhSUGOfx+0MjJ/l3
 jhO++SuXxV4IqbnYkiFcSRmYZRzlQ9kEsGC61dXA0IyuSnArtSMexei+y/gveBF5DV
 L+ux8k5tTesHjljPl9wFVOc6IXbBEorv//L9NsPU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas5p4.samsung.com (KnoxPortal) with ESMTP id
 20220308154305epcas5p4a76e9412f39f8c4e74fb40a43f3aaa2f~acjTfREx-0458304583epcas5p4b;
 Tue,  8 Mar 2022 15:43:05 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4KCfjd4dxNz4x9Pt; Tue,  8 Mar
 2022 15:43:01 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
 epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 2E.57.06423.58977226; Wed,  9 Mar 2022 00:43:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20220308152720epcas5p19653942458e160714444942ddb8b8579~acVkD7i7p1632216322epcas5p1Z;
 Tue,  8 Mar 2022 15:27:20 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20220308152720epsmtrp18448af239b56600a66975708faa5278d~acVkDHkoW0125001250epsmtrp1e;
 Tue,  8 Mar 2022 15:27:20 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-1f-622779850f9b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
 0D.96.03370.8D577226; Wed,  9 Mar 2022 00:27:20 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20220308152718epsmtip1a755c271693873fbf05c0285e1b44641~acViAHzMs0990109901epsmtip1g;
 Tue,  8 Mar 2022 15:27:18 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, sbates@raithlin.com, logang@deltatee.com,
 pankydev8@gmail.com, javier@javigon.com, mcgrof@kernel.org,
 a.manzanares@samsung.com, joshiiitr@gmail.com, anuj20.g@samsung.com
Subject: [PATCH 13/17] nvme: allow user passthrough commands to poll
Date: Tue,  8 Mar 2022 20:51:01 +0530
Message-Id: <20220308152105.309618-14-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308152105.309618-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDJsWRmVeSWpSXmKPExsWy7bCmlm5rpXqSwb2HChbTDytaNE34y2wx
 Z9U2RovVd/vZLFauPspk8a71HItF5+kLTBbn3x5msph06Bqjxd5b2hbzlz1lt1jSepzN4saE
 p4wWa24+ZbH4fGYeqwO/x7Orzxg9ds66y+7RvOAOi8fls6Uem1Z1snlsXlLvsftmA5vHtsUv
 WT36tqxi9Pi8SS6AKyrbJiM1MSW1SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VW
 ycUnQNctMwfoByWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFpXrpe
 XmqJlaGBgZEpUGFCdsatuf4Fa7UrzuxLb2A8qNzFyMkhIWAi8arlIUsXIxeHkMBuRollk18w
 QzifGCWenL3CBuF8ZpRY0TWNDaZl/ZUH7BCJXYwSzzasYoGrOrj1FpDDwcEmoClxYXIpSIOI
 gJfE/dvvWUFqmAW6mCTe7rsPNklYwEXi5sz97CA2i4CqxO3bK8HivAJWEs8b1jFCbJOXmHnp
 O1gNJ1D8562trBA1ghInZz5hAbGZgWqat84Gu1tC4ACHxK1Pr6GaXSQe7PzKDmELS7w6vgXK
 lpJ42d8GZRdL/LpzFKq5g1HiesNMFoiEvcTFPX+ZQL5hBvpm/S59iLCsxNRT65ggFvNJ9P5+
 wgQR55XYMQ/GVpS4N+kpK4QtLvFwxhJWkDESAh4S629nQAKrl1Hi7KfbjBMYFWYh+WcWkn9m
 IWxewMi8ilEytaA4Nz212LTAMC+1HB7Jyfm5mxjByVrLcwfj3Qcf9A4xMnEwHmKU4GBWEuG9
 f14lSYg3JbGyKrUoP76oNCe1+BCjKTDAJzJLiSbnA/NFXkm8oYmlgYmZmZmJpbGZoZI47+n0
 DYlCAumJJanZqakFqUUwfUwcnFINTMae5UosMZx2zfYLr1+emjTdqXvG1iyzmx0is9wProhl
 N/F1b7PZN9EtLeh0MCMn49wtjmU9q1g1Vh6syJRa7ZCSo1NntOfzfafkqz+rjvPszQl1slTl
 uNDadrVS7sSvZ3Xrny19uWTNzEB/66jQXPv2Z+vlXdp3Sq4vf5NZcSzn8+aXszad/J7D8zhs
 adJ5A4l2/WW/g5czsDG3vrp+b5cb5+Vpv8t5hJn99+ffffE0ZH0EQ0j2PI4fpWdEklX/8rbf
 nBGpf/ljonROHjOX/p1vmu8sHScUTdXf+T5kw7U0Q4vsxO8WszmTilYeO3jYfZsNYztPjLaQ
 zayKPxqzfRZUij06ULEy3mo2kxqfEktxRqKhFnNRcSIAyZXjXV8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42LZdlhJTvdGqXqSwavnuhbTDytaNE34y2wx
 Z9U2RovVd/vZLFauPspk8a71HItF5+kLTBbn3x5msph06Bqjxd5b2hbzlz1lt1jSepzN4saE
 p4wWa24+ZbH4fGYeqwO/x7Orzxg9ds66y+7RvOAOi8fls6Uem1Z1snlsXlLvsftmA5vHtsUv
 WT36tqxi9Pi8SS6AK4rLJiU1J7MstUjfLoEr49Zc/4K12hVn9qU3MB5U7mLk5JAQMJFYf+UB
 excjF4eQwA5GiWV3nzJBJMQlmq/9YIewhSVW/nsOVfSRUaJ77VvGLkYODjYBTYkLk0tBakQE
 AiQONl4Gq2EWmMEk0dP8mQUkISzgInFz5n6wQSwCqhK3b69kA7F5BawknjesY4RYIC8x89J3
 sBpOoPjPW1tZQWwhAUuJFet+Q9ULSpyc+QRsJjNQffPW2cwTGAVmIUnNQpJawMi0ilEytaA4
 Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOJq0tHYw7ln1Qe8QIxMH4yFGCQ5mJRHe++dVkoR4
 UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpganfQ3fO+/+bJ
 mYksK3McPndGhvP5bWZaZRgdpM0ks3nVgiKGmzOfqLBXPP776Qwfh3Xz5hyHg+rGqic0mJb4
 aKb1dNn7Xm+c43dtDZ+nofWKhDNL+0RnODfPOH5S2yCocMLl0BP/vm3zSK7Z4PWgcu7ElICj
 9bPb3q5xytstaWwS7fKIUy1O8RPHGZGY8AubP0l6PfNK58+YrWB6Jl9M9Q5vlMmM9IOqi5br
 LJvQKWRu0fbrfMb3F985JzhzC4gu4yx+9bXvddR8sbSGduNff9/ms27LnbJs0q2mJT+8r/yS
 SKt4vvHYpezAwPluXhKvlD8dO7Vt1cKVx8/xsj56ZLVpzWrGn8Jvs8zuHC07rsRSnJFoqMVc
 VJwIAFME66IVAwAA
X-CMS-MailID: 20220308152720epcas5p19653942458e160714444942ddb8b8579
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220308152720epcas5p19653942458e160714444942ddb8b8579
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152720epcas5p19653942458e160714444942ddb8b8579@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_074308_489682_61F40BAE 
X-CRM114-Status: GOOD (  20.63  )
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
 drivers/nvme/host/ioctl.c       | 30 ++++++++++++++++--------------
 include/uapi/linux/nvme_ioctl.h |  4 ++++
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index a4cde210aab9..a6712fb3eb98 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -132,7 +132,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 		struct nvme_command *cmd, u64 ubuffer,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
 		u32 meta_seed, u64 *result, unsigned timeout,
-		struct io_uring_cmd *ioucmd)
+		struct io_uring_cmd *ioucmd, unsigned int rq_flags)
 {
 	bool write = nvme_is_write(cmd);
 	struct nvme_ns *ns = q->queuedata;
@@ -140,7 +140,6 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	struct request *req;
 	struct bio *bio = NULL;
 	void *meta = NULL;
-	unsigned int rq_flags = 0;
 	blk_mq_req_flags_t blk_flags = 0;
 	int ret;
 
@@ -216,11 +215,12 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	struct nvme_command c;
 	unsigned length, meta_len;
 	void __user *metadata;
+	unsigned int rq_flags = 0;
 
 	if (copy_from_user(&io, uio, sizeof(io)))
 		return -EFAULT;
-	if (io.flags)
-		return -EINVAL;
+	if (io.flags & NVME_HIPRI)
+		rq_flags |= REQ_POLLED;
 
 	switch (io.opcode) {
 	case nvme_cmd_write:
@@ -258,7 +258,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 
 	memset(&c, 0, sizeof(c));
 	c.rw.opcode = io.opcode;
-	c.rw.flags = io.flags;
+	c.rw.flags = 0;
 	c.rw.nsid = cpu_to_le32(ns->head->ns_id);
 	c.rw.slba = cpu_to_le64(io.slba);
 	c.rw.length = cpu_to_le16(io.nblocks);
@@ -270,7 +270,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 
 	return nvme_submit_user_cmd(ns->queue, &c,
 			io.addr, length, metadata, meta_len,
-			lower_32_bits(io.slba), NULL, 0, NULL);
+			lower_32_bits(io.slba), NULL, 0, NULL, rq_flags);
 }
 
 static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
@@ -292,6 +292,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 {
 	struct nvme_passthru_cmd cmd;
 	struct nvme_command c;
+	unsigned int rq_flags = 0;
 	unsigned timeout = 0;
 	u64 result;
 	int status;
@@ -300,14 +301,14 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
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
@@ -323,7 +324,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			cmd.addr, cmd.data_len, nvme_to_user_ptr(cmd.metadata),
-			cmd.metadata_len, 0, &result, timeout, NULL);
+			cmd.metadata_len, 0, &result, timeout, NULL, rq_flags);
 
 	if (status >= 0) {
 		if (put_user(result, &ucmd->result))
@@ -339,6 +340,7 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 {
 	struct nvme_passthru_cmd64 cmd, *cptr;
 	struct nvme_command c;
+	unsigned int rq_flags = 0;
 	unsigned timeout = 0;
 	int status;
 
@@ -353,14 +355,14 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			return -EINVAL;
 		cptr = (struct nvme_passthru_cmd64 *)ioucmd->cmd;
 	}
-	if (cptr->flags)
-		return -EINVAL;
+	if (cptr->flags & NVME_HIPRI)
+		rq_flags |= REQ_POLLED;
 	if (!nvme_validate_passthru_nsid(ctrl, ns, cptr->nsid))
 		return -EINVAL;
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = cptr->opcode;
-	c.common.flags = cptr->flags;
+	c.common.flags = 0;
 	c.common.nsid = cpu_to_le32(cptr->nsid);
 	c.common.cdw2[0] = cpu_to_le32(cptr->cdw2);
 	c.common.cdw2[1] = cpu_to_le32(cptr->cdw3);
@@ -377,7 +379,7 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			cptr->addr, cptr->data_len,
 			nvme_to_user_ptr(cptr->metadata), cptr->metadata_len,
-			0, &cptr->result, timeout, ioucmd);
+			0, &cptr->result, timeout, ioucmd, rq_flags);
 
 	if (!ioucmd && status >= 0) {
 		if (put_user(cptr->result, &ucmd->result))
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


