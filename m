Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6464FC48285
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jan 2024 17:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EatXdtALEsh0MWMkzb1rd+jOe+kU6YHEaHDNFKIMSG8=; b=RGje8/9mDEk5l7e51zEY0uTVs5
	tyg1ipObrxoBnU+3tpUyf3ZVknBZXZcNFKuHDCYKf/V2tGYWIrCNLNwG1DryUJnw+97fgtspyvTtm
	+8VYvkRl39iR+9EfACpIJDWEaznKwXB/1o4E3LnRze52Gf6qf50Btz+2PPO0MFH3Ln6Zt7OvCfKF5
	0fSylZU/DBBPZwBiQFm99dGURPipHaurjTHbWx+aW8ZwFpwRMli+fTwyxRUmytSFeyDf2pViCS0qj
	mlMG1xcGy0P2PLoAST4Z/C92Vux6RXNPSKgnIZYgEce44tr40xDMaLKu0x05MxX5E6rveiSNq8eve
	l/DFSDUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTPpq-00000004qcK-007T;
	Fri, 26 Jan 2024 17:17:46 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTPob-00000004pre-09li
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jan 2024 17:16:34 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 40QHBddK025932
	for <linux-nvme@lists.infradead.org>; Fri, 26 Jan 2024 09:16:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=EatXdtALEsh0MWMkzb1rd+jOe+kU6YHEaHDNFKIMSG8=;
 b=nj/5o1wYEFnskGqPD/JCd9S+TrmZnUa6jQEEFwSkoW/+wNHn2k0+80aoDuFPAjwV9/fX
 zhhOEnjCgr/74e6VT5iVBDcYIGTRkvLyQfBb0u0P+M2k6/jzbq8hGtnp67db0HPMlTqG
 8F7f/aCdY5be3TaoOft6CQKXGUVZ875BUUunMy6Lav4PByLPgCi3oVfs1cPNUheCqInd
 LhA4fb6VyV2ky6bD1A+GE1dc+KVt8ABo6okmIjgGu1XJuywUaSpFJKeaSzLdEw0+oMbL
 wivc/nbbh6Jbie26aZW9RudT+Q/OQdKWKOyspxzgwmnXEyYCNm9Es89uu7MkggPYnOWj 5g== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3vvf2hgw84-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 26 Jan 2024 09:16:24 -0800
Received: from twshared7847.07.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 09:16:24 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 3F2772487C11D; Fri, 26 Jan 2024 09:16:10 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: <chaitanyak@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3] nvme: use ctrl state accessor
Date: Fri, 26 Jan 2024 09:16:08 -0800
Message-ID: <20240126171608.2136149-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: BA3ptKZVgZep6ZDKCz4FtQoOPwHPdtzb
X-Proofpoint-ORIG-GUID: BA3ptKZVgZep6ZDKCz4FtQoOPwHPdtzb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240126_091629_456489_622B849D 
X-CRM114-Status: GOOD (  22.59  )
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

