Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BADDC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 11:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2bLHWv4wwaZkqyqK/tn1XsGscp6nCBbwd1QJXn5OsOI=; b=z/OraxfZj3nnyvKoaeqEU7gaol
	amXsGAT4Y7SCwobB4L8dd/pQTotckMjA7wKwOh3JgeByqMTQ/2nckJxFr172OrgpnR8+NVAVGic6R
	+sp7dYYQzlp/l9YvF6qIct3RcRAS40u5SAPOQr5g3vv5+xfz8IUd3qY+ZSOQRlpMCFIzzwzPif6ie
	XUyoA/tbkICyO3hG6cQ2LpKR248VkQV/PEOrt2GRVSL3HAsFVbdOgiijc+uH/rs7RGAJwfEmvK7v1
	6D8XxpI/DsFXpcKK/DcDWftt6F2pYfLksCH9sLGjVkGojtgHnPFe6rBG8yASNaKnIa+qhuRAeVBkC
	6YXC/KEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzcuU-007wG0-UO; Fri, 10 Jun 2022 11:34:38 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzcta-007vlz-PX
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 11:33:45 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id DDFF01F9AE;
	Fri, 10 Jun 2022 11:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1654860813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2bLHWv4wwaZkqyqK/tn1XsGscp6nCBbwd1QJXn5OsOI=;
	b=pAAZRipHOdn56A07qAM6EvDMdlW/NXHuSiGMsoEeNl8ORDqAsM4AtuW1zsIcWB4LWi3393
	3hhUDfW7Kh7McdVUdC+ky+5ZmW24BdxduH9612kv5Xty2mG6ECm2wmb+11j3ET98Fj+aej
	4Mt3rdJAamEL8Da1ORjOfNDvz4C2qzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1654860813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2bLHWv4wwaZkqyqK/tn1XsGscp6nCBbwd1QJXn5OsOI=;
	b=5/w0PsZWkJWdeUVNuTg3MP9a3wQZ5scEm6dPn90uNwfTCQe9XyXTKpbmoEXYlT4sjoOLSS
	SxE2iQ8Ru6Gw03Aw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id D17822C14F;
	Fri, 10 Jun 2022 11:33:33 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id AC3AD5194A46; Fri, 10 Jun 2022 13:33:33 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 08/10] nvme/042: test hash and dh group variations for authenticated connections
Date: Fri, 10 Jun 2022 13:33:22 +0200
Message-Id: <20220610113324.10294-9-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220610113324.10294-1-hare@suse.de>
References: <20220610113324.10294-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_043343_062002_74871904 
X-CRM114-Status: GOOD (  12.47  )
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
 tests/nvme/042     | 89 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/042.out | 18 ++++++++++
 2 files changed, 107 insertions(+)
 create mode 100644 tests/nvme/042
 create mode 100644 tests/nvme/042.out

diff --git a/tests/nvme/042 b/tests/nvme/042
new file mode 100644
index 0000000..0b9762a
--- /dev/null
+++ b/tests/nvme/042
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
+	_setup_nvmet
+
+	truncate -s 512M "${file_path}"
+
+	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
+	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_create_nvmet_host "${subsys_name}" "${hostnqn}" "${hostkey}"
+
+	for hash in "hmac(sha256)" "hmac(sha384)" "hmac(sha512)" ; do
+
+		echo "Testing hash ${hash}"
+
+		_set_nvmet_hash "${hostnqn}" "${hash}"
+
+		_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+				     "${def_traddr}" "${def_trsvcid}" \
+				     "${hostnqn}" "${hostid}" \
+				     "${hostkey}"
+		if [ $? -ne 0 ] ; then
+			echo "nvme connect failed"
+		fi
+
+		udevadm settle
+
+		_nvme_disconnect_subsys "${subsys_name}"
+	done
+
+	for dhgroup in "ffdhe2048" "ffdhe3072" "ffdhe4096" "ffdhe6144" "ffdhe8192" ; do
+
+		echo "Testing DH group ${dhgroup}"
+
+		_set_nvmet_dhgroup "${hostnqn}" "${dhgroup}"
+
+		_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+				     "${def_traddr}" "${def_trsvcid}" \
+				     "${hostnqn}" "${hostid}" \
+				     "${hostkey}"
+
+		if [ $? -ne 0 ] ; then
+			echo "nvme connect failed"
+		fi
+
+		udevadm settle
+
+		_nvme_disconnect_subsys "${subsys_name}"
+	done
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
+	_remove_nvmet_subsystem "${subsys_name}"
+
+	_remove_nvmet_port "${port}"
+
+	_remove_nvmet_host "${hostnqn}"
+
+	rm ${file_path}
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/042.out b/tests/nvme/042.out
new file mode 100644
index 0000000..c05aa2f
--- /dev/null
+++ b/tests/nvme/042.out
@@ -0,0 +1,18 @@
+Running nvme/042
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
2.26.2


