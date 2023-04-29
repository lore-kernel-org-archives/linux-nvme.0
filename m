Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3E3C77B60
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Apr 2023 09:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j3RUN5D5cpuMgVbInnVIvXQH9V/4ewHPlZPhTRvKD5s=; b=gWmTAToPg+kkozmPmYz+V6BQQO
	hnFOHEPP0mJXv2ecYZN3OL+zkrmceC9Z76hYnloIRKp4WQ9M9sQZ6kCP7hJmN7rlsaYQKYVSuvW8x
	x609UMOQZyzmnm/D1aj4nYviI8rafitGT3nliRhWHcMSmKo1NsVKg/qDl1DlW3XggPebEJwJVO/of
	wyVAwOR3zEDZudJ0agRt6kCuwqj6vbMKqivcuYVCN0qTbXMd7n1qcUIAihCSFOm0kd8CZ0IubzyGD
	v0P2zTlJ9DhWRmRds+yMOD+aIFC/CEj88TUmbTXDDChKu3XpHBmhUgmtM5VYA1QeJCd8io2YvBtel
	+Re54K2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1psh6V-00CTro-24;
	Sat, 29 Apr 2023 09:42:56 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1psh6R-00CTpN-3B
	for linux-nvme@lists.infradead.org;
	Sat, 29 Apr 2023 09:42:53 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230429094250epoutp035e7e1697b350140ac902edd56a3c533b~aXozpSo1r2943429434epoutp03t
	for <linux-nvme@lists.infradead.org>; Sat, 29 Apr 2023 09:42:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230429094250epoutp035e7e1697b350140ac902edd56a3c533b~aXozpSo1r2943429434epoutp03t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1682761370;
	bh=j3RUN5D5cpuMgVbInnVIvXQH9V/4ewHPlZPhTRvKD5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vAXsULS9IJXjdp6dVdsU7pY9QucKNYevMPj3Duxc/TQcBbnqnT4536B2JafLdl9Ri
	 vEbw4LXJLs+XqztTzUCqneBmGyRw8lNinBdyjszX8ZTdr4iNQPMA6MSSBtENIG3U3F
	 hQ68siPLOQ2VoIVBbNRvpIL8B6YXlLQi4SC+fpiM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20230429094249epcas5p1857244999a0b36c8f611849df577d598~aXoy8tr851040910409epcas5p1q;
	Sat, 29 Apr 2023 09:42:49 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Q7kzX1cX6z4x9Pq; Sat, 29 Apr
	2023 09:42:48 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D0.7C.54880.896EC446; Sat, 29 Apr 2023 18:42:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20230429094247epcas5p333e0f515000de60fb64dc2590cf9fcd8~aXoxThIqq2931829318epcas5p3l;
	Sat, 29 Apr 2023 09:42:47 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230429094247epsmtrp104154e422aebf5b2f558085e93778bda~aXoxSxzyo0376803768epsmtrp1t;
	Sat, 29 Apr 2023 09:42:47 +0000 (GMT)
X-AuditID: b6c32a49-8c5ff7000001d660-8c-644ce6986599
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	73.29.28392.796EC446; Sat, 29 Apr 2023 18:42:47 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230429094245epsmtip2cde3811e2454169712d6ee8949816689~aXovlzz5Z0703907039epsmtip2S;
	Sat, 29 Apr 2023 09:42:45 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kbusch@kernel.org
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, anuj1072538@gmail.com,
	xiaoguang.wang@linux.alibaba.com, Anuj Gupta <anuj20.g@samsung.com>, Kanchan
	Joshi <joshi.k@samsung.com>
Subject: [RFC PATCH 05/12] nvme: wire-up register/unregister queue f_op
 callback
