Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC767C7EE23
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Apr 2023 09:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DtyDvlRYNmEJxi0GYtG3RjT+t7RC5XKjuqrISgRW5bE=; b=clX9babCD8U/2QseF4pr5/qMak
	MVuM4TwUs+kYKW4OjC+QPNom/6d84O9HwvZ3Zo8nELnrWa+MHzIKojhoWyeWOLJ7neYI/qaqpS1Kr
	LCUyRv+EwXmEN2N4gquNglkW2ZmKNUofwzeHgOqhLlgSdvp5hs5V3S2iFLPP+Y53Vzd67SuqnYa6a
	BM3cIs4JUAUrRGmnyBl4IMRK2ltYnG+J35Qn8eW5jG0r53lz1Ns7h+8MgufifhBpjoe2hBg5h4//c
	iAoz5adg6P1EPxtkyBc8oyGKdqdI6ZlQ+ZOeEaKmo8AP8PQPHyVAqoHOlFifw+V+3oHCoPfUHUi7x
	266S04EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1psh6h-00CU1p-1N;
	Sat, 29 Apr 2023 09:43:07 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1psh6c-00CTvY-01
	for linux-nvme@lists.infradead.org;
	Sat, 29 Apr 2023 09:43:04 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230429094300epoutp03b4003dab81c850afb52fd7713f97b9c7~aXo9LC0j_2944229442epoutp03o
	for <linux-nvme@lists.infradead.org>; Sat, 29 Apr 2023 09:43:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230429094300epoutp03b4003dab81c850afb52fd7713f97b9c7~aXo9LC0j_2944229442epoutp03o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1682761380;
	bh=DtyDvlRYNmEJxi0GYtG3RjT+t7RC5XKjuqrISgRW5bE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OoNvAOoHGOXA1xnEnAwu39oLMf0BMf8ih/m6BSUV5gr6Fb3wQG52PPrAwmeuteFhY
	 6hO6GwIZRk2DNAUiizftqL4hpWgkSAnH1dKKA8l062qbkYYOGusv/VApKsNdAW/iMU
	 DNEL/LuHweHeml377Ok6gMCH6RyFWY0LVzoF4p6M=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20230429094259epcas5p10dd02a8941a48e25f25dc3df91a1ae48~aXo8beI6i1041010410epcas5p1y;
	Sat, 29 Apr 2023 09:42:59 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Q7kzk2QLJz4x9Pv; Sat, 29 Apr
	2023 09:42:58 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	85.7C.54880.2A6EC446; Sat, 29 Apr 2023 18:42:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20230429094257epcas5p463574920bba26cd219275e57c2063d85~aXo6dL7V01668816688epcas5p46;
	Sat, 29 Apr 2023 09:42:57 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230429094257epsmtrp1808ec5ab05a9a48765311bf37e4cb428~aXo6cifes0376803768epsmtrp1y;
	Sat, 29 Apr 2023 09:42:57 +0000 (GMT)
X-AuditID: b6c32a49-8c5ff7000001d660-9e-644ce6a24f54
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D8.38.27706.1A6EC446; Sat, 29 Apr 2023 18:42:57 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230429094255epsmtip2c15ae7be5d7b2531d5b34103fe80be40~aXo40BWrm0920909209epsmtip2J;
	Sat, 29 Apr 2023 09:42:55 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kbusch@kernel.org
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, anuj1072538@gmail.com,
	xiaoguang.wang@linux.alibaba.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [RFC PATCH 10/12] nvme: submisssion/completion of uring_cmd to/from
 the registered queue
