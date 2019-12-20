Return-Path: <SRS0=LlAf=2K=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968E7C43603
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2019 03:32:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 645BF24680
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Dec 2019 03:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ESWYvIF0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtK0wIjv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645BF24680
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MQ4eTRgNADWgvJmG3+DpOWiV/NK+kMT91dLvA1BQq9g=; b=ESWYvIF0ZQhjH8
	bkRhgGD3XgYcWgJBn+wMkYA35sY1gP+GQTGCN+cF7YC3sBXHWZrYKhyqO76we0IXQhyWY2n+1Su4P
	+fMTF2aQORZwF3toQ0RxOxK1Z9ZQPZurQDthKFHmSeI0wTnB6/7YJkO/+05+4013hacFETrvVLMfK
	jHRdMRG/eb4i0x4Uad2GHgyIiURHfaL4QzwbuGiG1P4n3leIGEzs2VIBwQMdkUrkRvafnQv0JB1zC
	GDIeq3qeL+ws4w/XpGdMryqVsRLXUETdbAKNmfS/MRqcbw0dClyZNNrK1Jqyb1abYvJIz1yitG4um
	lWH+EaJACbCeB4ZnJg7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ii91i-0007JA-DV; Fri, 20 Dec 2019 03:32:30 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ii90h-0006Ys-FP
 for linux-nvme@lists.infradead.org; Fri, 20 Dec 2019 03:31:30 +0000
Received: from localhost (36-236-5-169.dynamic-ip.hinet.net [36.236.5.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 278BD24680;
 Fri, 20 Dec 2019 03:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576812687;
 bh=YD8ch1dgnhr96Bcs6yOJW5tSmKSai696pi1ntxM0O4I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XtK0wIjv4kGzmjTDM3gx9sZWnjcVK/ajA59kOlDYxa9SnuNimaXbPyfxmruPzkzAq
 Mx3F3a6aU6Wl5yg2S6km3vOpF7QtIdDE8+GZB11IuQfdFTWtJEMX6OuLTZGn6WQi4+
 /ptWDI7DISS9sjHERKoRxpGCBKWuDYt1c1mF1aU4=
From: Andy Lutomirski <luto@kernel.org>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 4/4] Do not install /etc/nvme/hostid or /etc/nvme/hostnqn by
 default
Date: Thu, 19 Dec 2019 19:31:05 -0800
Message-Id: <0537703137403a60ecd278610663db2d29f95624.1576726427.git.luto@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1576726427.git.luto@kernel.org>
References: <cover.1576726427.git.luto@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191219_193127_731103_190DAC00 
X-CRM114-Status: UNSURE (   8.63  )
X-CRM114-Notice: Please train this message.
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
Cc: Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Pre-generating them is nonsensical for package managers.  Moreover,
with the new systemd-generated ID support, it's preferable for the
files to be absent.  Don't generate them unless explicitly requested.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index d88404dd51f6..acb6983cb5b1 100644
--- a/Makefile
+++ b/Makefile
@@ -140,14 +140,12 @@ install-hostparams: install-etc
 
 install-etc:
 	$(INSTALL) -d $(DESTDIR)$(SYSCONFDIR)/nvme
-	touch $(DESTDIR)$(SYSCONFDIR)/nvme/hostnqn
-	touch $(DESTDIR)$(SYSCONFDIR)/nvme/hostid
 	if [ ! -f $(DESTDIR)$(SYSCONFDIR)/nvme/discovery.conf ]; then \
 		$(INSTALL) -m 644 -T ./etc/discovery.conf.in $(DESTDIR)$(SYSCONFDIR)/nvme/discovery.conf; \
 	fi
 
 install-spec: install-bin install-man install-bash-completion install-zsh-completion install-etc install-systemd install-udev install-dracut
-install: install-spec install-hostparams
+install: install-spec
 
 nvme.spec: nvme.spec.in NVME-VERSION-FILE
 	sed -e 's/@@VERSION@@/$(NVME_VERSION)/g' < $< > $@+
-- 
2.23.0


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
