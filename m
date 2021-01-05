Return-Path: <SRS0=mRFX=GI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1086C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jan 2021 22:50:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 676FE22D6E
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jan 2021 22:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 676FE22D6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZKExHaZMNjUjdRk1gLwAp2mPLwgNh3Z0mxU6VJQWjS8=; b=Z0Xwoahi96g8j9Umh30zs13Q5
	t2jc2IdoXI+XeFMGt9JGaN1u6abtexIXF3nAHV+Z+0om1IZJQResO3vHa/+cDwCSVFNZ2VGnINI/T
	BpqJfTeFnSvn2EMIf43exc2SPfC+jURCe5FUeuFel/Qt2gpqU9rI8e916diTuGMUybjnDBP4LGUMp
	b8JsAsqWDmPAq0UG57fGByAsUUVk+YGkULXXOKxMq9T1LwBzLc9cUudvJduLK4EtHHiZe5f1e+5ds
	PeZza1JCsBps0bVjQST00mDPtVVyPou7dj1xpAwcfNibuPemo73g3YRmYbRa5t22nF2Nja5FMc2D8
	3rbhCTZBg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwv9K-0002CF-7m; Tue, 05 Jan 2021 22:49:58 +0000
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwv9F-0002Ao-PC
 for linux-nvme@lists.infradead.org; Tue, 05 Jan 2021 22:49:55 +0000
Received: by mail-pg1-x534.google.com with SMTP id g15so858484pgu.9
 for <linux-nvme@lists.infradead.org>; Tue, 05 Jan 2021 14:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=a/ew2aNo3OYpuVhdNa1HAF1LqyVa38yd7xKEEyHhhHo=;
 b=cgVMqhtOkzCvvQOcanhs3oV6DHBf7SiYevEzjs9Buddtpsav+W8bBrkBeEUo9hRonW
 g/uh9YwGeKimEEwpuZJYyBW49N+d7zD7CCR93KdcIwYDlLpNfWmy4qjPACMf915EjvM/
 0KH/fjUFJKbj3VZzbT4QrcffVyHQjyf5OddyTCOLMqOcMzrETEzc3EwnExrQXSVUTdc5
 lizA6nRtkXSs5WzfWBBdYkbrlC+u3BLHqBvIv7M8hVMQbROEU7Nw7mMuMD3oa5DEVduz
 X3ydIfAxPoAShZnjmMIHbrNiqBL2iFxXp0cgma4Qj0RbAXm8iSWuO1cO+hFLutskHXiz
 9ZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=a/ew2aNo3OYpuVhdNa1HAF1LqyVa38yd7xKEEyHhhHo=;
 b=c/cNk+4lgiMry7DfBUKnTDG+1oXd2AtcIcFozD6c8F1QTzxwkMx8lVPZxudqpUuPvL
 f2SQoLLo7EtgMOlwx77RPSNGmnXUQpUf1LjuWZP7tgJgI3gbHW/y74v0d4NQjMTBS7Jr
 mxa5rrdXgeGkDEas1FfOHHmaBXvrcwTaEPE6Ic9at6DVBOAXRnwrSKYlzOjQebMuIWBH
 ar2ey+kCscmiJA97k2mx2OLwruuZAMuCIWesdD5ZTokcAsjLGpImDkh7gHnGr8MRdsWX
 nQpPVmhsIgfAJgBx0/I7Bt3UVfY7wpGy9/1CytPP6SL5JvoqMYDqnpQCQBvt7HoxZZNh
 q03Q==
X-Gm-Message-State: AOAM533BNkSJ6SMHBNEgEbPfhCJLM3qjXI/3HTMapya0eVn72dnvds+O
 tw4sp1VKSyS8RTyAxY3U0cLUHRxyzGkYiaWxrB0=
X-Google-Smtp-Source: ABdhPJw/XJO6IExKmuRMk4LAChHUzXkfL+KBMhUKr83Ul9nMkWXZwPqVeDJCzVR/wAFeVljjAUIqog==
X-Received: by 2002:a63:2cd:: with SMTP id 196mr1364614pgc.398.1609886991406; 
 Tue, 05 Jan 2021 14:49:51 -0800 (PST)
Received: from kai-mayerc-x40e.us.kioxia.com ([12.201.142.42])
 by smtp.gmail.com with ESMTPSA id 6sm351516pfj.216.2021.01.05.14.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Jan 2021 14:49:50 -0800 (PST)