Date: Sat, 29 Apr 2023 15:09:23 +0530
Message-Id: <20230429093925.133327-11-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230429093925.133327-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCJsWRmVeSWpSXmKPExsWy7bCmlu6iZz4pBlcnCFh8/PqbxWL13X42
	i5sHdjJZrFx9lMniXes5Fouj/9+yWUw6dI3RYu8tbYv5y56yW6x7/Z7FYtPfk0wO3B47Z91l
	9zh/byOLx+WzpR6bVnWyeex8aOmxeUm9x+6bDWwefVtWMXp83iQXwBmVbZORmpiSWqSQmpec
	n5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdKqSQlliTilQKCCxuFhJ386m
	KL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITtj+tMTTAW7tCumbGtk
	aWBcqdzFyMkhIWAicezyWrYuRi4OIYHdjBIHJi5lB0kICXxilHh6tQrC/sYocey/N0zD47t7
	oBr2MkpsP3CSDaLoM6PE4p/RXYwcHGwCmhIXJpeChEUEXCSa1k4Fq2cWuMgo0fPpEAtIQlgg
	WeLr/dlgNouAqkTv319gNq+AlURz1w8WiGXyEjMvfQc7iBMo/n3GbmaIGkGJkzOfgNUwA9U0
	b53NDLJAQmAuh0Tbi2XMIEdIAG3+tj0DYo6wxKvjW9ghbCmJl/1tUHayxKWZ55gg7BKJx3sO
	Qtn2Eq2n+sHGMAP9sn6XPsQqPone30+YIKbzSnS0CUFUK0rcm/SUFcIWl3g4YwmU7SFx4fB7
	dkhQ9TJKrLnzlWkCo/wsJB/MQvLBLIRtCxiZVzFKphYU56anFpsWGOallsNjNTk/dxMjOLlq
	ee5gvPvgg94hRiYOxkOMEhzMSiK8vJXuKUK8KYmVValF+fFFpTmpxYcYTYFBPJFZSjQ5H5je
	80riDU0sDUzMzMxMLI3NDJXEedVtTyYLCaQnlqRmp6YWpBbB9DFxcEo1MFl8afR2myFW9V4j
	ieteSqxAh+Di74WHN5nL9U7+e1b9V7fppQ/RVf1F6+XX7DPytDXd0MxdFtTsqsR4bbN492NR
	tox/ixbvWXll/83lwtWpt7o2Xln8d9flsqdrBY8HBR/fHtfSnXt1vveRPUVt7sL2S7ZP68p5
	YTrJJ1FQJin8xsq3Gy2073/xbw+YeHvZpDSOnwwPmjYfuCgbNkf8w5zAxnPF8W3sysqGK2qX
	nX5qvnQ+I8v3HalHtrpwiOWxrVHfOvln8QXFpuTEDYpqWh+tdKanp/AdfC81e9GlTVN2fSi9
	U5kpaDHvibHKrZiFgck/3rcGvOn8oRF49Mi+gJ6yiVfKG7s3VR7nVdw6J1WJpTgj0VCLuag4
	EQCVQJDRNwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsWy7bCSvO7CZz4pBgu/8lp8/PqbxWL13X42
	i5sHdjJZrFx9lMniXes5Fouj/9+yWUw6dI3RYu8tbYv5y56yW6x7/Z7FYtPfk0wO3B47Z91l
	9zh/byOLx+WzpR6bVnWyeex8aOmxeUm9x+6bDWwefVtWMXp83iQXwBnFZZOSmpNZllqkb5fA
	lTH96Qmmgl3aFVO2NbI0MK5U7mLk5JAQMJF4fHcPWxcjF4eQwG5GiTWPv7JDJMQlmq/9gLKF
	JVb+e84OUfSRUWLF0flADgcHm4CmxIXJpSA1IgJeEu1vZ4ENYha4ySixb/desGZhgUSJp7vf
	MoLYLAKqEr1/f7GA2LwCVhLNXT9YIBbIS8y89B2snhMo/n3GbmaQ+UIClhKNC+IhygUlTs58
	AlbODFTevHU28wRGgVlIUrOQpBYwMq1ilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAiO
	Di3NHYzbV33QO8TIxMF4iFGCg1lJhJe30j1FiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPx
	QgLpiSWp2ampBalFMFkmDk6pBqautC0mvZeWvNEVf1V/7Pu/jJMLlt6+ey00b7EEz/2y3qZV
	B/MrT5vPLDzxsVR28gKT5RuunXpVd23G7pqllQV30nYbeCR9spzl7TTX/8XyCFfJHSbOtVyX
	DXu0fza9/F+1I2/TFV7pG6W519iK3IqeFa0Tvrpj3vvERtlVM+5ocqZEy/ZuiN1zTzJvvlJL
	eMJW+STu5U+fuIlcds87NOXKq4k5NZwPZid5uN0SCnXOYGbbaLiJY+0D+927O35Jub1lPd45
	Uf3cgpwVEyc/3TI3duFLsffxTbUfXyRdiauw/sfcmL2AffMcXy876xNb9/wP5QvtmTPt8d4j
	O2JnX1S7JX6E/8jiTO7NJXV2UyemKbEUZyQaajEXFScCAE8v+f79AgAA
