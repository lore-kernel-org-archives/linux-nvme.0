Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512B5C53219
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2026 13:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h1J61ILnqKKg4VDJZwonm7SffZoPsDiIrYk3lN8zRX8=; b=rs7ZLEt2pK+daviV+YJKKe9WFJ
	ngcyCqk501U+ELSuMta+Wq5jQ0ZiumWZVAbqgkf0LPqOZeprCzNLMrnanGQpxac0745eIBc/XIMat
	ZrH2dAQep6qgueiECpAZHMg9V+mkEtORalpevkJp0hV4fIvpJ1fqbCkaNkPzurwt6zkuJwHb4MIhM
	pNH3b3RJ14IODa7c3iLY2Awn5sEa0EnutX5YwVkixx/xG6m0dqm+oa+CDAv4NhP0kE3MAkr1jbvDb
	FxzRSWHeZ3s+0rFp1l016gXEyAru+7dR8Q9UVLjfeppHcvt9mWXAqGxV6QzMuupEGL9xoDTyCxlUc
	yH3InJFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woi56-00000005Nbg-0k6n;
	Tue, 28 Jul 2026 13:42:52 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woi53-00000005Nax-3cYm
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jul 2026 13:42:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785246166; h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
	bh=h1J61ILnqKKg4VDJZwonm7SffZoPsDiIrYk3lN8zRX8=;
	b=N02KzQYBikp8lJAu9KUnah8NmzfTIPDqkFNIJs6D/xFv531L1+eTVV/5O2GeOp5nwoCLJcsv1tRZbm4V0rAgHCHH9jZhUWNPT+Rx56BVCQhvCGEN2Wn5d8nS0xo2+LAWm38USc5eQW2fB1b5b6WLhBkFJP6aB5mL3VtnHd9Pk6U=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=zhengrong_li@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X8.BRXT_1785246160;
Received: from U-92DF4J33-2338.local(mailfrom:zhengrong_li@linux.alibaba.com fp:SMTPD_---0X8.BRXT_1785246160 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 28 Jul 2026 21:42:45 +0800
From: Zhengrong Li <zhengrong_li@linux.alibaba.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, mlombard@arkamax.eu,
 kanie@linux.alibaba.com, zhengrong_li@linux.alibaba.com
Subject: [PATCH v3] nvmet: fix Reservation Register Replace for unregistered
 host with IEKEY
Date: Tue, 28 Jul 2026 16:26:01 +0800
Message-ID: <178524603690.41557.6564455796105179416@linux.alibaba.com>
In-Reply-To: <178521959386.52051.17173420094473200063@linux.alibaba.com>
References: <178521959386.52051.17173420094473200063@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_064250_094327_B7A04A0D 
X-CRM114-Status: GOOD (  14.93  )
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
Reservation Conflict.

The NVMe specification states:

  "A host may replace its reservation key without regard to its
   registration status or current reservation key value by setting
   the Ignore Existing Key (IEKEY) bit to '1' in the Reservation
   Register command."

Fix nvmet_pr_replace() to add a new registrant when the host is not
found in the registrant list and IEKEY is set with a non-zero NRKEY.
If IEKEY is set but NRKEY is zero, return Invalid Field since there
is no valid reservation key to register.

Tested with nvme-cli against nvmet-tcp:

  # no prior registration
  nvme resv-register /dev/nvmeXn1 -n 1 --rrega=2 --iekey --nrkey=0x9999

  Before: RESERVATION_CONFLICT (0x4083)
  After:  success, registrant created with rkey 0x9999

Fixes: 5a47c2080a73 ("nvmet: support reservation feature")
Signed-off-by: Zhengrong Li <zhengrong_li@linux.alibaba.com>
---
Changes since v2:
 - Quote the NVMe specification instead of referencing SPDK (Guixin).
 - Add the Fixes tag (Guixin).
 - Return NVME_SC_INVALID_FIELD when IEKEY is set but NRKEY is zero
   for an unregistered host (Guixin).
 - Allocate the new registrant before taking pr_sem and free it if
   unused (Guixin).
---
 drivers/nvme/target/pr.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
index c71ae46244ff..61fafc08297b 100644
--- a/drivers/nvme/target/pr.c
+++ b/drivers/nvme/target/pr.c
@@ -355,12 +355,20 @@ static u16 nvmet_pr_replace(struct nvmet_req *req,
 	u16 status = NVME_SC_RESERVATION_CONFLICT | NVME_STATUS_DNR;
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvmet_pr *pr = &req->ns->pr;
-	struct nvmet_pr_registrant *reg;
+	struct nvmet_pr_registrant *reg, *new = NULL;
 	u64 nrkey = le64_to_cpu(d->nrkey);
+	bool found = false;
+
+	if (ignore_key && nrkey) {
+		new = kzalloc_obj(*new);
+		if (!new)
+			return NVME_SC_INTERNAL;
+	}
 
 	down(&pr->pr_sem);
 	list_for_each_entry_rcu(reg, &pr->registrant_list, entry) {
 		if (uuid_equal(&reg->hostid, &ctrl->hostid)) {
+			found = true;
 			if (ignore_key || reg->rkey == le64_to_cpu(d->crkey))
 				status = nvmet_pr_update_reg_attr(pr, reg,
 						nvmet_pr_update_reg_rkey,
@@ -368,7 +376,23 @@ static u16 nvmet_pr_replace(struct nvmet_req *req,
 			break;
 		}
 	}
+
+	if (!found && ignore_key) {
+		if (!nrkey) {
+			status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+			goto out;
+		}
+		INIT_LIST_HEAD(&new->entry);
+		new->rkey = nrkey;
+		uuid_copy(&new->hostid, &ctrl->hostid);
+		list_add_tail_rcu(&new->entry, &pr->registrant_list);
+		status = NVME_SC_SUCCESS;
+		new = NULL;
+	}
+
+out:
 	up(&pr->pr_sem);
+	kfree(new);
 	return status;
 }
 
-- 
2.43.0


