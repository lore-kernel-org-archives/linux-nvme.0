Return-Path: <SRS0=M30F=P7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172A0C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 14:56:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B116E601FA
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 14:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B116E601FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QEEZKASnBfntd7FSlvUNnenXVHB7FgyLaB8toBCooNA=; b=xNif7x8YUxCqjQNg+0gbscW07A
	NQolm3fEzhNGVsVeu9bDELemuq+OLDbGjZrToFcYqTrxOsjCNEa0hBi/MIdANtCwuIQSCG0hZu5S0
	bt2PnmhJNJ6x+CRlnLlsZG9/G90HbxnwvZHA+VBcGFWHMzu4CgnKFW22QpWtDG3VESXUJeBghfUPU
	hSw7IhQWi0f8vMtcC1mqPKQ0z82JZg+kEtiGX2WQ5vEckOQVTW18bCwcWvc7HCodWQj63obGOArCg
	3y2ofuudqZBmiCqBd0uIkd/TVgkROZRtnthSg/BLzQV3FsqoxhvWmdlgAAPDbIx05bnTOBLzNmExN
	VIL3bE+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mlXyw-00AwJF-6s; Fri, 12 Nov 2021 14:56:46 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mlXns-00AsN6-Fg
 for linux-nvme@lists.infradead.org; Fri, 12 Nov 2021 14:45:22 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 9DE6A21991;
 Fri, 12 Nov 2021 14:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636728318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QEEZKASnBfntd7FSlvUNnenXVHB7FgyLaB8toBCooNA=;
 b=0BtuCFFM90ukmn+xXZUUuj09EVttl/0gXUKVtGqQghq3aUJTYEn6ysGCKgmxZR188U50YW
 dd5ySlEmw6mrHW37+3N5v9tV7lBXDJ9r3zFJuSr6pBuhGtnFY38gyjEfWj9GDvwjBgUK5w
 lMN9VALQgJyKCIElT5oG+lrV1vaHBqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636728318;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QEEZKASnBfntd7FSlvUNnenXVHB7FgyLaB8toBCooNA=;
 b=LQ+5Mx73CCNKenmI/vRDYEnCH3s+Kv9jrUvnfIMwlet8BvNBUlRynC7EndQosDuViXKOi0
 OV+EQZHKV2+xZGBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 628FDA3B8E;
 Fri, 12 Nov 2021 14:45:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 543DC5191283; Fri, 12 Nov 2021 15:45:18 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/6] nvmeof-tcp/002: create an authenticated nvmeof-tcp
 connection
Date: Fri, 12 Nov 2021 15:45:06 +0100
Message-Id: <20211112144510.98523-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211112144510.98523-1-hare@suse.de>
References: <20211112144510.98523-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211112_064520_728089_EDEB9DC1 
X-CRM114-Status: GOOD (  13.90  )
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
 tests/nvmeof-tcp/002     | 62 ++++++++++++++++++++++++++++++++++++++++
 tests/nvmeof-tcp/002.out |  6 ++++
 2 files changed, 68 insertions(+)
 create mode 100644 tests/nvmeof-tcp/002
 create mode 100644 tests/nvmeof-tcp/002.out

diff --git a/tests/nvmeof-tcp/002 b/tests/nvmeof-tcp/002
new file mode 100644
index 0000000..fad77c9
--- /dev/null
+++ b/tests/nvmeof-tcp/002
@@ -0,0 +1,62 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
+#
+# Test nvme over tcp authentication
+
+. tests/nvmeof-tcp/rc
+
+DESCRIPTION="Create authenticated TCP connection via localhost"
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
+	nvme connect -t "${nvme_trtype}" -n "${subsys}1" \
+	     -a "${def_traddr}" -s "${def_trsvcid}" -S "${hostkey}" \
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
+	rm ${scratch}
+
+	echo "Test complete"
+}
diff --git a/tests/nvmeof-tcp/002.out b/tests/nvmeof-tcp/002.out
new file mode 100644
index 0000000..c46ad3c
--- /dev/null
+++ b/tests/nvmeof-tcp/002.out
@@ -0,0 +1,6 @@
+Running nvmeof-tcp/002
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.26.2


