Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CE5C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:35:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83B33221FC
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B33221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OTM59+Xtm5SlifJtukC5kBj9xvFVCS+yGgnfmRdn1aM=; b=YY4YtuNub8dTEXZ97nNd91uWY
	+iHLHHRv2pT7xohTnlO0Cn47z6l2pnGFospHrfYGAqX7wEwl3oyAgvIqN3iV5mkdbYWpz08zaYQpW
	+6oh9sC2UT8FlXW9KYChk2ecyYas7ZPBnc3xeGgZOdXLwTKqikm+4Ds5dknHAIP1L3zCh4KC/BTNL
	BY6zRHD8hCOJK4cSuk1VxnIgirglp/T0rxL6Z6vtEdehqJEknMK6NpNvqWkxbTQpdo0+kJj6jEYJg
	QQ9R4Of+538oBbc2wzoGAIghrn8JxPuAPXJP9wUXuoVThHW2fgnmW8YdfGTdscheIZ4K8nt08K+lL
	jGbSQTRUg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V3o-0001lJ-MB; Tue, 26 Jan 2021 20:35:36 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V2B-000113-Mi
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:34:03 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EAhXTXrqmizmRHtuN4eY8XilrqSuuFSuxj0UUan1MrE=;
 b=AIzwYb1Ndaqqza22QKVWifZ3QaQFCfBmaN1emh8PxhDJ6yh1VKdFc5xKHp0ORHqipfnlMA
 Mj/K0o+W35Ic+T6/Zoy5G7i0EQ1vE/Wa+SHvAWaP7INkAYPAM3B/MvgX3r6KqVoB0KHXqK
 N6QqfujCLMVXhAh8ZZYfpUMIWKfCmDo=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 7ECE7B152;
 Tue, 26 Jan 2021 20:33:50 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 28/35] monitor: basic handling of add/remove uevents for nvme
 controllers
Date: Tue, 26 Jan 2021 21:33:17 +0100
Message-Id: <20210126203324.23610-29-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153356_703123_AD972B9A 
X-CRM114-Status: GOOD (  16.45  )
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
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Martin Wilck <mwilck@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Martin Wilck <mwilck@suse.com>

On add, we'd like to detect the creation of a discovery controller for a given
connection. More often than not, that doesn't work, because the controller
is still in "connecting" state when the uevent arrives, and reading subsysnqn
yields "(efault)".

This would need to be fixed by waiting for the connection to complete,
but doing this properly is currently out of scope. It's not really a big
problem, because without --persistent, the discovery controller will
be removed anyway, and with --persistent, we'll notice the discovery
controller as soon as it actually receives an AEN and generates an uevent.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 monitor.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/monitor.c b/monitor.c
index e3fee55..e2c2568 100644
--- a/monitor.c
+++ b/monitor.c
@@ -155,6 +155,36 @@ static int child_reset_signals(void)
 	return -err;
 }
 
+static void monitor_handle_nvme_add(struct udev_device *ud)
+{
+	const char *syspath = udev_device_get_syspath(ud);
+	CLEANUP(char, subsysnqn) = NULL;
+	CLEANUP(char, state) = NULL;
+
+	if (!syspath)
+		return;
+	subsysnqn = nvme_get_ctrl_attr(syspath, "subsysnqn");
+	state = nvme_get_ctrl_attr(syspath, "state");
+	log(LOG_DEBUG, "add %s => %s [%s]\n", syspath, subsysnqn, state);
+}
+
+static void monitor_handle_nvme_remove(struct udev_device *ud)
+{
+	const char *sysname = udev_device_get_sysname(ud);
+	struct nvme_connection *co;
+
+	if (!sysname)
+		return;
+
+	co = conndb_find_by_ctrl(sysname);
+	if (co) {
+		log(LOG_DEBUG, "%s: connection discovery controller removed\n",
+		    sysname);
+		co->discovery_instance = -1;
+	}
+	return;
+}
+
 static int monitor_get_fc_uev_props(struct udev_device *ud,
 				    char *traddr, size_t tra_sz,
 				    char *host_traddr, size_t htra_sz)
@@ -353,6 +383,14 @@ static void monitor_handle_nvme_uev(struct udev_device *ud)
 	char traddr[NVMF_TRADDR_SIZE], host_traddr[NVMF_TRADDR_SIZE];
 	char trsvcid[NVMF_TRSVCID_SIZE], transport[5];
 
+	if (!strcmp(udev_device_get_action(ud), "remove")) {
+		monitor_handle_nvme_remove(ud);
+		return;
+	}
+	if (!strcmp(udev_device_get_action(ud), "add")) {
+		monitor_handle_nvme_add(ud);
+		return;
+	}
 	if (strcmp(udev_device_get_action(ud), "change"))
 		return;
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
