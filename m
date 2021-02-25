Return-Path: <SRS0=GtbF=H3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57695C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 01:57:46 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA87664E85
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 01:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA87664E85
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=H4Lxn18t/k1N8DLfEa/BbbU2/VV1CVTuP91MHhpY71M=; b=WFLMLAwz9TzZKUirv/ikb5FG5
	FB/LkRBz4jFmQgQ1IVtWgpmlj4P/mkBlVy48Ca37EChdlCVEqB4HSGfdInREnqZCxDthA0crI2k/5
	og0XDNsfEbe6yuBmnXq1rlucDhYTZAhasdMYQwe4gASVfPll/biQ+t8X5LCiIg9ntRPb+J7wKAsDQ
	Oz2SSyT6oXWL8/vtT/Xw8lgJZkODECuljrvVY5Vt6z2fDGh7d/feGBOWlVBZirz9sGLh6X+TV7Hi1
	BGaT8YeV09z2bAsmPJ0ZDR1F8wRjoiOQMLsm5dttkeF3mu82G4pyD4Jqa34ceNFoEwjvYFR+ou4iy
	pJZSZVRtg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lF5uK-0007oE-RX; Thu, 25 Feb 2021 01:57:36 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lF5uI-0007nU-Os
 for linux-nvme@lists.infradead.org; Thu, 25 Feb 2021 01:57:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614218254; x=1645754254;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ff7kua5tRY2tHI5+YYKTtqN5JWaMT/beDenxeEwqJBA=;
 b=LcKYkU9mVCxmHMX6qCBM1owI2bL6+r4B555SApY4ZIKNfmYklG5ba02K
 ZLv4d/AMSkhjySjbpRZPwbx1n5UhhefC1FyU1KMT5L4ihy+aqsPOvMpyy
 fcyzctiUJ1q0WuirUYeu15xdcajKVdaKEgalFboPYGkLu4YD+Zmu7Er6F
 mRvVVZHThyF8HBEDfMhZ8YCTfJ38wv3DGuibX3rAcwq75vpPmmAWuvXyj
 SZigbuJmny2Wq2SZCRTINjNdg24yuKEn3+WwKahiwqlHSAP43SxDfC4Ja
 fmwqXZxik1DsmM/sfvefRqqE5bSaplbuEpEGEyyHLAgLbLDbu+neAatQG g==;
IronPort-SDR: DsrEWQMCw3Kz2xPU1IqwxZemofzC8GB8p/QIO8UoCNkXmFTFwRyE8vIMjUni7WmKEa5Vi0SV2V
 myaeel6z9J3ehJ81GNn3vNmHA8OQnYRLV5gktWhwYjXhiHuft5YZ1EaZeE3RBJCcnmiUUXIQ4b
 ykMhyKWDfsho839muet/08wgl/L/Dy7cBB0rQ7/CcozOrPKdFUEXC+ka1+2oStuQAz8v/OaDmU
 UtyLU8NCEuVE63053TlGW8Qclo8uV9Q48omgxA/pz8nblAWwHi2ezbpFQ21NqfQhdzjhXnp1sz
 DZQ=
X-IronPort-AV: E=Sophos;i="5.81,203,1610380800"; d="scan'208";a="271299757"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 09:57:33 +0800
IronPort-SDR: 3xIjs0ZfdiLPo8Hw00oKupGdiOuGiNIgU+nI3BlYgMRP5Am3RYcVPmMFvjLee3m+KwH+21BtmR
 dDQ57AVX86zUg5xqM1+grkbGYbE7VcdgKwqJqdXPQM1eqYy8OfLA9k2WmdbVWTe2sLW4JSATgt
 f7QvVSzxfZGgoJfzybs7o5bZgMJboeUXcnnrelzljPA3uEIBn0bwkFGf9WA6CghVDGTdY/A7N6
 OG2dDRtLHpjhPBJGm6G7YS3VlC8t/m+NstVsyCvKlF7OA53Q3+uRp69nZM8PsDaPbMA/S9jIhX
 sINZhkC9Ke2+Bgxvxrzn8QS+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2021 17:38:56 -0800
IronPort-SDR: nAvBhpM6B/abV2YQEeh2ZvGchLln2HijSXRosmwxPiWbRx9N4IDIktOsRdMrKISiK7C03wm750
 akLvsydvN4j4PhfSzO20XKf+BOr6EiNDTrcCPkxkEMeqtGWdjKEwLbwYvLrB3tJ5ngucoTnXIk
 frrovQjPkQIeA5KZ3/cZMkc+O9dg/JCg2IcwQWWk/uEMGNDf1zAxef1C8XNFjZFz2IW1py/RJB
 0rrHYGXAeltDP1SNj8/eT5MKZYlkmBVG2aY+4sAZGddeo0upE55oEh9pq+Q7KoNjH9D6uo9j09
 TZY=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 17:57:33 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 5/6] nvmet: remove unnecessary function parameters
