Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539E3C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Oct 2022 18:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u0yn+E7zwUQ6ytPZuxSaies+RqM5ft8C/zIIHD6hIK0=; b=kNdsRbI5T8F8Q15aan9hMkV23D
	tn+uiEo2hohH4m9ARMSnwIIXFf/a7T48EYEK/v8EGS1u2OHY161yQi8Jzr/TumVhYfTrOs2joNo/l
	GscBC0hcZeDu/t6xYM/8SxGiFGtqx4elnsXk1x/+jCebeoonFV+JXRvgWDjvz7e+1o90Ma137wLSg
	+spNISYRUI+utUXgMqfSuHVxbeVIYDBO6A38Cq+OChLMiS1MF8fE7nHRZeJcUUuUgAhNHKnXEe9zv
	kK6/S060MTNtq25WDZtVrAclGAKL0+GkjMsiDd+F1M/mps0wR8teucW9BaBY5co4y4Oros4GgW4yF
	6uBx/cAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1og8vQ-00FcoW-EH; Wed, 05 Oct 2022 18:15:20 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1og8vN-00Fco3-MU
	for linux-nvme@lists.infradead.org; Wed, 05 Oct 2022 18:15:19 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D379E1F933;
	Wed,  5 Oct 2022 18:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1664993710; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u0yn+E7zwUQ6ytPZuxSaies+RqM5ft8C/zIIHD6hIK0=;
	b=d7OZzjuRDdLP8IdErdgYTkp5F0AqDsNkm5oABFbbAErzVwTce4cLrUQNE/w4sOFwqOIsIL
	MnNW5fCeEgH97eTWgfKf6Shfr6r5WpDWK6KedWOjaZx+Jxsbd+TeCfPDWAR62hZymSZVgJ
	s1hYEdbpCpBmV2Hd91w71FRzq9nP+BA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1664993710;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u0yn+E7zwUQ6ytPZuxSaies+RqM5ft8C/zIIHD6hIK0=;
	b=WXxRjav0IP7BBvIlkTa4TNB/c1ZRlnPxwVoUBvK7kXsZg5JMDJ8cesVP0AGR8HbRbSqlLb
	+zcYozet+v3UQcAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5CDF13345;
	Wed,  5 Oct 2022 18:15:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id WMUdMK7JPWMhCQAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 05 Oct 2022 18:15:10 +0000
Date: Wed, 5 Oct 2022 20:15:10 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: "Knight, Frederick" <Frederick.Knight@netapp.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"hare@suse.de" <hare@suse.de>
Subject: Re: [PATCH v2] nvmet: force reconnect when number of queue changes
Message-ID: <20221005181510.zu7vcwjtltcal2zi@carbon.lan>
References: <20220927143157.3659-1-dwagner@suse.de>
 <d151b0c1-d28e-faeb-03d4-ed28b9768ee2@grimberg.me>
 <20220928074850.h6rwvwgz2oje3ebg@carbon.lan>
 <f1909450-1435-9661-056f-b955d6089ca7@grimberg.me>
 <20220928090243.c4ctbj2frydwsfav@carbon.lan>
 <DM8PR06MB7704C17B1DF832A432024BE2F1549@DM8PR06MB7704.namprd06.prod.outlook.com>
 <20220928135053.s6h6xr3llhp6riwr@carbon.lan>
 <b121c092-cecc-b891-be3c-b32c2a3e611d@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b121c092-cecc-b891-be3c-b32c2a3e611d@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221005_111517_935847_EB32421C 
X-CRM114-Status: GOOD (  31.14  )
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

On Wed, Sep 28, 2022 at 05:23:06PM +0300, Sagi Grimberg wrote:
> > As far I can tell, what's is missing from a testing point of view is the
> > ability to fail requests without the DNR bit set or the ability to tell
> > the host to reconnect. Obviously, an AEN would be nice for this but I
> > don't know if this is reason enough to extend the spec.
> 
> Looking into the code, its the connect that fails on invalid parameter
> with a DNR, because the host is attempting to connect to a subsystems
> that does not exist on the port (because it was taken offline for
> maintenance reasons).
> 
> So I guess it is valid to allow queue change without removing it from
> the port, but that does not change the fundamental question on DNR.
> If the host sees a DNR error on connect, my interpretation is that the
> host should not retry the connect command itself, but it shouldn't imply
> anything on tearing down the controller and giving up on it completely,
> forever.

Okay, let me try to avoid the DNR discussion for now and propose
something else? What about adding a 'enable' attribute to the subsys?

The snipped below does the trick. Though There is no explicit
synchronization between host and target, so it's possible the host
doesn't notice that the subsystem toggled enabled and updated the number
queues. But not sure if it's worth to address this, it feels a bit
over-engineered.


diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 051a420d818e..2438f5e04409 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1294,6 +1294,9 @@ static ssize_t nvmet_subsys_attr_qid_max_store(struct config_item *item,
 	struct nvmet_ctrl *ctrl;
 	u16 qid_max;
 
+	if (subsys->enabled)
+		return -EACCES;
+
 	if (sscanf(page, "%hu\n", &qid_max) != 1)
 		return -EINVAL;
 
@@ -1302,16 +1305,39 @@ static ssize_t nvmet_subsys_attr_qid_max_store(struct config_item *item,
 
 	down_write(&nvmet_config_sem);
 	subsys->max_qid = qid_max;
-
-	/* Force reconnect */
-	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
-		ctrl->ops->delete_ctrl(ctrl);
 	up_write(&nvmet_config_sem);
 
 	return cnt;
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_qid_max);
 
+static ssize_t nvmet_subsys_attr_enable_show(struct config_item *item,
+					     char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%d\n", to_subsys(item)->enabled);
+}
+
+static ssize_t nvmet_subsys_attr_enable_store(struct config_item *item,
+					      const char *page, size_t cnt)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+	bool enable;
+
+	if (strtobool(page, &enable))
+		goto inval;
+
+	if (enable)
+		nvmet_subsystem_enable(subsys);
+	else
+		nvmet_subsystem_disable(subsys);
+
+	return cnt;
+inval:
+	pr_err("Invalid value '%s' for enable\n", page);
+	return cnt;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_enable);
+
 static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_allow_any_host,
 	&nvmet_subsys_attr_attr_version,
@@ -1320,6 +1346,7 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_cntlid_max,
 	&nvmet_subsys_attr_attr_model,
 	&nvmet_subsys_attr_attr_qid_max,
+	&nvmet_subsys_attr_attr_enable,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	&nvmet_subsys_attr_attr_pi_enable,
 #endif
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 8e3cf0c3588c..487842f16d67 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -546,6 +546,22 @@ bool nvmet_ns_revalidate(struct nvmet_ns *ns)
 	return oldsize != ns->size;
 }
 
+int nvmet_subsystem_enable(struct nvmet_subsys *subsys)
+{
+	mutex_lock(&subsys->lock);
+	subsys->enabled = true;
+	mutex_unlock(&subsys->lock);
+
+	return 0;
+}
+
+void nvmet_subsystem_disable(struct nvmet_subsys *subsys)
+{
+	mutex_lock(&subsys->lock);
+	subsys->enabled = false;
+	mutex_unlock(&subsys->lock);
+}
+
 int nvmet_ns_enable(struct nvmet_ns *ns)
 {
 	struct nvmet_subsys *subsys = ns->subsys;
@@ -954,7 +970,10 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	if (unlikely(!req->sq->ctrl))
 		/* will return an error for any non-connect command: */
 		status = nvmet_parse_connect_cmd(req);
-	else if (likely(req->sq->qid != 0))
+	else if (unlikely(!req->sq->ctrl->subsys->enabled)) {
+		req->error_loc = offsetof(struct nvme_common_command, dptr);
+		status = NVME_SC_INTERNAL;
+	} else if (likely(req->sq->qid != 0))
 		status = nvmet_parse_io_cmd(req);
 	else
 		status = nvmet_parse_admin_cmd(req);
@@ -1368,6 +1387,15 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	}
 
 	down_read(&nvmet_config_sem);
+	if (!subsys->enabled) {
+		pr_info("connect by host %s for disabled subsystem %s not possible\n",
+			hostnqn, subsysnqn);
+		req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(subsysnqn);
+		up_read(&nvmet_config_sem);
+		status = NVME_SC_INTERNAL;
+		req->error_loc = offsetof(struct nvme_common_command, dptr);
+		goto out_put_subsystem;
+	}
 	if (!nvmet_host_allowed(subsys, hostnqn)) {
 		pr_info("connect by host %s for subsystem %s not allowed\n",
 			hostnqn, subsysnqn);
@@ -1588,6 +1616,8 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	INIT_LIST_HEAD(&subsys->ctrls);
 	INIT_LIST_HEAD(&subsys->hosts);
 
+	subsys->enabled = true;
+
 	return subsys;
 
 free_mn:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index dfe3894205aa..269bfc979870 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -235,6 +235,7 @@ struct nvmet_ctrl {
 
 struct nvmet_subsys {
 	enum nvme_subsys_type	type;
+	bool			enabled;
 
 	struct mutex		lock;
 	struct kref		ref;
@@ -486,6 +487,8 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 		enum nvme_subsys_type type);
 void nvmet_subsys_put(struct nvmet_subsys *subsys);
 void nvmet_subsys_del_ctrls(struct nvmet_subsys *subsys);
+int nvmet_subsystem_enable(struct nvmet_subsys *subsys);
+void nvmet_subsystem_disable(struct nvmet_subsys *subsys);
 
 u16 nvmet_req_find_ns(struct nvmet_req *req);
 void nvmet_put_namespace(struct nvmet_ns *ns);

