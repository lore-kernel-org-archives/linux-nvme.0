Return-Path: <SRS0=Uncj=4D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABA1C35242
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Feb 2020 01:39:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D50E22073A
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Feb 2020 01:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gmkjbw3w";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Z1Qnj0uF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50E22073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VuoEAoUJV24w2/G7qbEPEbPYXNv8eJi7y89WRAY+dRo=; b=Gmkjbw3wwbUhQg
	3JsI2NAiynsYk+acjPBWzIUAplZhVOJHIUDNlBU+4PMcYjEW8xNb8yNGsj1/qzUG3bzPaeIVmyFMH
	zdVTWcO5RLy91NapLM+y3aqQyHpuqxUSNaQQQWUNqhNUn9hk1uA2bgsTCJutYTG3HBEC8j/EbX3w2
	0JrNkYdYf5YSKr8KUU2DIjQKwmNVYqxTdFL3O/3m1KhcXZJfxWUV6Np3hgbhSTBPo3FvJaL9dQySQ
	/Thz6BcxEh8a293QS88RVLqVZ35hg6bAp/b3BxWYDDPFZXbtCsr8y8RqNh7+IqqAGtDW3wK2EgB73
	giTWhxLTo/xKulBdrIAQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j2mQE-0006uP-2B; Sat, 15 Feb 2020 01:39:06 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2mQ6-0006mi-SP
 for linux-nvme@lists.infradead.org; Sat, 15 Feb 2020 01:39:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1581730738; x=1613266738;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=PVVWGcIQHoA1Y15S9BkGYIyI5ZJjziivksjUZDcIiq4=;
 b=Z1Qnj0uFXJP+q0JZXBIbFCy9lCrYG9jJn3eUQGQ9nqJ7Hf1HRC79eKVy
 s2CLya7Gn650bhnBHzj1HsnX1JYTE/TVVb4FNimitapGgXx/KTZ8WbJX5
 kVc3FptT8xW1Z0u2/dCD4butNVEogwLtIwpA/y6stnEqKY6pR1cmlKfHf
 Sz1cSw0uYO7KcjW0yA0fjJFspdOlvCjdDtEF3xuRV8QhAXg/LoorL4PGe
 itmZqyXI5kgbsC0jCyUfdQoyxKTRNe1MpqTQ2nwNqYty6Cklx9Hm4cFjI
 AYoO4R7qmS9GVpxLmDRKVkGev0gGoFQiFmwltvo/H30bCaTBmaQixUmCh w==;
IronPort-SDR: VTn7J0dW7yAPTobeQ3o0V6H5EzLmBA6lZixdC4idVr+3O2zIsGNQl/BQOag+JlmDMdE4uZM/3L
 62AfPOI3evKslQIBToImhH+ZXPe0alCIFfNRil886B+X+7WiVtwpnxEjYYNVjippRupA7Navvw
 mSreaS5wQMhvbIQhI+VvCdFumGplgsRnKlQ34GeuGYLYaTnhSFCIlCZmK9a1e8O/dCLYjy8Su9
 fMbP50CKDFRY3HhuhJBotfLkhMp7CMelUFgP5YGggpVef5gPECLHLMg3/WtZXeJUMiZ6fu+rqC
 u18=
X-IronPort-AV: E=Sophos;i="5.70,442,1574092800"; d="scan'208";a="129907009"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2020 09:38:38 +0800
IronPort-SDR: N/G0Sy+2R8mVzdyqS5+SFzBez1joW5GMFs0bPNeb2+T8CKywGblLq0GRpdAy1f+doDcJST0UzP
 b6eLTVhJwpBLMKowuR5W/CM89/P7j/UurK5KwLkyUliK6KNmJQgwYvVKxEElwaKve6S6203FnA
 dFKq7jqTuzbz1CrfGSrSM06F1I6nQ8I1Cmw1IcjTbMjbC9Ky+awsfAaNpB0K3XM3/G6s2E+R1e
 f169fgB9xlAx8c1E8pvwsxrrqRejME+GZeQH2l2fTOc9jDM6snJeYOZMOmIAhEBpp8UM3bQz+V
 Z1qeE5N3teyewb4bMivraeZe
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Feb 2020 17:31:23 -0800
IronPort-SDR: S28rkRdp/fHt66j4ARdXmJ9N3zErjASd2Ogir+OINWiXB52XMzv4bBfrIJwrnB+fuDjOUBQxF9
 qgoNys/vi4xbs8F9YOn25v5OYKJgd6rlFB2Y426YMyX9AusvEhsZQES47tTRwh6O7xqjafHDR0
 zMtlyhKjvUSfCB9UEd0dciLyqeNNE5r1nZF0YbRdbPnalt33k5af6s+59hkP+xD+gTNI1DBlqz
 68FXTl3QHtpFT513vra0NATLlitUtymLvCteneegwDAhstZmW1nWl3Hfwe5UcWYQ7olGQuIDkA
 HKg=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 14 Feb 2020 17:38:37 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: osandov@fb.com
Subject: [PATCH blktests V2 2/3] nvme: test target cntlid min cntlid max
Date: Fri, 14 Feb 2020 17:38:30 -0800
Message-Id: <20200215013831.6715-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200215013831.6715-1-chaitanya.kulkarni@wdc.com>
References: <20200215013831.6715-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200214_173859_022404_B98BDD00 
X-CRM114-Status: GOOD (  10.09  )
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
Cc: linux-block@vger.kernel.org,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The new testcases exercises newly added cntlid [min|max] attributes
for NVMeOF target.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 tests/nvme/033     | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/033.out |  4 +++
 2 files changed, 65 insertions(+)
 create mode 100755 tests/nvme/033
 create mode 100644 tests/nvme/033.out

diff --git a/tests/nvme/033 b/tests/nvme/033
new file mode 100755
index 0000000..49f2fa1
--- /dev/null
+++ b/tests/nvme/033
@@ -0,0 +1,61 @@
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
+PORT=""
+NVMEDEV=""
+LOOP_DEV=""
+FILE_PATH="$TMPDIR/img"
+SUBSYS_NAME="blktests-subsystem-1"
+
+_have_cid_min_max()
+{
+	local cid_min=14
+	local cid_max=15
+
+	_setup_nvmet
+	truncate -s 1G "${FILE_PATH}"
+	LOOP_DEV="$(losetup -f --show "${FILE_PATH}")"
+
+	# we can only know skip reason when we create a subsys
+	 _create_nvmet_subsystem "${SUBSYS_NAME}" "${LOOP_DEV}" \
+		"91fdba0d-f87b-4c25-b80f-db7be1418b9e" ${cid_min} ${cid_max}
+}
+
+requires() {
+	_have_program nvme && _have_modules loop nvme-loop nvmet && \
+		_have_configfs && _have_cid_min_max
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	PORT="$(_create_nvmet_port "loop")"
+	_add_nvmet_subsys_to_port "${PORT}" "${SUBSYS_NAME}"
+
+	nvme connect -t loop -n "${SUBSYS_NAME}"
+
+	udevadm settle
+
+	NVMEDEV="$(_find_nvme_loop_dev)"
+	nvme id-ctrl /dev/"${NVMEDEV}"n1 | grep cntlid | tr -s ' ' ' '
+
+	nvme disconnect -n "${SUBSYS_NAME}"
+
+	_remove_nvmet_subsystem_from_port "${PORT}" "${SUBSYS_NAME}"
+	_remove_nvmet_subsystem "${SUBSYS_NAME}"
+	_remove_nvmet_port "${PORT}"
+
+	losetup -d "${LOOP_DEV}"
+
+	rm "${FILE_PATH}"
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
