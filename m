Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFFAC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jun 2022 15:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4Kb5CWRA5LlqGaoxU2SK5O2kdDtLVm4F1urLHmSvY0o=; b=Gdd4seREr2TSYzKtOP7mpIEdTV
	AhBC6v7Gkv7va812XfFycZ8F9KQO1wH59aAjFZNCzvLPJn1HxHNYJ+diEnBfRhnMe/Wi3kFXUeYYf
	vFO2k+Jj3FjJvbgyjoA69hgxY4qcInPmtYXlRlJwDelePUrHvn0gIJQUVdi9fKrDpbX9/jRRs1bft
	WC7cn1Mi96WCr9uzUqj5gkQLlBjyFECGmlvu4kLHdzaNJxMY9xaLZF4ZzfRqlAm0jjBc3C+oKei8U
	6LfYgpSFcBCXqy6SwxbAV4BhTM1QNoktN9sRvFyLoXW5eWYRrqTkjLtlWaRlVrVzEBGSkQAgigYui
	+v2p1NEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6wLg-000OM6-3P; Thu, 30 Jun 2022 15:44:56 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6wLa-000OJd-FU
	for linux-nvme@lists.infradead.org; Thu, 30 Jun 2022 15:44:52 +0000
Received: by mail-wr1-f49.google.com with SMTP id i1so23419890wrb.11
        for <linux-nvme@lists.infradead.org>; Thu, 30 Jun 2022 08:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Kb5CWRA5LlqGaoxU2SK5O2kdDtLVm4F1urLHmSvY0o=;
        b=zafbejGgbKtokiYj5/SQ9Eoyd2JCopfTnji4R9NB93wiZEzVs9XFmExCcmssprhX20
         gB6jbPD1LgQiZkejpURQD1L1Ioe7BIjX/C7OPLZxXXKuNT2FSLBi//iGCfomBIXNyNcM
         hC5UI/xPoQH1/PVr4Bgi155jOQD7Pj13fFxngHEzawLZzqioDO1cy6bstWxJzHKxUyYZ
         B1ss39EP5IxYzkB7YEliheTAGZ3AXREfnsi3kLeE8oASIHqkL2PtpfBATLILjvVg7KQS
         rQlyXGMZPZFSdEj+3RuGErJxbmZY5ghRT3bq+bvwBCiz+kR0NEixZgsz8NRsoxnuIPo+
         B2rg==
X-Gm-Message-State: AJIora/jGzbqMletka53QRzt9lCQ0MnQnMHNqBsUwwtISNJnN0lNc4+f
	im9HEtgd1ixMO/eUwPXiw9U=
X-Google-Smtp-Source: AGRyM1sjdOHNnP3ZTVBi1hSHPtM70hKXN7qiGNGJHdsuU25BmDmMgH+Yl/95EFIY9DoFcLAP5qlzjQ==
X-Received: by 2002:a5d:6481:0:b0:21d:231e:83b4 with SMTP id o1-20020a5d6481000000b0021d231e83b4mr8763918wri.689.1656603886776;
        Thu, 30 Jun 2022 08:44:46 -0700 (PDT)
Received: from localhost.localdomain (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d44c2000000b0021a3d94c7bdsm19829452wrr.28.2022.06.30.08.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 08:44:46 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH blktests v2] nvme: add nvmf reset/disconnect during traffic test
Date: Thu, 30 Jun 2022 18:44:44 +0300
Message-Id: <20220630154444.475600-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220630_084450_569972_A95097F4 
X-CRM114-Status: GOOD (  14.35  )
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
Changes from v1:
- fix copyright
- change subsys name
- fix test cleanup warnings
- don't log device names
- fix shellcheck

 tests/nvme/040     | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/040.out |  6 +++++
 tests/nvme/rc      |  8 +++++++
 3 files changed, 73 insertions(+)
 create mode 100755 tests/nvme/040
 create mode 100644 tests/nvme/040.out

diff --git a/tests/nvme/040 b/tests/nvme/040
new file mode 100755
index 000000000000..d259784698d9
--- /dev/null
+++ b/tests/nvme/040
@@ -0,0 +1,59 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2022 Sagi Grimberg <sagi@grimberg.me>
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
+	local subsys="blktests-subsystem-1"
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
+	echo "starting background fio"
+	_run_fio_rand_io --filename="${nvmedev}n1" --size=1g \
+		--group_reporting --ramp_time=5  &> /dev/null &
+	sleep 5
+
+	# do reset/remove operation
+	echo "resetting controller"
+	_nvme_reset_ctrl ${nvmedev}
+	sleep 1
+	echo "deleting controller"
+	_nvme_delete_ctrl ${nvmedev}
+
+	echo "stopping background fio"
+	{ kill $!; wait; } &> /dev/null
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys}"
+	_remove_nvmet_subsystem "${subsys}"
+	_remove_nvmet_port "${port}"
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/040.out b/tests/nvme/040.out
new file mode 100644
index 000000000000..50d02d4e3cd0
--- /dev/null
+++ b/tests/nvme/040.out
@@ -0,0 +1,6 @@
+Running nvme/040
+starting background fio
+resetting controller
+deleting controller
+stopping background fio
+Test complete
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 4bebbc762cbb..dfea7f3a0da4 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -447,3 +447,11 @@ _nvme_disable_err_inject()
         echo 0 > /sys/kernel/debug/"$1"/fault_inject/probability
         echo 0 > /sys/kernel/debug/"$1"/fault_inject/times
 }
+
+_nvme_reset_ctrl() {
+	echo 1 > /sys/class/nvme/"$1"/reset_controller
+}
+
+_nvme_delete_ctrl() {
+	echo 1 > /sys/class/nvme/"$1"/delete_controller
+}
-- 
2.34.1


