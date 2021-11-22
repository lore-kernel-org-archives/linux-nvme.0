Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DE2C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 08:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VTall5Sp5wxaGAnI1v3rBHpNwNB952Rk8sQQz7Chpzo=; b=kqzFaRd7DE315e+g4Fxn+TUyii
	3fQbv3Xyy0BdcnDqc8uUtxQddcAfXKCD1jF6zbOUkblU9SZikVjjZvv77JwKWpyfIofT1V7P8cvjx
	GtC5icPwlLkuFwtBCZHai0aukIQN3a/Q8TJKzYT9iocSbRTSqpadsPW7iz+dTGLojlcfkkcut+Y1/
	le4vieF2Y8ytbC/3aQzRAfpQ6hINMmVIpJSi3Qf8OW6s4EEJmCfgDbirHIS6dJT9i5uo/rtPvxkY9
	vRCFYC+1ZlteALGphV9mCmkohJvO+rCmIuLp8OnObNpVZ61hHo/26pg618OnyUnBlYnCawvMIdP7D
	NKg9SJKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp4UU-00FF33-3l; Mon, 22 Nov 2021 08:15:54 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp4As-00FAuO-Bd
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 07:55:43 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 7C897218BB;
 Mon, 22 Nov 2021 07:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637567736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VTall5Sp5wxaGAnI1v3rBHpNwNB952Rk8sQQz7Chpzo=;
 b=ErpIyzsv0V00HRRZJkLbeXKX0+nKxifKR2v1v0ZCDvDSKLoqku3ZFBREFjZi9nxeLyv+WZ
 ALR8yy2SL5F9yHYCMwU/Y3cx47/coPutLW4DjwFaAzecnyTlh/xNdM6DA+U0swBUMIU3fz
 8W+B2yzz9cXznIxEG1Ek0t/XF9zDQfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637567736;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VTall5Sp5wxaGAnI1v3rBHpNwNB952Rk8sQQz7Chpzo=;
 b=NhuiS/lGWoYm2WXIz/s3lV6RxNH614aY+YoZ6Vb/tbnTYbAbN1MjQjUgkezN/O8CnEgA7B
 JZqWad9fHUk5lXBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 5A4BCA3B8B;
 Mon, 22 Nov 2021 07:55:36 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 48DDF51917F5; Mon, 22 Nov 2021 08:55:36 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 4/9] nvme/039: simple test for nvmeof-tcp connection
Date: Mon, 22 Nov 2021 08:55:19 +0100
Message-Id: <20211122075524.26207-5-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211122075524.26207-1-hare@suse.de>
References: <20211122075524.26207-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211121_235538_642423_DF59016C 
X-CRM114-Status: GOOD (  13.78  )
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
 tests/nvme/039     | 56 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/039.out |  6 +++++
 2 files changed, 62 insertions(+)
 create mode 100644 tests/nvme/039
 create mode 100644 tests/nvme/039.out

diff --git a/tests/nvme/039 b/tests/nvme/039
new file mode 100644
index 0000000..eb015be
--- /dev/null
+++ b/tests/nvme/039
@@ -0,0 +1,56 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
+#
+# Test nvme over tcp connection
+
+. tests/nvme/rc
+
+DESCRIPTION="Create single TCP connection via localhost"
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
+	local nvme_trtype="tcp"
+
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	truncate -s 512M "${scratch}"
+
+	port="$(_create_nvmet_port "${nvme_trtype}")"
+
+	_create_nvmet_subsystem "${subsys}1" "${scratch}"
+	_add_nvmet_subsys_to_port "${port}" "${subsys}1"
+	_create_nvmet_host "${subsys}1" "${hostnqn}"
+
+	nvme connect -t "${nvme_trtype}" -n "${subsys}1" \
+	     -a "${def_traddr}" -s "${def_trsvcid}" \
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
diff --git a/tests/nvme/039.out b/tests/nvme/039.out
new file mode 100644
index 0000000..7970853
--- /dev/null
+++ b/tests/nvme/039.out
@@ -0,0 +1,6 @@
+Running nvme/039
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.26.2


