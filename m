Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96723E6F090
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Dec 2025 13:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bM58L9I/i9ZyMehfLP2aRrDC5Uf7gxt7KWKdUsPNwLk=; b=gqgNQNUK3tmMK6k1ryPp+XW8Qx
	qrn7PmZDvXrQqdofCkj3KmEShqO1hrD7p/1Uxsdk9lUjmoddD6r+jBoSybb9qGc+KN97in2GuMqmJ
	93V3zeIokw4HEUWZ+a/aJbepcqMpxtcMaKO8qvfTe2ON406uGz3Dam3lpENUxDf2htBwl2BrJPy5u
	wnw9uGhp4ChW2odcHgMlm5r6ZiBrN433R0D1x/L898VokaftLLvPsneiSMGMS2P/MK4mkXRjidUAv
	bN1FoKNCE4c+VATaBOQaEymfefk/bHsWQieEDLotXPHtnXm5EmgYXfig1d4EZwnud0TkFtu3xi1uG
	Dl6VjBiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vY2B5-0000000FWfb-3IT4;
	Tue, 23 Dec 2025 13:11:51 +0000
Received: from smtp-79.smtpout.orange.fr ([80.12.242.79] helo=smtp.smtpout.orange.fr)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vY2B1-0000000FWeu-3BHl
	for linux-nvme@lists.infradead.org;
	Tue, 23 Dec 2025 13:11:50 +0000
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id Y2Auvr9AoECGYY2AuvgbFO; Tue, 23 Dec 2025 14:11:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1766495502;
	bh=bM58L9I/i9ZyMehfLP2aRrDC5Uf7gxt7KWKdUsPNwLk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Wq4TJWOUAv3HjtdEoq0EKiQM+v6W6hg2BgCcvxAwz6+//i2k5ybAp8fSh0qln+EPp
	 91VJPSMgW5KmO/cEC0PHo2oFYno9CvZsHz5baqX4ddZKuSars1FwM48T21mqWV6x22
	 OaxnR+x31R32HNuoEzEn52Qvhk8ISNj3MFPotiZ53SVG9jb1cLc1Vi6mi3ZssCK0zg
	 ZcW2b3siiHwR5dgC0jewAe8QJgBPP1l174+BExhEYCCVYGeVUVaMp1bWn3GNxGr6nV
	 0KCyApGp2NPdlHtePeigUQ947MJsRrinxs6XdM4h6pcGQWKt9Jvv0lDd5jlKOzZQyk
	 zE+FU85YWbAcQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 23 Dec 2025 14:11:42 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: Constify struct configfs_item_operations and configfs_group_operations
Date: Tue, 23 Dec 2025 14:11:34 +0100
Message-ID: <82fd284cf70cffd374f5889a5c2a1f3800bafab3.1766495484.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251223_051149_004695_2BC5BECF 
X-CRM114-Status: GOOD (  10.93  )
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

'struct configfs_item_operations' and 'configfs_group_operations' are not
modified in this driver.

Constifying these structures moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  79551	  38896	    640	 119087	  1d12f	drivers/nvme/target/configfs.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  80639	  37808	    640	 119087	  1d12f	drivers/nvme/target/configfs.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

This change is possible since commits f2f36500a63b and f7f78098690d.
---
 drivers/nvme/target/configfs.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 825134d70d08..e44ef69dffc2 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -819,7 +819,7 @@ static void nvmet_ns_release(struct config_item *item)
 	nvmet_ns_free(ns);
 }
 
