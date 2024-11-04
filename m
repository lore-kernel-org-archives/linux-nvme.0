Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C1FE677F9
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2024 08:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TDWuylvMnkoAXjPlzxx1kq8I/psHAwqv4n6/K0AAhoo=; b=kQ45EAm9b+iJU3MwtMlHNnOSMH
	Rn8i7Zxv5EY1QNixTfC5UZMzia+hjTEaEQoBP8bYo7u7gDqUJ3TWXmwxrmMbDO2zyBdw26HziVq3i
	LP15l/lebWsrPJ5XNn7c0LtByT/jf7mpXAQEu8sHvbgCWhVAHfayazRhcyPQ1SQqxzH+tbjlf7UkR
	MR0t5fm7Rp4CQcw/W+i1gXq+xcWre2TtOEVXCNreRlqi4GUTgSFFxCxEEy6ona6ReBHeVZYBH+XUM
	Qik3L0PVnzKpTYhI+ie3mafVux1Kyu7wJEE/BSR+v0x7Yo8D7jzyzUr/xt5yWrNE9aeTojsfCcA/c
	i8LTm36Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7ssq-0000000D2iA-2mT3;
	Mon, 04 Nov 2024 08:56:24 +0000
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7ssG-0000000D2VY-2Dt2
	for linux-nvme@lists.infradead.org;
	Mon, 04 Nov 2024 08:55:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730710546; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=TDWuylvMnkoAXjPlzxx1kq8I/psHAwqv4n6/K0AAhoo=;
	b=V6UF1hGOSSgEC9sVo6JcR2Ug56CUErZugIeOVX5zIPip6HlMNXdiykUgVcfOFcN4NQPr12P+lIS4hbzRCvSn4WfD4VRq1CjD6dp/uL8rmLlfoCaBPounYOYSNCT4K/ENvFeN0D9JdGMRx00toWc8mxJZjoCeVZeivnDaybIy3c4=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WIe2aWn_1730710540 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 04 Nov 2024 16:55:45 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH RFC 3/3] nvmet: report ns's vwc not present
Date: Mon,  4 Nov 2024 16:55:02 +0800
Message-ID: <20241104085524.118221-4-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104085524.118221-1-kanie@linux.alibaba.com>
References: <20241104085524.118221-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_005548_750711_22536315 
X-CRM114-Status: GOOD (  10.56  )
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

Currently, we report that controller has vwc even though the ns may
not have vwc. Report ns's vwc not present when not buffered_io or
backdev doesn't have vwc.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/admin-cmd.c | 36 +++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 081f0473cd9e..dffb84f560ad 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -685,6 +685,39 @@ static void nvmet_execute_identify_ctrl_nvm(struct nvmet_req *req)
 		   nvmet_zero_sgl(req, 0, sizeof(struct nvme_id_ctrl_nvm)));
 }
 
+static void nvmet_execute_identify_cs_indep(struct nvmet_req *req)
+{
+	struct nvme_id_ns_cs_indep *id;
+	u16 status;
+
+	status = nvmet_req_find_ns(req);
+	if (status)
+		goto out;
+
+	id = kzalloc(sizeof(*id), GFP_KERNEL);
+	if (!id) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	if ((req->ns->file && !req->ns->buffered_io) ||
+	    (req->ns->bdev && !bdev_write_cache(req->ns->bdev)))
+		id->nsfeat |= NVME_NS_VWC_NOT_PRESENT;
+
+	id->nmic |= NVME_NS_NMIC_SHARED;
+	///TODO: report reservation supported when that patch applied.
+	id->anagrpid = cpu_to_le32(req->ns->anagrpid);
+
+	if (req->ns->readonly)
+		id->nsattr |= NVME_NS_ATTR_RO;
+	id->nstat = NVME_NSTAT_NRDY;
+
+	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
+	kfree(id);
+out:
+	nvmet_req_complete(req, status);
+}
+
 static void nvmet_execute_identify(struct nvmet_req *req)
 {
 	if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
@@ -729,6 +762,9 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 			break;
 		}
 		break;
+	case NVME_ID_CNS_NS_CS_INDEP:
+		nvmet_execute_identify_cs_indep(req);
+		return;
 	}
 
 	pr_debug("unhandled identify cns %d on qid %d\n",
-- 
2.43.0


