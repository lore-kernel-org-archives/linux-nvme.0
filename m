Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABD7C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Mar 2022 10:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tqekc63nzHmrqj+sWBcGGlsveY5sBq7Ei7r42cLUVUs=; b=ZNvYQkCtfHARcic+RYQFayIAK4
	fbtl2JumQXZqcWrxyj8v6ywJKIgk7gqnKbj8u8nnZoGH7uuBrHdufPAhLTKRRdLCdoh9HvzWdwbVV
	p2vfK1ODC4V7VbbIdwQ7PO4W04Tcg3OPjs1vbLPGQ4NYu3gROK2eeW4p0O6BkiqtqNjDMGY2WZPBi
	OteDeHzKlJStkHPmEHYSGElppSEqyJenpqFaphqzZHad31BOdow5yDV9P9Bw1l/CfEmzCxRzbI2bU
	U6wgmDAZWTsI7QdQDl3BSCkK7Y83b6JnawvBolSwGGGcsA+yEwRhXqbNA4+zUW8Wt9FOm5aGUrYVr
	FhjWoznw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nYmUP-0089Sq-Eb; Mon, 28 Mar 2022 10:20:45 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nYmT6-0088wu-JH
 for linux-nvme@lists.infradead.org; Mon, 28 Mar 2022 10:19:28 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 5BD8A1F38A;
 Mon, 28 Mar 2022 10:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648462760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tqekc63nzHmrqj+sWBcGGlsveY5sBq7Ei7r42cLUVUs=;
 b=ct01pD9pvDrNc7Y05R5c9B3YMGbfE7WfhSOGP6gzkyQUYp8Cw241uQQL6Wu9MhDCktw9uM
 IqHK5RVPeuCRKpeMvdNu3qmXQKjE8pCNh2KUwRkpSJGGSXSBV22pFz09bNKZTbtSaPBabE
 zTHtZPDOAm4sCtYDILaBRWsKSwYlbIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648462760;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tqekc63nzHmrqj+sWBcGGlsveY5sBq7Ei7r42cLUVUs=;
 b=TixUgsJ8MXtmLl/96Ksurj1upFuUlWQqdYAqBZyk/AuR06Xb5cR5LFEvCTC/FOeNPtg/qB
 6vjnssyJy6MRaCDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 560F7A3B98;
 Mon, 28 Mar 2022 10:19:20 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 52EB151939CB; Mon, 28 Mar 2022 12:19:20 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Omar Sandoval <osandov@fb.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 09/10] nvme/042: test bi-directional authentication
Date: Mon, 28 Mar 2022 12:18:54 +0200
Message-Id: <20220328101855.73975-10-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220328101855.73975-1-hare@suse.de>
References: <20220328101855.73975-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220328_031924_822608_C43E4A80 
X-CRM114-Status: GOOD (  13.10  )
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
 tests/nvme/042     | 107 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/042.out |   8 ++++
 2 files changed, 115 insertions(+)
 create mode 100644 tests/nvme/042
 create mode 100644 tests/nvme/042.out

diff --git a/tests/nvme/042 b/tests/nvme/042
new file mode 100644
index 0000000..f3954b4
--- /dev/null
+++ b/tests/nvme/042
@@ -0,0 +1,107 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
+#
+# Test bi-directional authentication
+
+. tests/nvme/rc
+
+DESCRIPTION="Test bi-directional authentication"
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
+	local subsys="blktests-subsystem-1"
+	local hostid="$(uuidgen)"
+	local hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
+	local scratch="/tmp/blktest-ns1.img"
+	local hostkey
+	local ctrlkey
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
+	ctrlkey="$(nvme gen-dhchap-key -n ${subsys} 2> /dev/null)"
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
+	_create_nvmet_host "${subsys}" "${hostnqn}" "${hostkey}" "${ctrlkey}"
+
+	_set_nvmet_dhgroup "${hostnqn}" "ffdhe2048"
+
+	# Step 1: Connect with host authentication only
+	echo "Test host authentication"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys}" \
+			     "${def_traddr}" "${def_trsvcid}" \
+			     "${hostnqn}" "${hostid}" \
+			     "${hostkey}"
+
+	ctrldev=$(_find_nvme_dev "${subsys}")
+	if [ -z "$ctrldev" ] ; then
+		echo "nvme controller not found"
+	fi
+
+	_nvme_disconnect_subsys "${subsys}"
+
+	# Step 2: Connect with host authentication
+	# and invalid ctrl authentication
+	echo "Test host authentication and invalid ctrl authentication"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys}" \
+			     "${def_traddr}" "${def_trsvcid}" \
+			     "${hostnqn}" "${hostid}" \
+			     "${hostkey}" "${hostkey}"
+	ctrldev=$(_find_nvme_dev "${subsys}1")
+	if [ -n "${ctrldev}" ] ; then
+		echo "nvme controller found!"
+		_nvme_disconnect_subsys "${ctrldev}"
+	fi
+
+	# Step 3: Connect with host authentication
+	# and valid ctrl authentication
+	echo "Test host authentication and valid ctrl authentication"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys}" \
+			     "${def_traddr}" "${def_trsvcid}" \
+			     "${hostnqn}" "${hostid}" \
+			     "${hostkey}" "${ctrlkey}"
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
diff --git a/tests/nvme/042.out b/tests/nvme/042.out
new file mode 100644
index 0000000..17a461b
--- /dev/null
+++ b/tests/nvme/042.out
@@ -0,0 +1,8 @@
+Running nvme/042
+Test host authentication
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test host authentication and invalid ctrl authentication
+no controller found
+Test host authentication and valid ctrl authentication
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.29.2


