Return-Path: <SRS0=tapN=C7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCBAC4727E
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 12:15:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A98F120936
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 12:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2e46hlFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A98F120936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zx96WHK9YAE0XkwlVyOfxAdX5P2/WgwfZDSvJCYMFow=; b=2e46hlFVQAjU3zQClhMTl+DIMM
	R9hZMrbBYmAJguv2hWHUupNHdUUE/tSbIBsds34/OTo0HV0FQVgqdOkCEiVNNok9QG3zCSdlYPI5i
	ewg+rIeY4vnr50ydkm5UFxjItms2Eqv5YvZK80G9XmpPvaC9eyFIp7XFHRK098Mz48rhvSCOi5549
	Rjmctjkp12h8dhBgFr6N0SWSk95qi3QgcU4Z8EG/Homq3Sz0nUrHurYftLM+yEgn1B2+yEBrrqfyk
	XVTGR5lp9uVWsTEw3ts4y4oAAnviBTo+qR4flp/IpE1Avl5ioSXhgIA9mX0Q7KSUjzUuZuq9awZts
	jCo/0sJQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKhCp-0003rp-BL; Tue, 22 Sep 2020 12:15:36 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKhCW-0003nJ-Ps
 for linux-nvme@lists.infradead.org; Tue, 22 Sep 2020 12:15:19 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id BA60EAF57;
 Tue, 22 Sep 2020 12:15:48 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 7/7] nvme-fcloop: use a device for lport
Date: Tue, 22 Sep 2020 14:15:01 +0200
Message-Id: <20200922121501.32851-8-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200922121501.32851-1-hare@suse.de>
References: <20200922121501.32851-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200922_081517_125970_D1141BFE 
X-CRM114-Status: GOOD (  19.15  )
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
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 James Smart <james.smart@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add a 'struct device' to the lport such that the lport will show
up in sysfs and we get a valid name in the logging output.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/fcloop.c | 53 ++++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index b84f8754b3a3..1af1917ddf4c 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -214,6 +214,7 @@ static LIST_HEAD(fcloop_nports);
 static DEFINE_IDA(fcloop_portid_ida);
 
 struct fcloop_lport {
+	struct device dev;
 	struct nvme_fc_local_port *localport;
 	struct list_head lport_list;
 	struct completion unreg_done;
@@ -1053,6 +1054,16 @@ static struct nvmet_fc_target_template tgttemplate = {
 	.lsrqst_priv_sz		= sizeof(struct fcloop_lsreq),
 };
 
+static void fcloop_release_lport(struct device *dev)
+{
+	struct fcloop_lport *lport =
+		container_of(dev, struct fcloop_lport, dev);
+
+	ida_free(&fcloop_portid_ida, lport->port_id);
+
+	kfree(lport);
+}
+
 static ssize_t
 fcloop_create_local_port(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t count)
@@ -1063,7 +1074,7 @@ fcloop_create_local_port(struct device *dev, struct device_attribute *attr,
 	struct fcloop_lport *lport;
 	struct fcloop_lport_priv *lport_priv;
 	unsigned long flags;
-	int ret = -ENOMEM, port_id;
+	int ret = -ENOMEM, port_id, port_num;
 
 	lport = kzalloc(sizeof(*lport), GFP_KERNEL);
 	if (!lport)
@@ -1094,25 +1105,39 @@ fcloop_create_local_port(struct device *dev, struct device_attribute *attr,
 		goto out_free_ida;
 	}
 
+	lport->port_id = port_id;
+	lport->dev.class = fcloop_class;
+	lport->dev.release = fcloop_release_lport;
+	dev_set_name(&lport->dev, "lport%d", lport->port_id);
+	device_initialize(&lport->dev);
+
 	memset(&pinfo, 0, sizeof(pinfo));
 	pinfo.node_name = opts->wwnn;
 	pinfo.port_name = opts->wwpn;
 	pinfo.port_role = opts->roles;
 	pinfo.port_id = port_id;
 
-	ret = nvme_fc_register_localport(&pinfo, &fctemplate, NULL, &localport);
-	if (!ret) {
-		/* success */
-		lport_priv = localport->private;
-		lport_priv->lport = lport;
+	ret = nvme_fc_register_localport(&pinfo, &fctemplate,
+					 &lport->dev, &localport);
+	if (ret)
+		goto out_free_ida;
 
-		lport->localport = localport;
-		INIT_LIST_HEAD(&lport->lport_list);
+	/* success */
+	lport_priv = localport->private;
+	lport_priv->lport = lport;
 
-		spin_lock_irqsave(&fcloop_lock, flags);
-		list_add_tail(&lport->lport_list, &fcloop_lports);
-		spin_unlock_irqrestore(&fcloop_lock, flags);
+	lport->localport = localport;
+	INIT_LIST_HEAD(&lport->lport_list);
+
+	ret = device_add(&lport->dev);
+	if (ret) {
+		nvme_fc_unregister_localport(lport->localport);
+		goto out_free_ida;
 	}
+	spin_lock_irqsave(&fcloop_lock, flags);
+	list_add_tail(&lport->lport_list, &fcloop_lports);
+	spin_unlock_irqrestore(&fcloop_lock, flags);
+
 out_free_ida:
 	if (ret)
 		ida_free(&fcloop_portid_ida, port_id);
@@ -1138,15 +1163,15 @@ __wait_localport_unreg(struct fcloop_lport *lport)
 {
 	int ret;
 
+	device_del(&lport->dev);
+
 	init_completion(&lport->unreg_done);
 
 	ret = nvme_fc_unregister_localport(lport->localport);
 
 	wait_for_completion(&lport->unreg_done);
 
-	ida_free(&fcloop_portid_ida, lport->port_id);
-
-	kfree(lport);
+	put_device(&lport->dev);
 
 	return ret;
 }
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