X-CMS-MailID: 20230429094257epcas5p463574920bba26cd219275e57c2063d85
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230429094257epcas5p463574920bba26cd219275e57c2063d85
References: <20230429093925.133327-1-joshi.k@samsung.com>
	<CGME20230429094257epcas5p463574920bba26cd219275e57c2063d85@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230429_024302_365678_40D6E3E3 
X-CRM114-Status: GOOD (  22.05  )
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

If IORING_URING_CMD_DIRECT flag is set, get the registered qid and
- submit the io_uring command via mq_ops->queue_uring_cmd.
- complete it via mq_ops->poll_uring_cmd.

If the command could not be submitted this way due to any reason,
abstract it and fallback to old way of submission.
This keeps IORING_URING_CMD_DIRECT flag advisory.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/ioctl.c | 105 +++++++++++++++++++++++++++++++++-----
 drivers/nvme/host/nvme.h  |   4 ++
 2 files changed, 97 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 18f4f20f5e76..df86fb4f132b 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -653,6 +653,23 @@ static bool is_ctrl_ioctl(unsigned int cmd)
 	return false;
 }
 
+static int nvme_uring_cmd_io_direct(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+		struct io_uring_cmd *ioucmd, unsigned int issue_flags)
+{
+	struct request_queue *q = ns ? ns->queue : ctrl->admin_q;
+	int qid = io_uring_cmd_import_qid(ioucmd);
+	struct nvme_uring_direct_pdu *pdu =
+		(struct nvme_uring_direct_pdu *)&ioucmd->pdu;
+
+	if ((issue_flags & IO_URING_F_IOPOLL) != IO_URING_F_IOPOLL)
+		return -EOPNOTSUPP;
+
+	pdu->ns = ns;
+	if (q->mq_ops && q->mq_ops->queue_uring_cmd)
+		return q->mq_ops->queue_uring_cmd(ioucmd, qid);
+	return -EOPNOTSUPP;
+}
+
 static int nvme_ctrl_ioctl(struct nvme_ctrl *ctrl, unsigned int cmd,
 		void __user *argp, fmode_t mode)
 {
@@ -763,6 +780,14 @@ static int nvme_ns_uring_cmd(struct nvme_ns *ns, struct io_uring_cmd *ioucmd,
 
 	switch (ioucmd->cmd_op) {
 	case NVME_URING_CMD_IO:
+		if (ioucmd->flags & IORING_URING_CMD_DIRECT) {
+			ret = nvme_uring_cmd_io_direct(ctrl, ns, ioucmd,
+					issue_flags);
+			if (ret == -EIOCBQUEUED)
+				return ret;
+			/* in case of any error, just fallback */
+			ioucmd->flags &= ~(IORING_URING_CMD_DIRECT);
+		}
 		ret = nvme_uring_cmd_io(ctrl, ns, ioucmd, issue_flags, false);
 		break;
 	case NVME_URING_CMD_IO_VEC:
@@ -783,6 +808,38 @@ int nvme_ns_chr_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags)
 	return nvme_ns_uring_cmd(ns, ioucmd, issue_flags);
 }
 
+/* similar to blk_mq_poll; may be possible to unify */
+int nvme_uring_cmd_iopoll_qid(struct request_queue *q,
+				 struct io_uring_cmd *ioucmd, int qid,
+				 struct io_comp_batch *iob,
+				 unsigned int flags)
+{
+	long state = get_current_state();
+	int ret;
+
+	if (!(q->mq_ops && q->mq_ops->poll_uring_cmd))
+		return 0;
+	do {
+		ret = q->mq_ops->poll_uring_cmd(ioucmd, qid, iob);
+		if (ret > 0) {
+			__set_current_state(TASK_RUNNING);
+			return ret;
+		}
+		if (signal_pending_state(state, current))
+			__set_current_state(TASK_RUNNING);
+		if (task_is_running(current))
+			return 1;
+
+		if (ret < 0 || (flags & BLK_POLL_ONESHOT))
+			break;
+		cpu_relax();
+
+	} while (!need_resched());
+
+	__set_current_state(TASK_RUNNING);
+	return 0;
+}
+
 int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd,
 				 struct io_comp_batch *iob,
 				 unsigned int poll_flags)
