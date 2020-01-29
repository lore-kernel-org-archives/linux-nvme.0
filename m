Return-Path: <SRS0=KTZ6=3S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603E9C2D0DB
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2020 23:30:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30715206D5
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jan 2020 23:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZbemLnab";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Up+LXu/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30715206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=V4Sj79H0pEXotNhi4A+lM7GqBOMnXbZd4HJeCFhJXwY=; b=ZbemLnabYTWkEY
	OPI3xJwrY8ZQechcJ0zsudNxg8dIgcLjdPxiS6k2MfmUB22PU1Z/3jJSyGvb7CaExRwn7qxb5935R
	ytJOleppRvqNJzsrLTSOmpcn+XnwP/91hbJxJ+rQ/l4D37/GH3qdi0TcjsvEZPCwB49qp+Ykvap8H
	K+TMXtKj3foOUMrpEDLTtzhywestY8YCDtopX3r1Kwu1Nm0OpxUwTdwa1e+zZdAr9EtwDCWd00mJX
	K77yVpkWMEdJnBmGUxQLVtBZmJHrL1vx0MoPOcsTI7VP/p9PN4IZsjPOZ4yNTUChUYzhRr+oeoHHm
	JsoQNk4Bm+9tsYSz8qrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iwwmv-0004Uq-Pi; Wed, 29 Jan 2020 23:30:25 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iwwm6-0002aY-Vc
 for linux-nvme@lists.infradead.org; Wed, 29 Jan 2020 23:29:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580340575; x=1611876575;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KXZsNyr6H+GgS1XHW+oCnKz+5nhllTOXchAqtu9WpTE=;
 b=Up+LXu/hl3V2wDoL6zhunOWsccwKrNF4VzVsaAFkmfZMv1atBih8z0Zf
 1Ye/wE7LsezmMK1XXKMabALF5BkfIIddNV7bt4TVq2zn69MRXpTWRvVJS
 ys+LotMgsU/T2vx070sfN1y3XEtcavcqe/2c7+Q9t+G35qpgjs/g4EnXR
 /jsbERf0HeNwZMNpK5qyfFdXSawjfAKQ/gWzBqRQvSWdV75WU4t6dL+Yk
 tm7WrZuMVZjYqmv5vAYzv+AmIbCR8Hg4/RwZb9kCKq/UJf9Evowuj7/fl
 ckbVJeC4WiLonTReJrQcOg3DtfIZMuTw1my39ltkToI21VDzk8Q5jpNW7 A==;
IronPort-SDR: cWm5jwzAVUgCnm0GbPZufF8ZOfUxGLdFvEpTSdKWJUJ26S7GFX5BbvZ9Yp+NMNFig99jK/T1NS
 1rhQ2DwRw0zYl/ozbuXLmGCL+Zhj3Tmmlt0/ODhK/va2ghA7cbJdA2Hp3ttrPQojk0Iyxhn2en
 KLoNRXYRtvyygf0oJqnpAb/qin2uMr0bztd2Mz3Ws3GCUxq+/RsSAGEFRjXlIUyOLaZOvRWRef
 PLApYzPoywVVeVcPr6eDgWH3/sd2gcp/foeUjY3THF0R1l0hmasc6wcV3410etFI3tjpW4rCkH
 AnM=
X-IronPort-AV: E=Sophos;i="5.70,379,1574092800"; d="scan'208";a="130160266"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2020 07:29:34 +0800
IronPort-SDR: L45gHc7MgZyIBTqZJis+n8bgNPV/csZnGwNEtSJbv+mKdqRYbwlOOW7kAQ0J3Ef69z/XAGCqOg
 B7gR4k6knogxcroPMRkS2Ckxe89+J436SYZ4jcjVaxIloMqyZxhHiKLw2xJus2g+woGnrJ+ROF
 lgn3mKoMQxHTDkcmCdmzgGPxagRyoyhPMFlYMCoKV5JpUgLQ9e9M8q+T0jzB1Cuoos6afi4F+P
 6KLjoG3zgf5R2n+m6ooRWK5nW0XZkEokkgWrmpx5VIwKESPUy9hNt7tz+uhFFyxyM0JpvRoSBH
 K20xpShUkcaFcSFeK3PApZyn
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jan 2020 15:22:45 -0800
IronPort-SDR: +Fg+K68EUDIVpRmHuf0S6I/mwkBrljSa5T8RJpGzPLemxJPtQ/eeT8+hdmj4s+TO3xbMtWLijM
 0ekH1rT2WIJVZIWUdEXtuyVBgX8kWvdTvYQfu6gfHd7NdUcfXFyhcRc/yBeThlvZZ6OWpEskP4
 lLansx0+vPIlNRiZS4Ll8SVWnjK0oJHzeA00YLWiJobtD3ARFxI3ym+kve1ge4Lg9A4ZwhH2zb
 Kbqocnda3m/2FW2Dvn6tToxTDfrJmVgBji2cgsEilRzxn54CIUVm9mKvrsMkVYGuW0LGwmwaH1
 EDI=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 29 Jan 2020 15:29:33 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 4/5 blktests] nvme: test target model attribute
Date: Wed, 29 Jan 2020 15:29:20 -0800
Message-Id: <20200129232921.11771-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
References: <20200129232921.11771-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200129_152935_054228_D8500B1B 
X-CRM114-Status: GOOD (  11.53  )
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

The new testcases exercises newly added cntlid [min|max] attribute for
NVMeOF target.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 tests/nvme/034     | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/034.out |  3 +++
 2 files changed, 63 insertions(+)
 create mode 100755 tests/nvme/034
 create mode 100644 tests/nvme/034.out

diff --git a/tests/nvme/034 b/tests/nvme/034
new file mode 100755
index 0000000..1a55ff9
--- /dev/null
+++ b/tests/nvme/034
@@ -0,0 +1,60 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2017-2018 Western Digital Corporation or its affiliates.
+#
+# Test NVMeOF target cntlid[min|max] attributes.
+
+. tests/nvme/rc
+
+DESCRIPTION="Test NVMeOF target model attribute"
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
+	local result
+	local nvmedev
+	local loop_dev
+	local model="test~model"
+	local file_path="$TMPDIR/img"
+	local subsys_name="blktests-subsystem-1"
+
+	truncate -s 1G "${file_path}"
+
+	loop_dev="$(losetup -f --show "${file_path}")"
+
+	_create_nvmet_subsystem "${subsys_name}" "${loop_dev}" \
+		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" 0 100 ${model}
+	port="$(_create_nvmet_port "loop")"
+	_add_nvmet_subsys_to_port "${port}" "${subsys_name}"
+
+	nvme connect -t loop -n "${subsys_name}"
+
+	udevadm settle
+
+	nvmedev="$(_find_nvme_loop_dev)"
+	nvme list | grep ${nvmedev}n1 | grep -q test~model
+	result=$?
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
+	if [ ${result} -eq 0 ]; then
+		echo "Test complete"
+	fi
+}
diff --git a/tests/nvme/034.out b/tests/nvme/034.out
new file mode 100644
index 0000000..0a7bd2f
--- /dev/null
+++ b/tests/nvme/034.out
@@ -0,0 +1,3 @@
+Running nvme/034
+NQN:blktests-subsystem-1 disconnected 1 controller(s)
+Test complete
-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