From: klayph@gmail.com
X-Google-Original-From: clay.mayers@kioxia.com
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvme: support fused NVME_IOCTL_SUBMIT_IO
Date: Tue,  5 Jan 2021 14:49:39 -0800
Message-Id: <20210105224939.1336-3-clay.mayers@kioxia.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20210105224939.1336-1-clay.mayers@kioxia.com>
References: <20210105224939.1336-1-clay.mayers@kioxia.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210105_174953_937932_9E2F727B 
X-CRM114-Status: GOOD (  24.06  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Clay Mayers <mayerc@kioxia.com>

Extends the functionality of the NVME_IOCTL_SUBMIT_IO ioctl to support
a pair of fused nvme_user_io requests.

When submitting a fused pair, an array of two nvme_user_io structs are
supplied when invoking NVME_IOCTL_SUBMIT_IO ioctl.  Rather than
introduce a new ioctl code, the presence of a fused pair is indicated
by the nvme_user_io.flags having the value of NVME_CMD_FUSED_FIRST.
This then indicates a second nvme_user_io struct follows the first with
an nvme_user_io.flags set to NVME_CMD_FUSED_SECOND.

A fused pair may fail to submit with -EWOULDBLOCK.  This indicates the
device queue selected for the first command didn't have a tag available
when the request for the second command was created.

Signed-off-by: Clay Mayers <clay.mayers@kioxia.com>
---
 drivers/nvme/host/core.c | 260 ++++++++++++++++++++++++++++++---------
 1 file changed, 200 insertions(+), 60 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a498cf6a9eaf..ce5d2a9a08a8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1468,16 +1468,40 @@ static void __user *nvme_to_user_ptr(uintptr_t ptrval)
 	return (void __user *)ptrval;
 }
 
