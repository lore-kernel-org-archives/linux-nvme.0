Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FD2C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 07:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K0V6w17WI5lG2kGCW1DnWoMzGe5i/UbFZRH76BreOYI=; b=ORjMhY5ndkapCvjSac9LEghcXp
	IRpx1OpspgDTPsF0CdyefB3ZjqvcpPUZl4+N5AA2+UYH8JcuBru15AmpDKGsBt9/sTeWoXroYX+8p
	2/2w9I738thq6zh3WyJ7O9tw3TIvRYc0rFLwHxUcjkjB3NohFg3z8r9M5yTqGeG84YalE+itkMDwb
	imeNTqM5Dgz/XUSd9hZSdBQ6rMOkd7KUOBBkNrtolYo3eATaDZ7brhvgKcpjRNJ9pbHen16/gma+o
	6AkHoXWigOpS6zC46siwIMqnsE/Ek1avV+7SFuJxn4Ga5DQbKeQN17DK8tPAo1E9qPno96KsmjFZj
	E+y+numQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpQdP-0017yw-5f; Tue, 23 Nov 2021 07:54:35 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpQYu-0016kP-Vo
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 07:49:59 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 279B41FD61;
 Tue, 23 Nov 2021 07:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637653788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K0V6w17WI5lG2kGCW1DnWoMzGe5i/UbFZRH76BreOYI=;
 b=GdupxuCEF1Yebw/HUNMHJplLdfj/DuJP/mn6KgZKF72QoI257MjDi56eLCfD85hr8SPfnU
 WXAzlg9NqaG+btUOxq+zwLZ5zeMivgqkHjC8mNZjegtdQqrw4SpuUa/ujS6Uf56B0YE4/p
 srRt4hs2+g2CvTqyS+hS7Ub7skU20XE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637653788;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K0V6w17WI5lG2kGCW1DnWoMzGe5i/UbFZRH76BreOYI=;
 b=hkEsbVpipLFmrmTql+XW1e29yW0xoyRT1w1ZXPdRlepPAVqLPVskpQ5Qt88jNwI42SjlsB
 6GZ9KrPfnu53gTAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 1E83DA3B91;
 Tue, 23 Nov 2021 07:49:48 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 414345191895; Tue, 23 Nov 2021 08:49:47 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 10/10] nvme/043: test re-authentication
Date: Tue, 23 Nov 2021 08:49:40 +0100
Message-Id: <20211123074940.113390-11-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211123074940.113390-1-hare@suse.de>
References: <20211123074940.113390-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_234957_246900_D40E959A 
X-CRM114-Status: GOOD (  15.06  )
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
 tests/nvme/043     | 136 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/043.out |  12 ++++
 2 files changed, 148 insertions(+)
 create mode 100644 tests/nvme/043
 create mode 100644 tests/nvme/043.out

diff --git a/tests/nvme/043 b/tests/nvme/043
new file mode 100644
index 0000000..c217ade
--- /dev/null
+++ b/tests/nvme/043
@@ -0,0 +1,136 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2021 Hannes Reinecke, SUSE Labs
+#
+# Test re-authentication
+
+. tests/nvme/rc
+
+DESCRIPTION="Test re-authentication"
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
+	echo "Re-authenticate with original host key"
+
+	echo "${hostkey}" > /sys/class/nvme/${ctrldev}/dhchap_secret
+
+	echo "Renew host key on the controller"
+
+	new_hostkey="$(nvme gen-dhchap-key -n ${subsys} 2> /dev/null)"
+
+	_set_nvmet_hostkey "${hostnqn}" "${new_hostkey}"
+
+	echo "Re-authenticate with new host key"
+
+	echo "${new_hostkey}" > /sys/class/nvme/${ctrldev}/dhchap_secret
+
+	ctrldev=$(_find_nvme_dev "${subsys}")
+	if [ -z "$ctrldev" ] ; then
+		echo "nvme controller not found"
+	fi
+
+	echo "Renew ctrl key on the controller"
+
+	new_ctrlkey="$(nvme gen-dhchap-key -n ${subsys} 2> /dev/null)"
+
+	_set_nvmet_ctrlkey "${hostnqn}" "${new_ctrlkey}"
+
+	echo "Re-authenticate with new ctrl key"
+
+	echo "${new_ctrlkey}" > /sys/class/nvme/${ctrldev}/dhchap_ctrl_secret
+
+	ctrldev=$(_find_nvme_dev "${subsys}")
+	if [ -z "$ctrldev" ] ; then
+		echo "nvme controller not found"
+	fi
+
+	echo "Change DH group to ffdhe8192"
+
+	_set_nvmet_dhgroup "${hostnqn}" "ffdhe8192"
+
+	echo "Re-authenticate with changed DH group"
+	echo "${new_hostkey}" > /sys/class/nvme/${ctrldev}/dhchap_secret
+
+	ctrldev=$(_find_nvme_dev "${subsys}")
+	if [ -z "$ctrldev" ] ; then
+		echo "nvme controller not found"
+	fi
+
+	echo "Change hash to hmac(sha512)"
+
+	_set_nvmet_hash "${hostnqn}" "hmac(sha512)"
+
+	echo "Re-authenticate with changed hash"
+	echo "${new_hostkey}" > /sys/class/nvme/${ctrldev}/dhchap_secret
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
diff --git a/tests/nvme/043.out b/tests/nvme/043.out
new file mode 100644
index 0000000..a0c5022
--- /dev/null
+++ b/tests/nvme/043.out
@@ -0,0 +1,12 @@
+Running nvme/043
+Re-authenticate with original host key
+Renew host key on the controller
+Re-authenticate with new host key
+Renew ctrl key on the controller
+Re-authenticate with new ctrl key
+Change DH group to ffdhe8192
+Re-authenticate with changed DH group
+Change hash to hmac(sha512)
+Re-authenticate with changed hash
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.29.2


