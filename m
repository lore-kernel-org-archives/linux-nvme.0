Return-Path: <SRS0=M30F=P7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC63C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 15:02:20 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31593603E8
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 15:02:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 31593603E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YAPEXpSAP00/1Y9bHQ0OtU6JU3EOSgNeBfWa2gKCmgQ=; b=aAn9NRVPq7oOE0Th6k9XBx8pMW
	3naG5tjMVsWNwQyipE8TLLgiydQLVKWLnWdDGQtY2GCM8kSiRPGejbVbyOra+d8iCgBDnOWgqo+00
	PeVo93qghnpv4aFo/RhPf3JMX+6gjK6CBw3oq7Oq4PhP4kjCMXbjzYvQqAIbyhqL2DznlUAvoqOO7
	ulBrZyRAy/Z9bPFWG6ZAjwvPFchRFjT06711Zj3nE4EidRYT29wAlkcftnbyYhKFAm+VeblnaIJD5
	0p2dGaqghV/DVjo2ckIdn8voiqpDQdvXe/6X8mBoq6G9F6S/jl+rnAsfwg/qrfRb9JKbOxpPNcGVi
	AHyn6sfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mlY4G-00AxpW-OG; Fri, 12 Nov 2021 15:02:16 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mlXns-00AsN1-Ge
 for linux-nvme@lists.infradead.org; Fri, 12 Nov 2021 14:45:24 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 9CAD31FD66;
 Fri, 12 Nov 2021 14:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636728318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YAPEXpSAP00/1Y9bHQ0OtU6JU3EOSgNeBfWa2gKCmgQ=;
 b=EvEg2riYErTLu2JoG4J3n3mGJt2ecu5OyRMfvlZP5q5tfreRfy/nepJniJLK/jbo0OenQr
 J56vFM1TBTt/8v5H7/xl1MJKVuItGpMquvj9wgJQ8yhVimiWycV+9APTfFc6eUkLXZGKeo
 mIdDnjXwpWDNkj7uXJ5PfBxcjhvufeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636728318;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YAPEXpSAP00/1Y9bHQ0OtU6JU3EOSgNeBfWa2gKCmgQ=;
 b=7U3IWEGm/42x3FODhDNqV9vbVcE/bSCPjzTW88ZPBn2mac3SE/g1N24qFNo5/B5QhdTHGj
 hkFTg4iD+nhJAqAQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 74DB8A3B8F;
 Fri, 12 Nov 2021 14:45:18 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 594615191285; Fri, 12 Nov 2021 15:45:18 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/6] nvmeof-tcp/003: test different key types
Date: Fri, 12 Nov 2021 15:45:07 +0100
Message-Id: <20211112144510.98523-4-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211112144510.98523-1-hare@suse.de>
References: <20211112144510.98523-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211112_064520_843135_6D4CF2B4 
X-CRM114-Status: GOOD (  13.97  )
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
 tests/nvmeof-tcp/003     | 100 +++++++++++++++++++++++++++++++++++++++
 tests/nvmeof-tcp/003.out |  36 ++++++++++++++
 2 files changed, 136 insertions(+)
 create mode 100644 tests/nvmeof-tcp/003
 create mode 100644 tests/nvmeof-tcp/003.out

diff --git a/tests/nvmeof-tcp/003 b/tests/nvmeof-tcp/003
new file mode 100644
index 0000000..c8a91e9
--- /dev/null
+++ b/tests/nvmeof-tcp/003
@@ -0,0 +1,100 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
+#
+# Test nvme over tcp dhchap keys
+
+. tests/nvmeof-tcp/rc
+
+DESCRIPTION="Test dhchap keys for authenticated TCP connection via localhost"
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
+	for hmac in 1 2 3; do
+		echo "Testing hmac ${hmac}"
+		hostkey="$(nvme gen-dhchap-key --hmac=${hmac} -n ${subsys}1 2> /dev/null)"
+		if [ $? -ne 0 ] ; then
+			echo "couldn't generate host key for hmac ${hmac}"
+			return 1
+		fi
+		_set_nvmet_hostkey "${hostnqn}" "${hostkey}"
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
+	for key_len in 32 48 64; do
+		echo "Testing key length ${key_len}"
+		hostkey="$(nvme gen-dhchap-key --key-length=${key_len} -n ${subsys}1 2> /dev/null)"
+		if [ $? -ne 0 ] ; then
+			echo "couldn't generate host key for length ${key_len}"
+			return 1
+		fi
+		_set_nvmet_hostkey "${hostnqn}" "${hostkey}"
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
diff --git a/tests/nvmeof-tcp/003.out b/tests/nvmeof-tcp/003.out
new file mode 100644
index 0000000..4d85539
--- /dev/null
+++ b/tests/nvmeof-tcp/003.out
@@ -0,0 +1,36 @@
+Running nvmeof-tcp/003
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing hmac 1
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing hmac 2
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing hmac 3
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing key length 32
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing key length 48
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Testing key length 64
+nvme-subsys0 - NQN=blktests-subsystem-1
+\
+ +- nvme0 tcp traddr=127.0.0.1,trsvcid=4420 live
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.26.2


