Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87450C61DB9
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2026 10:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HwZef8uP2UTUP7F0y7cm1P/PWSmNKyGYhqNY1iNiwGw=; b=ERZPPvIoksOCQloYDM0rOodspV
	XElYtq687Sd2juaTe2fnwW9YARRBNBBoLDH7MnevxhQErYJOLQ2IoFs8UgXX+lckIYccJ1i36SGix
	Ae8PB5uNm5hXYmJP+5iDbNMdAgH+HliJXOcSC5OA1BqmtO7+86o4noc07SLketO2pOd/mxc3ZFDSk
	I101YjqMwDAKuygjUtqKd6J3GOjYNj2ncUOOjxhd6R/t3Z7ZQCW2a6BCUjYdTBXiaDCwyztNFLQvg
	+GkhsF4X4bbR8ps7m2BY5chs1zMvcpxIsBuCHLBLWckrpjMtsNyJ5DUEw7e9vEcPPEAy4SPwds9Vf
	fYqPboeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzX7a-00000003oBk-2hpK;
	Thu, 27 Aug 2026 10:14:10 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzX7X-00000003o9l-0CDn
	for linux-nvme@lists.infradead.org;
	Thu, 27 Aug 2026 10:14:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787825641; h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
	bh=HwZef8uP2UTUP7F0y7cm1P/PWSmNKyGYhqNY1iNiwGw=;
	b=JDvdav4q7CJgTy2NyrNvB3bCJHYDp9E5b11GTuw83ZZd8nI+ilkwdUDM8JvBiVEsp+LpHhqk2PGkQcQYl8G/a2fxeflE1C59br0D1G4zlcR8EYeYeA+Ulg2xl6HcCoH0dSl1R5lA8qJEbaRnaWKjYWdcN9ktqPq3aU3bRdbsbAg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=chuyf26@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X9jIJuB_1787825640;
Received: from x31j07255.sqa.na131(mailfrom:Chuyf26@linux.alibaba.com fp:SMTPD_---0X9jIJuB_1787825640 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 27 Aug 2026 18:14:00 +0800
From: Yifei Chu <Chuyf26@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Subject: [PATCH v2] nvmet: verify the hostid when looking up a controller
Date: Thu, 27 Aug 2026 18:12:12 +0800
Message-ID: <178782553270.1581249.13595405857993482779@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260827_031407_249175_A080745F 
X-CRM114-Status: GOOD (  15.08  )
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

nvmet_ctrl_find_get() matches controllers by cntlid and hostnqn only.
The connect data also carries the connecting host's hostid, but it is
never compared against the hostid the controller was created with, so
the lookup can return a controller whose recorded hostid differs.

Controller IDs are allocated sequentially and easy to guess, and
nothing prevents two hosts from using the same hostnqn (misconfigured
clones, or a reinstalled host whose controller still exists). Such a
host currently attaches its queues to the other host's controller and
shares its controller state with it. Also require the hostid from the
connect data to match the controller's hostid so that the lookup is
bound to the identity the controller was created with.

Controllers that were created without a hostid keep the old behaviour.

Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
Reported-by: Abaci <abaci@linux.alibaba.com>
Assisted-by: abaci:qwen3.8-max
Signed-off-by: Yifei Chu <Chuyf26@linux.alibaba.com>
---
v2: reword the changelog as a correctness fix instead of a security
    fix, the hostid is not a secret either (Sagi).
    Previous thread:
    https://lore.kernel.org/all/178707054946.2644927.16076495238405774277@lin=
ux.alibaba.com/

 drivers/nvme/target/core.c        | 12 ++++++++++++
 drivers/nvme/target/fabrics-cmd.c |  2 +-
 drivers/nvme/target/nvmet.h       |  1 +
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index d74c01c..f1eb5cc 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1471,6 +1471,7 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
=20
 struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
 				       const char *hostnqn, u16 cntlid,
+				       const uuid_t *hostid,
 				       struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl =3D NULL;
@@ -1491,6 +1492,17 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(const char *sub=
sysnqn,
 				pr_warn("hostnqn mismatch.\n");
 				continue;
 			}
+			/*
+			 * Also require the hostid from the connect data to
+			 * match the hostid the controller was created with.
+			 * Accept a nil hostid only if the controller was
+			 * created without one.
+			 */
+			if (!uuid_is_null(&ctrl->hostid) &&
+			    !uuid_equal(&ctrl->hostid, hostid)) {
+				pr_warn("hostid mismatch.\n");
+				continue;
+			}
 			if (!kref_get_unless_zero(&ctrl->ref))
 				continue;
=20
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-=
cmd.c
index 42d1d18..5e2487d 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -364,7 +364,7 @@ static void nvmet_execute_io_connect(struct nvmet_req *re=
q)
 	d->subsysnqn[NVMF_NQN_FIELD_LEN - 1] =3D '\0';
 	d->hostnqn[NVMF_NQN_FIELD_LEN - 1] =3D '\0';
 	ctrl =3D nvmet_ctrl_find_get(d->subsysnqn, d->hostnqn,
-				   le16_to_cpu(d->cntlid), req);
+				   le16_to_cpu(d->cntlid), &d->hostid, req);
 	if (!ctrl) {
 		status =3D NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
 		goto out;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index e362d79..52ea4c7 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -623,6 +623,7 @@ struct nvmet_alloc_ctrl_args {
 struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args);
 struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
 				       const char *hostnqn, u16 cntlid,
+				       const uuid_t *hostid,
 				       struct nvmet_req *req);
 void nvmet_ctrl_put(struct nvmet_ctrl *ctrl);
 u16 nvmet_check_ctrl_status(struct nvmet_req *req);
--=20
2.43.5

