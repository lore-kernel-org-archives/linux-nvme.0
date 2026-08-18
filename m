Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EF6C5DF7D
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2026 16:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=rjgW8LwK6mEJwA83Y/FDojebuJigf9Ue9Khgrnv6kbE=; b=3dgcxDmTDxxpbl
	/0NBSTgE/BVOSmhhHJCCblY6pGxS0pIQu5vBRCS2tFfxuIrg5n7Wedxk+eSiG0FdhM7S1YWdhxAVt
	zvm8QC51F/exMebJvvGIXSZPLycOWJzWJpT7aV4Ukmk4V6/De6i7qX8DSPFRF5KX8Acr4JGi1gJ66
	RQqSGejgvxIpLvp+61qoNaSejCxwi0w7T8DqiYo42ZqIapkPDtZqYvezIOjtobVSUf9DGRp9OgnF/
	RWbtb87c+1Bo1fn9wNLFQhJn5HJAvnQbr6J58kXM61U98QEnG6/1tFPIOzkmuBA0nO6HXY9OKqmQw
	Fv7urgOe97uqRB0nhFkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwMi4-00000008Lk2-3zvp;
	Tue, 18 Aug 2026 16:30:44 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwMi2-00000008Lj9-1XB3
	for linux-nvme@lists.infradead.org;
	Tue, 18 Aug 2026 16:30:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787070639; h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
	bh=rjgW8LwK6mEJwA83Y/FDojebuJigf9Ue9Khgrnv6kbE=;
	b=yE73pbX57Inl8Hat+HvNB2V3QhWXc3/j/ct710fgHKj+oeAWZIm2qYhcb3/M19wnMHJucYWwpia7mLsKgUsaZkoi52lBKSsaifyXPYToXSipAXA30x0wVW05ONmC6FWVZrUT8HsAb224Z2T7bIefnBxBLLOcrXGGrhDyEsjGQHw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=chuyf26@linux.alibaba.com;NM=1;PH=DS;RN=1;SR=0;TI=SMTPD_---0X9E5Cas_1787070638;
Received: from x31j07255.sqa.na131(mailfrom:Chuyf26@linux.alibaba.com fp:SMTPD_---0X9E5Cas_1787070638 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 00:30:39 +0800
From: Chuyf26 <Chuyf26@linux.alibaba.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: verify the hostid when looking up a controller
Date: Wed, 19 Aug 2026 00:29:09 +0800
Message-ID: <178707054946.2644927.16076495238405774277@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260818_093042_563066_5AF6EA8C 
X-CRM114-Status: GOOD (  15.18  )
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
The hostnqn is not a secret: any host that can reach the subsystem can
put an arbitrary NQN into its connect data.  A malicious host knowing
or guessing the NQN and controller ID of another host (controller IDs
are allocated sequentially) can therefore attach its queues to that
host's controller, issue commands on its behalf, or disturb its I/O by
tearing down the shared controller state.

The path is: an unauthenticated host sends a fabrics CONNECT command,
nvmet_execute_fabrics_connect() parses the connect data capsule and
hands subsysnqn, hostnqn and cntlid to nvmet_ctrl_find_get(), which
returns the first matching controller.  The connect data also carries
the host's hostid, but it is never compared.

Also require the hostid from the connect data to match the controller's
hostid.  The hostid identifies the host installation and is generated
locally, so it cannot be chosen by an attacker to impersonate another
host.  Controllers that were created without a hostid keep the old
behaviour.

Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
Reported-by: Abaci <abaci@linux.alibaba.com>
Assisted-by: abaci:qwen3.8-max
Signed-off-by: Chuyf26 <Chuyf26@linux.alibaba.com>
---
 drivers/nvme/target/core.c        | 12 ++++++++++++
 drivers/nvme/target/fabrics-cmd.c |  2 +-
 drivers/nvme/target/nvmet.h       |  1 +
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 7b6309d866be..64a5fa951bca 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1287,6 +1287,7 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
=20
 struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
 				       const char *hostnqn, u16 cntlid,
+				       const uuid_t *hostid,
 				       struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl =3D NULL;
@@ -1307,6 +1308,17 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(const char *sub=
sysnqn,
 				pr_warn("hostnqn mismatch.\n");
 				continue;
 			}
+			/* hostnqn alone does not identify a host: any host
+			 * able to connect to the subsystem can claim it.
+			 * Also require the hostid, which identifies the host
+			 * installation, to match.  Accept a nil hostid only
+			 * if the controller was created without one.
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
index e008f162ce68..9e0573b2aec9 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -311,7 +311,7 @@ static void nvmet_execute_io_connect(struct nvmet_req *re=
q)
 	d->subsysnqn[NVMF_NQN_FIELD_LEN - 1] =3D '\0';
 	d->hostnqn[NVMF_NQN_FIELD_LEN - 1] =3D '\0';
 	ctrl =3D nvmet_ctrl_find_get(d->subsysnqn, d->hostnqn,
-				   le16_to_cpu(d->cntlid), req);
+				   le16_to_cpu(d->cntlid), &d->hostid, req);
 	if (!ctrl) {
 		status =3D NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 		goto out;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 9aef41c26415..137860ec4b28 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -532,6 +532,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *h=
ostnqn,
 		uuid_t *hostid);
 struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
 				       const char *hostnqn, u16 cntlid,
+				       const uuid_t *hostid,
 				       struct nvmet_req *req);
 void nvmet_ctrl_put(struct nvmet_ctrl *ctrl);
 u16 nvmet_check_ctrl_status(struct nvmet_req *req);
--=20
2.43.5