-static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
+struct nvme_user_io_req {
+	struct nvme_command cmd;
+	struct request *rq;
+	struct bio *bio;	/* bio in rq at the time of allocation */
+	void *meta;
+	void __user *udata;
+	void __user *umeta;
+	unsigned int len;
+	unsigned int mlen;
+	u32 mseed;
+};
+
+static void nvme_free_io(struct nvme_user_io_req *nrq)
+{
+	if (!nrq)
+		return;
+	kfree(nrq->meta);
+	if (nrq->bio)
+		blk_rq_unmap_user(nrq->bio);
+	if (nrq->rq)
+		blk_mq_free_request(nrq->rq);
+	nrq->meta = NULL;
+	nrq->bio = NULL;
+	nrq->rq = NULL;
+}
+
+static int nvme_prep_io(struct nvme_ns *ns, struct nvme_user_io_req *nrq,
+			struct nvme_user_io __user *uio, int size)
 {
 	struct nvme_user_io io;
-	struct nvme_command c;
-	unsigned length, meta_len;
-	void __user *metadata;
 
-	if (copy_from_user(&io, uio, sizeof(io)))
+	if (unlikely(copy_from_user(&io, uio, size)))
 		return -EFAULT;
-	if (io.flags)
+	if (unlikely(io.flags & ~(NVME_CMD_FUSE_FIRST|NVME_CMD_FUSE_SECOND)))
 		return -EINVAL;
 
 	switch (io.opcode) {
@@ -1489,33 +1513,160 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 		return -EINVAL;
 	}
 
-	length = (io.nblocks + 1) << ns->lba_shift;
-	meta_len = (io.nblocks + 1) * ns->ms;
-	metadata = nvme_to_user_ptr(io.metadata);
+	nrq->udata = nvme_to_user_ptr(io.addr);
+	nrq->len = (io.nblocks + 1) << ns->lba_shift;
+	nrq->umeta = nvme_to_user_ptr(io.metadata);
+	nrq->mlen = (io.nblocks + 1) * ns->ms;
+	nrq->mseed = lower_32_bits(io.slba);
+	nrq->bio = nrq->meta = NULL;
 
 	if (ns->features & NVME_NS_EXT_LBAS) {
-		length += meta_len;
-		meta_len = 0;
-	} else if (meta_len) {
+		nrq->len += nrq->mlen;
+		nrq->mlen = 0;
+	} else if (nrq->mlen) {
 		if ((io.metadata & 3) || !io.metadata)
 			return -EINVAL;
 	}
 
-	memset(&c, 0, sizeof(c));
-	c.rw.opcode = io.opcode;
-	c.rw.flags = io.flags;
-	c.rw.nsid = cpu_to_le32(ns->head->ns_id);
-	c.rw.slba = cpu_to_le64(io.slba);
-	c.rw.length = cpu_to_le16(io.nblocks);
-	c.rw.control = cpu_to_le16(io.control);
-	c.rw.dsmgmt = cpu_to_le32(io.dsmgmt);
-	c.rw.reftag = cpu_to_le32(io.reftag);
-	c.rw.apptag = cpu_to_le16(io.apptag);
-	c.rw.appmask = cpu_to_le16(io.appmask);
-
-	return nvme_submit_user_cmd(ns->queue, &c,
-			nvme_to_user_ptr(io.addr), length,
-			metadata, meta_len, lower_32_bits(io.slba), NULL, 0);
+	memset(&nrq->cmd, 0, sizeof(nrq->cmd));
+	nrq->cmd.rw.opcode = io.opcode;
+	nrq->cmd.rw.flags = io.flags;
+	nrq->cmd.rw.nsid = cpu_to_le32(ns->head->ns_id);
+	nrq->cmd.rw.slba = cpu_to_le64(io.slba);
+	nrq->cmd.rw.length = cpu_to_le16(io.nblocks);
+	nrq->cmd.rw.control = cpu_to_le16(io.control);
+	nrq->cmd.rw.dsmgmt = cpu_to_le32(io.dsmgmt);
+	nrq->cmd.rw.reftag = cpu_to_le32(io.reftag);
+	nrq->cmd.rw.apptag = cpu_to_le16(io.apptag);
+	nrq->cmd.rw.appmask = cpu_to_le16(io.appmask);
+
+	return 0;
+}
+
+static struct request *nvme_mk_req_io(struct nvme_ns *ns,
+				      struct nvme_user_io_req *nrq,
+				      blk_mq_req_flags_t flags, int qid,
+				      int timeout)
+{
+	bool write = nvme_is_write(&nrq->cmd);
+	struct request_queue *q = ns->queue;
+	struct gendisk *disk = ns->disk;
+	struct request *rq;
+	struct bio *bio = NULL;
+	void *meta = NULL;
+	int ret;
+
+	rq = nvme_alloc_request(q, &nrq->cmd, flags, qid);
+	if (unlikely(IS_ERR(rq)))
+		return rq;
+
+	rq->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+	nvme_req(rq)->flags |= NVME_REQ_USERCMD;
+
+	if (nrq->udata && nrq->len) {
+		ret = blk_rq_map_user(q, rq, NULL, nrq->udata, nrq->len,
+				GFP_KERNEL);
+		if (ret)
+			goto out;
+		bio = rq->bio;
+		bio->bi_disk = disk;
+		if (disk && nrq->umeta && nrq->mlen) {
+			meta = nvme_add_user_metadata(bio, nrq->umeta, nrq->mlen,
+					nrq->mseed, write);
+			if (IS_ERR(meta)) {
+				ret = PTR_ERR(meta);
+				goto out_unmap;
+			}
+			nrq->meta = meta;
+		}
+	}
+	nrq->bio = bio;
+	return rq;
+out_unmap:
+	if (bio)
+		blk_rq_unmap_user(bio);
+ out:
+	blk_mq_free_request(rq);
+	return ERR_PTR(ret);
+}
+
+static int nvme_unprep_io(struct nvme_user_io_req *nrq,
+			  u64 *result)
+{
+	struct request *rq = nrq->rq;
+	int write = nvme_is_write(&nrq->cmd);
+	int ret;
+
+	if (unlikely(nvme_req(rq)->flags & NVME_REQ_CANCELLED))
+		ret = -EINTR;
+	else
+		ret = nvme_req(rq)->status;
+	if (result)
+		*result = le64_to_cpu(nvme_req(rq)->result.u64);
+	if (nrq->meta && !ret && !write) {
+		if (copy_to_user(nrq->umeta, nrq->meta, nrq->mlen))
+			ret = -EFAULT;
+	}
+	nvme_free_io(nrq);
+	return ret;
+}
+
+/* support both NVME_IOCTL_SUBMIT_IO and NVME_IOCTL_SUBMIT_IO32 */
+static int nvme_submit_io(struct nvme_ns *ns, void __user *uio,
+			  int size)
+{
+	struct nvme_user_io_req nrq, nrq2;
+	struct request *rq, *rq2;
+	int ret, fused;
+
+	ret = nvme_prep_io(ns, &nrq, uio, size);
+	if (unlikely(ret))
+		return ret;
+	fused = (nrq.cmd.common.flags == NVME_CMD_FUSE_FIRST);
+	if (fused) {
+		ret = nvme_prep_io(ns, &nrq2, uio+size, size);
+		if (unlikely(ret))
+			return ret;
+		if (unlikely(nrq2.cmd.common.flags != NVME_CMD_FUSE_SECOND))
+			return -EINVAL;
+	} else if (unlikely(nrq.cmd.common.flags)) {
+		return -EINVAL;
+	}
+	rq = nvme_mk_req_io(ns, &nrq, 0, NVME_QID_ANY, 0);
+	if (unlikely(IS_ERR(rq)))
+		return PTR_ERR(rq);
+	nrq.rq = rq;
+	if (fused) {
+		DECLARE_COMPLETION_ONSTACK(wait);
+
+		rq2 = nvme_mk_req_io(ns, &nrq2, BLK_MQ_REQ_NOWAIT,
+				     nvme_req_qid(rq), 0);
+		if (unlikely(IS_ERR(rq2))) {
+			nvme_free_io(&nrq);
+			return PTR_ERR(rq2);
+		}
+		nvme_req(rq)->nrq2 = nvme_req(rq2);
+		nrq2.rq = rq2;
+
+		rq->cmd_flags |= REQ_NOMERGE;
+		rq2->cmd_flags |= REQ_NOMERGE;
+		rq->end_io_data = &wait;
+		blk_execute_rq_nowait(rq->q, ns->disk, rq, false, nvme_end_sync_rq);
+		nvme_execute_passthru_rq(rq2);
+
+		/*
+		 * both will be complete at this point, but nvme spec doesn't
+		 * specify cqe ordering for fused operations so wait for the
+		 * first to complete as well
+		 */
+		wait_for_completion_io(&wait);
+		nvme_unprep_io(&nrq, NULL);
+		ret = nvme_unprep_io(&nrq2, NULL);
+	} else {
+		nvme_execute_passthru_rq(rq);
+		ret = nvme_unprep_io(&nrq, NULL);
+	}
+	return ret;
 }
 
 static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
