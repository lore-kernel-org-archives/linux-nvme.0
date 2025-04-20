Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEDDC369CF
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Apr 2025 10:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v93O7DN2wEcExVFOSE99bu9rc0q5B26viN5zcTiVnew=; b=F/N+4Ppoig+kVRim1zA5CeVgm0
	OIbHdgCUlQvu0IHa185URL4IAknSeu2DIJGpALetZAB7j6RTHOsx6Z/7FT+AkE6y895um8m/EtKID
	D8x5dSMyalYxPgYdf34jRAePK3pbymSZn9bpZnzLMllezYjDF/vjKuodoKIAWpUJFVRxHwpSQ+vxn
	rtybyptePRJH6a+hngGQXdplkajmU094o17szkQFNGihcmmrhM83PDb9RcaazjCb3mGTVKMWM+pdw
	jaOaQxurrmfvLORODKI7bSxJDMpB0TwwNTxcHtZFtfFZu47e5zEkZmcBJQXBFFjKtwRYRkuh+cziM
	rDQc3MQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6SDb-00000002SIq-43nL;
	Sun, 20 Apr 2025 10:48:11 +0000
Received: from mailout.nod.at ([116.203.167.152] helo=lithops.sigma-star.at)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u6SDY-00000002SHs-1bhy
	for linux-nvme@lists.infradead.org;
	Sun, 20 Apr 2025 10:48:09 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 3A956298567;
	Sun, 20 Apr 2025 12:47:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id xY4LTf1S-asA; Sun, 20 Apr 2025 12:47:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id E255B298562;
	Sun, 20 Apr 2025 12:47:56 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id llVxRfCL_f69; Sun, 20 Apr 2025 12:47:56 +0200 (CEST)
Received: from anvil.corp.sigma-star.at (84-115-238-41.cable.dynamic.surfer.at [84.115.238.41])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 83470298566;
	Sun, 20 Apr 2025 12:47:56 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	a.hindborg@kernel.org,
	leitao@debian.org,
	kch@nvidia.com,
	sagi@grimberg.me,
	hch@lst.de,
	upstream+nvme@sigma-star.at,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 2/2] nvmet: Restrict in-band config files to root
Date: Sun, 20 Apr 2025 12:47:26 +0200
Message-ID: <20250420104726.2963750-2-richard@nod.at>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250420104726.2963750-1-richard@nod.at>
References: <20250420104726.2963750-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250420_034808_560181_D9A94AD1 
X-CRM114-Status: UNSURE (   8.58  )
X-CRM114-Notice: Please train this message.
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

There is no need to have key material world readable.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/nvme/target/configfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configf=
s.c
index e44ef69dffc2..7327543f161d 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -2128,7 +2128,7 @@ static ssize_t nvmet_host_dhchap_key_store(struct c=
onfig_item *item,
 	return ret < 0 ? ret : count;
 }
=20
-CONFIGFS_ATTR(nvmet_host_, dhchap_key);
+CONFIGFS_ATTR_PERM(nvmet_host_, dhchap_key, S_IRUSR | S_IWUSR);
=20
 static ssize_t nvmet_host_dhchap_ctrl_key_show(struct config_item *item,
 		char *page)
@@ -2161,7 +2161,7 @@ static ssize_t nvmet_host_dhchap_ctrl_key_store(str=
uct config_item *item,
 	return ret < 0 ? ret : count;
 }
=20
-CONFIGFS_ATTR(nvmet_host_, dhchap_ctrl_key);
+CONFIGFS_ATTR_PERM(nvmet_host_, dhchap_ctrl_key, S_IRUSR | S_IWUSR);
=20
 static ssize_t nvmet_host_dhchap_hash_show(struct config_item *item,
 		char *page)
@@ -2187,7 +2187,7 @@ static ssize_t nvmet_host_dhchap_hash_store(struct =
config_item *item,
 	return count;
 }
=20
-CONFIGFS_ATTR(nvmet_host_, dhchap_hash);
+CONFIGFS_ATTR_PERM(nvmet_host_, dhchap_hash, S_IRUSR | S_IWUSR);
=20
 static ssize_t nvmet_host_dhchap_dhgroup_show(struct config_item *item,
 		char *page)
@@ -2217,7 +2217,7 @@ static ssize_t nvmet_host_dhchap_dhgroup_store(stru=
ct config_item *item,
 	return count;
 }
=20
-CONFIGFS_ATTR(nvmet_host_, dhchap_dhgroup);
+CONFIGFS_ATTR_PERM(nvmet_host_, dhchap_dhgroup, S_IRUSR | S_IWUSR);
=20
 static struct configfs_attribute *nvmet_host_attrs[] =3D {
 	&nvmet_host_attr_dhchap_key,
--=20
2.48.1