Date: Sat, 29 Apr 2023 15:09:18 +0530
Message-Id: <20230429093925.133327-6-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230429093925.133327-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmuu6MZz4pBn1TOCw+fv3NYtE04S+z
	xeq7/WwWNw/sZLJYufook8W71nMsFkf/v2WzmHToGqPF3lvaFvOXPWW3WPf6PYvFpr8nmRx4
	PHbOusvucf7eRhaPy2dLPTat6mTz2PnQ0mPzknqP3Tcb2Dz6tqxi9Pi8SS6AMyrbJiM1MSW1
	SCE1Lzk/JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoXiWFssScUqBQQGJx
	sZK+nU1RfmlJqkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsbkaUEFk9Uq
	rnzdyd7AOE+hi5GTQ0LARGLrh1ZmEFtIYDejxN0NRl2MXED2J0aJd/fOM0E4nxklpnx6wQ7T
	sfJkDxtEYhejxNybT5jhqk78v87axcjBwSagKXFhcilIg4iAi0TT2qlgDcwC3xglmnbPZQGp
	ERYIkuiZIQtSwyKgKnF65xEmEJtXwFJi1d+DzBDL5CVmXvoOtphTwEri+4zdzBA1ghInZz5h
	AbGZgWqat86Gql/KIfH7kRCE7SKxouMVG4QtLPHq+BaoB6QkXva3QdnJEpdmnmOCsEskHu85
	CGXbS7Se6mcGOZMZ6JX1u/QhVvFJ9P5+wgQSlhDglehog9qkKHFv0lNWCFtc4uGMJVC2h8Sj
	N6ugQdXLKLFg6yH2CYzys5B8MAvJB7MQti1gZF7FKJlaUJybnlpsWmCYl1oOj9Xk/NxNjOA0
	q+W5g/Hugw96hxiZOBgPMUpwMCuJ8PJWuqcI8aYkVlalFuXHF5XmpBYfYjQFBvFEZinR5Hxg
	os8riTc0sTQwMTMzM7E0NjNUEudVtz2ZLCSQnliSmp2aWpBaBNPHxMEp1cCUt+f0pmWbH+/y
	TQkL/T/zR7HJO919O6xiD+wqFnkX9HmtgnbAnNj1XQu/ltSWHYh5t8Tc37hQ/r2/35qy4ryz
	4o9kpnedXffN+pCNdEF4USj7fmP/xfEXNtpPMDP8eaRr3cMTD3lbIl+4a+++XqnPO7n+yZmZ
	XreqtFcra9znNrn1sFWuPfDNno3VraofhJz+XKs6dKXnUf1+rsYbzLydbm9PvT2Z7Olk6Py9
	XUzy7tNzMZeaXxxhWfD49tUt4ff8Z0VqLe5bqH5+x/x1xippFTeB/lk2l8Uv/bbJb8t/nDYP
	VQP+LLd3O2er997/ocWkm3sbNR/OW/BBbU/0wrNpjTzTzKZlO2RuPZn2QZNZiaU4I9FQi7mo
	OBEA9oMVuzwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsWy7bCSvO70Zz4pBts/S1l8/PqbxaJpwl9m
	i9V3+9ksbh7YyWSxcvVRJot3redYLI7+f8tmMenQNUaLvbe0LeYve8puse71exaLTX9PMjnw
	eOycdZfd4/y9jSwel8+Wemxa1cnmsfOhpcfmJfUeu282sHn0bVnF6PF5k1wAZxSXTUpqTmZZ
	apG+XQJXxuRpQQWT1SqufN3J3sA4T6GLkZNDQsBEYuXJHjYQW0hgB6PEsytKEHFxieZrP9gh
	bGGJlf+eA9lcQDUfGSU2PjzP2MXIwcEmoClxYXIpSI2IgJdE+9tZbCA1zAL/GCXef73MBFIj
	LBAgsbrfAaSGRUBV4vTOI0wgNq+ApcSqvweZIebLS8y89B1sF6eAlcT3GbuZQVqFgGoaF8RD
	lAtKnJz5hAXEZgYqb946m3kCo8AsJKlZSFILGJlWMUqmFhTnpucWGxYY5aWW6xUn5haX5qXr
	JefnbmIER4iW1g7GPas+6B1iZOJgPMQowcGsJMLLW+meIsSbklhZlVqUH19UmpNafIhRmoNF
	SZz3QtfJeCGB9MSS1OzU1ILUIpgsEwenVAMT53f57vnT3B+ah0SdXyV4dOKf4O3HK8qmC7vd
	duMUnyF2KSLpeNrE4olsglxX9r+Ot53KzP9Zg+fLI4MZ+9urRayOxrS9ZzLm+Xzuxj6rM/0L
	HPKeP37uVmQ3963kytfTOu2M7D6fPWd0TW/Nj0+zyyvu8C/8utyx7hPr6wNRdy1YDXevNFE/
	WeXvlHjPteOj5nMBh1/+98pXuV6adrD4A+O9h0uDuZi2ye/kP5xnsGH+Rplq6YBPCXlLVsYL
	3zBNXZDWVhLb7Wz393/CvJuTUjYIPt3gPOuvrtqJpJ2PvsbvVXH+rDm7TSwm0r/aZIVA+kmp
	xsfbbbjkgi+82LLV8sbfw5OFs7MEJcryG1YbKLEUZyQaajEXFScCAGoRqoL/AgAA
X-CMS-MailID: 20230429094247epcas5p333e0f515000de60fb64dc2590cf9fcd8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230429094247epcas5p333e0f515000de60fb64dc2590cf9fcd8
References: <20230429093925.133327-1-joshi.k@samsung.com>
	<CGME20230429094247epcas5p333e0f515000de60fb64dc2590cf9fcd8@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230429_024252_347726_05310C95 
X-CRM114-Status: GOOD (  15.28  )
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

From: Anuj Gupta <anuj20.g@samsung.com>

Implement register/unregister handlers for char-device file.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/core.c      | 26 +++++++++++++++++++
 drivers/nvme/host/ioctl.c     | 48 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/multipath.c |  2 ++
 drivers/nvme/host/nvme.h      |  2 ++
 4 files changed, 78 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ba476c48d566..4462ce50d076 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4059,6 +4059,30 @@ static int nvme_ns_chr_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+int nvme_register_queue(struct file *file)
