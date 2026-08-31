Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D76C61DE2
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2026 02:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hn2MpPKGdK7fW3YtkPww1djcK8cUXcA1I0LgLBoL6PE=; b=om8tDImBYC0zUxBlqff8w9dRz4
	UgAT8C2O2+Rv1uSa3I6RTmSAK8ZzrEK5xfu9rxC6lBSnkuzaQrxmb7i37sn9dsdUB5lXzbpa59J6c
	V9nB2mQkbegXZSr3x8ejsVUGVsDWF/9m++j8sYMyGvrcp+661sSFVCg0X7Sh9Chs5XICaM3ljhezc
	rSLdTjhkC4D4I9jtJUFZ4DHAnmXQs77fBuWuBOpvDgbHkBogZ1iUkpJcR7S3zOw+WsVT4fCMG2xgw
	ma0ovGiu7qm7iHUgTTgjotS0R77ZCStXbU+C0GFT3Ul1VJ2IDF9/HeSA0tYUVtNMX//DUh9oYX5Y6
	asgShLBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0rv6-00000008Mtw-2mRV;
	Mon, 31 Aug 2026 02:38:48 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0rv2-00000008Mt6-3g9e
	for linux-nvme@lists.infradead.org;
	Mon, 31 Aug 2026 02:38:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788143920; h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
	bh=Hn2MpPKGdK7fW3YtkPww1djcK8cUXcA1I0LgLBoL6PE=;
	b=isLHBRArMDgiG8PuejfjNovz0DekIVPvYNAjaam0oyOu5pXDA8E/reu9P8YbAy8uzPCXpQ0wXrfG74GyS84975Or1+Bm/OzwQ2/uIsqVIl9tzOu2lt4UuhgwAq3nyEZSZrwMBykdwFx7KG7ejUtlpab4ACun71DA96WWYHbiF20=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=chuyf26@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0X9rzAKd_1788143918;
Received: from x31j07255.sqa.na131(mailfrom:Chuyf26@linux.alibaba.com fp:SMTPD_---0X9rzAKd_1788143918 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Aug 2026 10:38:39 +0800
From: Yifei Chu <Chuyf26@linux.alibaba.com>
To: kbusch@kernel.org
Cc: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org
Subject: [PATCH v3] nvmet: verify the hostid when looking up a controller
Date: Mon, 31 Aug 2026 10:36:51 +0800
Message-ID: <178814381141.3422569.11201888645559295686@linux.alibaba.com>
In-Reply-To: <5fb6acc2-4ac1-4f1a-861f-13c88b3b9239@grimberg.me>
References: <178782553270.1581249.13595405857993482779@linux.alibaba.com>
 <5fb6acc2-4ac1-4f1a-861f-13c88b3b9239@grimberg.me>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_193845_576100_FDA7BB19 
X-CRM114-Status: GOOD (  15.14  )
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

Require the hostid from the connect data to match the controller's
hostid so that the lookup is bound to the identity the controller was
created with.

Controllers that were created without a hostid keep the old behaviour.

Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
Reported-by: Abaci <abaci@linux.alibaba.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Assisted-by: abaci:qwen3.8-max
Signed-off-by: Yifei Chu <Chuyf26@linux.alibaba.com>
---
v3: drop the second paragraph of the changelog (Sagi).
    Collected Sagi's Reviewed-by.

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

