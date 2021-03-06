Return-Path: <SRS0=TRJs=IE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040FCC433E0
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:47:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA9EF65077
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Mar 2021 00:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA9EF65077
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jaJZGt/V9Pi2MNiSzTliOZoWfnAgtDeI1t1fyK+fevo=; b=oCbQ0OLJmDjqp06rHNBbD6UoP
	QmRKyuQaXxl/ItulS01IZnKNOfak9n2uWVWtpV1b6FJxOdmARNupF0YcnK5HPXVwLV3dGYgT1AL5g
	aTyKPysWXsBWvTLUzQBf1pFpLmrNpfn8TOI8B5UKBESuzz+G/rMnhFDncXkR0Ain7fb8TjH9t9WCX
	ddm5y8dti6/FyfDrIakjItsgPRSa7hNNMwvG3KAZPE/7BrP71gGUPlUn2ScTtejCzOZP/LRBR1Ti+
	ruYSA7RLfNQ/lu6egKirCCs3ryOx3vcCxKrUe/ZF4WVWXOXmZJT1aC04kbLKjYQTSQP3s7UhTMIow
	DEf56EiPA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lIL6H-00HYzh-0a; Sat, 06 Mar 2021 00:47:21 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lIKwf-00HVkH-Ml
 for linux-nvme@lists.infradead.org; Sat, 06 Mar 2021 00:37:29 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1614991040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xkk6fa7//mZGHFQKDpGhuLpg+VPVlEJFIOhfntRoKCg=;
 b=J25bhZvtQhZFUp7IBAKY0xm8b0axsAr6VhVDObyVHzXry1M2sC6I8mn2hsfH1LraddBYIf
 LRLRS+bxm/QjjRnBnLENiWvL0v4TF1r9Ilv12Tpxg/2fwKhAO9VjlhVigcbGzHpnea0N6z
 xqKYLqZqI6jViZPOWX5O4rf+oeQPu6M=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9D267AF5A;
 Sat,  6 Mar 2021 00:37:20 +0000 (UTC)
From: mwilck@suse.com
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>,
 Martin Wilck <mwilck@suse.com>
Subject: [PATCH v2 15/16] nvmf-autoconnect: add unit file for
 nvme-monitor.service
Date: Sat,  6 Mar 2021 01:36:58 +0100
Message-Id: <20210306003659.21207-16-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210306003659.21207-1-mwilck@suse.com>
References: <20210306003659.21207-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210306_003726_887215_60BA316C 
X-CRM114-Status: UNSURE (   9.31  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Martin Wilck <mwilck@suse.com>

Running both this service and the udev-based nvmf autoconnect service
is discouraged. A "Conflicts" directive against nvmf-connect@.service
wouldn't work, because it would cause the monitor to be stopped as soon
as an event arrives. Therefore, mask the udev rules that would start
the parallel discovery.
---
 nvmf-autoconnect/systemd/nvme-monitor.service | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 nvmf-autoconnect/systemd/nvme-monitor.service

diff --git a/nvmf-autoconnect/systemd/nvme-monitor.service b/nvmf-autoconnect/systemd/nvme-monitor.service
new file mode 100644
index 0000000..5666761
--- /dev/null
+++ b/nvmf-autoconnect/systemd/nvme-monitor.service
@@ -0,0 +1,18 @@
+[Unit]
+Description=NVMe Event Monitor for Automatical Subsystem Connection
+Documentation=man:nvme-monitor(1)
+DefaultDependencies=false
+RequiresMountsFor=/sys /run /dev
+Conflicts=shutdown.target
+After=systemd-udevd-kernel.socket
+Before=sysinit.target systemd-udev-trigger.service nvmefc-boot-connections.service
+
+[Service]
+Type=simple
+ExecStartPre=-/usr/bin/ln -sf /dev/null /run/udev/rules.d/70-nvmf-autoconnect.rules
+ExecStart=/usr/sbin/nvme monitor
+ExecStartPost=-/usr/bin/rm -f /run/udev/rules.d/70-nvmf-autoconnect.rules
+KillMode=mixed
+
+[Install]
+WantedBy=sysinit.target
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
