Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC03C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:34:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0D5222A85
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0D5222A85
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/9M6zasRjHIepF1TAO7+60Z4cqYn5Ar7ciR6BQTcqsA=; b=EKYAZQwVAcs8DJPRZuuJIFy2V
	+ejf/+aaI+5jHB5Zi8XL2yqrBTitF3DgToOmsYn3loNzrxDTtEksxWrZ8dNqKcD4xOVI51XpGbP6V
	+lsLMMuCJDg6MBHglFfZq/wSNCjrpimGXqc/jhx+WvqzdBUyLkzRAwdO/intjMTBbraOuk0TGljAQ
	0jxoxoKSgyXw/Vzlan+InEFyLNgWsywwSBZv+k44PbOrgNRYrQQDt2G1r8KlpNVfg9i6a4U0B/S7E
	qLvu7aeJ0xHeWeInFgLo1oSG3wNXvniomLvmBWQCli8iIJEARQ4OHpbGvpPXBbg0vV9SvHPnd4Kau
	OgmVTq1qA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V30-0001Ke-9L; Tue, 26 Jan 2021 20:34:46 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V27-0000xu-O7
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:33:56 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ez+i9IlOUvyYnPgGtQFf1SW/R4DNXumx4jrt6apas9g=;
 b=cH8yXs/UB9IEpIGip8hF67ZuDAh9ii67bdmyKX0/KqAZz2nCey8v7GytTuW4ZS+RYMCadq
 l5K6dntZ50ZMXhxu85dy+dQm+L39PiSegO+YaYJQty27rADw3ERvysGBkyJNmWsp5dKypE
 //mlubFMUN6HFYeF2r33stgaOVNqvFI=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9AD63B01F;
 Tue, 26 Jan 2021 20:33:46 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 15/35] monitor: implement handling of nvme AEN events
Date: Tue, 26 Jan 2021 21:33:04 +0100
Message-Id: <20210126203324.23610-16-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_153352_127534_105B3955 
X-CRM114-Status: GOOD (  13.86  )
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

This is very similar to fc_udev_device events, except that we
have different udev properties and must use trsvcid.

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 monitor.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/monitor.c b/monitor.c
index 6547265..69c8333 100644
--- a/monitor.c
+++ b/monitor.c
@@ -214,6 +214,74 @@ static void monitor_handle_fc_uev(struct udev_device *ud)
 	monitor_discovery("fc", traddr, NULL, host_traddr);
 }
 
+static int monitor_get_nvme_uev_props(struct udev_device *ud,
+				      char *transport, size_t tr_sz,
+				      char *traddr, size_t tra_sz,
+				      char *trsvcid, size_t trs_sz,
+				      char *host_traddr, size_t htra_sz)
+{
+	const char *sysname = udev_device_get_sysname(ud);
+	bool aen_disc = false;
+	struct udev_list_entry *entry;
+
+	entry = udev_device_get_properties_list_entry(ud);
+	if (!entry) {
+		log(LOG_NOTICE, "%s: emtpy properties list\n", sysname);
+		return -ENOENT;
+	}
+
+	*transport = *traddr = *trsvcid = *host_traddr = '\0';
+	for (; entry; entry = udev_list_entry_get_next(entry)) {
+		const char *name = udev_list_entry_get_name(entry);
+
+		if (!strcmp(name, "NVME_AEN") &&
+		    !strcmp(udev_list_entry_get_value(entry), "0x70f002"))
+				aen_disc = true;
+		else if (!strcmp(name, "NVME_TRTYPE"))
+			memccpy(transport, udev_list_entry_get_value(entry),
+				'\0', tr_sz);
+		else if (!strcmp(name, "NVME_TRADDR"))
+			memccpy(traddr, udev_list_entry_get_value(entry),
+				'\0', htra_sz);
+		else if (!strcmp(name, "NVME_TRSVCID"))
+			memccpy(trsvcid, udev_list_entry_get_value(entry),
+				'\0', trs_sz);
+		else if (!strcmp(name, "NVME_HOST_TRADDR"))
+			memccpy(host_traddr, udev_list_entry_get_value(entry),
+				'\0', tra_sz);
+	}
+	if (!aen_disc) {
+		log(LOG_DEBUG, "%s: not a \"discovery log changed\" AEN, ignoring event\n",
+		    sysname);
+		return -EINVAL;
+	}
+
+	if (!*traddr || !*transport) {
+		log(LOG_WARNING, "%s: transport properties missing\n", sysname);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void monitor_handle_nvme_uev(struct udev_device *ud)
+{
+	char traddr[NVMF_TRADDR_SIZE], host_traddr[NVMF_TRADDR_SIZE];
+	char trsvcid[NVMF_TRSVCID_SIZE], transport[5];
+
+	if (strcmp(udev_device_get_action(ud), "change"))
+		return;
+
+	if (monitor_get_nvme_uev_props(ud, transport, sizeof(transport),
+				       traddr, sizeof(traddr),
+				       trsvcid, sizeof(trsvcid),
+				       host_traddr, sizeof(host_traddr)))
+		return;
+
+	monitor_discovery(transport, traddr,
+			  strcmp(trsvcid, "none") ? trsvcid : NULL, host_traddr);
+}
+
 static void monitor_handle_udevice(struct udev_device *ud)
 {
 	const char *subsys  = udev_device_get_subsystem(ud);
@@ -226,6 +294,8 @@ static void monitor_handle_udevice(struct udev_device *ud)
 	}
 	if (!strcmp(subsys, "fc"))
 		monitor_handle_fc_uev(ud);
+	else if (!strcmp(subsys, "nvme"))
+		monitor_handle_nvme_uev(ud);
 }
 
 static void monitor_handle_uevents(struct udev_monitor *monitor)
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
