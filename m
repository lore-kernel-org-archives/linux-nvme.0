Return-Path: <SRS0=tapN=C7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA8AC2D0E2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 12:15:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AB8A20756
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2020 12:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VMV1IbVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB8A20756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0+hjdRJxcu6aw8BJh6w6Cbatt40V5rMZf/gOXDhlw1s=; b=VMV1IbVo6w1StuFqIijTAy0AGP
	3jJrWzJyOmKt5tdAR9D094OLjsSz83gNpAC3dHkwxZg2SpaHR0j/SZ1mIZ6LusHN5wjfYSyiwVhfk
	PJbf7ZNWyyr1EPYjnwSfVQ2gMEtL6CS8sGjcBPEvLCynFGwDgbuiQAzOoVekcDhG1kOJUuDXj1Hys
	7DdeK4mze5eJUyj4EvI/JtFj2ZrPupcH9N0nblRaBwTvdvJuOJ8+KgIgxi1HfqNfeo3hvtz8fX0UK
	zG0ALMhqfeNT6O5gJQsaj5s1R5VOiR9dYzqTzxQ7BCvVktzSsdSqLQEuEjdpSz1uMlamX9xbbes1U
	3o+CpZHg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKhCt-0003tA-Qo; Tue, 22 Sep 2020 12:15:39 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKhCW-0003nQ-TL
 for linux-nvme@lists.infradead.org; Tue, 22 Sep 2020 12:15:19 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id CFF4FAF5B;
 Tue, 22 Sep 2020 12:15:48 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 6/7] nvme-fcloop: use a device for nport
Date: Tue, 22 Sep 2020 14:15:00 +0200
Message-Id: <20200922121501.32851-7-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200922121501.32851-1-hare@suse.de>
References: <20200922121501.32851-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200922_081517_229187_7CC0F7B6 
X-CRM114-Status: GOOD (  18.19  )
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

Add a 'struct device' to the nport such that the nport will show
up in sysfs and we get a valid name in the logging output.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/fcloop.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 7dab98545979..b84f8754b3a3 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -245,11 +245,11 @@ struct fcloop_tport {
 };
 
 struct fcloop_nport {
+	struct device dev;
 	struct fcloop_rport *rport;
 	struct fcloop_tport *tport;
 	struct fcloop_lport *lport;
 	struct list_head nport_list;
-	struct kref ref;
 	u64 node_name;
 	u64 port_name;
 	u32 port_role;
@@ -949,10 +949,10 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 }
 
 static void
-fcloop_nport_free(struct kref *ref)
+fcloop_release_nport(struct device *dev)
 {
 	struct fcloop_nport *nport =
-		container_of(ref, struct fcloop_nport, ref);
+		container_of(dev, struct fcloop_nport, dev);
 	unsigned long flags;
 
 	spin_lock_irqsave(&fcloop_lock, flags);
@@ -967,13 +967,13 @@ fcloop_nport_free(struct kref *ref)
 static void
 fcloop_nport_put(struct fcloop_nport *nport)
 {
-	kref_put(&nport->ref, fcloop_nport_free);
+	put_device(&nport->dev);
 }
 
-static int
+static void
 fcloop_nport_get(struct fcloop_nport *nport)
 {
-	return kref_get_unless_zero(&nport->ref);
+	get_device(&nport->dev);
 }
 
 static void
@@ -1007,6 +1007,8 @@ fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
 #define	FCLOOP_SGL_SEGS			256
 #define FCLOOP_DMABOUND_4G		0xFFFFFFFF
 
+static struct class *fcloop_class;
+
 static struct nvme_fc_port_template fctemplate = {
 	.localport_delete	= fcloop_localport_delete,
 	.remoteport_delete	= fcloop_remoteport_delete,
@@ -1225,8 +1227,10 @@ fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
 	newnport->port_id = port_id;
 	if (opts->mask & NVMF_OPT_ROLES)
 		newnport->port_role = opts->roles;
-
-	kref_init(&newnport->ref);
+	newnport->dev.class = fcloop_class;
+	newnport->dev.release = fcloop_release_nport;
+	dev_set_name(&newnport->dev, "nport%d", newnport->port_id);
+	device_initialize(&newnport->dev);
 
 	spin_lock_irqsave(&fcloop_lock, flags);
 
@@ -1267,6 +1271,10 @@ fcloop_alloc_nport(const char *buf, size_t count, bool remoteport)
 		}
 	}
 
+	ret = device_add(&newnport->dev);
+	if (ret)
+		goto out_invalid_opts;
+
 	list_add_tail(&newnport->nport_list, &fcloop_nports);
 
 	spin_unlock_irqrestore(&fcloop_lock, flags);
@@ -1339,6 +1347,8 @@ __unlink_remote_port(struct fcloop_nport *nport)
 	if (rport && nport->tport)
 		nport->tport->remoteport = NULL;
 	nport->rport = NULL;
+	if (!nport->tport)
+		device_del(&nport->dev);
 
 	return rport;
 }
@@ -1406,7 +1416,7 @@ fcloop_create_target_port(struct device *dev, struct device_attribute *attr,
 	tinfo.port_name = nport->port_name;
 	tinfo.port_id = nport->port_id;
 
-	ret = nvmet_fc_register_targetport(&tinfo, &tgttemplate, NULL,
+	ret = nvmet_fc_register_targetport(&tinfo, &tgttemplate, &nport->dev,
 						&targetport);
 	if (ret) {
 		fcloop_nport_put(nport);
@@ -1438,6 +1448,8 @@ __unlink_target_port(struct fcloop_nport *nport)
 	if (tport && nport->rport)
 		nport->rport->targetport = NULL;
 	nport->tport = NULL;
+	if (!nport->rport)
+		device_del(&nport->dev);
 
 	return tport;
 }
@@ -1513,7 +1525,6 @@ static const struct attribute_group *fcloop_dev_attr_groups[] = {
 	NULL,
 };
 
-static struct class *fcloop_class;
 static struct device *fcloop_device;
 
 
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
