Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7F2C35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 22:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YL1UpKDiMTPKleUo7sXmgWfForKJJNBBJRT8WwxEANM=; b=ym5x6wEZCPHYdah/vsVa4jAuIB
	doKrPSxfh/pc3VplJm9XrC+WFHyDHitkJOqFT5+BdpxogcZlscRt47oCNM1I4RwvsXuF0av5H7xTI
	Cd0bkPM+5KZrKJd20LTrcbV8B7Y0wSag8JoxpooMZ4ioxR8P4je4lCuO7XMlCRZMTnkOkiLdKfUl6
	MBmb5MUIP5Icxsa3DG6FWK+ravjKGZTnqi5USpb8zJ2rFZNOQhY4Lqs6dJbypa6mYwAZi2+M5WtSf
	PdovTBY1l8P+kZUW3/SHbMdPjWZGlJ+JIZcVqHyWlw/QNbvXOeMKj4HPEgeWfarmMaFnzHWW4Wm9o
	+h0IMU9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFLuc-00CDV1-31;
	Mon, 18 Dec 2023 22:16:34 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFLuX-00CDUf-17
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 22:16:32 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BILWWDL014731
	for <linux-nvme@lists.infradead.org>; Mon, 18 Dec 2023 14:16:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=YL1UpKDiMTPKleUo7sXmgWfForKJJNBBJRT8WwxEANM=;
 b=b1G90TXDLGrXiRzXBi2nDrCHvo6b8uIdhhrrGVqoVZpGAeexXisDeQeUpCOaIVu8JFcK
 ov63PomyTZQllXKUybBInLVb3Mjy2YTP35qxMXlinfIKUGhuF2NuBRMhBUcOXmqgVMY0
 BqP+bgb8L9otUvF40Il0+8JfpIlcyce9siXSQ4K2ySW16HHUToM2TA8n54XuCNckdD5Z
 KYYrQ84/9aLY6cbM9iZN/id12ekJqYXqfBvFw334MJ0OxgNseSNQBHcuZYVrUuUhypkp
 jpHrpgj8EgCNkalfHfesVdPtlEQMpqtv3MNwdQMeWutSrrRyt4QDx2LSzf9kIgd3ZG5Z cQ== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3v1am4yb52-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 18 Dec 2023 14:16:27 -0800
Received: from twshared6977.02.ash8.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 18 Dec 2023 14:16:26 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 3E91923493336; Mon, 18 Dec 2023 14:16:19 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <hare@suse.de>, <sagi@grimberg.me>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH] nvme-auth: isolate auth to fabrics transports
Date: Mon, 18 Dec 2023 14:16:13 -0800
Message-ID: <20231218221613.2803017-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: dOdBldhXb8IKvC_Yi0qbzpeH9UfwW8uB
X-Proofpoint-ORIG-GUID: dOdBldhXb8IKvC_Yi0qbzpeH9UfwW8uB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_15,2023-12-14_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_141629_742621_A1955A7C 
X-CRM114-Status: GOOD (  22.33  )
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

