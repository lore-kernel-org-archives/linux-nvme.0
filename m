Return-Path: <SRS0=M30F=P7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA90C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 14:59:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2B606023F
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 14:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F2B606023F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1t0edND/6kdv04LexoM3a0Q4mNvwbW+NUr0Bv7TtoVE=; b=lVzDhjzo8opMmXminoyOZFul0C
	BtpDKyLyON5tOV/34XLW++JHhffYSsf8sPUH33EiaYe5Rdo0xOptUTnyP8mlZpTDmFqW+JnC9TVuS
	aYM5D6ea1jLIztV6EcWqSz2hYTfVnBPjloeqx3wDp6xSLzBPugXspG0Nldj2I6SgtuQu8KdVabwQf
	RdxZt0ij2NAqvxOCwLQ9u6ID6BzQzDr46Dga1ng6hXzSriH3+45UIJqJN22/n0AAqeYtRCOiQVhxo
	ReOAl3dRcp2b8fz836KaakSXIp/eMf5/JETnkmuwuzW8H7a+FRpyESc7KhoAUWPZCyW3Udou4ksmx
	ffw5++ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mlY1Q-00Ax5E-TY; Fri, 12 Nov 2021 14:59:20 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mlXns-00AsN5-Gd
 for linux-nvme@lists.infradead.org; Fri, 12 Nov 2021 14:45:23 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id A51231FD68;
 Fri, 12 Nov 2021 14:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636728318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1t0edND/6kdv04LexoM3a0Q4mNvwbW+NUr0Bv7TtoVE=;
 b=AgpYxw6IA3ezMiqO4GJFI/WfInopPKDbw0NKTTj3RA70zfycwnknLQ7yoRp03n8EHjNsfd
 UFN++0LILSQ5xzXCY7BxHNqsQKZsvifFV7k9CUUzFoBMLICZAQ+NnAEnzFZY6bq93quqM2
 rNS+QroBW9P+G0BH/p0TnFqCbdlW83E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636728318;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1t0edND/6kdv04LexoM3a0Q4mNvwbW+NUr0Bv7TtoVE=;
 b=5lfjKLtkYtV1OgztMo0XliYzo8hodZ1cE3bCcvCZ0YJa/WhX0TZ9mb6KqrBHByfe5tIEZi
 iD5uN+Yqa7ozi/Dg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 9BECDA3B83;
 Fri, 12 Nov 2021 14:45:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 657565191289; Fri, 12 Nov 2021 15:45:18 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 5/6] nvmeof-tcp/005: test bi-directional authentication
Date: Fri, 12 Nov 2021 15:45:09 +0100
Message-Id: <20211112144510.98523-6-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211112144510.98523-1-hare@suse.de>
References: <20211112144510.98523-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211112_064520_843789_2B975D96 
X-CRM114-Status: GOOD (  13.79  )
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

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 tests/nvmeof-tcp/005     | 74 ++++++++++++++++++++++++++++++++++++++++
 tests/nvmeof-tcp/005.out |  6 ++++
 2 files changed, 80 insertions(+)
 create mode 100644 tests/nvmeof-tcp/005
 create mode 100644 tests/nvmeof-tcp/005.out

diff --git a/tests/nvmeof-tcp/005 b/tests/nvmeof-tcp/005
new file mode 100644
index 0000000..f33030a
--- /dev/null
+++ b/tests/nvmeof-tcp/005
@@ -0,0 +1,74 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
+#
+# Test nvme over tcp bi-directional authentication
+
+. tests/nvmeof-tcp/rc
+
+DESCRIPTION="Test bi-directional authentication for TCP connection via localhost"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_modules loop
+	_require_nvme_trtype_is_fabrics
+}
+
+
+test() {
+	local port
+	local genctr
+	local subsys="blktests-subsystem-"
+	local hostid="$(uuidgen)"
+	local hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
+	local scratch="/tmp/blktest-ns1.img"
+	local hostkey
+
+	echo "Running ${TEST_NAME}"
+
+	hostkey="$(nvme gen-dhchap-key -n ${subsys}1 2> /dev/null)"
+	if [ $? -ne 0 ] ; then
+		echo "nvme gen-dhchap-key command missing"
+		return 1
+	fi
+
+	ctrlkey="$(nvme gen-dhchap-key -n ${subsys}1 2> /dev/null)"
+	if [ $? -ne 0 ] ; then
+		echo "nvme gen-dhchap-key command missing"
+		return 1
+	fi
+
+	_setup_nvmet
+
+	truncate -s 512M "${scratch}"
+
+	port="$(_create_nvmet_port "${nvme_trtype}")"
+
+	_create_nvmet_subsystem "${subsys}1" "${scratch}"
+	_add_nvmet_subsys_to_port "${port}" "${subsys}1"
+	_create_nvmet_host "${subsys}1" "${hostnqn}" "${hostkey}"
+
+	_set_nvmet_dhgroup "${hostnqn}" "ffdhe2048"
+	_set_nvmet_ctrlkey "${hostnqn}" "${ctrlkey}"
+	
+	nvme connect -t "${nvme_trtype}" -n "${subsys}1" \
+	     -a "${def_traddr}" -s "${def_trsvcid}" \
+	     -S "${hostkey}" -C "${ctrlkey}" \
+	     --hostnqn="${hostnqn}" --hostid="${hostid}"
+
+	nvme list-subsys
+
+	nvme disconnect -n "${subsys}1"
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys}1"
+	_remove_nvmet_subsystem "${subsys}1"
+
+	_remove_nvmet_port "${port}"
+
+	_remove_nvmet_host "${hostnqn}"
+
+	rm ${scratch}
+
+	echo "Test complete"
+}
diff --git a/tests/nvmeof-tcp/005.out b/tests/nvmeof-tcp/005.out
new file mode 100644
index 0000000..2cd467a
--- /dev/null
+++ b/tests/nvmeof-tcp/005.out
@@ -0,0 +1,6 @@
+Running nvmeof-tcp/005
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.26.2


