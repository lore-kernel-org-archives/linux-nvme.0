Return-Path: <SRS0=M30F=P7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E4AC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 15:00:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7DC160F46
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 15:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E7DC160F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gE92laWHdLsnl+Wndbeu2wT+bOst23gtieIZ7JEkFiA=; b=b4SuTh2jubTrn8KT+9OimH2Ty8
	AGH1DjSc/LlcfjOVcRwF+E35mwGAkecrKg+w5bI2jtNLjCF8+ohImx5JYK59QtA0G8viFXMhYH6Sb
	nJVEP0CQGdS8oWjhqqyRa/J4Bhiy/QQj/r9ze2xZbVjPfvyIY3V46GhfMLIBX9KyM1w8Lu37hCEQY
	ne1CQnEoaun8sJNjKqsemn7le0TBygBG0dk9XhqzAJ2cpOqMcCMEMIo7UFYa7J1XOcZZFGPYPO+Xs
	c1Ej8SI1+HvfiRBD6Z9epne0YkE/9NQWfb8De4rRdfDtYqRK+rRw6NEC4yIvQh9YIODTsdDBCXYcX
	OT0CI7uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mlY2K-00AxJr-FQ; Fri, 12 Nov 2021 15:00:16 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mlXns-00AsN0-Fl
 for linux-nvme@lists.infradead.org; Fri, 12 Nov 2021 14:45:23 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 999B121990;
 Fri, 12 Nov 2021 14:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636728318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gE92laWHdLsnl+Wndbeu2wT+bOst23gtieIZ7JEkFiA=;
 b=IOfA/82X/N1kk4vCx3VaspcQBrhyuAPiGO/QUR+FnNq1EaNedMQRio6P5v6rl05pjya4Cb
 Ltz69N83eSh4RAdabIULulioIJ24Z5UGQEKsvZJIghRCoDS0hqM4E1p0aRmPJDZOlK/iQ7
 svkzHqK3iAVdUWwVVDV07gEWVKpu4zA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636728318;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gE92laWHdLsnl+Wndbeu2wT+bOst23gtieIZ7JEkFiA=;
 b=8/qd+DtJH4D5o1H7c91XqcM5WMxA8U41Pb3i5OgM4NokGvcn+OfhhXTPfCiQq+JDDClEhH
 uC+F8BmvrGDXZ9Ag==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 7A4E4A3B90;
 Fri, 12 Nov 2021 14:45:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 5F39C5191287; Fri, 12 Nov 2021 15:45:18 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 4/6] nvmeof-tcp/004: test hash and dhgroup variations
Date: Fri, 12 Nov 2021 15:45:08 +0100
Message-Id: <20211112144510.98523-5-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211112144510.98523-1-hare@suse.de>
References: <20211112144510.98523-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211112_064520_798966_1612F591 
X-CRM114-Status: GOOD (  14.02  )
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
 tests/nvmeof-tcp/004     | 86 ++++++++++++++++++++++++++++++++++++++++
 tests/nvmeof-tcp/004.out | 37 +++++++++++++++++
 2 files changed, 123 insertions(+)
 create mode 100644 tests/nvmeof-tcp/004
 create mode 100644 tests/nvmeof-tcp/004.out

diff --git a/tests/nvmeof-tcp/004 b/tests/nvmeof-tcp/004
new file mode 100644
index 0000000..b9569dc
--- /dev/null
+++ b/tests/nvmeof-tcp/004
@@ -0,0 +1,86 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
+#
+# Test nvme over tcp hash and dh group selection
+
+. tests/nvmeof-tcp/rc
+
+DESCRIPTION="Test hash and DH group for authenticated TCP connection via localhost"
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
+	for hash in "hmac(sha384)" "hmac(sha512)" ; do
+
+		echo "Testing hash ${hash}"
+
+		_set_nvmet_hash "${hostnqn}" "${hash}"
+
+		nvme connect -t "${nvme_trtype}" -n "${subsys}1" \
+		     -a "${def_traddr}" -s "${def_trsvcid}" -S "${hostkey}" \
+		     --hostnqn="${hostnqn}" --hostid="${hostid}"
+
+		nvme list-subsys
+
+		nvme disconnect -n "${subsys}1"
+	done
+
+	for dhgroup in "ffdhe2048" "ffdhe3072" "ffdhe4096" "ffdhe6144" "ffdhe8192" ; do
+
+		echo "Testing DH group ${dhgroup}"
+
+		_set_nvmet_dhgroup "${hostnqn}" "${dhgroup}"
+	
+		nvme connect -t "${nvme_trtype}" -n "${subsys}1" \
+		     -a "${def_traddr}" -s "${def_trsvcid}" -S "${hostkey}" \
+		     --hostnqn="${hostnqn}" --hostid="${hostid}"
+
+		nvme list-subsys
+
+		nvme disconnect -n "${subsys}1"
+	done
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
diff --git a/tests/nvmeof-tcp/004.out b/tests/nvmeof-tcp/004.out
new file mode 100644
index 0000000..dc226c8
--- /dev/null
+++ b/tests/nvmeof-tcp/004.out
@@ -0,0 +1,37 @@
+Running nvmeof-tcp/004
+Testing hash hmac(sha384)
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing hash hmac(sha512)
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing DH group ffdhe2048
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing DH group ffdhe3072
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing DH group ffdhe4096
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing DH group ffdhe6144
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing DH group ffdhe8192
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.26.2


