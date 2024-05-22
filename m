Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEA6C25B7A
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 09:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1dlru2O3YRCMSJWvLAv8sbH1bNFL0tKRJoXt9iLxq1g=; b=EhFUb774aWXRvFXdb4Be71u96c
	q/f4b5lNLv9XkZJsg6mq2z/xSHuz/fciq6PyIAkjbFgkE1ATlmtxCfsL0QjcdRAU8av1EmHg/RBgA
	w8MwBJmI83mqpxAgwdXCbsWzju/tqoIpnrQWbU9GK+J/5aeywS+PMYwgsEmyt9BH46ylDkckj5iAO
	HAIBK9yMXTKZIjX24N2BufU+wBEU5O1DUBhMWqPwjNLTzSw/zpB7SICTSq9WogsfVzhziLn4BhsEL
	0E3Gv3NtXOqtn9Qe06nJDaMGOxDOnoQ66Ii7A3R9JIoeOxzCachlbevvUTLRVmh+5LZkDtAyhs422
	Oq+gCjJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9huu-00000002SEc-11Ow;
	Wed, 22 May 2024 09:05:48 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9hur-00000002SCk-1C7l
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 09:05:46 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4200f3b5b6aso351365e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 22 May 2024 02:05:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716368742; x=1716973542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dlru2O3YRCMSJWvLAv8sbH1bNFL0tKRJoXt9iLxq1g=;
        b=ohpoD1RstvBgEWhYk2MdgFzEjiMdL4UwLR7gcDnUj8gXCPlYEhv0lJV95oOphkazgy
         FpX4XkJslnRnYMidvdk+wrq4znLbPu7MlF6SoNeyyT8L0fTj61ZELrunCijk9DtgD0gP
         MNZ0XuAgjeXjDJRZW2On2nyq6naUnU+KgbVD12iIwNfgLzMgblbLc+fLnXtkYyC2uZVd
         5NKi7REtZegFYnAIEIT2ljNwl/tKeo245LcBW3WAgWBFJYqTdr4lUdNdfIjLcJm7Ql7x
         LGQq+e+3Ew+SOVv/Sdgpy7PBX+6zXdw55DK68upgZyJpvtC5i4URGbD0LchknlMnjtBw
         smIw==
X-Gm-Message-State: AOJu0Yyh3U7mHI80gkIWaXMWhAg7AWJQPJhq+8YbYOvxAEuIZK6sSDr5
	ibviRewJZ4dOcmx5/4WiYTVnULLY+yzfy20sH92QDCt9FW6vZwAQkzJDYQ==
X-Google-Smtp-Source: AGHT+IEvYKd511VmWVLUld/qVZzbqOCxxVCCOWTb2u9dgsvrVpFgM62PMbrVSW+cFAc3p2T8PYEoDQ==
X-Received: by 2002:a05:600c:5491:b0:41f:9c43:574f with SMTP id 5b1f17b1804b1-420fd387a2dmr8745085e9.3.1716368742090;
        Wed, 22 May 2024 02:05:42 -0700 (PDT)
Received: from vastdata-ubuntu2.vastdata.com (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42013bf1a5dsm389235795e9.30.2024.05.22.02.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 02:05:41 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v2] nvme: add regression test for concurrently enable/disable nvmet ns
Date: Wed, 22 May 2024 12:05:40 +0300
Message-Id: <20240522090540.467551-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_020545_341914_65D36848 
X-CRM114-Status: GOOD (  13.88  )
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

Reproduce a hang in nvmet when concurrently disabling/enabling
an nvmet namespace.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Changes from v1:
- remove local variable
- fix shellcheck warnings

 tests/nvme/051     | 47 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/051.out |  2 ++
 2 files changed, 49 insertions(+)
 create mode 100755 tests/nvme/051
 create mode 100644 tests/nvme/051.out

diff --git a/tests/nvme/051 b/tests/nvme/051
new file mode 100755
index 000000000000..624b42f432eb
--- /dev/null
+++ b/tests/nvme/051
@@ -0,0 +1,47 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Sagi Grimberg
+#
+# Regression test for kernel hang when enabling/disabling nvmet
+# namespace concurrently
+
+. tests/nvme/rc
+
+DESCRIPTION="test nvmet concurrent ns enable/disable"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_require_nvme_trtype_is_fabrics
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+ns_enable_disable_loop() {
+	local ns="$1"
+	for ((i = 1; i <= 200; i++)); do
+		echo 0 > "${ns}/enable"
+		echo 1 > "${ns}/enable"
+	done
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	_nvmet_target_setup
+	ns="${NVMET_CFS}subsystems/${def_subsysnqn}/namespaces/1"
+
+	# fire off two enable/disable loops concurrently and wait
+	# for them to complete...
+	ns_enable_disable_loop $ns &
+	ns_enable_disable_loop $ns &
+	wait
+
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/051.out b/tests/nvme/051.out
new file mode 100644
index 000000000000..156f0687aab2
--- /dev/null
+++ b/tests/nvme/051.out
@@ -0,0 +1,2 @@
+Running nvme/051
+Test complete
-- 
2.40.1


