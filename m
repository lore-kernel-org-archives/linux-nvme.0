Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7D3C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 07:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N+wvSDaVfcQeQsCDyyjpjdT4Ml557XVxoX6hGqAe6Kc=; b=L9nkWrNImswjGr5S9feEz7r4Qs
	uCjGkHpS+TIZTxfMoGuGbiZA8cvxJLrkowJyCYJlVx3sz4F1kX3nc0zYNPw8yfl5tO9WM0fD2dloj
	nA+WefbjoGEwiizre9z5uUdoDLsIEB7zplR8GukihkoB8WMbw7W8QiEg8hlr6AKfwAuRhKyxpRvFU
	S/yhud9MbNQULgxCLX+3MSq1JV12WI3SP1My0Mhosli4yhJB5MqM4g0kZjcf6lqdtNTNUE43oOsCE
	uhR+hzdWQ4J8KJ/wXRw6HFQxqhJo/X9Gt645Z1YCaZgwxfrlvSzl9uWkr3sGQJ084Xh0KM8eNrNgI
	/nLE/qbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpQbx-0017d5-8I; Tue, 23 Nov 2021 07:53:05 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpQYu-0016kK-Q5
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 07:49:58 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 23CF11FD60;
 Tue, 23 Nov 2021 07:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637653788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N+wvSDaVfcQeQsCDyyjpjdT4Ml557XVxoX6hGqAe6Kc=;
 b=D2uGv6YXsQ3nwIjh6rnBioGPss3QHvOr5rSMSsbHCEyhLNUyb1Y3p5WtCfnpELHka/29YK
 ThsCQ4MJo2zzCiTuWq3EasVjb68XgxMsqIiGqkcNN3BWNvky3dppgKv3JYqidGrYp+mvyf
 V276MAhpQp4nTdRveI/k0jLZ0N8sA4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637653788;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N+wvSDaVfcQeQsCDyyjpjdT4Ml557XVxoX6hGqAe6Kc=;
 b=eXViLJ0IjLVXUZSdfWgYJuuSfsuWO42sIAjY1f0Cy1/v3k6ntHTutW2umtTscWE7NM3Duv
 Yd4QXDO84gqmpJDw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 1BA86A3B90;
 Tue, 23 Nov 2021 07:49:48 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 2C545519188D; Tue, 23 Nov 2021 08:49:47 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 06/10] nvme/039: create authenticated connections
Date: Tue, 23 Nov 2021 08:49:36 +0100
Message-Id: <20211123074940.113390-7-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211123074940.113390-1-hare@suse.de>
References: <20211123074940.113390-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_234957_060996_C73EFEEF 
X-CRM114-Status: GOOD (  13.98  )
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
 tests/nvme/039     | 83 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/039.out |  7 ++++
 2 files changed, 90 insertions(+)
 create mode 100644 tests/nvme/039
 create mode 100644 tests/nvme/039.out

diff --git a/tests/nvme/039 b/tests/nvme/039
new file mode 100644
index 0000000..4fbe7de
--- /dev/null
+++ b/tests/nvme/039
@@ -0,0 +1,83 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
+#
+# Create authenticated connections
+
+. tests/nvme/rc
+
+DESCRIPTION="Create authenticated connections"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_modules loop
+	_require_nvme_trtype_is_fabrics
+	_require_nvme_cli_auth
+}
+
+
+test() {
+	local port
+	local subsys="blktests-subsystem-1"
+	local hostid="$(uuidgen)"
+	local hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
+	local scratch="/tmp/blktest-ns1.img"
+	local hostkey
+	local ctrldev
+
+	echo "Running ${TEST_NAME}"
+
+	hostkey="$(nvme gen-dhchap-key -n ${subsys} 2> /dev/null)"
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
+	_create_nvmet_subsystem "${subsys}" "${scratch}"
+	_add_nvmet_subsys_to_port "${port}" "${subsys}"
+	_create_nvmet_host "${subsys}" "${hostnqn}" "${hostkey}"
+
+	# Test unauthenticated connection (should fail)
+	echo "Test unauthenticated connection"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys}" \
+			     "${def_traddr}" "${def_trscvid}" \
+			     "${hostnqn}" "${hostid}"
+
+	ctrldev=$(_find_nvme_dev "${subsys}")
+	if [ -n "$ctrldev" ] ; then
+		echo "nvme controller found"
+	fi
+
+	_nvme_disconnect_subsys "${subsys}"
+
+	# Test authenticated connection
+	echo "Test authenticated connection"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys}" \
+			     "${def_traddr}" "${def_trscvid}" \
+			     "${hostnqn}" "${hostid}" "${hostkey}"
+
+	ctrldev=$(_find_nvme_dev "${subsys}")
+	if [ -z "$ctrldev" ] ; then
+		echo "nvme controller not found"
+	fi
+
+	_nvme_disconnect_subsys "${subsys}"
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys}"
+	_remove_nvmet_subsystem "${subsys}"
+
+	_remove_nvmet_port "${port}"
+
+	_remove_nvmet_host "${hostnqn}"
+
+	rm ${scratch}
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/039.out b/tests/nvme/039.out
new file mode 100644
index 0000000..e42d2f1
--- /dev/null
+++ b/tests/nvme/039.out
@@ -0,0 +1,7 @@
+Running nvme/039
+Test unauthenticated connection
+no controller found
+NQN:blktests-subsystem-1 disconnected 0 controller(s)
+Test authenticated connection
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.29.2