@@ -1672,6 +1823,23 @@ static int nvme_handle_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
 	return ret;
 }
 
+struct nvme_user_io32 {
+	__u8	opcode;
+	__u8	flags;
+	__u16	control;
+	__u16	nblocks;
+	__u16	rsvd;
+	__u64	metadata;
+	__u64	addr;
+	__u64	slba;
+	__u32	dsmgmt;
+	__u32	reftag;
+	__u16	apptag;
+	__u16	appmask;
+} __attribute__((__packed__));
+
+#define NVME_IOCTL_SUBMIT_IO32	_IOW('N', 0x42, struct nvme_user_io32)
+
 static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
@@ -1700,8 +1868,10 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 	case NVME_IOCTL_IO_CMD:
 		ret = nvme_user_cmd(ns->ctrl, ns, argp);
 		break;
+	case NVME_IOCTL_SUBMIT_IO32:
+		fallthrough;	/* structures are identical except size */
 	case NVME_IOCTL_SUBMIT_IO:
-		ret = nvme_submit_io(ns, argp);
+		ret = nvme_submit_io(ns, argp, _IOC_SIZE(cmd));
 		break;
 	case NVME_IOCTL_IO64_CMD:
 		ret = nvme_user_cmd64(ns->ctrl, ns, argp);
@@ -1717,41 +1887,11 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 	return ret;
 }
 
-#ifdef CONFIG_COMPAT
-struct nvme_user_io32 {
-	__u8	opcode;
-	__u8	flags;
-	__u16	control;
-	__u16	nblocks;
-	__u16	rsvd;
-	__u64	metadata;
-	__u64	addr;
-	__u64	slba;
-	__u32	dsmgmt;
-	__u32	reftag;
-	__u16	apptag;
-	__u16	appmask;
-} __attribute__((__packed__));
-
-#define NVME_IOCTL_SUBMIT_IO32	_IOW('N', 0x42, struct nvme_user_io32)
 
+#ifdef CONFIG_COMPAT
 static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
-	/*
-	 * Corresponds to the difference of NVME_IOCTL_SUBMIT_IO
-	 * between 32 bit programs and 64 bit kernel.
-	 * The cause is that the results of sizeof(struct nvme_user_io),
-	 * which is used to define NVME_IOCTL_SUBMIT_IO,
-	 * are not same between 32 bit compiler and 64 bit compiler.
-	 * NVME_IOCTL_SUBMIT_IO32 is for 64 bit kernel handling
-	 * NVME_IOCTL_SUBMIT_IO issued from 32 bit programs.
-	 * Other IOCTL numbers are same between 32 bit and 64 bit.
-	 * So there is nothing to do regarding to other IOCTL numbers.
-	 */
-	if (cmd == NVME_IOCTL_SUBMIT_IO32)
-		return nvme_ioctl(bdev, mode, NVME_IOCTL_SUBMIT_IO, arg);
-
 	return nvme_ioctl(bdev, mode, cmd, arg);
 }
 #else
@@ -3118,7 +3258,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ret = nvme_configure_apst(ctrl);
 	if (ret < 0)
 		return ret;
-	
+
 	ret = nvme_configure_timestamp(ctrl);
 	if (ret < 0)
 		return ret;
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