@@ -792,14 +849,26 @@ int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd,
 	struct nvme_ns *ns;
 	struct request_queue *q;
 
-	rcu_read_lock();
-	bio = READ_ONCE(ioucmd->cookie);
 	ns = container_of(file_inode(ioucmd->file)->i_cdev,
 			struct nvme_ns, cdev);
 	q = ns->queue;
-	if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio && bio->bi_bdev)
-		ret = bio_poll(bio, iob, poll_flags);
-	rcu_read_unlock();
+	if (!(ioucmd->flags & IORING_URING_CMD_DIRECT)) {
+		rcu_read_lock();
+		bio = READ_ONCE(ioucmd->cookie);
+		if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio && bio->bi_bdev)
+			ret = bio_poll(bio, iob, poll_flags);
+
+		rcu_read_unlock();
+	} else {
+		int qid = io_uring_cmd_import_qid(ioucmd);
+
+		if (qid <= 0)
+			return 0;
+		if (!percpu_ref_tryget(&q->q_usage_counter))
+			return 0;
+		ret = nvme_uring_cmd_iopoll_qid(q, ioucmd, qid, iob, poll_flags);
+		percpu_ref_put(&q->q_usage_counter);
+	}
 	return ret;
 }
 #ifdef CONFIG_NVME_MULTIPATH
@@ -952,13 +1021,25 @@ int nvme_ns_head_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd,
 	struct request_queue *q;
 
 	if (ns) {
-		rcu_read_lock();
-		bio = READ_ONCE(ioucmd->cookie);
-		q = ns->queue;
-		if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio
-				&& bio->bi_bdev)
-			ret = bio_poll(bio, iob, poll_flags);
-		rcu_read_unlock();
+		if (!(ioucmd->flags & IORING_URING_CMD_DIRECT)) {
+			rcu_read_lock();
+			bio = READ_ONCE(ioucmd->cookie);
+			q = ns->queue;
+			if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio
+					&& bio->bi_bdev)
+				ret = bio_poll(bio, iob, poll_flags);
+			rcu_read_unlock();
+		} else {
+			int qid = io_uring_cmd_import_qid(ioucmd);
+
+			if (qid <= 0)
+				return 0;
+			if (!percpu_ref_tryget(&q->q_usage_counter))
+				return 0;
+			ret = nvme_uring_cmd_iopoll_qid(q, ioucmd, qid, iob,
+							poll_flags);
+			percpu_ref_put(&q->q_usage_counter);
+		}
 	}
 	srcu_read_unlock(&head->srcu, srcu_idx);
 	return ret;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 4eb45afc9484..2fd4432fbe12 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -176,6 +176,10 @@ struct nvme_uring_data {
 	__u32	timeout_ms;
 };
 
+struct nvme_uring_direct_pdu {
+	struct nvme_ns *ns;
+};
+
 /*
  * Mark a bio as coming in through the mpath node.
  */
-- 
2.25.1


