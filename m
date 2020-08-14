Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276E2C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:19:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9E8220838
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="yEyp6yn8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9E8220838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LXYMzjQwTxeU4BSRJbYnvhjfQoxENbdi7QZywjxbAb8=; b=yEyp6yn8lLs5WAP3xp2kjyDsD
	aEAsyq/1a3TPffCLPFQgGTiH0SVm6ABbiJ0qC5IXSmYjOyT/5GMUEiPfPID+9rVDwiyWV4pvv0i8J
	nmE+gE9ivy8hmnu7k2G8QLUeVPDwazFgktFVdE4MVKW3Em+KYGI5qG0uL6cFMgxYRGJXNw5yI5Qpy
	B8r4/dFBH5wyvL8LKYOEtAqZvY8h5GTZcABst89OErUiwDxeG7B06bfNaIh4o3Ogj1K8hm2xrP8Z5
	hPhThuXqx/unR1V3mR+YwUmOzTwNmmfI5mJwiYM78UtVjL+WhyMO11eoM1hvZ6ZjEBmkRlbjqxfcU
	tzO0Pi7pA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6T3J-0002PM-MC; Fri, 14 Aug 2020 06:18:57 +0000
Received: from mail-wm1-f65.google.com ([209.85.128.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6T3G-0002Na-Fj
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 06:18:55 +0000
Received: by mail-wm1-f65.google.com with SMTP id 184so6982562wmb.0
 for <linux-nvme@lists.infradead.org>; Thu, 13 Aug 2020 23:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4OhW2rUuJwKjNaFcB34eClsm9+qjLIquHqcWEiCTCC0=;
 b=n0+SX5UiQUx+Py+9Age9wWzbZmVKAbBwPuKAXkq4MgsiihEZMBv8HUOAxJ7PmGkUzP
 ipUz3+w0oowKKtJ91R5vMa2ZlcHKcD1oihtYhVwA5YWR6TYV6NBTBHc9JWu199RQTHQz
 g/vmRKCcOtASIGbzZECV8RBq74Hhv3XY5/tGHNzeDbCVxC3Nt/IuIOgv2KdB03Gxdh95
 T4AsSnZmAMOV42B27kWkUGOVN6TNofka8BxWPOImKQ+eM6gbCrGl+VZLMjkvVy/HnTO7
 +M8MySaaPEf6VFoZoQRlR8bPd2YuNxNsmjiuiEQpJ12cJSZnPEAOevYU64LoxwHA9TIp
 6/IA==
X-Gm-Message-State: AOAM531ev2kBN5IHFm1zVbAhbSVW3KR3L5drc/t9EqD1ncN5RsaAoDkW
 Lloexz25v9aqtC9oSYb9eQl1J48jLzWjbQ==
X-Google-Smtp-Source: ABdhPJxFuWPIMgqdzeQoLSZO22LFh5x90KpUs2OtVL5I2U3yepGIHVF7CmBH8ySTLVYcTr4SVKpWqQ==
X-Received: by 2002:a1c:e907:: with SMTP id q7mr1110462wmc.155.1597385933249; 
 Thu, 13 Aug 2020 23:18:53 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:51f:3472:bc7:2f4f])
 by smtp.gmail.com with ESMTPSA id
 l21sm12278131wmj.25.2020.08.13.23.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 23:18:52 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v4 6/7] common: move module_unload to common
Date: Thu, 13 Aug 2020 23:18:14 -0700
Message-Id: <20200814061815.536540-7-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814061815.536540-1-sagi@grimberg.me>
References: <20200814061815.536540-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_021854_554101_819BC891 
X-CRM114-Status: GOOD (  14.20  )
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
Cc: Keith Busch <kbusch@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>
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
index e446db297ba1..829b26624b7f 100755
--- a/tests/nvmeof-mp/rc
+++ b/tests/nvmeof-mp/rc
@@ -145,19 +145,6 @@ remove_mpath_devs() {
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
index 4013e9514767..c36515066ffb 100755
--- a/tests/srp/rc
+++ b/tests/srp/rc
@@ -320,19 +320,6 @@ remove_mpath_devs() {
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
