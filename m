Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2306C61DA4
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Feb 2023 09:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=UXtRwDphID/Ql8XT+1xkKeabHjao2p9LV348IWYUnm0=; b=pJyv5/NRQ3ZWWcZ9L9GZAgPrwF
	Xp3+1HG3r+7PmaXVbbI1GA+39VOcwrAis6IODGqo5fBM0Ih83RjIPDcVq9YUXj5wlxWwkymWfgX9I
	gA7k2zaEug4ItbtJX8RsevxWi5XssZd68bvbSRe3UoqSbuuszF/fnDLRfh4OA4/sL8k7C4QgrAFoT
	bqKJsc+KK2jnUN5d0n1BHS7kMP4xMz0yAvm4TVLFGJm9zlZZH+3RALkAdLfEOuf4sTBIORFvmGuNe
	bh1m7DgSvR2NJrc5WR/GdFvAujnNuCgYYcNVAqtDgGCwDSr1YDXZw4cn15FVPoD2Pfjg4TBFqBjr0
	PF1HUnfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ3Vz-000uPA-2i; Thu, 09 Feb 2023 09:46:51 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ3Vt-000uL1-U6
	for linux-nvme@lists.infradead.org; Thu, 09 Feb 2023 09:46:48 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230209094637epoutp01a1127f4f66de886dc19adef9e57e1a25~CHujyXzfi3050830508epoutp012
	for <linux-nvme@lists.infradead.org>; Thu,  9 Feb 2023 09:46:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230209094637epoutp01a1127f4f66de886dc19adef9e57e1a25~CHujyXzfi3050830508epoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1675935997;
	bh=UXtRwDphID/Ql8XT+1xkKeabHjao2p9LV348IWYUnm0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=iPS+AjZQorlYfxunJY2wIMkMe/NX0gieroLpFLp4v2xDxvE1aQZkp0dGXYJinw68H
	 nlvO0m0jYIyxVDSbM65DCd7Uq0LCF9aR4wt9BbFqZMu1gV/sdcfoaPXPTdTHHvYRqQ
	 0XjOhFhMu4Rrm41ZQpQa0dz5vQg0UD6rbAG3MzgQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20230209094636epcas5p4900245f58cc64f82e76a7613e95a9524~CHujdM3v61483014830epcas5p4I;
	Thu,  9 Feb 2023 09:46:36 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4PCBpM40Jvz4x9QF; Thu,  9 Feb
	2023 09:46:35 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DA.AC.10528.7F0C4E36; Thu,  9 Feb 2023 18:46:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20230209094631epcas5p436d4f54caa91ff6d258928bba76206de~CHueJKDwx1483014830epcas5p45;
	Thu,  9 Feb 2023 09:46:31 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230209094631epsmtrp2019e6139681194d91451061a8c0c6e90~CHueIfHZk0061800618epsmtrp2n;
	Thu,  9 Feb 2023 09:46:31 +0000 (GMT)
X-AuditID: b6c32a49-c17ff70000012920-74-63e4c0f7058c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	4B.7F.17995.7F0C4E36; Thu,  9 Feb 2023 18:46:31 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20230209094630epsmtip17ea651030a5b735f4dcb21cb2f8c1742~CHudLjiDR0523905239epsmtip1e;
	Thu,  9 Feb 2023 09:46:29 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: shinichiro.kawasaki@wdc.com
