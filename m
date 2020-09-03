Return-Path: <SRS0=8iPx=CM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D91AC43461
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 23:54:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DD5D206B7
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 23:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YUUOwg3B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD5D206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4k/q/aaS3e/leqq4LHnNZ2Gye4zuL566fPfBrHeUFVo=; b=YUUOwg3BHWVtUherjEVUl1cm7
	56o6v78XivomO3MsKZnfbxnranca+1TsMf9ylZjMa/JWIGgHpujrKRm45DaU0xZaMcFEqdUWntRAe
	cWqrfNyGeVHsp2vg+Q8VgLkeFAMdHbQ/m1XCHqzsKwHTa8xDvo7Sy5ZUrj97MjC0Eyp7+rcdSxYSk
	/bz9C8Elcxs0qk217pXRxLbJUTLaTcqMGpLOILSxCn1wQ/UWjDJJ9n5SURZ7JPwS8FgGPmfyt9mXc
	4LahRLWOXBmLX09pQLN7QUKIkHmAIldq+NXk7raCTYxvLeV1fdlmeQUpaEpxZfHANRg70lsXUTudO
	hrY/4JuOQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDz3P-0001tF-M3; Thu, 03 Sep 2020 23:54:07 +0000
Received: from mail-wr1-f66.google.com ([209.85.221.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDz3L-0001rG-QH
 for linux-nvme@lists.infradead.org; Thu, 03 Sep 2020 23:54:04 +0000
Received: by mail-wr1-f66.google.com with SMTP id x14so4903309wrl.12
 for <linux-nvme@lists.infradead.org>; Thu, 03 Sep 2020 16:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E4766iF8tGytH+Vfs6i3/U2RwWmzQyiBC+bGyaYv3Kg=;
 b=NgSkkZed+ZgAOSgD5bPletC3/Ii+DKvckP+2nw+7QsV7DjmUEA530JNb/wAKOpnnRE
 TnjcfMG2UFuBxrh40wFQ4si4L987IDWU6YUrwWiMwjap8mFg+XVHn3HO5qn6nq7yzLxb
 xi0vAXSB4wMzYpiZ+TkXVhp5/ATBsoyfcES6orSS4yNTEYoWVphHapbaS0Jl/Pqm7uwP
 TKM/KLzY00L2WKVdUg4QnbJP+OBVKRHwysUmcjotH7G1WP/7di4JJ01vWE+7qdTb8UgK
 qYgdq9wYOJyThaPgtgcsyVzVqbHLSpXZE/lOJkt2aTbuULPX3uTwaw95oPjaf89MZoip
 VPKg==
X-Gm-Message-State: AOAM532KS3z4LqRQvmYiy7jeM3n7GCyc62peqqW6DblqzrEglc4y7Aoa
 9CxW92CspjuTUAqP6emMESEj7LNn0Jmp5Q==
X-Google-Smtp-Source: ABdhPJz9wmNhEgElMHthJYRKXZb/0dVNl4i6PMis1ISMWyfAJycy+sQwiYvzl1r4Q9BtwymoHqNVpQ==
X-Received: by 2002:adf:db88:: with SMTP id u8mr4752891wri.184.1599177242817; 
 Thu, 03 Sep 2020 16:54:02 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:79a5:e112:bd7c:4b29])
 by smtp.gmail.com with ESMTPSA id u17sm7024992wmm.4.2020.09.03.16.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 16:54:02 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-block@vger.kernel.org,
	Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v7 6/7] common: move module_unload to common
Date: Thu,  3 Sep 2020 16:53:36 -0700
Message-Id: <20200903235337.527880-7-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903235337.527880-1-sagi@grimberg.me>
References: <20200903235337.527880-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_195403_920462_077523FE 
X-CRM114-Status: GOOD (  13.92  )
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
Cc: Keith Busch <kbusch@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

It creates a dependency between multipath-over-rdma and test/nvmeof/rc
(and test/srp/rc) which is not a natural home for it.

Move it to common helpers.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 common/rc          | 13 +++++++++++++
 tests/nvmeof-mp/rc | 13 -------------
 tests/srp/rc       | 13 -------------
 3 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/common/rc b/common/rc
index 7f02103dc786..cdc0150ea5ea 100644
--- a/common/rc
+++ b/common/rc
@@ -291,3 +291,16 @@ _filter_xfs_io_error() {
 _uptime_s() {
 	awk '{ print int($1) }' /proc/uptime
 }
+
+# Arguments: module to unload ($1) and retry count ($2).
+unload_module() {
+	local i m=$1 rc=${2:-1}
+
+	[ ! -e "/sys/module/$m" ] && return 0
+	for ((i=rc;i>0;i--)); do
+		modprobe -r "$m"
+		[ ! -e "/sys/module/$m" ] && return 0
+		sleep .1
+	done
+	return 1
+}
diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc
index b95adf047a2f..d7a7c878fb19 100755
--- a/tests/nvmeof-mp/rc
+++ b/tests/nvmeof-mp/rc
@@ -149,19 +149,6 @@ remove_mpath_devs() {
 	} &>> "$FULL"
 }
 
-# Arguments: module to unload ($1) and retry count ($2).
-unload_module() {
-	local i m=$1 rc=${2:-1}
-
-	[ ! -e "/sys/module/$m" ] && return 0
-	for ((i=rc;i>0;i--)); do
-		modprobe -r "$m"
-		[ ! -e "/sys/module/$m" ] && return 0
-		sleep .1
-	done
-	return 1
-}
-
 start_nvme_client() {
 	modprobe nvme-core dyndbg=+pmf &&
 		modprobe nvme dyndbg=+pmf &&
diff --git a/tests/srp/rc b/tests/srp/rc
index 72a3bca3b44d..7fc094b8267f 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -321,19 +321,6 @@ remove_mpath_devs() {
 	} &>> "$FULL"
 }
 
-# Arguments: module to unload ($1) and retry count ($2).
-unload_module() {
-	local i m=$1 rc=${2:-1}
-
-	[ ! -e "/sys/module/$m" ] && return 0
-	for ((i=rc;i>0;i--)); do
-		modprobe -r "$m"
-		[ ! -e "/sys/module/$m" ] && return 0
-		sleep .1
-	done
-	return 1
-}
-
 # Load the SRP initiator driver with kernel module parameters $1..$n.
 start_srp_ini() {
 	modprobe scsi_transport_srp || return $?
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
