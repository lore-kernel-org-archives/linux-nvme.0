Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8332EC4167B
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Dec 2022 16:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HxQqVF7aS8U+VXB9qqStHMuH4Hjq4oE4ZYJVyCIYQIg=; b=SHjci8PEQ2FiWNzpm1cel/8oO8
	K0BLRtwYt+u5642t5UwlIiZKxIaFdOFqH8WEmpNkvmyy/o8a+EgWpFEw4K2OkSA6ED52VMLZ63BsT
	hgCg/bNNZKZTB32IA1wRT8AcbwgfREcuP7qBKFj7zTsobbD6hm6hFws/PTjeNuQcymfOkfJJyDi54
	P9DgtxQM3VwnHvYMVoAj16/IsBS4tiHKhcr4He+IQY482V/1LZ/8olMaDktaZcBt1w8KzHdU/3LI8
	ubDENp0w2CJDMWpeAtpCXo+DWjLYuByX/rrLMfQnSLuYXXSaDyEvks2KUmRADu1JeCDlUJRJvJ4f+
	5R+wvVxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6w9l-002nRQ-0i; Sun, 18 Dec 2022 16:04:53 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p6w9h-002nOj-Ec
	for linux-nvme@lists.infradead.org; Sun, 18 Dec 2022 16:04:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1215460DD5;
	Sun, 18 Dec 2022 16:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A19C433F1;
	Sun, 18 Dec 2022 16:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671379488;
	bh=payr6Zz9b7V+tYyl8ijR5b+RPG29xwu55hsg8ntU0cU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=plYfwaYejzj2vDU+Vhf0yDBM/QTRYwbsOP00QSb+8khbStGfRD2fDhL6eSahg+Pft
	 VuQDpGF5A37zUaMfsHLM5b9k1aDSzhUxxSnKob7wPHOAPinjM2hqa0WX1RkEMOGqVf
	 ibV/ZNxe3dNAySCO9HO6YStQtH16R4z7PaF/Ouy2ohKZyQphrQ9FfA4lwg6JSf4oZu
	 QkZ2twRYixjUmbkfLvDZf5CZnHZVLoja7d2s5zX1ggb/m/BlcWXMi19lVmjq5sHCrW
	 TxnQpSeRJt0PhiSgx6yBydPinqRUjeWnv8vfzrTNJcItdUyScpzNG6MlfW2sVzmIip
	 Ldt/BmjJW6RhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	axboe@fb.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 47/85] nvme-auth: don't override ctrl keys before validation
Date: Sun, 18 Dec 2022 11:01:04 -0500
Message-Id: <20221218160142.925394-47-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221218160142.925394-1-sashal@kernel.org>
References: <20221218160142.925394-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221218_080449_788541_51056A3C 
X-CRM114-Status: GOOD (  11.61  )
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

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 01604350e14560d4d69323eb1ba12a257a643ea8 ]

Replace ctrl ctrl_key/host_key only after nvme_auth_generate_key is successful.
Also, this fixes a bug where the keys are leaked.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7e3893d06bab..c69dcc0e3d67 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3745,13 +3745,17 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 	memcpy(dhchap_secret, buf, count);
 	nvme_auth_stop(ctrl);
 	if (strcmp(dhchap_secret, opts->dhchap_secret)) {
+		struct nvme_dhchap_key *key, *host_key;
 		int ret;
 
-		ret = nvme_auth_generate_key(dhchap_secret, &ctrl->host_key);
+		ret = nvme_auth_generate_key(dhchap_secret, &key);
 		if (ret)
 			return ret;
 		kfree(opts->dhchap_secret);
 		opts->dhchap_secret = dhchap_secret;
+		host_key = ctrl->host_key;
+		ctrl->host_key = key;
+		nvme_auth_free_key(host_key);
 		/* Key has changed; re-authentication with new key */
 		nvme_auth_reset(ctrl);
 	}
@@ -3795,13 +3799,17 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 	memcpy(dhchap_secret, buf, count);
 	nvme_auth_stop(ctrl);
 	if (strcmp(dhchap_secret, opts->dhchap_ctrl_secret)) {
+		struct nvme_dhchap_key *key, *ctrl_key;
 		int ret;
 
-		ret = nvme_auth_generate_key(dhchap_secret, &ctrl->ctrl_key);
+		ret = nvme_auth_generate_key(dhchap_secret, &key);
 		if (ret)
 			return ret;
 		kfree(opts->dhchap_ctrl_secret);
 		opts->dhchap_ctrl_secret = dhchap_secret;
+		ctrl_key = ctrl->ctrl_key;
+		ctrl->ctrl_key = key;
+		nvme_auth_free_key(ctrl_key);
 		/* Key has changed; re-authentication with new key */
 		nvme_auth_reset(ctrl);
 	}
-- 
2.35.1