Date: Wed, 24 Feb 2021 17:56:41 -0800
Message-Id: <20210225015642.29288-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210225015642.29288-1-chaitanya.kulkarni@wdc.com>
References: <20210225015642.29288-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_205735_020103_5F5E8F35 
X-CRM114-Status: GOOD (  12.87  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The function nvmet_alloc_ctrl() accepts subsysnqn, hostnqn, cntlid,
nvmet_req, and out pointer to nvmet_ctrl structure. The parameters
subsysnqn, hostnqn and cntlid can be derived from the caller's
struct nvmf_connect_data.

Replace these parameters with structure pointer nvmf_connect_data *d.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/core.c        | 16 ++++++++--------
 drivers/nvme/target/fabrics-cmd.c |  3 +--
 drivers/nvme/target/nvmet.h       |  4 ++--
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 4dce09000b3a..c64f0322c757 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1296,8 +1296,8 @@ static void nvmet_fatal_error_handler(struct work_struct *work)
 	ctrl->ops->delete_ctrl(ctrl);
 }
 
-u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
-		struct nvmet_req *req, u32 kato, struct nvmet_ctrl **ctrlp)
+u16 nvmet_alloc_ctrl(struct nvmf_connect_data *d, struct nvmet_req *req,
+		     u32 kato, struct nvmet_ctrl **ctrlp)
 {
 	struct nvmet_subsys *subsys;
 	struct nvmet_ctrl *ctrl;
@@ -1305,19 +1305,19 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	u16 status;
 
 	status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
-	subsys = nvmet_find_get_subsys(req->port, subsysnqn);
+	subsys = nvmet_find_get_subsys(req->port, d->subsysnqn);
 	if (!subsys) {
 		pr_warn("connect request for invalid subsystem %s!\n",
-			subsysnqn);
+			d->subsysnqn);
 		req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(subsysnqn);
 		req->error_loc = offsetof(struct nvme_common_command, dptr);
 		goto out;
 	}
 
 	down_read(&nvmet_config_sem);
-	if (!nvmet_host_allowed(subsys, hostnqn)) {
+	if (!nvmet_host_allowed(subsys, d->hostnqn)) {
 		pr_info("connect by host %s for subsystem %s not allowed\n",
-			hostnqn, subsysnqn);
+			d->hostnqn, d->subsysnqn);
 		req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(hostnqn);
 		up_read(&nvmet_config_sem);
 		status = NVME_SC_CONNECT_INVALID_HOST | NVME_SC_DNR;
@@ -1341,8 +1341,8 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	INIT_RADIX_TREE(&ctrl->p2p_ns_map, GFP_KERNEL);
 	INIT_WORK(&ctrl->fatal_err_work, nvmet_fatal_error_handler);
 
-	memcpy(ctrl->subsysnqn, subsysnqn, NVMF_NQN_SIZE);
-	memcpy(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE);
+	memcpy(ctrl->subsysnqn, d->subsysnqn, NVMF_NQN_SIZE);
+	memcpy(ctrl->hostnqn, d->hostnqn, NVMF_NQN_SIZE);
 
 	kref_init(&ctrl->ref);
 	ctrl->subsys = subsys;
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index acbb8d1c402c..b41748d8edf3 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -188,8 +188,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 		goto out;
 	}
 
-	status = nvmet_alloc_ctrl(d->subsysnqn, d->hostnqn, req,
-				  le32_to_cpu(c->kato), &ctrl);
+	status = nvmet_alloc_ctrl(d, req, le32_to_cpu(c->kato), &ctrl);
 	if (status)
 		goto out;
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 9a445fab3547..87a0c528a107 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -426,8 +426,8 @@ int nvmet_sq_init(struct nvmet_sq *sq);
 void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl);
 
 void nvmet_update_cc(struct nvmet_ctrl *ctrl, u32 new);
-u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
-		struct nvmet_req *req, u32 kato, struct nvmet_ctrl **ctrlp);
+u16 nvmet_alloc_ctrl(struct nvmf_connect_data *d, struct nvmet_req *req,
+		     u32 kato, struct nvmet_ctrl **ctrlp);
 struct nvmet_ctrl *nvmet_ctrl_find_get(struct nvmf_connect_data *d,
 				       struct nvmet_req *req);
 void nvmet_ctrl_put(struct nvmet_ctrl *ctrl);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
