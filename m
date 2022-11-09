Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84367C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 03:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZBuChYWjOFH8hLHplXy8et99egojLp7RKz+p8dwaQuo=; b=vUsYcPAS7akOg/wnecYmT7sToD
	TlSW8UUULb8peTp0C9aF8kE7pjULh2JtMNEOxqNbX/OXJ7BnUXXt4WFQDdJPRsznG6WDCyS3XqPnd
	1dCw0kmCoQv7PHrnkK4yW7rnRkEkMsPJO0aOJ9SBlb9X7H84Q88wjqvK0sDcbI+l2lHMtJepgfG1R
	sdvqFbDZqtnWnLXHgZrLg6nVsp6GvGRT1Mkd2H7wVcKhRdGDIIl2VTF/4xi+8YCT9R/z0cQKZbBPv
	LSCETWjHtVHbpCTsE1p0nr9QTkEm+UFAIr7ndyvSX94TN3Vte7m6HZtWrfsE5e91yqtUg4zQxhCYr
	XYgvJJNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc6J-00AQyC-6q; Wed, 09 Nov 2022 03:50:07 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc1H-00AOUg-TB
	for linux-nvme@bombadil.infradead.org; Wed, 09 Nov 2022 03:44:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=ZBuChYWjOFH8hLHplXy8et99egojLp7RKz+p8dwaQuo=; b=o1O+RDjyJ1Cbw4TTLtEQzbkGEy
	8F2iypRhXYb3BsqDrECBdMBBSI+jOKay3Spq2IMX+JrdOFUH7ljnr5hGz3aUI42d0jpcMZF8zQpb9
	/0xAvXTaM3UymW7zvydAg01Vp1OvZ1WrCbGLXyCXfPQTiqFFgFeQh9zfZWT8HriPfxSSPbJGxfN4X
	qQyM6oii17EX5sbHlFCPqkvgSMnA1Wzx1xTWRirhO4o7L+07mHDOumd1a9zuu94CVq+3elxzfgYow
	GU127nVSB198xYKIox4OzIA/0mnrsQk7cwB+pmx9V4ZzC8O13220+HKQ71KgYPQCNyWK9DBoWPznq
	UapPvv2w==;
Received: from mail-pf1-f172.google.com ([209.85.210.172])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc1J-00Ar1H-RM
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 03:44:59 +0000
Received: by mail-pf1-f172.google.com with SMTP id i3so15540771pfc.11
        for <linux-nvme@lists.infradead.org>; Tue, 08 Nov 2022 19:44:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBuChYWjOFH8hLHplXy8et99egojLp7RKz+p8dwaQuo=;
        b=7r35JWi2zB5feTuUbIMFFHrYtegJtJzBxCdnZqGK/dgD/mt8jGGRwn8a8etq4hshHG
         SSGoBFe9DvobUvRTPt73clS0823GnzdfVJY7uE7COy51vbCBjnRaM9FoPp2bee+XBUAy
         wj/gCMElgS6Wl5iU9qqLFa6IVDyw9BfmcqI6yEgggj0HV1OLzBR/DqIZs36B7gryiNLw
         c+YS7TZjEWwu6v4I64gyI+vku9X9r8Wc/KSuCl7bguXB9G30FEis18nF8RKr+I4WEBa0
         BDnSZGvpUzoQbpbq7n2unGIWi4ktgptNWAb00u3M8OqHjmdiIa3yPc9bMeTVMDgZa5Le
         RR/Q==
X-Gm-Message-State: ANoB5pkmWmCMXHJdgpsa9R0WAsgviNGuKWTbipbKv0USCggpobQN7IPA
	qCUoPruZjRegmbdPmeIlB0FffGhVDZBWxcdy
X-Google-Smtp-Source: AA0mqf7G385QtjkvcIXtMMAjE7qB+44mNBmdYsuDYq6uIM3pKTxwS+gMq00ucG7rEzRGTb5waEvY1g==
X-Received: by 2002:a65:55c2:0:b0:470:8e8d:b2a4 with SMTP id k2-20020a6555c2000000b004708e8db2a4mr4534251pgs.484.1667965485896;
        Tue, 08 Nov 2022 19:44:45 -0800 (PST)
Received: from localhost.localdomain (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id i10-20020a17090332ca00b00186cd4a8aedsm7765612plr.252.2022.11.08.19.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 19:44:45 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH 17/16 blktests] nvme: add re-authentication running concurrently with reset
Date: Wed,  9 Nov 2022 05:44:20 +0200
Message-Id: <20221109034420.1000086-18-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109034420.1000086-1-sagi@grimberg.me>
References: <20221109034420.1000086-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_034457_931981_27EFB6DA 
X-CRM114-Status: GOOD (  13.64  )
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

when re-authentication with new host-key and/or ctrl-key there is an
async work that is scheduled async. A controller reset should be mutual
exclusive with the re-authentication work. Add a test that triggers
re-authentication and immediately resets the controller.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/046     | 112 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/046.out |  23 ++++++++++
 2 files changed, 135 insertions(+)
 create mode 100755 tests/nvme/046
 create mode 100644 tests/nvme/046.out

