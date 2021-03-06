Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4A6C433DB
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:50:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABD4065068
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:50:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD4065068
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yvNR0ViFSTD2MHMkfL+J3bzcFGahpXBW1S16d5rmbAk=; b=IqyagV1qaE9A6bG3gEt/6ve6L
	qJjLdZaIEmu1mAI8vez5Hq5yV3TU+u6ClUB0L0ZVUCDjX5qy0VdQOQO8n2Kt8mjGoV9eb5JBS7hml
	iDoUqpHUws+sLMmCuNdB1WG1YZe+UPxEuQKqwph2u/8nQUcdJ0NXIdXXdu/ozvCrN2t9aKILHMtVH
	bivnRQHgnP/Nv8gG5HMPit/H+XwyiTXGMqthV4C+pzZh4egS79kowfWrS5foWmtHdhkyiRS/ApLmE
	KzHUrSYX4ziU2vZAVgN4EjYV83O0QMLkf3nBx+7HrJgcIN/6SYDlA5oQtPCaYBSDVEvfn9WbrmNm3
	bMMa0Xsew==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIL9V-00HaBe-KD; Sat, 06 Mar 2021 00:50:41 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIKwd-00HVjZ-Mb
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 00:37:29 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1614991038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5bTvIdYPfjqoFUFDVKiXJrCOoD8HAin+UQslpg4zr6I=;
 b=JTo9k+00pn5BWt/MgKALIFXG0k6MKb4ST/SuHnU0+VZ8qkugUrJwj1+zPBCve8KKWTnObP
 tuC8yd1Tc76w8hc1OXKyRNJqfLIAGMMTGv/BmBpJC/ePG4cdPYDAH/qILQQtHkVq7r9rFq
 FTYiO9NfYte9ctcnbbsVPPdTQiC2ty0=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 80D18AF33;
 Sat,  6 Mar 2021 00:37:18 +0000 (UTC)
From: mwilck@suse.com
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>
Subject: [PATCH v2 09/16] monitor: handling of add/remove uevents for nvme
 controllers
Date: Sat,  6 Mar 2021 01:36:52 +0100
Message-Id: <20210306003659.21207-10-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210306003659.21207-1-mwilck@suse.com>
References: <20210306003659.21207-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_003726_093401_7EF5BD9B 
X-CRM114-Status: GOOD (  13.68  )
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
---
 monitor.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/monitor.c b/monitor.c
index e7e91f9..43d3084 100644
--- a/monitor.c
+++ b/monitor.c
@@ -159,6 +159,36 @@ static int child_reset_signals(void)
 	return -err;
 }
 
+static void monitor_handle_nvme_add(struct udev_device *ud)
+{
+	const char *syspath = udev_device_get_syspath(ud);
+	char *subsysnqn __cleanup__(cleanup_charp) = NULL;
+	char *state __cleanup__(cleanup_charp) = NULL;
+
+	if (!syspath)
+		return;
+	subsysnqn = nvme_get_ctrl_attr(syspath, "subsysnqn");
+	state = nvme_get_ctrl_attr(syspath, "state");
+	msg(LOG_DEBUG, "add %s => %s [%s]\n", syspath, subsysnqn, state);
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
+		msg(LOG_DEBUG, "%s: connection discovery controller removed\n",
+		    sysname);
+		co->discovery_instance = -1;
+	}
+	return;
+}
+
 static int monitor_get_fc_uev_props(struct udev_device *ud,
 				    char *traddr, size_t tra_sz,
 				    char *host_traddr, size_t htra_sz)
@@ -358,6 +388,14 @@ static void monitor_handle_nvme_uev(struct udev_device *ud)
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
