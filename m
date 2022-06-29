Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84F0BC43334
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jun 2022 08:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BWPVXiR8YVJWXuEkJWT6y/zuanM8LOc0uQkG15JtwJI=; b=zR3Di+5R0glfu3iUaBi0vqnzKl
	i1wJeoKtTPd+a1auuJQq5aSBKo1RV3BD///mUWi2hjDCCFJII7phGhcDuh93epnlk8A0CYy9V1JhN
	wEwZ+JYirfoExNi4yv2lmrZtbfpq4RMmm6j6Mgd0gwbF+EfreINFZhhJtVnLecs/9Opz9ne0+tHfL
	yF53r2euFPzMo/CugbFwA8/giRqWqxNQDzaTKUk3Qfy7PxpC3vXVP6c/7iDBAe/jq6mxuB2fPrRLx
	qwityH5CuBc0oDWw/bVicBnJpd1G+mxF8zkwx7y18rU5vIoPQ1r7elk9gvK+ClajiN2HoDJz7TKDt
	ieFOyDQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6TSe-00AVoE-Iz; Wed, 29 Jun 2022 08:54:12 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6TSb-00AVnP-UH
	for linux-nvme@lists.infradead.org; Wed, 29 Jun 2022 08:54:11 +0000
Received: by mail-wm1-f48.google.com with SMTP id n185so8888931wmn.4
        for <linux-nvme@lists.infradead.org>; Wed, 29 Jun 2022 01:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BWPVXiR8YVJWXuEkJWT6y/zuanM8LOc0uQkG15JtwJI=;
        b=bz+My/MmDkA4FVSPGWLPfV426hBgpj47WP+fpGJf4Joys+wrEPruUHDUH0AG2xlxW6
         CztPwWXdWeh8429aMDMt8wp4QeaJFzAF5FBkKqV1VmttO8tQxjwnnDAvKFTkPbjuEyPR
         nFeOb3xALxDAEMUcDSXhYURROy5puvMJIXKzucJ2ZrfVs/o4MtCP/3MOzKYgxhH93mwv
         IrwuodbeKmBhYp+Pct1cqPntrDpHj79IetODrdLId33zHIcZTJIs/JuxaoUFhXmTqAAj
         B+swAVaw514E6wJWzdggu+0oYPxLtYSjTk4Ts1+YiSTFmiahzAMYnEx+mjToji9ajdrz
         yl/A==
X-Gm-Message-State: AJIora8wO057MpVdT5l5pPPOGrlSfUqWtzgcF/XWDi3dIjZNJmViWiXV
	row3TOxEsegNWXXRN99Y6AOU8jrvgwk=
X-Google-Smtp-Source: AGRyM1tknZr4n47JQiykqP9fbjlT0lHSiAnMeFmqbig3/Oh07BFx1xYutZcJuLC24MhQmpjoWMzMPg==
X-Received: by 2002:a05:600c:1f07:b0:39c:880f:4456 with SMTP id bd7-20020a05600c1f0700b0039c880f4456mr2400215wmb.79.1656492847251;
        Wed, 29 Jun 2022 01:54:07 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e16-20020a5d4e90000000b0021b91d1ddbfsm15574435wru.21.2022.06.29.01.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 01:54:06 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: add nvmf reset/disconnect during traffic test
Date: Wed, 29 Jun 2022 11:54:05 +0300
Message-Id: <20220629085405.357517-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220629_015410_014618_9A61503C 
X-CRM114-Status: GOOD (  14.19  )
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

Test traffic controller reset and disconnect during traffic.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/040     | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/040.out |  6 +++++
 tests/nvme/rc      |  8 +++++++
 3 files changed, 69 insertions(+)
 create mode 100755 tests/nvme/040
 create mode 100644 tests/nvme/040.out

diff --git a/tests/nvme/040 b/tests/nvme/040
new file mode 100755
index 000000000000..88d255a8d0e0
--- /dev/null
+++ b/tests/nvme/040
@@ -0,0 +1,55 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2019 Yi Zhang <yi.zhang@redhat.com>
+#
+# Test nvme fabrics controller reset/disconnect/reconnect operation during I/O
+# This test is somewhat similar to test 032 but for fabrics controllers.
+
+. tests/nvme/rc
+
+DESCRIPTION="test nvme fabrics controller reset/disconnect operation during I/O"
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_have_fio
+	_require_nvme_trtype_is_fabrics
+}
+
+test() {
+	local subsys="blktests-subsystem-"
+	local port
+	local loop_dev
+	local nvmedev
+
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+	truncate -s 1G "$TMPDIR/img"
+	loop_dev="$(losetup -f --show "$TMPDIR/img")"
+
+	port="$(_create_nvmet_port "${nvme_trtype}")"
+	_create_nvmet_subsystem "${subsys}" "${loop_dev}"
+	_add_nvmet_subsys_to_port "${port}" "${subsys}"
+	_nvme_connect_subsys "${nvme_trtype}" "${subsys}"
+	udevadm settle
+	nvmedev=$(_find_nvme_dev "${subsys}")
+
+	# start fio job
+	echo "starting background fio on ${nvmedev}n1"
+	_run_fio_rand_io --filename="${nvmedev}n1" --size=1g \
+		--group_reporting --ramp_time=5  &> /dev/null &
+	sleep 5
+
+	# do reset/remove operation
+	echo "resetting ${nvmedev}"
+	_nvme_reset_ctrl ${nvmedev}
+	sleep 1
+	echo "deleting ${nvmedev}"
+	_nvme_delete_ctrl ${nvmedev}
+
+	echo "stopping background fio on ${nvmedev}n1"
+	{ kill $!; wait; } &> /dev/null
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/040.out b/tests/nvme/040.out
new file mode 100644
index 000000000000..f14ae8db1ddb
--- /dev/null
+++ b/tests/nvme/040.out
@@ -0,0 +1,6 @@
+Running nvme/040
+starting background fio on nvme0n1
+resetting nvme0
+deleting nvme0
+stopping background fio on nvme0n1
+Test complete
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 4bebbc762cbb..684d56b184e5 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -447,3 +447,11 @@ _nvme_disable_err_inject()
         echo 0 > /sys/kernel/debug/"$1"/fault_inject/probability
         echo 0 > /sys/kernel/debug/"$1"/fault_inject/times
 }
+
+_nvme_reset_ctrl() {
+	echo 1 > /sys/class/nvme/$1/reset_controller
+}
+
+_nvme_delete_ctrl() {
+	echo 1 > /sys/class/nvme/$1/delete_controller
+}
-- 
2.34.1