diff --git a/tests/nvme/046 b/tests/nvme/046
new file mode 100755
index 000000000000..2cd1b1bff4f1
--- /dev/null
+++ b/tests/nvme/046
@@ -0,0 +1,112 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2022 Hannes Reinecke, SUSE Labs
+#
+# Test re-authentication and reset running in parallel
+
+. tests/nvme/rc
+
+DESCRIPTION="Test re-authentication concurrently with reset"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_have_kernel_option NVME_AUTH
+	_have_kernel_option NVME_TARGET_AUTH
+	_require_nvme_trtype_is_fabrics
+	_require_nvme_cli_auth
+	_have_driver dh_generic
+}
+
+
+test() {
+	local port
+	local subsys_name="blktests-subsystem-1"
+	local hostid
+	local hostnqn
+	local file_path="${TMPDIR}/img"
+	local hostkey
+	local new_hostkey
+	local ctrlkey
+	local new_ctrlkey
+	local ctrldev
+
+	echo "Running ${TEST_NAME}"
+
+	hostid="$(uuidgen)"
+	if [ -z "$hostid" ] ; then
+		echo "uuidgen failed"
+		return 1
+	fi
+	hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
+
+	hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
+	if [ -z "$hostkey" ] ; then
+		echo "failed to generate host key"
+		return 1
+	fi
+
+	ctrlkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
+	if [ -z "$ctrlkey" ] ; then
+		echo "failed to generate ctrl key"
+		return 1
+	fi
+
+	_setup_nvmet
+
+	truncate -s 512M "${file_path}"
+
+	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
+	port="$(_create_nvmet_port "${nvme_trtype}")"
+	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+	_create_nvmet_host "${subsys_name}" "${hostnqn}" "${hostkey}" "${ctrlkey}"
+
+	_set_nvmet_dhgroup "${hostnqn}" "ffdhe2048"
+
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys_name}" \
+			     "${def_traddr}" "${def_trsvcid}" \
+			     "${hostnqn}" "${hostid}" \
+			     "${hostkey}" "${ctrlkey}"
+
+	udevadm settle
+
+	ctrldev=$(_find_nvme_dev "${subsys_name}")
+	if [ -z "$ctrldev" ] ; then
+		echo "nvme controller not found"
+	fi
+
+	hostkey_file="/sys/class/nvme/${ctrldev}/dhchap_secret"
+	ctrlkey_file="/sys/class/nvme/${ctrldev}/dhchap_ctrl_secret"
+
+	for ((i = 0; i < 10; i++)); do
+		echo "Re-authenticate with new host key (iteration $i)"
+		new_hostkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
+		_set_nvmet_hostkey "${hostnqn}" "${new_hostkey}"
+		echo "${new_hostkey}" > "${hostkey_file}"
+		_nvme_reset_ctrl $ctrldev
+
+		echo "Re-authenticate with new ctrl key (iteration $i)"
+		new_ctrlkey="$(nvme gen-dhchap-key -n ${subsys_name} 2> /dev/null)"
+		_set_nvmet_ctrlkey "${hostnqn}" "${new_ctrlkey}"
+		echo "${new_ctrlkey}" > "${ctrlkey_file}"
+		_nvme_reset_ctrl $ctrldev
+	done
+
+	nvmedev=$(_find_nvme_dev "${subsys_name}")
+
+	_run_fio_rand_io --size=8m --filename="/dev/${nvmedev}n1"
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
diff --git a/tests/nvme/046.out b/tests/nvme/046.out
new file mode 100644
index 000000000000..2d63f4e3112b
--- /dev/null
+++ b/tests/nvme/046.out
@@ -0,0 +1,23 @@
+Running nvme/046
+Re-authenticate with new host key (iteration 0)
+Re-authenticate with new ctrl key (iteration 0)
+Re-authenticate with new host key (iteration 1)
+Re-authenticate with new ctrl key (iteration 1)
+Re-authenticate with new host key (iteration 2)
+Re-authenticate with new ctrl key (iteration 2)
+Re-authenticate with new host key (iteration 3)
+Re-authenticate with new ctrl key (iteration 3)
+Re-authenticate with new host key (iteration 4)
+Re-authenticate with new ctrl key (iteration 4)
+Re-authenticate with new host key (iteration 5)
+Re-authenticate with new ctrl key (iteration 5)
+Re-authenticate with new host key (iteration 6)
+Re-authenticate with new ctrl key (iteration 6)
+Re-authenticate with new host key (iteration 7)
+Re-authenticate with new ctrl key (iteration 7)
+Re-authenticate with new host key (iteration 8)
+Re-authenticate with new ctrl key (iteration 8)
+Re-authenticate with new host key (iteration 9)
+Re-authenticate with new ctrl key (iteration 9)
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.34.1