Some transports don't use authentication, so contain the resources and
handling for it to fabrics that do use it.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/auth.c  | 112 +++++++++++++++++++++++---------------
 drivers/nvme/host/core.c  |  23 ++++++--
 drivers/nvme/host/nvme.h  |  26 ++++++---
 drivers/nvme/host/sysfs.c |  24 ++++----
 4 files changed, 116 insertions(+), 69 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 72c0525c75f50..023cac4cbc20b 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -312,7 +312,7 @@ static int nvme_auth_set_dhchap_reply_data(struct nvm=
e_ctrl *ctrl,
 	data->hl =3D chap->hash_len;
 	data->dhvlen =3D cpu_to_le16(chap->host_key_len);
 	memcpy(data->rval, chap->response, chap->hash_len);
-	if (ctrl->ctrl_key) {
+	if (ctrl->auth->ctrl_key) {
 		chap->bi_directional =3D true;
 		get_random_bytes(chap->c2, chap->hash_len);
 		data->cvalid =3D 1;
@@ -427,7 +427,8 @@ static int nvme_auth_dhchap_setup_host_response(struc=
t nvme_ctrl *ctrl,
 		__func__, chap->qid, chap->s1, chap->transaction);
=20
 	if (!chap->transformed_key) {
-		chap->transformed_key =3D nvme_auth_transform_key(ctrl->host_key,
+		chap->transformed_key =3D nvme_auth_transform_key(
+						ctrl->auth->host_key,
 						ctrl->opts->host->nqn);
 		if (IS_ERR(chap->transformed_key)) {
 			ret =3D PTR_ERR(chap->transformed_key);
@@ -510,7 +511,7 @@ static int nvme_auth_dhchap_setup_ctrl_response(struc=
t nvme_ctrl *ctrl,
 	u8 buf[4], *challenge =3D chap->c2;
 	int ret;
=20
-	transformed_key =3D nvme_auth_transform_key(ctrl->ctrl_key,
+	transformed_key =3D nvme_auth_transform_key(ctrl->auth->ctrl_key,
 				ctrl->opts->subsysnqn);
 	if (IS_ERR(transformed_key)) {
 		ret =3D PTR_ERR(transformed_key);
@@ -696,7 +697,7 @@ static void nvme_queue_auth_work(struct work_struct *=
work)
 		return;
 	}
=20
-	chap->transaction =3D ctrl->transaction++;
+	chap->transaction =3D ctrl->auth->transaction++;
=20
 	/* DH-HMAC-CHAP Step 1: send negotiate */
 	dev_dbg(ctrl->device, "%s: qid %d send negotiate\n",
@@ -755,9 +756,9 @@ static void nvme_queue_auth_work(struct work_struct *=
work)
=20
 	dev_dbg(ctrl->device, "%s: qid %d host response\n",
 		__func__, chap->qid);
-	mutex_lock(&ctrl->dhchap_auth_mutex);
+	mutex_lock(&ctrl->auth->dhchap_auth_mutex);
 	ret =3D nvme_auth_dhchap_setup_host_response(ctrl, chap);
-	mutex_unlock(&ctrl->dhchap_auth_mutex);
+	mutex_unlock(&ctrl->auth->dhchap_auth_mutex);
 	if (ret) {
 		chap->error =3D ret;
 		goto fail2;
@@ -802,19 +803,19 @@ static void nvme_queue_auth_work(struct work_struct=
 *work)
 		return;
 	}
=20
-	mutex_lock(&ctrl->dhchap_auth_mutex);
-	if (ctrl->ctrl_key) {
+	mutex_lock(&ctrl->auth->dhchap_auth_mutex);
+	if (ctrl->auth->ctrl_key) {
 		dev_dbg(ctrl->device,
 			"%s: qid %d controller response\n",
 			__func__, chap->qid);
 		ret =3D nvme_auth_dhchap_setup_ctrl_response(ctrl, chap);
 		if (ret) {
-			mutex_unlock(&ctrl->dhchap_auth_mutex);
+			mutex_unlock(&ctrl->auth->dhchap_auth_mutex);
 			chap->error =3D ret;
 			goto fail2;
 		}
 	}
-	mutex_unlock(&ctrl->dhchap_auth_mutex);
+	mutex_unlock(&ctrl->auth->dhchap_auth_mutex);
=20
 	ret =3D nvme_auth_process_dhchap_success1(ctrl, chap);
 	if (ret) {
@@ -855,18 +856,22 @@ static void nvme_queue_auth_work(struct work_struct=
 *work)
 int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
 {
 	struct nvme_dhchap_queue_context *chap;
+	struct nvme_auth *auth =3D ctrl->auth;
=20
-	if (!ctrl->host_key) {
+	if (!auth)
+		return -ENOTSUPP;
+
+	if (!auth->host_key) {
 		dev_warn(ctrl->device, "qid %d: no key\n", qid);
 		return -ENOKEY;
 	}
=20
-	if (ctrl->opts->dhchap_ctrl_secret && !ctrl->ctrl_key) {
+	if (ctrl->opts->dhchap_ctrl_secret && !auth->ctrl_key) {
 		dev_warn(ctrl->device, "qid %d: invalid ctrl key\n", qid);
 		return -ENOKEY;
 	}
=20
-	chap =3D &ctrl->dhchap_ctxs[qid];
+	chap =3D &auth->dhchap_ctxs[qid];
 	cancel_work_sync(&chap->auth_work);
 	queue_work(nvme_auth_wq, &chap->auth_work);
 	return 0;
@@ -876,9 +881,13 @@ EXPORT_SYMBOL_GPL(nvme_auth_negotiate);
 int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
 {
 	struct nvme_dhchap_queue_context *chap;
+	struct nvme_auth *auth =3D ctrl->auth;
 	int ret;
=20
-	chap =3D &ctrl->dhchap_ctxs[qid];
+	if (!auth)
+		return -ENOTSUPP;
+
+	chap =3D &auth->dhchap_ctxs[qid];
 	flush_work(&chap->auth_work);
 	ret =3D chap->error;
 	/* clear sensitive info */
@@ -889,8 +898,9 @@ EXPORT_SYMBOL_GPL(nvme_auth_wait);
=20
 static void nvme_ctrl_auth_work(struct work_struct *work)
 {
-	struct nvme_ctrl *ctrl =3D
-		container_of(work, struct nvme_ctrl, dhchap_auth_work);
+	struct nvme_auth *auth =3D
+		container_of(work, struct nvme_auth, dhchap_auth_work);
+	struct nvme_ctrl *ctrl =3D auth->ctrl;
 	int ret, q;
=20
 	/*
@@ -939,72 +949,86 @@ static void nvme_ctrl_auth_work(struct work_struct =
*work)
 int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 {
 	struct nvme_dhchap_queue_context *chap;
+	struct nvme_auth *auth;
 	int i, ret;
=20
-	mutex_init(&ctrl->dhchap_auth_mutex);
-	INIT_WORK(&ctrl->dhchap_auth_work, nvme_ctrl_auth_work);
-	if (!ctrl->opts)
+	if (!ctrl->opts || !(ctrl->ops->flags & NVME_F_FABRICS))
 		return 0;
+
+	auth =3D kzalloc(sizeof(*auth), GFP_KERNEL);
+	if (!auth)
+		return -ENOMEM;
+
+	mutex_init(&auth->dhchap_auth_mutex);
+	INIT_WORK(&auth->dhchap_auth_work, nvme_ctrl_auth_work);
+
 	ret =3D nvme_auth_generate_key(ctrl->opts->dhchap_secret,
-			&ctrl->host_key);
+			&auth->host_key);
 	if (ret)
-		return ret;
+		goto err_free_auth;
 	ret =3D nvme_auth_generate_key(ctrl->opts->dhchap_ctrl_secret,
-			&ctrl->ctrl_key);
+			&auth->ctrl_key);
 	if (ret)
 		goto err_free_dhchap_secret;
=20
 	if (!ctrl->opts->dhchap_secret && !ctrl->opts->dhchap_ctrl_secret)
-		return 0;
+		goto ok;
=20
-	ctrl->dhchap_ctxs =3D kvcalloc(ctrl_max_dhchaps(ctrl),
+	auth->dhchap_ctxs =3D kvcalloc(ctrl_max_dhchaps(ctrl),
 				sizeof(*chap), GFP_KERNEL);
-	if (!ctrl->dhchap_ctxs) {
+	if (!auth->dhchap_ctxs) {
 		ret =3D -ENOMEM;
 		goto err_free_dhchap_ctrl_secret;
 	}
=20
 	for (i =3D 0; i < ctrl_max_dhchaps(ctrl); i++) {
-		chap =3D &ctrl->dhchap_ctxs[i];
+		chap =3D &auth->dhchap_ctxs[i];
 		chap->qid =3D i;
 		chap->ctrl =3D ctrl;
 		INIT_WORK(&chap->auth_work, nvme_queue_auth_work);
 	}
=20
+ok:
+	auth->ctrl =3D ctrl;
+	ctrl->auth =3D auth;
 	return 0;
 err_free_dhchap_ctrl_secret:
-	nvme_auth_free_key(ctrl->ctrl_key);
-	ctrl->ctrl_key =3D NULL;
+	nvme_auth_free_key(auth->ctrl_key);
 err_free_dhchap_secret:
-	nvme_auth_free_key(ctrl->host_key);
-	ctrl->host_key =3D NULL;
+	nvme_auth_free_key(auth->host_key);
+err_free_auth:
+	kfree(auth);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_init_ctrl);
=20
-void nvme_auth_stop(struct nvme_ctrl *ctrl)
+void __nvme_auth_stop(struct nvme_auth *auth)
 {
-	cancel_work_sync(&ctrl->dhchap_auth_work);
+	cancel_work_sync(&auth->dhchap_auth_work);
 }
-EXPORT_SYMBOL_GPL(nvme_auth_stop);
+EXPORT_SYMBOL_GPL(__nvme_auth_stop);
=20
 void nvme_auth_free(struct nvme_ctrl *ctrl)
 {
+	struct nvme_auth *auth =3D ctrl->auth;
 	int i;
=20
-	if (ctrl->dhchap_ctxs) {
+	if (!auth)
+		return;
+
+	if (auth->dhchap_ctxs) {
 		for (i =3D 0; i < ctrl_max_dhchaps(ctrl); i++)
-			nvme_auth_free_dhchap(&ctrl->dhchap_ctxs[i]);
-		kfree(ctrl->dhchap_ctxs);
-	}
-	if (ctrl->host_key) {
-		nvme_auth_free_key(ctrl->host_key);
-		ctrl->host_key =3D NULL;
-	}
-	if (ctrl->ctrl_key) {
-		nvme_auth_free_key(ctrl->ctrl_key);
-		ctrl->ctrl_key =3D NULL;
+			nvme_auth_free_dhchap(&auth->dhchap_ctxs[i]);
+		kfree(auth->dhchap_ctxs);
 	}
+
+	if (auth->host_key)
+		nvme_auth_free_key(auth->host_key);
+	if (auth->ctrl_key)
+		nvme_auth_free_key(auth->ctrl_key);
+
+	ctrl->auth =3D NULL;
+	kfree(auth);
 }
 EXPORT_SYMBOL_GPL(nvme_auth_free);
=20
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 590cd4f097c22..1746ddc03595a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -390,6 +390,22 @@ static inline void nvme_end_req(struct request *req)
 	blk_mq_end_request(req, status);
 }
=20
+#ifdef CONFIG_NVME_HOST_AUTH
+static inline void nvme_auth_req(struct nvme_ctrl *ctrl, struct request =
*req)
+{
+	if (ctrl->auth) {
+		queue_work(nvme_wq, &ctrl->auth->dhchap_auth_work);
+		nvme_retry_req(req);
+	} else
+		nvme_end_req(req);
+}
+#else
+static inline void nvme_auth_req(struct nvme_ctrl *ctrl, struct request =
*req)
+{
+	nvme_end_req(req);
+}
+#endif
+
 void nvme_complete_rq(struct request *req)
 {
 	struct nvme_ctrl *ctrl =3D nvme_req(req)->ctrl;
@@ -420,12 +436,7 @@ void nvme_complete_rq(struct request *req)
 		nvme_failover_req(req);
 		return;
 	case AUTHENTICATE:
-#ifdef CONFIG_NVME_HOST_AUTH
-		queue_work(nvme_wq, &ctrl->dhchap_auth_work);
-		nvme_retry_req(req);
-#else
-		nvme_end_req(req);
-#endif
+		nvme_auth_req(ctrl, req);
 		return;
 	}
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 39a90b7cb1254..7476fa0215c3f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -253,6 +253,16 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_DIRTY_CAPABILITY	=3D 5,
 };
=20
+struct nvme_auth {
+	struct nvme_ctrl *ctrl;
+	struct work_struct dhchap_auth_work;
+	struct mutex dhchap_auth_mutex;
+	struct nvme_dhchap_queue_context *dhchap_ctxs;
+	struct nvme_dhchap_key *host_key;
+	struct nvme_dhchap_key *ctrl_key;
+	u16 transaction;
+};
+
 struct nvme_ctrl {
 	bool comp_seen;
 	bool identified;
@@ -350,12 +360,7 @@ struct nvme_ctrl {
 #endif
=20
 #ifdef CONFIG_NVME_HOST_AUTH
-	struct work_struct dhchap_auth_work;
-	struct mutex dhchap_auth_mutex;
-	struct nvme_dhchap_queue_context *dhchap_ctxs;
-	struct nvme_dhchap_key *host_key;
-	struct nvme_dhchap_key *ctrl_key;
-	u16 transaction;
+	struct nvme_auth *auth;
 #endif
 	struct key *tls_key;
=20
@@ -1053,7 +1058,14 @@ static inline bool nvme_ctrl_sgl_supported(struct =
nvme_ctrl *ctrl)
 int __init nvme_init_auth(void);
 void __exit nvme_exit_auth(void);
 int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl);
-void nvme_auth_stop(struct nvme_ctrl *ctrl);
+void __nvme_auth_stop(struct nvme_auth *auth);
+
+static inline void nvme_auth_stop(struct nvme_ctrl *ctrl)
+{
+	if (ctrl->auth)
+		__nvme_auth_stop(ctrl->auth);
+}
+
 int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid);
 int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid);
 void nvme_auth_free(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index c6b7fbd4d34dd..a2f5f8a341866 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -451,16 +451,16 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct=
 device *dev,
 		}
 		kfree(opts->dhchap_secret);
 		opts->dhchap_secret =3D dhchap_secret;
-		host_key =3D ctrl->host_key;
-		mutex_lock(&ctrl->dhchap_auth_mutex);
-		ctrl->host_key =3D key;
-		mutex_unlock(&ctrl->dhchap_auth_mutex);
+		host_key =3D ctrl->auth->host_key;
+		mutex_lock(&ctrl->auth->dhchap_auth_mutex);
+		ctrl->auth->host_key =3D key;
+		mutex_unlock(&ctrl->auth->dhchap_auth_mutex);
 		nvme_auth_free_key(host_key);
 	} else
 		kfree(dhchap_secret);
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
-	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
+	queue_work(nvme_wq, &ctrl->auth->dhchap_auth_work);
=20
 	return count;
 }
@@ -509,16 +509,16 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(s=
truct device *dev,
 		}
 		kfree(opts->dhchap_ctrl_secret);
 		opts->dhchap_ctrl_secret =3D dhchap_secret;
-		ctrl_key =3D ctrl->ctrl_key;
-		mutex_lock(&ctrl->dhchap_auth_mutex);
-		ctrl->ctrl_key =3D key;
-		mutex_unlock(&ctrl->dhchap_auth_mutex);
+		ctrl_key =3D ctrl->auth->ctrl_key;
+		mutex_lock(&ctrl->auth->dhchap_auth_mutex);
+		ctrl->auth->ctrl_key =3D key;
+		mutex_unlock(&ctrl->auth->dhchap_auth_mutex);
 		nvme_auth_free_key(ctrl_key);
 	} else
 		kfree(dhchap_secret);
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
-	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
+	queue_work(nvme_wq, &ctrl->auth->dhchap_auth_work);
=20
 	return count;
 }
@@ -594,9 +594,9 @@ static umode_t nvme_dev_attrs_are_visible(struct kobj=
ect *kobj,
 	if (a =3D=3D &dev_attr_fast_io_fail_tmo.attr && !ctrl->opts)
 		return 0;
 #ifdef CONFIG_NVME_HOST_AUTH
-	if (a =3D=3D &dev_attr_dhchap_secret.attr && !ctrl->opts)
+	if (a =3D=3D &dev_attr_dhchap_secret.attr && !ctrl->auth)
 		return 0;
-	if (a =3D=3D &dev_attr_dhchap_ctrl_secret.attr && !ctrl->opts)
+	if (a =3D=3D &dev_attr_dhchap_ctrl_secret.attr && !ctrl->auth)
 		return 0;
 #endif
 #ifdef CONFIG_NVME_TCP_TLS
--=20
2.34.1


