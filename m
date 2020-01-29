Return-Path: <SRS0=KTZ6=3S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6D9C2D0DB
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2020 23:29:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4084C206D5
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2020 23:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ix2u0DyD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ElRJOHmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4084C206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Qbgxqk2Rz7h4xlJIBlFQs5CZR9dwZk3XxuvLUMOLYbY=; b=Ix2u0DyDD5t79Y
	yTJFMgNjI4bd4qK7Tk6/bfS8kLYNyj5c+E8v3gNUmc7yEsgwd9IAgqBGShbT3KYDwWYTYodHA5QdI
	4QRcc5xdBBY4dHps/1uHNOjRVALeTQw7GhdMFEHYzfq4rEfnbi8EYOAYfiPEzLNLrYdkF3ho7A2sq
	0TOBnCeEcmD+Q5w5/x1rsZSiDhOtebTorYALBvTPIeo4rVRPAo7TZvKq0qakkTRwFJ017olW5350S
	zj4OGYutU6HIlj9/6eqhKjlS/OscNDXsgE5GSi3DmBv5QvuDPpFZzImgwPAeOhFGvj3cvNpP4aUAI
	BUPCvbLxMzpKmFSL0P9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iwwmJ-0002tc-FJ; Wed, 29 Jan 2020 23:29:47 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iwwm5-0002ax-S4
 for linux-nvme@lists.infradead.org; Wed, 29 Jan 2020 23:29:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580340574; x=1611876574;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6LRKDrLJNKRzqs49kNk7BQqax8ZTUAptPqv9+XRu5GE=;
 b=ElRJOHmqQmzHyQtdywLEomKAk+kxlX31P5WuFZanDId/9mN77P8KoDcg
 Ye2OWyb/tEnrBsWQ3mlWOIl7GwBCaNpfWh+L4G70cuLTS8VeMX5euqLSx
 vbOQdN0pkKGiRKYBHI0s+PPlZZd9nZ3tAJSvVUV4ioWbOSXld9GaYQnSQ
 MEG37vZbi1mwgesWXUYHKJ4rXqmTN6WA/3hMGp/wFu85+ik0QP6jSLg+Q
 /ztpX1g6mQKDbtDRn+1LN4/2L7XR8SNrS5skTciPVmB3U9YAvssRfgo97
 qgF1CrMdulYc9/x343vLxiz/yrLlm0YPVE1iL3z8mt0XqxmJRaI1+gdMy w==;
IronPort-SDR: OqB3HSLra8orPPHS+Xxr1tdYRBWISkPFr+Py5Tdc8StjM9OUpKds8333p9Y+cHj/BZF4Zu5kJO
 yLpQZubJ8H0t6756oCvEw6IumNSc95jgqyd0OutoAKObaLH4ryW1f3xGQtMpQ+xK9I6qJ9RGi3
 tXw6zT/JKigh6DOufEuYEHRS5PHS/g889RzqwENoU39+rBmvv02qAkvmFiw18MNF+KLIpbOxm6
 RVoi+bhyU7fD0vXJKmdpOKA2QMrC/FBlstfxAk3oG5x8ViGOKTqjvnoTx+31b0p4++aiOWfDiq
 qk4=
X-IronPort-AV: E=Sophos;i="5.70,379,1574092800"; d="scan'208";a="130160262"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2020 07:29:31 +0800
IronPort-SDR: VUWXuQtmt1/vDfu7vzEXQFCOKpxEWkOQPwn8l8JIL544rWky0KvRn/4JL8vZg5oBjEDCZOoT5W
 9wazTou9tMbZaV7KBqnMSYAV7n3i4a5qwZm73MuzDpmUtJ0pwtADJVpf+KO7waLUvlFFufL8+1
 NHDCqfraMo6opizZ/UsxY8CJk2I68vO2UUQJIx0wvFJ+ywjjj38uvwLSzxKGMm/J5V5YKw3ZvW
 bkGKUW5wtTEbt6xzQyXY8RJTcLcB1C5PRq66mbVOqTdyXpLlU9yHHAAcsjPsHfzAW0zqBYEpZu
 HwoOXzOpMr8dtitoxRU2ZC5r
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2020 15:22:42 -0800
IronPort-SDR: 7Z3ts7qElZgUF3XUm8Y4K1zcsg7VGjQAv3RDKP+yYNWNy1ls92mpDFadk5UBAQnqsp2I20viqf
 8KFbd85lKDbLjXPZDPxdOEEq2G0wZ4jTyWG0obrDldOTd/1CNleP7P7XViPlFqWvU+OyjgmVrc
 8RDYJY8Vrg8J0hR4gtxTtF+2zdE4gPVNRbrIkhi/VHgIMQJ/Vwgg/SN2mLNHZo7GR+KfMGYXsI
 OjeLHwIt7gRepdOjpeeDzCYPVjf3mjeVUIi61b/ILaWZzez9ECmVS17w/xZeOE4XMz4fNTdb9p
 MaI=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Jan 2020 15:29:31 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/5 blktests] nvme: test target cntlid min cntlid max
Date: Wed, 29 Jan 2020 15:29:18 -0800
Message-Id: <20200129232921.11771-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
References: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200129_152933_942319_FC8C5D23 
X-CRM114-Status: GOOD (  11.31  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The new testcases exercises newly added cntlid [min|max] attributes
for NVMeOF target.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 tests/nvme/033     | 57 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/033.out |  4 ++++
 2 files changed, 61 insertions(+)
 create mode 100755 tests/nvme/033
 create mode 100644 tests/nvme/033.out

diff --git a/tests/nvme/033 b/tests/nvme/033
new file mode 100755
index 0000000..97eba7f
--- /dev/null
+++ b/tests/nvme/033
@@ -0,0 +1,57 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
+#
+# Test NVMeOF target cntlid[min|max] attributes.
+
+. tests/nvme/rc
+
+DESCRIPTION="Test NVMeOF target cntlid[min|max] attributes"
+QUICK=1
+
+requires() {
+	_have_program nvme && _have_modules loop nvme-loop nvmet && \
+		_have_configfs
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	local port
+	local nvmedev
+	local loop_dev
+	local cid_min=14
+	local cid_max=15
+	local file_path="$TMPDIR/img"
+	local subsys_name="blktests-subsystem-1"
+
+	truncate -s 1G "${file_path}"
+
+	loop_dev="$(losetup -f --show "${file_path}")"
+
+	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
+		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" ${cid_min} ${cid_max}
+	port="$(_create_nvmet_port "loop")"
+	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+
+	nvme connect -t loop -n "${subsys_name}"
+
+	udevadm settle
+
+	nvmedev="$(_find_nvme_loop_dev)"
+	nvme id-ctrl /dev/${nvmedev}n1 | grep cntlid | tr -s ' ' ' '
+
+	nvme disconnect -n "${subsys_name}"
+
+	_remove_nvmet_subsystem_from_port "${port}" "${subsys_name}"
+	_remove_nvmet_subsystem "${subsys_name}"
+	_remove_nvmet_port "${port}"
+
+	losetup -d "${loop_dev}"
+
+	rm "${file_path}"
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/033.out b/tests/nvme/033.out
new file mode 100644
index 0000000..b1b0d15
--- /dev/null
+++ b/tests/nvme/033.out
@@ -0,0 +1,4 @@
+Running nvme/033
+cntlid : e
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
