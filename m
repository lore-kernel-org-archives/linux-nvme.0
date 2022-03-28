Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6824C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Mar 2022 10:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w3a2mWfvTxAToLHUZvr2KYzsEc9hzI1B8bhb78yrFEY=; b=r2WUUIiHqcroTeztqY5h/f2wCK
	BIe3NOFu/vgMjqTkgU2eR3Nuje7MjiK7PsVtwEl1RaoYd4QAZVKx05RwJkzi5x+/HiiJOtkzA5QPC
	W7veJZOdBBJjk4cTcesW4SZRUkc3wj9gsvtsA+E/FqCifYZBl4yU2ALZr4EVATFjSXkkkkkkAivlH
	SViyczFMg6VHITvghsMLmwXg7JE0lB7hw5SmU9MIberAoVed4iMf0AQvEVM3STVmr3e+Btt/NH+nA
	cj8YoTbV6Q27uvF5qmy3iVfpj8nKddNhqYGwTgB5dMun92rCg8RZGspb+wAoStmlqsBbgBMDMQgiK
	pw3BniHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nYmTY-008962-EM; Mon, 28 Mar 2022 10:19:52 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nYmT3-0088uY-O6
 for linux-nvme@lists.infradead.org; Mon, 28 Mar 2022 10:19:25 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 57E89210F1;
 Mon, 28 Mar 2022 10:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648462760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3a2mWfvTxAToLHUZvr2KYzsEc9hzI1B8bhb78yrFEY=;
 b=AIQjU+YFuzUTnKnXnZJrC4zoawJuDBbbT3dzUWIZAUZGtoz+qGEWU5dXNlknHgqaQU7J5C
 raYBIDxTgclYPgKIzMl/h3MEZpyDB0GjUrrtq1XjtlOJOXHbZUYKjm3fjcHb27DcWzkcHz
 Av63q3vQoFWEC/494RRJliBScrwUvYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648462760;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3a2mWfvTxAToLHUZvr2KYzsEc9hzI1B8bhb78yrFEY=;
 b=kWuQ8HKuSwfc1wJxxw7qq9Sa7ratG3mnPRXnWvYevMJjRJo219N3GHJJkBHg/muCjSRXFv
 F6XA8qJ1jOr/GqDw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 4FCB9A3B97;
 Mon, 28 Mar 2022 10:19:20 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 4D9F751939C9; Mon, 28 Mar 2022 12:19:20 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Omar Sandoval <osandov@fb.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 08/10] nvme/041: test hash and dh group variations for
 authenticated connections
Date: Mon, 28 Mar 2022 12:18:53 +0200
Message-Id: <20220328101855.73975-9-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220328101855.73975-1-hare@suse.de>
References: <20220328101855.73975-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220328_031922_081626_7D804913 
X-CRM114-Status: GOOD (  12.26  )
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
 tests/nvme/041     | 89 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/041.out | 18 ++++++++++
 2 files changed, 107 insertions(+)
 create mode 100644 tests/nvme/041
 create mode 100644 tests/nvme/041.out

diff --git a/tests/nvme/041 b/tests/nvme/041
new file mode 100644
index 0000000..034c715
--- /dev/null
+++ b/tests/nvme/041
@@ -0,0 +1,89 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
+#
+# Test hash and dh group variations for authenticated connections
+
+. tests/nvme/rc
+
+DESCRIPTION="Test hash and DH group variations for authenticated connections"
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
+	for hash in "hmac(sha256)" "hmac(sha384)" "hmac(sha512)" ; do
+
+		echo "Testing hash ${hash}"
+
+		_set_nvmet_hash "${hostnqn}" "${hash}"
+
+		_nvme_connect_subsys "${nvme_trtype}" "${subsys}" \
+				     "${def_traddr}" "${def_trsvcid}" \
+				     "${hostnqn}" "${hostid}" \
+				     "${hostkey}"
+
+		ctrldev=$(_find_nvme_dev "${subsys}")
+		if [ -z "$ctrldev" ] ; then
+			echo "nvme controller not found"
+		fi
+
+		_nvme_disconnect_subsys "${subsys}"
+	done
+
+	for dhgroup in "ffdhe2048" "ffdhe3072" "ffdhe4096" "ffdhe6144" "ffdhe8192" ; do
+
+		echo "Testing DH group ${dhgroup}"
+
+		_set_nvmet_dhgroup "${hostnqn}" "${dhgroup}"
+
+		_nvme_connect_subsys "${nvme_trtype}" "${subsys}" \
+				     "${def_traddr}" "${def_trsvcid}" \
+				     "${hostnqn}" "${hostid}" \
+				     "${hostkey}"
+
+		ctrldev=$(_find_nvme_dev "${subsys}")
+		if [ -z "$ctrldev" ] ; then
+			echo "nvme controller not found"
+		fi
+
+		_nvme_disconnect_subsys "${subsys}"
+	done
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
diff --git a/tests/nvme/041.out b/tests/nvme/041.out
new file mode 100644
index 0000000..e8558d3
--- /dev/null
+++ b/tests/nvme/041.out
@@ -0,0 +1,18 @@
+Running nvme/041
+Testing hash hmac(sha256)
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing hash hmac(sha384)
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing hash hmac(sha512)
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing DH group ffdhe2048
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing DH group ffdhe3072
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing DH group ffdhe4096
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing DH group ffdhe6144
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing DH group ffdhe8192
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.29.2


