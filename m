Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CACAC54E55
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Mar 2024 11:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qrppTb6/b41h9YRam6jVTDT7tDXXuNVpsKhd5XsKJsM=; b=j9CQcmtsBRKMhuZzDIw5GLpS78
	ZoxMBYxJrB0RCD8vwqTtBFoZOM59+n5sqDpjvrs0EOgxOe1r5ALQFeSTdwDai9Lq6/jq3uGldkrq2
	fFiZYBWKSdHsY12ifyysHzsYcFg6gplPQV85p7t++il1f1WdFC3zGuWehtBk1+BbkYwX5PfOCjOzY
	rWNG2uXbjPa1NkbJqiarejNKcRzGUfZ+QH4xgyv+W/vfXKfvU/hqvTaH/BbbIIE20Bc/DLTHbQamT
	YPn4GK3rvNk/lfAoB/nX/mJp3wUt+HK9GXQIBH6O/ABRPbGsMM8Rbza4aSwCtHbc1hVT48F8DalKn
	Kmryo2WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg14B-0000000HZax-4B44;
	Fri, 01 Mar 2024 11:28:40 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rg148-0000000HZYv-3Vma
	for linux-nvme@lists.infradead.org;
	Fri, 01 Mar 2024 11:28:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4D95060FE4;
	Fri,  1 Mar 2024 11:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92707C433C7;
	Fri,  1 Mar 2024 11:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709292516;
	bh=yidaUjHxCjSjlwNBvy5VOqRLtXGiEo0zBw+lnYiHcv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S+2B373hEJCXZnYz7mH0R5P7yVf33SyxrLMYOVqWT0wKcaTUJSef2BGwuFd3H4UH7
	 t91l4PtK6VghjT5Lwuy5O2M1spx9olkipcCa3bAIqkaavhaI51CA4IFvz4Eey7K5Vl
	 Fy066VVwI0mPD3IjjQN5f0kGwiKx5HIt9d/+JW2Xe5FVloJkAUSIm/XFGm73k11sBM
	 ZdN5IhS6bHnvrwlQ3oTCOixhJl+BfO2BU++fzN5B6K8Lg7Yktdg+zkBDd2punf4SV4
	 4S4xe8MkO94KJcKIis7wPVOdOEKEQySbAYviPi8jCnbRyEj88lrkDhAXe23QRTYPdj
	 Ug+2PT83qlFgA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/4] nvmet: return DHCHAP status codes from nvmet_setup_auth()
Date: Fri,  1 Mar 2024 12:28:22 +0100
Message-Id: <20240301112823.132570-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240301112823.132570-1-hare@kernel.org>
References: <20240301112823.132570-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240301_032837_006419_74C73D3C 
X-CRM114-Status: GOOD (  13.58  )
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

A failure in nvmet_setup_auth() does not mean that the NVMe
authentication command failed, so we should rather return a
protocol error with a 'failure1' response than an NVMe status.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/auth.c             | 17 +++++++----------
 drivers/nvme/target/fabrics-cmd-auth.c | 11 ++++++-----
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 9afc28f1ffac..63dea7cd7cd1 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -149,13 +149,16 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 	}
 	if (!host) {
 		pr_debug("host %s not found\n", ctrl->hostnqn);
-		ret = -EPERM;
+		ret = NVME_AUTH_DHCHAP_FAILURE_FAILED;
 		goto out_unlock;
 	}
 
 	ret = nvmet_setup_dhgroup(ctrl, host->dhchap_dhgroup_id);
-	if (ret < 0)
+	if (ret < 0) {
 		pr_warn("Failed to setup DH group");
+		ret = NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
+		goto out_unlock;
+	}
 
 	if (!host->dhchap_secret) {
 		pr_debug("No authentication provided\n");
@@ -166,12 +169,6 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 		pr_debug("Re-use existing hash ID %d\n",
 			 ctrl->shash_id);
 	} else {
-		hash_name = nvme_auth_hmac_name(host->dhchap_hash_id);
-		if (!hash_name) {
-			pr_warn("Hash ID %d invalid\n", host->dhchap_hash_id);
-			ret = -EINVAL;
-			goto out_unlock;
-		}
 		ctrl->shash_id = host->dhchap_hash_id;
 	}
 
@@ -180,7 +177,7 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 	ctrl->host_key = nvme_auth_extract_key(host->dhchap_secret + 10,
 					       host->dhchap_key_hash);
 	if (IS_ERR(ctrl->host_key)) {
-		ret = PTR_ERR(ctrl->host_key);
+		ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
 		ctrl->host_key = NULL;
 		goto out_free_hash;
 	}
@@ -198,7 +195,7 @@ int nvmet_setup_auth(struct nvmet_ctrl *ctrl)
 	ctrl->ctrl_key = nvme_auth_extract_key(host->dhchap_ctrl_secret + 10,
 					       host->dhchap_ctrl_key_hash);
 	if (IS_ERR(ctrl->ctrl_key)) {
-		ret = PTR_ERR(ctrl->ctrl_key);
+		ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
 		ctrl->ctrl_key = NULL;
 		goto out_free_hash;
 	}
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index eb7785be0ca7..a95dc6606396 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -240,12 +240,13 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 			pr_debug("%s: ctrl %d qid %d reset negotiation\n", __func__,
 				 ctrl->cntlid, req->sq->qid);
 			if (!req->sq->qid) {
-				if (nvmet_setup_auth(ctrl) < 0) {
-					status = NVME_SC_INTERNAL;
-					pr_err("ctrl %d qid 0 failed to setup"
-					       "re-authentication",
+				status = nvmet_setup_auth(ctrl);
+				if (status) {
+					pr_err("ctrl %d qid 0 failed to setup re-authentication\n",
 					       ctrl->cntlid);
-					goto done_failure1;
+					req->sq->dhchap_status = status;
+					req->sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_FAILURE1;
+					goto done_kfree;
 				}
 			}
 			req->sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
-- 
2.35.3