-static const struct configfs_item_operations nvmet_ns_item_ops = {
+static struct configfs_item_operations nvmet_ns_item_ops = {
 	.release		= nvmet_ns_release,
 };
 
@@ -860,7 +860,7 @@ static struct config_group *nvmet_ns_make(struct config_group *group,
 	return ERR_PTR(ret);
 }
 
-static const struct configfs_group_operations nvmet_namespaces_group_ops = {
+static struct configfs_group_operations nvmet_namespaces_group_ops = {
 	.make_group		= nvmet_ns_make,
 };
 
@@ -1095,7 +1095,7 @@ static void nvmet_port_subsys_drop_link(struct config_item *parent,
 	kfree(p);
 }
 
-static const struct configfs_item_operations nvmet_port_subsys_item_ops = {
+static struct configfs_item_operations nvmet_port_subsys_item_ops = {
 	.allow_link		= nvmet_port_subsys_allow_link,
 	.drop_link		= nvmet_port_subsys_drop_link,
 };
@@ -1170,7 +1170,7 @@ static void nvmet_allowed_hosts_drop_link(struct config_item *parent,
 	kfree(p);
 }
 
-static const struct configfs_item_operations nvmet_allowed_hosts_item_ops = {
+static struct configfs_item_operations nvmet_allowed_hosts_item_ops = {
 	.allow_link		= nvmet_allowed_hosts_allow_link,
 	.drop_link		= nvmet_allowed_hosts_drop_link,
 };
@@ -1696,7 +1696,7 @@ static void nvmet_subsys_release(struct config_item *item)
 	nvmet_subsys_put(subsys);
 }
 
-static const struct configfs_item_operations nvmet_subsys_item_ops = {
+static struct configfs_item_operations nvmet_subsys_item_ops = {
 	.release		= nvmet_subsys_release,
 };
 
@@ -1741,7 +1741,7 @@ static struct config_group *nvmet_subsys_make(struct config_group *group,
 	return &subsys->group;
 }
 
-static const struct configfs_group_operations nvmet_subsystems_group_ops = {
+static struct configfs_group_operations nvmet_subsystems_group_ops = {
 	.make_group		= nvmet_subsys_make,
 };
 
@@ -1809,7 +1809,7 @@ static void nvmet_referral_release(struct config_item *item)
 	kfree(port);
 }
 
-static const struct configfs_item_operations nvmet_referral_item_ops = {
+static struct configfs_item_operations nvmet_referral_item_ops = {
 	.release	= nvmet_referral_release,
 };
 
@@ -1835,7 +1835,7 @@ static struct config_group *nvmet_referral_make(
 	return &port->group;
 }
 
-static const struct configfs_group_operations nvmet_referral_group_ops = {
+static struct configfs_group_operations nvmet_referral_group_ops = {
 	.make_group		= nvmet_referral_make,
 	.disconnect_notify	= nvmet_referral_notify,
 };
@@ -1915,7 +1915,7 @@ static void nvmet_ana_group_release(struct config_item *item)
 	kfree(grp);
 }
 
-static const struct configfs_item_operations nvmet_ana_group_item_ops = {
+static struct configfs_item_operations nvmet_ana_group_item_ops = {
 	.release		= nvmet_ana_group_release,
 };
 
@@ -1961,7 +1961,7 @@ static struct config_group *nvmet_ana_groups_make_group(
 	return ERR_PTR(ret);
 }
 
-static const struct configfs_group_operations nvmet_ana_groups_group_ops = {
+static struct configfs_group_operations nvmet_ana_groups_group_ops = {
 	.make_group		= nvmet_ana_groups_make_group,
 };
 
@@ -2001,7 +2001,7 @@ static struct configfs_attribute *nvmet_port_attrs[] = {
 	NULL,
 };
 
-static const struct configfs_item_operations nvmet_port_item_ops = {
+static struct configfs_item_operations nvmet_port_item_ops = {
 	.release		= nvmet_port_release,
 };
 
@@ -2084,7 +2084,7 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 	return &port->group;
 }
 
-static const struct configfs_group_operations nvmet_ports_group_ops = {
+static struct configfs_group_operations nvmet_ports_group_ops = {
 	.make_group		= nvmet_ports_make,
 };
 
@@ -2239,7 +2239,7 @@ static void nvmet_host_release(struct config_item *item)
 	kfree(host);
 }
 
-static const struct configfs_item_operations nvmet_host_item_ops = {
+static struct configfs_item_operations nvmet_host_item_ops = {
 	.release		= nvmet_host_release,
 };
 
@@ -2270,7 +2270,7 @@ static struct config_group *nvmet_hosts_make_group(struct config_group *group,
 	return &host->group;
 }
 
-static const struct configfs_group_operations nvmet_hosts_group_ops = {
+static struct configfs_group_operations nvmet_hosts_group_ops = {
 	.make_group		= nvmet_hosts_make_group,
 };
 
-- 
2.52.0


