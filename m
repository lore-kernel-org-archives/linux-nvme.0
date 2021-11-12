Return-Path: <SRS0=M30F=P7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53ECAC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 14:58:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15DE46023F
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 14:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 15DE46023F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DlH43sI7rPd2McmZ2PLytvoXPJFwTiy9vZWkCHAeBq8=; b=bXHXG/mTF8XfwTwByU1zQGXY2w
	8Sq0srp3wJaKaqTLo1sjhBEjuEjDxwizsL106PLd//7CFKlIwuk3Ld+2FDXrGWC5PoMCkWzRXB3IX
	of/kAa6OGJfi5MHyXd7YTIJUJwYhOqRsUzcrKWP5Ohvd8WaP3oqnyxZiMA3+kVIWRYNscbC7EC4K5
	oKvGNvBS80tW2oLYOYfxIzHCEsXBRx/Ao8d6411l6cREL4ydqF9ZqgT+7wfgSuiMA6Cq2ybCWIrTX
	utmkSIu0zUnLtnykBCo/W9XkpGqDGhjE6LrCIkvJBHk3RWBwcg+stXJsyde+QNutFMsqMTAC+UjAx
	/YP46Diw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mlY0C-00AwjF-AM; Fri, 12 Nov 2021 14:58:04 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mlXns-00AsN7-GZ
 for linux-nvme@lists.infradead.org; Fri, 12 Nov 2021 14:45:23 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id A6A5F1FD6A;
 Fri, 12 Nov 2021 14:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636728318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DlH43sI7rPd2McmZ2PLytvoXPJFwTiy9vZWkCHAeBq8=;
 b=utJSwdfZksw3IiVOA+3/0iaoIxRE0mufqD1d77U8yny4cS0eWXcY2C1RkTtKrwTrpk8IUG
 nGWbQSMKfPRq2t2Oh3Y8T46grFOGHaDcF3vKy6IiYVwcbtV5ibDgQodj26tUrfS8Ithnsm
 jk+rh1Mj93jAq3gYKzf2kX9Ln6HjnGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636728318;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DlH43sI7rPd2McmZ2PLytvoXPJFwTiy9vZWkCHAeBq8=;
 b=pgt3VGsXUQwalbfiYscqlXGUtfSOPnwh6DqzPaYZcqqwCQAuBAt8t3Wyd13FwYBliCb0mN
 2Hw7JznnSrTPvCCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 9C92AA3B92;
 Fri, 12 Nov 2021 14:45:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 6A86D519128B; Fri, 12 Nov 2021 15:45:18 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 6/6] nvmeof-tcp/006: test re-authentication
Date: Fri, 12 Nov 2021 15:45:10 +0100
Message-Id: <20211112144510.98523-7-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211112144510.98523-1-hare@suse.de>
References: <20211112144510.98523-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211112_064520_873320_B9713449 
X-CRM114-Status: GOOD (  15.30  )
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
 tests/nvmeof-tcp/006     | 113 +++++++++++++++++++++++++++++++++++++++
 tests/nvmeof-tcp/006.out |  23 ++++++++
 2 files changed, 136 insertions(+)
 create mode 100644 tests/nvmeof-tcp/006
 create mode 100644 tests/nvmeof-tcp/006.out

diff --git a/tests/nvmeof-tcp/006 b/tests/nvmeof-tcp/006
new file mode 100644
index 0000000..7376879
--- /dev/null
+++ b/tests/nvmeof-tcp/006
@@ -0,0 +1,113 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
+#
+# Test nvme over tcp re-authentication
+
+. tests/nvmeof-tcp/rc
+
+DESCRIPTION="Test re-authentication for TCP connection via localhost"
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
+	ctrl=$(_find_nvme_dev "${subsys}1")
+
+	echo "Re-authenticate with original host key"
+
+	echo "${hostkey}" > /sys/class/nvme/${ctrl}/dhchap_secret
+
+	echo "Renew host key on the controller"
+
+	new_hostkey="$(nvme gen-dhchap-key -n ${subsys}1 2> /dev/null)"
+
+	_set_nvmet_hostkey "${hostnqn}" "${new_hostkey}"
+
+	echo "Re-authenticate with new host key"
+
+	echo "${new_hostkey}" > /sys/class/nvme/${ctrl}/dhchap_secret
+
+	nvme list-subsys
+
+	echo "Renew ctrl key on the controller"
+
+	new_ctrlkey="$(nvme gen-dhchap-key -n ${subsys}1 2> /dev/null)"
+
+	_set_nvmet_ctrlkey "${hostnqn}" "${new_ctrlkey}"
+
+	echo "Re-authenticate with new ctrl key"
+
+	echo "${new_ctrlkey}" > /sys/class/nvme/${ctrl}/dhchap_ctrl_secret
+
+	nvme list-subsys
+
+	echo "Change DH group to ffdhe8192"
+
+	_nvmet_set_dhgroup "${subsys}1" "ffdhe8192"
+
+	echo "Re-authenticate with changed DH group"
+	echo "${new_hostkey}" > /sys/class/nvme/${ctrl}/dhchap_secret
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
diff --git a/tests/nvmeof-tcp/006.out b/tests/nvmeof-tcp/006.out
new file mode 100644
index 0000000..006d9fe
--- /dev/null
+++ b/tests/nvmeof-tcp/006.out
@@ -0,0 +1,23 @@
+Running nvmeof-tcp/006
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+Re-authenticate with original host key
+Renew host key on the controller
+Re-authenticate with new host key
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+Renew ctrl key on the controller
+Re-authenticate with new ctrl key
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+Change DH group to ffdhe8192
+tests/nvmeof-tcp/006: line 94: _nvmet_set_dhgroup: command not found
+Re-authenticate with changed DH group
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.26.2