+{
+	struct nvme_ns *ns = container_of(file_inode(file)->i_cdev,
+			struct nvme_ns, cdev);
+	struct nvme_ctrl *ctrl = ns->ctrl;
+	struct request_queue *q = ns ? ns->queue : ctrl->admin_q;
+
+	if (q->mq_ops && q->mq_ops->register_queue)
+		return q->mq_ops->register_queue(ns);
+	return -EINVAL;
+}
+
+int nvme_unregister_queue(struct file *file, int qid)
+{
+	struct nvme_ns *ns = container_of(file_inode(file)->i_cdev,
+			struct nvme_ns, cdev);
+	struct nvme_ctrl *ctrl = ns->ctrl;
+	struct request_queue *q = ns ? ns->queue : ctrl->admin_q;
+
+	if (q->mq_ops && q->mq_ops->unregister_queue)
+		return q->mq_ops->unregister_queue(ns, qid);
+	return -EINVAL;
+}
+
 static const struct file_operations nvme_ns_chr_fops = {
 	.owner		= THIS_MODULE,
 	.open		= nvme_ns_chr_open,
@@ -4067,6 +4091,8 @@ static const struct file_operations nvme_ns_chr_fops = {
 	.compat_ioctl	= compat_ptr_ioctl,
 	.uring_cmd	= nvme_ns_chr_uring_cmd,
 	.uring_cmd_iopoll = nvme_ns_chr_uring_cmd_iopoll,
+	.register_queue	= nvme_register_queue,
+	.unregister_queue = nvme_unregister_queue,
 };
 
 static int nvme_add_ns_cdev(struct nvme_ns *ns)
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index d24ea2e05156..292a578686b6 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -871,6 +871,54 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
 	return ret;
 }
 
+int nvme_ns_head_register_queue(struct file *file)
+{
+	struct cdev *cdev = file_inode(file)->i_cdev;
+	struct nvme_ns_head *head =
+		container_of(cdev, struct nvme_ns_head, cdev);
+	struct nvme_ns *ns;
+	struct nvme_ctrl *ctrl;
+	struct request_queue *q;
+	int srcu_idx, ret = -EINVAL;
+
+	srcu_idx = srcu_read_lock(&head->srcu);
+	ns = nvme_find_path(head);
+	if (!ns)
+		goto out_unlock;
+
+	ctrl = ns->ctrl;
+	q = ns ? ns->queue : ctrl->admin_q;
+	if (q->mq_ops && q->mq_ops->register_queue)
+		ret = q->mq_ops->register_queue(ns);
+out_unlock:
+	srcu_read_unlock(&head->srcu, srcu_idx);
+	return ret;
+}
+
+int nvme_ns_head_unregister_queue(struct file *file, int qid)
+{
+	struct cdev *cdev = file_inode(file)->i_cdev;
+	struct nvme_ns_head *head =
+		container_of(cdev, struct nvme_ns_head, cdev);
+	struct nvme_ns *ns;
+	struct nvme_ctrl *ctrl;
+	struct request_queue *q;
+	int srcu_idx, ret = -EINVAL;
+
+	srcu_idx = srcu_read_lock(&head->srcu);
+	ns = nvme_find_path(head);
+	if (!ns)
+		goto out_unlock;
+
+	ctrl = ns->ctrl;
+	q = ns ? ns->queue : ctrl->admin_q;
+	if (q->mq_ops && q->mq_ops->unregister_queue)
+		ret = q->mq_ops->unregister_queue(ns, qid);
+out_unlock:
+	srcu_read_unlock(&head->srcu, srcu_idx);
+	return ret;
+}
+
 int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 		unsigned int issue_flags)
 {
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9171452e2f6d..eed30daf1a37 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -471,6 +471,8 @@ static const struct file_operations nvme_ns_head_chr_fops = {
 	.compat_ioctl	= compat_ptr_ioctl,
 	.uring_cmd	= nvme_ns_head_chr_uring_cmd,
 	.uring_cmd_iopoll = nvme_ns_head_chr_uring_cmd_iopoll,
+	.register_queue	= nvme_ns_head_register_queue,
+	.unregister_queue = nvme_ns_head_unregister_queue,
 };
 
 static int nvme_add_ns_head_cdev(struct nvme_ns_head *head)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 73992dc9dec7..4619a7498f8e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -843,6 +843,8 @@ int nvme_ns_head_ioctl(struct block_device *bdev, fmode_t mode,
 		unsigned int cmd, unsigned long arg);
 long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
 		unsigned long arg);
+int nvme_ns_head_register_queue(struct file *file);
+int nvme_ns_head_unregister_queue(struct file *file, int qid);
 long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 		unsigned long arg);
 int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd,
-- 
2.25.1


