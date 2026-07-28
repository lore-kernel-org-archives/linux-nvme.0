Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425E8C53219
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2026 08:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TneiM6e6RDL0JyuSfZuZzm00PxSYV11FeCR168lVPu8=; b=RMyF4XlI7DXrdNGGZa9JAl9yc9
	kJy2xzn8Srk8CIBQqeoy8/P6xqoADqSJQ2bd8e7Sk0FhykZLmbCJws4VG0eyEoA1z050+kShGnOPG
	m7WPajG0lUIdIX3a+XPhxrOJY3afzMKEiyG8M2XbGzK1+Pw37PBUQIauDX3vD5sObvH0xeKEaoQx+
	eyKwczAW7q+qgFv3nlV+f5NeFsgSnG8xl82RgwzCep76csaw9mPBlR2uIjRWuqzqCYH65S6Dg8XUl
	JdPIaEl0vhzQ2kEPtdd+4bU/T3V4F6tMSjZkDoP21qgjqdmQ5BUK2pvpmMrbjVMUQW/rH1ssiYuz8
	1iYJeWww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wodY1-00000004kkx-2gjt;
	Tue, 28 Jul 2026 08:52:25 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wodXv-00000004kkL-1BMP
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jul 2026 08:52:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785228736; h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
	bh=TneiM6e6RDL0JyuSfZuZzm00PxSYV11FeCR168lVPu8=;
	b=BdRDVMOujZ61iSri794LhLJJFRE23l7GhdGOhlLGP2NiUOP596GkZa9nfKOp/H7gZnRRoCVIiZmlqu360FzaSF+QmKNhcXafstcKx0AcgrRzqjaDWyMBUf3OEVpToM63zRNBEB+mmzOH3H5fydcLNnMuqfD16piFtLOwQliAC54=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=zhengrong_li@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X8-F-2u_1785228728;
Received: from U-92DF4J33-2338.local(mailfrom:zhengrong_li@linux.alibaba.com fp:SMTPD_---0X8-F-2u_1785228728 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 28 Jul 2026 16:52:14 +0800
From: Zhengrong Li <zhengrong_li@linux.alibaba.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, mlombard@arkamax.eu,
 zhengrong_li@linux.alibaba.com
Subject: [PATCH v2] nvmet: fix Reservation Register Replace for unregistered
 host with IEKEY
Date: Tue, 28 Jul 2026 16:26:01 +0800
Message-ID: <178522866228.3074.13245921492128352379@linux.alibaba.com>
In-Reply-To: <178521959386.52051.17173420094473200063@linux.alibaba.com>
References: <178521959386.52051.17173420094473200063@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_015221_061888_A8295F03 
X-CRM114-Status: GOOD (  12.70  )
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

When a host sends a Reservation Register command with RREGA=Replace
and IEKEY=1 without being previously registered, nvmet returns
Reservation Conflict.  SPDK accepts this combination and creates a
new registrant with the provided NRKEY, with an explicit unit test
covering this scenario (test/unit/lib/nvmf/subsystem.c).

Fix nvmet_pr_replace() to add a new registrant when the host is not
found in the registrant list and IEKEY is set with a non-zero NRKEY,
consistent with SPDK's behavior.

Tested with nvme-cli against nvmet-tcp:

  # no prior registration
  nvme resv-register /dev/nvmeXn1 -n 1 --rrega=2 --iekey --nrkey=0x9999

  Before: RESERVATION_CONFLICT (0x4083)
  After:  success, registrant created with rkey 0x9999

Signed-off-by: Zhengrong Li <zhengrong_li@linux.alibaba.com>
---
Changes since v1:
 - Use kzalloc_obj() instead of kmalloc_obj() + memset() (Maurizio).
---
 drivers/nvme/target/pr.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
index c71ae46244ff..944e3d3947d0 100644
--- a/drivers/nvme/target/pr.c
+++ b/drivers/nvme/target/pr.c
@@ -355,12 +355,14 @@ static u16 nvmet_pr_replace(struct nvmet_req *req,
 	u16 status = NVME_SC_RESERVATION_CONFLICT | NVME_STATUS_DNR;
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmet_pr *pr = &req->ns->pr;
-	struct nvmet_pr_registrant *reg;
+	struct nvmet_pr_registrant *reg, *new;
 	u64 nrkey = le64_to_cpu(d->nrkey);
+	bool found = false;
 
 	down(&pr->pr_sem);
 	list_for_each_entry_rcu(reg, &pr->registrant_list, entry) {
 		if (uuid_equal(&reg->hostid, &ctrl->hostid)) {
+			found = true;
 			if (ignore_key || reg->rkey == le64_to_cpu(d->crkey))
 				status = nvmet_pr_update_reg_attr(pr, reg,
 						nvmet_pr_update_reg_rkey,
@@ -368,6 +370,21 @@ static u16 nvmet_pr_replace(struct nvmet_req *req,
 			break;
 		}
 	}
+
+	if (!found && ignore_key && nrkey) {
+		new = kzalloc_obj(*new);
+		if (!new) {
+			status = NVME_SC_INTERNAL;
+			goto out;
+		}
+		INIT_LIST_HEAD(&new->entry);
+		new->rkey = nrkey;
+		uuid_copy(&new->hostid, &ctrl->hostid);
+		list_add_tail_rcu(&new->entry, &pr->registrant_list);
+		status = NVME_SC_SUCCESS;
+	}
+
+out:
 	up(&pr->pr_sem);
 	return status;
 }
-- 
2.43.0