The ctrl->state value is updated in another thread using WRITE_ONCE, so
ensure all the readers use the appropriate accessor.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v2->v3:

  A few more state checkers that v2 missed (Chaitanya)

 drivers/nvme/host/apple.c     | 13 +++++++------
 drivers/nvme/host/auth.c      |  2 +-
 drivers/nvme/host/core.c      |  4 ++--
 drivers/nvme/host/fabrics.h   |  8 +++++---
 drivers/nvme/host/multipath.c | 15 ++++++++-------
 drivers/nvme/host/nvme.h      | 11 ++++++-----
 drivers/nvme/host/sysfs.c     |  6 +++---
 drivers/nvme/target/loop.c    |  8 +++++---
 8 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 596bb11eeba5a..c727cd1f264bf 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -797,6 +797,7 @@ static int apple_nvme_init_request(struct blk_mq_tag_=
set *set,
=20
 static void apple_nvme_disable(struct apple_nvme *anv, bool shutdown)
 {
+	enum nvme_ctrl_state state =3D nvme_ctrl_state(&anv->ctrl);
 	u32 csts =3D readl(anv->mmio_nvme + NVME_REG_CSTS);
 	bool dead =3D false, freeze =3D false;
 	unsigned long flags;
@@ -808,8 +809,8 @@ static void apple_nvme_disable(struct apple_nvme *anv=
, bool shutdown)
 	if (csts & NVME_CSTS_CFS)
 		dead =3D true;
=20
-	if (anv->ctrl.state =3D=3D NVME_CTRL_LIVE ||
-	    anv->ctrl.state =3D=3D NVME_CTRL_RESETTING) {
+	if (state =3D=3D NVME_CTRL_LIVE ||
+	    state =3D=3D NVME_CTRL_RESETTING) {
 		freeze =3D true;
 		nvme_start_freeze(&anv->ctrl);
 	}
@@ -881,7 +882,7 @@ static enum blk_eh_timer_return apple_nvme_timeout(st=
ruct request *req)
 	unsigned long flags;
 	u32 csts =3D readl(anv->mmio_nvme + NVME_REG_CSTS);
=20
-	if (anv->ctrl.state !=3D NVME_CTRL_LIVE) {
+	if (nvme_ctrl_state(&anv->ctrl) !=3D NVME_CTRL_LIVE) {
 		/*
 		 * From rdma.c:
 		 * If we are resetting, connecting or deleting we should
@@ -985,10 +986,10 @@ static void apple_nvme_reset_work(struct work_struc=
t *work)
 	u32 boot_status, aqa;
 	struct apple_nvme *anv =3D
 		container_of(work, struct apple_nvme, ctrl.reset_work);
+	enum nvme_ctrl_state state =3D nvme_ctrl_state(&anv->ctrl);
=20
-	if (anv->ctrl.state !=3D NVME_CTRL_RESETTING) {
-		dev_warn(anv->dev, "ctrl state %d is not RESETTING\n",
-			 anv->ctrl.state);
+	if (state !=3D NVME_CTRL_RESETTING) {
+		dev_warn(anv->dev, "ctrl state %d is not RESETTING\n", state);
 		ret =3D -ENODEV;
 		goto out;
 	}
diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 72c0525c75f50..2a12ee878783f 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -897,7 +897,7 @@ static void nvme_ctrl_auth_work(struct work_struct *w=
ork)
 	 * If the ctrl is no connected, bail as reconnect will handle
 	 * authentication.
 	 */
-	if (ctrl->state !=3D NVME_CTRL_LIVE)
+	if (nvme_ctrl_state(ctrl) !=3D NVME_CTRL_LIVE)
 		return;
=20
 	/* Authenticate admin queue first */
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0810be0d1154c..a42c347d08e87 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -721,7 +721,7 @@ blk_status_t nvme_fail_nonready_command(struct nvme_c=
trl *ctrl,
 EXPORT_SYMBOL_GPL(nvme_fail_nonready_command);
=20
 bool __nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
-		bool queue_live)
+		bool queue_live, enum nvme_ctrl_state state)
 {
 	struct nvme_request *req =3D nvme_req(rq);
=20
@@ -742,7 +742,7 @@ bool __nvme_check_ready(struct nvme_ctrl *ctrl, struc=
t request *rq,
 		 * command, which is require to set the queue live in the
 		 * appropinquate states.
 		 */
-		switch (nvme_ctrl_state(ctrl)) {
+		switch (state) {
 		case NVME_CTRL_CONNECTING:
 			if (blk_rq_is_passthrough(rq) && nvme_is_fabrics(req->cmd) &&
 			    (req->cmd->fabrics.fctype =3D=3D nvme_fabrics_type_connect ||
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index fbaee5a7be196..06cc54851b1be 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -185,9 +185,11 @@ static inline bool
 nvmf_ctlr_matches_baseopts(struct nvme_ctrl *ctrl,
 			struct nvmf_ctrl_options *opts)
 {
-	if (ctrl->state =3D=3D NVME_CTRL_DELETING ||
-	    ctrl->state =3D=3D NVME_CTRL_DELETING_NOIO ||
-	    ctrl->state =3D=3D NVME_CTRL_DEAD ||
+	enum nvme_ctrl_state state =3D nvme_ctrl_state(ctrl);
+
+	if (state =3D=3D NVME_CTRL_DELETING ||
+	    state =3D=3D NVME_CTRL_DELETING_NOIO ||
+	    state =3D=3D NVME_CTRL_DEAD ||
 	    strcmp(opts->subsysnqn, ctrl->opts->subsysnqn) ||
 	    strcmp(opts->host->nqn, ctrl->opts->host->nqn) ||
 	    !uuid_equal(&opts->host->id, &ctrl->opts->host->id))
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.=
c
index 2dd4137a08b28..74de1e64aeead 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -156,7 +156,7 @@ void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 		if (!ns->head->disk)
 			continue;
 		kblockd_schedule_work(&ns->head->requeue_work);
-		if (ctrl->state =3D=3D NVME_CTRL_LIVE)
+		if (nvme_ctrl_state(ns->ctrl) =3D=3D NVME_CTRL_LIVE)
 			disk_uevent(ns->head->disk, KOBJ_CHANGE);
 	}
 	up_read(&ctrl->namespaces_rwsem);
@@ -223,13 +223,14 @@ void nvme_mpath_revalidate_paths(struct nvme_ns *ns=
)
=20
 static bool nvme_path_is_disabled(struct nvme_ns *ns)
 {
+	enum nvme_ctrl_state state =3D nvme_ctrl_state(ns->ctrl);
+
 	/*
 	 * We don't treat NVME_CTRL_DELETING as a disabled path as I/O should
 	 * still be able to complete assuming that the controller is connected.
 	 * Otherwise it will fail immediately and return to the requeue list.
 	 */
-	if (ns->ctrl->state !=3D NVME_CTRL_LIVE &&
-	    ns->ctrl->state !=3D NVME_CTRL_DELETING)
+	if (state !=3D NVME_CTRL_LIVE && state !=3D NVME_CTRL_DELETING)
 		return true;
 	if (test_bit(NVME_NS_ANA_PENDING, &ns->flags) ||
 	    !test_bit(NVME_NS_READY, &ns->flags))
@@ -331,7 +332,7 @@ static struct nvme_ns *nvme_round_robin_path(struct n=
vme_ns_head *head,
=20
 static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
 {
-	return ns->ctrl->state =3D=3D NVME_CTRL_LIVE &&
+	return nvme_ctrl_state(ns->ctrl) =3D=3D NVME_CTRL_LIVE &&
 		ns->ana_state =3D=3D NVME_ANA_OPTIMIZED;
 }
=20
@@ -358,7 +359,7 @@ static bool nvme_available_path(struct nvme_ns_head *=
head)
 	list_for_each_entry_rcu(ns, &head->list, siblings) {
 		if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
 			continue;
-		switch (ns->ctrl->state) {
+		switch (nvme_ctrl_state(ns->ctrl)) {
 		case NVME_CTRL_LIVE:
 		case NVME_CTRL_RESETTING:
 		case NVME_CTRL_CONNECTING:
@@ -667,7 +668,7 @@ static void nvme_update_ns_ana_state(struct nvme_ana_=
group_desc *desc,
 	 * controller is ready.
 	 */
 	if (nvme_state_is_live(ns->ana_state) &&
-	    ns->ctrl->state =3D=3D NVME_CTRL_LIVE)
+	    nvme_ctrl_state(ns->ctrl) =3D=3D NVME_CTRL_LIVE)
 		nvme_mpath_set_live(ns);
 }
=20
@@ -748,7 +749,7 @@ static void nvme_ana_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl =3D container_of(work, struct nvme_ctrl, ana_wor=
k);
=20
-	if (ctrl->state !=3D NVME_CTRL_LIVE)
+	if (nvme_ctrl_state(ctrl) !=3D NVME_CTRL_LIVE)
 		return;
=20
 	nvme_read_ana_log(ctrl);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 030c808182406..1700063bc24de 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -805,17 +805,18 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, str=
uct request *req);
 blk_status_t nvme_fail_nonready_command(struct nvme_ctrl *ctrl,
 		struct request *req);
 bool __nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
-		bool queue_live);
+		bool queue_live, enum nvme_ctrl_state state);
=20
 static inline bool nvme_check_ready(struct nvme_ctrl *ctrl, struct reque=
st *rq,
 		bool queue_live)
 {
-	if (likely(ctrl->state =3D=3D NVME_CTRL_LIVE))
+	enum nvme_ctrl_state state =3D nvme_ctrl_state(ctrl);
+
+	if (likely(state =3D=3D NVME_CTRL_LIVE))
 		return true;
-	if (ctrl->ops->flags & NVME_F_FABRICS &&
-	    ctrl->state =3D=3D NVME_CTRL_DELETING)
+	if (ctrl->ops->flags & NVME_F_FABRICS && state =3D=3D NVME_CTRL_DELETIN=
G)
 		return queue_live;
-	return __nvme_check_ready(ctrl, rq, queue_live);
+	return __nvme_check_ready(ctrl, rq, queue_live, state);
 }
=20
 /*
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 754e911110420..6b2f06f190de3 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -311,6 +311,7 @@ static ssize_t nvme_sysfs_show_state(struct device *d=
ev,
 				     char *buf)
 {
 	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
+	unsigned state =3D (unsigned)nvme_ctrl_state(ctrl);
 	static const char *const state_name[] =3D {
 		[NVME_CTRL_NEW]		=3D "new",
 		[NVME_CTRL_LIVE]	=3D "live",
@@ -321,9 +322,8 @@ static ssize_t nvme_sysfs_show_state(struct device *d=
ev,
 		[NVME_CTRL_DEAD]	=3D "dead",
 	};
=20
-	if ((unsigned)ctrl->state < ARRAY_SIZE(state_name) &&
-	    state_name[ctrl->state])
-		return sysfs_emit(buf, "%s\n", state_name[ctrl->state]);
+	if (state < ARRAY_SIZE(state_name) && state_name[state])
+		return sysfs_emit(buf, "%s\n", state_name[state]);
=20
 	return sysfs_emit(buf, "unknown state\n");
 }
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 2b2e0d00af85e..e589915ddef85 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -400,7 +400,7 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_=
ctrl *ctrl)
 	}
=20
 	nvme_quiesce_admin_queue(&ctrl->ctrl);
-	if (ctrl->ctrl.state =3D=3D NVME_CTRL_LIVE)
+	if (nvme_ctrl_state(&ctrl->ctrl) =3D=3D NVME_CTRL_LIVE)
 		nvme_disable_ctrl(&ctrl->ctrl, true);
=20
 	nvme_cancel_admin_tagset(&ctrl->ctrl);
@@ -434,8 +434,10 @@ static void nvme_loop_reset_ctrl_work(struct work_st=
ruct *work)
 	nvme_loop_shutdown_ctrl(ctrl);
=20
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
-		if (ctrl->ctrl.state !=3D NVME_CTRL_DELETING &&
-		    ctrl->ctrl.state !=3D NVME_CTRL_DELETING_NOIO)
+		enum nvme_ctrl_state state =3D nvme_ctrl_state(&ctrl->ctrl);
+
+		if (state !=3D NVME_CTRL_DELETING &&
+		    state !=3D NVME_CTRL_DELETING_NOIO)
 			/* state change failure for non-deleted ctrl? */
 			WARN_ON_ONCE(1);
 		return;
--=20
2.34.1


