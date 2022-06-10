Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C16C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 11:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8hm5AP1OL60EjQ5W4Zf5iNi1e2FVoBavWklN7GZmkic=; b=B2uenJT2W5fwTV1fLokupDgFnl
	DyyC+ZWjXh5AAVhGOywXXVIPATHrW+bbUxvfAtwFc7hKWm1hV7JogF25t4kU/sMCH/kYd1pVeTQjU
	Au7UPXmWId3edCdIBQv+tRLThAR/Iy37qUwIUCUNHnJ0tHRLL4RPmdbcWfZHxN0CfnmZCMhG3UeMh
	gF0TVHXAgpeTAwR6qXvhmN2tEhdTdVUf5UPMsg50l75buJm5Eo9Qohk8kDjcIvg/6fyXjJi99sJos
	/O7uX6+dmjwFHi90xQQ8UW8C54Iaoo3mxqXj0faBU8IX4FNYJ750Zyp2WRNdd28a0eVUHfZi6r2Oj
	6LajaiLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzctq-007vsv-Jl; Fri, 10 Jun 2022 11:33:58 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzctT-007vit-56
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 11:33:41 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id DC9481F985;
	Fri, 10 Jun 2022 11:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1654860813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8hm5AP1OL60EjQ5W4Zf5iNi1e2FVoBavWklN7GZmkic=;
	b=zTBIsnzaPGWwvBOlO35sJ3sfWUyg7i0NVf30Ikn1+UQCJ83ZaFjksD1zmvISEk0V6w5FAC
	cIejwedAy8rZM4GcPAp5xSVrr4P/2rYJRaHfa632jwBokGBGqfLAuUuPll3x15nyXzO+2e
	eh1fIFbd0/IUc2oNelUIH2MYYf90JIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1654860813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8hm5AP1OL60EjQ5W4Zf5iNi1e2FVoBavWklN7GZmkic=;
	b=7bcU33guy4Bwt+qrmaCJDcwCAisO4RusG6OQtTiSWC8AtXpzfOkowukjodn6uWPMRCt669
	QuXE6LPlE8500vAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id D11602C14B;
	Fri, 10 Jun 2022 11:33:33 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id A4D925194A42; Fri, 10 Jun 2022 13:33:33 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 06/10] nvme/040: create authenticated connections
Date: Fri, 10 Jun 2022 13:33:20 +0200
Message-Id: <20220610113324.10294-7-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220610113324.10294-1-hare@suse.de>
References: <20220610113324.10294-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_043335_433526_C30B9438 
X-CRM114-Status: GOOD (  12.58  )
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
 tests/nvme/040     | 81 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/040.out |  7 ++++
 2 files changed, 88 insertions(+)
 create mode 100644 tests/nvme/040
 create mode 100644 tests/nvme/040.out

diff --git a/tests/nvme/040 b/tests/nvme/040
new file mode 100644
index 0000000..ce6157f
--- /dev/null
+++ b/tests/nvme/040
@@ -0,0 +1,81 @@
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
+	_have_loop
+	_require_nvme_trtype_is_fabrics
+	_require_nvme_cli_auth
+}
+
+
+test() {
+	local port
+	local subsys_name="blktests-subsystem-1"
+	local hostid="$(uuidgen)"
+	local hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
+	local file_path="${TMPDIR}/img"
+	local hostkey
+	local ctrldev
+
+	echo "Running ${TEST_NAME}"
+
+	hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
+	if [ $? -ne 0 ] ; then
+		echo "nvme gen-dhchap-key command missing"
+		return 1
+	fi
+
+	_setup_nvmet
+
+	truncate -s 512M "${file_path}"
+
+	_create_nvmet_subsystem "${subsys_name}" "${file_path}" \
+		"b92842df-a394-44b1-84a4-92ae7d112861"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
+	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_create_nvmet_host "${subsys_name}" "${hostnqn}" "${hostkey}"
+
+	# Test unauthenticated connection (should fail)
+	echo "Test unauthenticated connection"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+			     "${def_traddr}" "${def_trscvid}" \
+			     "${hostnqn}" "${hostid}"
+	if [ $? -eq 0 ] ; then
+		echo "nvme connect succeeded"
+	fi
+
+	_nvme_disconnect_subsys "${subsys_name}"
+
+	# Test authenticated connection
+	echo "Test authenticated connection"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+			     "${def_traddr}" "${def_trscvid}" \
+			     "${hostnqn}" "${hostid}" "${hostkey}"
+	if [ $? -ne 0 ] ; then
+		echo "nvme connect failed"
+	fi
+
+	udevadm settle
+
+	_nvme_disconnect_subsys "${subsys_name}"
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
+	_remove_nvmet_subsystem "${subsys_name}"
+
+	_remove_nvmet_port "${port}"
+
+	_remove_nvmet_host "${hostnqn}"
+
+	rm "${file_path}"
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/040.out b/tests/nvme/040.out
new file mode 100644
index 0000000..b5da85f
--- /dev/null
+++ b/tests/nvme/040.out
@@ -0,0 +1,7 @@
+Running nvme/040
+Test unauthenticated connection
+no controller found: failed to write to nvme-fabrics device
+NQN:blktests-subsystem-1 disconnected 0 controller(s)
+Test authenticated connection
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.26.2