Cc: hch@lst.de, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH blktests] nvme/046: add test for unprivileged passthrough
Date: Thu,  9 Feb 2023 15:15:41 +0530
Message-Id: <20230209094541.248729-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7bCmpu73A0+SDS6tV7RYufook8XR/2/Z
	LPbe0raYv+wpu8W+WZ4OrB6bl9R77L7ZwObRt2UVo8fnTXIe7Qe6mQJYo7JtMlITU1KLFFLz
	kvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4A2KymUJeaUAoUCEouLlfTt
	bIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOyM7YcPche0CVYse/t
	C+YGxke8XYycHBICJhITbj1n62Lk4hAS2M0oca19NzOE84lRYtWZn0wQzmdGiUk/PzDBtNxa
	sRaqZRejxN+/L5nhqi5tOA6U4eBgE9CUuDC5FKRBREBeYuXsZlYQm1mgSGLG53YwW1jAU2Ll
	1XnsIDaLgKrE3KevmEBaeQUsJbZsLYbYJS8x89J3sBJeAUGJkzOfsECMkZdo3jobbK2EwD52
	icavvxkhGlwkOnoaWCBsYYlXx7ewQ9hSEp/f7WWDsJMlLs08B/VMicTjPQehbHuJ1lP9zCA3
	MAOdv36XPsQuPone30/ATpMQ4JXoaBOCqFaUuDfpKSuELS7xcMYSKNtDoq/lF9g1QgKxEj8P
	tLNMYJSbheSDWUg+mIWwbAEj8ypGydSC4tz01GLTAsO81HJ4VCbn525iBCc5Lc8djHcffNA7
	xMjEwXiIUYKDWUmE9/vEx8lCvCmJlVWpRfnxRaU5qcWHGE2BoTqRWUo0OR+YZvNK4g1NLA1M
	zMzMTCyNzQyVxHnVbU8mCwmkJ5akZqemFqQWwfQxcXBKNTAtPnOy9MoZI/+zk87Gfduadiyo
	YZMc599bKX/fHPV/9cx2X2dORmDzAkGZ9QkaVwMaYhb/THmrbOnz8rz7v+qb1Q8Nzkyeu/sW
	++SIeQIVbOzc5zvu7Odve1zzzj/m02qnVbfEy8rav0XsOFB47fNRtu0h2w8sfB6qI3f575KS
	jbJMJzVjXhdyfljm52Cea1Kz6n1H/+e3EdECVWFpQld4dOK6Sm6d/X5g+9lKi8s/BbdNDIyq
	ltv5T+5Ze82RJwFZalbuxSIX+7RKNj9cwHp4d72a+XuTRlEh1U0N27XTHOSDIk7JzFY+9tlT
	Pz6dS1lz0pxtLSqWkcq26+u8rv4Itg75eLB0d/mVaxMzZQOUWIozEg21mIuKEwFVObbR+wMA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrALMWRmVeSWpSXmKPExsWy7bCSnO73A0+SDRbPZbFYufook8XR/2/Z
	LPbe0raYv+wpu8W+WZ4OrB6bl9R77L7ZwObRt2UVo8fnTXIe7Qe6mQJYo7hsUlJzMstSi/Tt
	Ergythw9yF7QJVix7+0L5gbGR7xdjJwcEgImErdWrGXrYuTiEBLYwShxc0E3C0RCXKL52g92
	CFtYYuW/5+wQRR8ZJea3vGDsYuTgYBPQlLgwuRSkRkRAXmLl7GZWEJtZoEzi+MUlYHOEBTwl
	Vl6dBzaHRUBVYu7TV0wgrbwClhJbthZDjJeXmHnpO1gJr4CgxMmZT1ggxshLNG+dzTyBkW8W
	ktQsJKkFjEyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCA1FLawfjnlUf9A4xMnEw
	HmKU4GBWEuH9PvFxshBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNTUwtSi2Cy
	TBycUg1MLtzL5xzhCVh05eWUjWd1PlpOtf9wVD3lw5OaXcX7yt0YnY5yxRX+kOy+r3dxeVPv
	voPvp+2rDHJ7bLzY0v6J+999/1Tk1xxlMvx+6Hlp7Ga+/kN+c5O3RE/dGMbdsHTzk8jzvYwb
	nR7vvmPs8eWJsOAugyKTW8GXHplUGO9e+FOi9nHa/r0C5h/0OIrjtiftZn6rbR4eLW1q+i2B
	w4+v/TeXDGOt3p/Yadeldxx6tdXiSe4HjZpjd/yP5Cw1u77X+uHmCdYJVn3W08y9m8779ZYI
	bRHSF/3ElVoSaef1wyJu29ttJ07de7yRJyz6buinU01+j76Jbf93Lk6u/qF0f/gir5JJBxd8
	ujS1aIb9dSWW4oxEQy3mouJEALkohUqzAgAA
X-CMS-MailID: 20230209094631epcas5p436d4f54caa91ff6d258928bba76206de
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230209094631epcas5p436d4f54caa91ff6d258928bba76206de
References: <CGME20230209094631epcas5p436d4f54caa91ff6d258928bba76206de@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230209_014647_295972_93D8BF85 
X-CRM114-Status: GOOD (  19.05  )
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

Ths creates a non-root user "blktest46", alters permissions for
char-device node (/dev/ngX) and runs few passthrough commands.
At the end of the test, user is deleted and permissions are reverted.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 tests/nvme/046     | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/046.out |  2 ++
 2 files changed, 57 insertions(+)
 create mode 100644 tests/nvme/046
 create mode 100644 tests/nvme/046.out

diff --git a/tests/nvme/046 b/tests/nvme/046
new file mode 100644
index 0000000..40bda62
--- /dev/null
+++ b/tests/nvme/046
@@ -0,0 +1,55 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Kanchan Joshi, Samsung Electronics
+# Test for unprivileged passthrough
+
+. tests/nvme/rc
+
+DESCRIPTION="basic test for unprivileged passthrough on /dev/ngX"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_fio
+}
+
+device_requires() {
+	_require_test_dev_is_nvme
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+	local ngdev=${TEST_DEV/nvme/ng}
+	local usr="blktest46"
+	local perm=$(stat -c "%a" $ngdev)
+	local nsid=$(_test_dev_nvme_nsid)
+
+	useradd -m $usr
+	chmod g+r,o+r "$ngdev"
+
+	if ! su $usr -c "nvme io-passthru ${ngdev} -o 2 -l 4096 \
+		-n $nsid -r" >> "${FULL}" 2>&1; then
+		echo "Error: io-passthru read failed"
+	fi
+
+	if su $usr -c "echo hello | nvme io-passthru ${ngdev} -o 1 -l 4096 \
+		-n $nsid -r" >> "${FULL}" 2>&1; then
+		echo "Error: io-passthru write passed (unexpected)"
+	fi
+
+	if ! su $usr -c "nvme id-ns ${ngdev}" >> "${FULL}" 2>&1; then
+		echo "Error: id-ns failed"
+	fi
+
+	if ! su $usr -c "nvme id-ctrl ${ngdev}" >> "${FULL}" 2>&1; then
+		echo "Error: id-ctrl failed"
+	fi
+
+	if su $usr -c "nvme ns-descs ${ngdev}" >> "${FULL}" 2>&1; then
+		echo "Error: ns-descs passed (unexpected)"
+	fi
+
+	echo "Test complete"
+	chmod  $perm "$ngdev"
+	userdel -r  $usr >> "${FULL}" 2>&1
+}
diff --git a/tests/nvme/046.out b/tests/nvme/046.out
new file mode 100644
index 0000000..2b5fa6a
--- /dev/null
+++ b/tests/nvme/046.out
@@ -0,0 +1,2 @@
+Running nvme/046
+Test complete
-- 
2.25.1


