Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7778C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 10:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f/4XsePvZijU2GILRG/FcHeFI39T0ZlM2Bsr8KLA4pI=; b=YWLa451POjBWVsAvWNV1GaZ1/v
	gkbIpMzar9DF8S1IIbBu/J58NUNvHsSjFU2tPKvOkvQZghG2L/M6P1cvo+HaW1U4G/NGFzpXRhBwE
	Qoy0RyIZgy4bsLH9Wsvpw6ZvX0IdlQJhCY8v80KFW3ooUmRS2RdZBGEirRy1qggxN5THhE2DoS5BZ
	nbUAIriPv7OyALx8mUWQ1BmJCd+thRNzS+T2YMrWZp0XMEviDsY/K1Wn183XxBN5WLpBSpZeVFOiJ
	0p+8JCJs0mLYVPeNdM6t8Icmsrr06wHh6IY/kLDTrej1ugU3Iqhau+wQDWd10NgZVObz0SPE+XqTM
	+rWnM4dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTiL6-0053Fz-JE; Mon, 14 Mar 2022 10:54:12 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTiKX-00531k-LX
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 10:53:39 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 541A921902;
 Mon, 14 Mar 2022 10:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647255215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f/4XsePvZijU2GILRG/FcHeFI39T0ZlM2Bsr8KLA4pI=;
 b=ACjV/3efVZbU/q5NHnr2VEXTg22KPDCH2GBuYgY4tTMb/PiOyHdRd+ejNkt/By3k5Y3A2w
 MTsONVIoUcSs2qAltLcXTmTT4CDLvkt/FRt6FB9jljWHtIsOeTKSwHZCvbGSMYNaHHWKIk
 SlweugoJJ8qokevUGaY66iRWhHYaN/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647255215;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f/4XsePvZijU2GILRG/FcHeFI39T0ZlM2Bsr8KLA4pI=;
 b=iXTBLWgIN9u1qA9rUKS0H+PfM3N8aii1COOBo7CJtFgYsXR4WjgJtjMrKhh/EDMCoWNvA+
 OwdZwUrC11R+pUBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 20359A3B83;
 Mon, 14 Mar 2022 10:53:34 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 504CF51936AD; Mon, 14 Mar 2022 11:53:34 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/3] nvmet: expose discovery subsystem in sysfs
Date: Mon, 14 Mar 2022 11:53:31 +0100
Message-Id: <20220314105333.56714-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220314105333.56714-1-hare@suse.de>
References: <20220314105333.56714-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_035337_892800_46A667A8 
X-CRM114-Status: GOOD (  12.87  )
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

Expose the discovery subsystem in sysfs instead of having it as
an internal structure. This requires the admin to manually
enable the discovery subsystem by linking it to a port, but
this can be seen as a feature as it will allows us to expose
subsystems without discovery subsystems and discovery subsystems
with no I/O subsystems.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/configfs.c  | 11 +++++++++++
 drivers/nvme/target/core.c      |  1 +
 drivers/nvme/target/discovery.c |  7 +------
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index a54cbddd764e..9b94af2444b2 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1041,6 +1041,11 @@ static ssize_t nvmet_subsys_attr_allow_any_host_store(struct config_item *item,
 	if (strtobool(page, &allow_any_host))
 		return -EINVAL;
 
+	if (subsys == nvmet_disc_subsys) {
+		pr_err("Can't change allow_any_host on discovery subsystem!\n");
+		return -EPERM;
+	}
+
 	down_write(&nvmet_config_sem);
 	if (allow_any_host && !list_empty(&subsys->hosts)) {
 		pr_err("Can't set allow_any_host when explicit hosts are set!\n");
@@ -1965,6 +1970,12 @@ int __init nvmet_init_configfs(void)
 	configfs_add_default_group(&nvmet_subsystems_group,
 			&nvmet_configfs_subsystem.su_group);
 
+	config_group_init_type_name(&nvmet_disc_subsys->group,
+				    NVME_DISC_SUBSYS_NAME,
+				    &nvmet_subsys_type);
+	configfs_add_default_group(&nvmet_disc_subsys->group,
+				   &nvmet_subsystems_group);
+
 	config_group_init_type_name(&nvmet_ports_group,
 			"ports", &nvmet_ports_type);
 	configfs_add_default_group(&nvmet_ports_group,
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 44f544356081..fab92c008c53 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1557,6 +1557,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 		break;
 	case NVME_NQN_DISC:
 	case NVME_NQN_CURR:
+		subsys->allow_any_host = 1;
 		subsys->max_qid = 0;
 		break;
 	default:
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index c2162eef8ce1..90bcc829c12a 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -208,18 +208,13 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 
 	nvmet_set_disc_traddr(req, req->port, traddr);
 
-	nvmet_format_discovery_entry(hdr, req->port,
-				     nvmet_disc_subsys->subsysnqn,
-				     traddr, NVME_NQN_CURR, numrec);
-	numrec++;
-
 	list_for_each_entry(p, &req->port->subsystems, entry) {
 		if (!nvmet_host_allowed(p->subsys, ctrl->hostnqn))
 			continue;
 
 		nvmet_format_discovery_entry(hdr, req->port,
 				p->subsys->subsysnqn, traddr,
-				NVME_NQN_NVME, numrec);
+				p->subsys->type, numrec);
 		numrec++;
 	}
 
-- 
2.29.2


