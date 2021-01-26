Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D19C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:41:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BFE922B3B
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 20:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BFE922B3B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=B/7lDETSPzj+k1XBQRfRVuuEcbbCiW0mfd8t9fqzw3Q=; b=cF5tNtLdOA605REoGJtG1W8Mx
	2y7gYCQPHD5GI8Yf4w5KNWZEzLYV2Nczj4gkuK5IjkW+ALg/Xfe8yXEzqdsEi17MXpo9kfmylCERy
	NjzptxDnmKSgSMaMx1B0wj4ehBklOaxJAUGjxzf1WvBLuNhuxJs0hLHztVCzv+IqjkKmTeO3ikMLn
	s++CtIlhOdhsGpPVZBvkFrLxeHx6w2wfyBt3BNpq99Ymnf2g3K0bZ9jHa9oBCxbowEi9ovsGF/99p
	LJfySiyFKdz64jFMEIDTLXBOLhpe1pmALhPPgEfNfXMS2yVLRwyQ0oOAmlzpkhv9x4579NkdKLQXw
	OShF9f42w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4V8E-0003tp-U9; Tue, 26 Jan 2021 20:40:10 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4V5B-0002Qn-Oh
 for linux-nvme@merlin.infradead.org; Tue, 26 Jan 2021 20:37:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=9NjX5dW51NzdpEEGKDwGLZVNXAAzSTFL5oPNKUOCDHw=; b=LbUs+pQpKe8c5LviMQ7Fmc5Ow4
 t9mgR+VmW7gufQcgQWmZQX0XOP3wJLhrBwsuPXUsJhxxq762Qa/c3COofmdk97qozOl2uxijyvzD6
 8D4pgJp8rg+GeM2bRNBZ8cva3LvOC9c2ZcZJnAQiUqdivX2dw9BUwKUoZvRVbS6K9tOeOLZwSFPT3
 OX6sjJppiwko7oxH3TquC7Ywyqyb6gRpdagWOMdwgJp+y8hzyYXxMHRRD6kJpp5c/52BVdL8bhfwe
 n6dcw+a/QprxpqQsYHEefPw9As7rjEUkAAkpQMV/rcy94ZUFz2012VIeOPWkb1BcQS12nk0u9OYe/
 zSVBwZMg==;
Received: from mx2.suse.de ([195.135.220.15])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1l4V2O-006FGm-RC
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 20:34:59 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1611693231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9NjX5dW51NzdpEEGKDwGLZVNXAAzSTFL5oPNKUOCDHw=;
 b=UxYwqISQwUzNlmykxrgXDhrwAiIsFts/qCQ4gCopHlFRTgbp/b1vkrZL+h4Ka+h+kcbyt6
 ioYjdxwmG0MAgAhXIB0QbG0ipbOfewfw/lXZ4OSlhUbHejzvK/S8fzYxyrNoKd7OU5Om5d
 nEBhdjMBrcqHwuvc0YJXkKQF7krJcRU=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 87176B16A;
 Tue, 26 Jan 2021 20:33:51 +0000 (UTC)
From: mwilck@suse.com
To: Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 32/35] nvmf-autoconnect: add unit file for nvme-monitor.service
Date: Tue, 26 Jan 2021 21:33:21 +0100
Message-Id: <20210126203324.23610-33-mwilck@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126203324.23610-1-mwilck@suse.com>
References: <20210126203324.23610-1-mwilck@suse.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_203459_345915_7E5B672F 
X-CRM114-Status: GOOD (  11.25  )
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

Signed-off-by: Martin Wilck <mwilck@suse.com>
---
 nvmf-autoconnect/systemd/nvme-monitor.service | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 nvmf-autoconnect/systemd/nvme-monitor.service

diff --git a/nvmf-autoconnect/systemd/nvme-monitor.service b/nvmf-autoconnect/systemd/nvme-monitor.service
new file mode 100644
index 0000000..d85b133
--- /dev/null
+++ b/nvmf-autoconnect/systemd/nvme-monitor.service
@@ -0,0 +1,17 @@
+[Unit]
+Description=NVMe Event Monitor for Automatical Subsystem Connection
+Documentation=man:nvme-monitor(1)
+DefaultDependencies=false
+Requires=systemd-udevd-kernel.socket
+RequiresMountsFor=/sys
+Conflicts=shutdown.target
+After=systemd-udevd-kernel.socket
+Before=sysinit.target systemd-udev-trigger.service nvmefc-boot-connections.service
+
+[Service]
+Type=simple
+ExecStart=/usr/sbin/nvme monitor -A -p
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
