Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5B7C77B62
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Mar 2023 03:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rTeo60yU6LUJTy7lbMQUQj1ypxXoz3pWJuOqKhfb1V0=; b=CjTzW9yV7i1gvyOVhWmlgdPF76
	D6QjL9IfxrUpYuonEypxM0Fu/qp4RdZK2KxV6MwsB1qLQGea+1wNvwH3HpEr9r6qxRY1fXghURasn
	Y3RHvslUl+SOWvXUpyocsRFtvRhmuA64oWq1Lpgbjt/jyM5KoVHp+ZmOz+SR/o/M/lBbMAmpLIvCR
	8MsB4H0JVKiJp0monPCRWClmnMO90I+DMa9NE0kJtnl+Oox1wSKUhtVThk2pBwa2jRgaU9Rtk1/Ho
	eKSGfRAU9T+R9x2944eZuxCsHwyQm0GeuOhBmbsICOjYh16Ona5o+kXL3WgAXOeMGsM7CZmj2BcIp
	SySLlLsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pi5hz-005jL6-37;
	Fri, 31 Mar 2023 03:45:47 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pi5hs-005jIG-1m
	for linux-nvme@lists.infradead.org;
	Fri, 31 Mar 2023 03:45:42 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230331034537epoutp02f873f33fa8add4da88b7b4203ea55025~RZDo6I2CY1092310923epoutp02F
	for <linux-nvme@lists.infradead.org>; Fri, 31 Mar 2023 03:45:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230331034537epoutp02f873f33fa8add4da88b7b4203ea55025~RZDo6I2CY1092310923epoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1680234337;
	bh=rTeo60yU6LUJTy7lbMQUQj1ypxXoz3pWJuOqKhfb1V0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xgmx7JpDby+3DQS0iEBEQlbgiZqERaKpemILt1olNbspFGi9jACw8rXkOACHghAqy
	 GCP1K6kfM5MPydZ6xDFvyqUeXIn7jND3FuBDupy+RijJS0BHCKLlybP6XxtS4s37SH
	 dbVoVXZX/o+Kstle2mWtNMklz6N+BOoqpHuXq8CM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20230331034536epcas5p37410910c56f619daf7af792d0c503483~RZDoip4y-0506605066epcas5p3z;
	Fri, 31 Mar 2023 03:45:36 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4PnmQl3tzhz4x9Q9; Fri, 31 Mar
	2023 03:45:35 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F5.2E.06765.D5756246; Fri, 31 Mar 2023 12:45:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20230331034533epcas5p2834dad2bc54ad1a6348895f522400e8c~RZDlBgpgy0950709507epcas5p2a;
	Fri, 31 Mar 2023 03:45:33 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230331034533epsmtrp1410a5b14a7c4039fe840e661e4d7aa70~RZDlAxj7z1855118551epsmtrp1O;
	Fri, 31 Mar 2023 03:45:33 +0000 (GMT)
X-AuditID: b6c32a4b-46dfa70000011a6d-4c-6426575df067
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	4D.52.31821.C5756246; Fri, 31 Mar 2023 12:45:32 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20230331034531epsmtip19e73d611497015a708530613cb590065~RZDj5sMwQ1824818248epsmtip1t;
	Fri, 31 Mar 2023 03:45:31 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: shinichiro.kawasaki@wdc.com
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	mcgrof@kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH blktests 2/2] nvme/047: add test for uring-passthrough
Date: Fri, 31 Mar 2023 09:14:14 +0530
Message-Id: <20230331034414.42024-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230331034414.42024-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAKsWRmVeSWpSXmKPExsWy7bCmum5suFqKwcXjAhZH/79ls9h7S9ti
	/rKn7BY3JjxltNg3y9OB1WPTqk42j81L6j36tqxi9Pi8Sc6j/UA3UwBrVLZNRmpiSmqRQmpe
	cn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtBmJYWyxJxSoFBAYnGxkr6d
	TVF+aUmqQkZ+cYmtUmpBSk6BSYFecWJucWleul5eaomVoYGBkSlQYUJ2xt/b59gKFvBVHH3z
	hrGB8QZ3FyMnh4SAiUTr3atMXYxcHEICuxklns86xALhfGKUWH+og72LkQPI+cwosbcSxARp
	OHnHCKJkF6PE92sLoeqBSm7PmcUMUsQmoClxYXIpyAIRAXmJlbObWUFsZoFKiRVNB8FGCgu4
	STw+6AESZhFQlTj+oIkZxOYVsJC4N2sTK8Rt8hIzL31nB7E5BSwlWjdvhaoRlDg58wkLxEh5
	ieats5kh6i+xS0zq4YSwXSQaP6xkgrCFJV4d38IOYUtJvOxvg7KTJS7NPAdVUyLxeM9BKNte
	ovVUP9gnzECfrN+lD7GKT6L39xMmSCjwSnS0CUFUK0rcm/QU6mJxiYczlrBClHhIfNmvAwmb
	HkaJU8/2sExglJ+F5IFZSB6YhbBsASPzKkbJ1ILi3PTUYtMC47zUcniUJufnbmIEJz0t7x2M
	jx580DvEyMTBeIhRgoNZSYS30Fg1RYg3JbGyKrUoP76oNCe1+BCjKTCEJzJLiSbnA9NuXkm8
	oYmlgYmZmZmJpbGZoZI4r7rtyWQhgfTEktTs1NSC1CKYPiYOTqkGJkc19gkXHy3b4Pvmw+3J
	1yoeChRt32l1LNcmLL3m68nPJT/2ur3+l3TPQSf77MIg0bxwrn9n3mutl8kwmNAW+XSnzppM
	lfO/1phlvDl3+FleQNuJc6+2i1h0m/qvCw4+yef+32jaj8f88dV8FUY6Dr4f24x3f/iZVetx
	PPzs+oV6HiwHondnmF06e5y3hyVjqeGveQm+r31uCnwIeN3eeawtIWXbnPu1UVtN2Cu+JH8r
	tZbQFTw5ZXnBA05dHqW5L24tcd4qfsfc7KfW9VM7xUIcssWcH71w3LLljXyk26nFP9ak3tkj
	sOzst+zvpx/e2z2/TWX2jGbdl3Eb2qafz0ng1xPx3zfR9v/jg98MSgSUWIozEg21mIuKEwHr
	O8O+AwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsWy7bCSnG5MuFqKwa5TFhZH/79ls9h7S9ti
	/rKn7BY3JjxltNg3y9OB1WPTqk42j81L6j36tqxi9Pi8Sc6j/UA3UwBrFJdNSmpOZllqkb5d
	AlfG39vn2AoW8FUcffOGsYHxBncXIweHhICJxMk7Rl2MXBxCAjsYJU7Mn8fSxcgJFBeXaL72
	gx3CFpZY+e85O0TRR0aJfcsnsYM0swloSlyYXApSIyIgL7FydjMriM0sUCsxbeYtVpASYQE3
	iccHPUDCLAKqEscfNDGD2LwCFhL3Zm1ihRgvLzHz0newVZwClhKtm7eC1QgB1XTsaGGHqBeU
	ODnzCQvEeHmJ5q2zmScwCsxCkpqFJLWAkWkVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7u
	JkZw2Gpp7WDcs+qD3iFGJg7GQ4wSHMxKIryFxqopQrwpiZVVqUX58UWlOanFhxilOViUxHkv
	dJ2MFxJITyxJzU5NLUgtgskycXBKNTAdZFzjLlL9tj3NIUjutOYFSaYDq/dVR8qprmmetNpL
	Jn35/df2NuyL3x+uqplTeSzZSiRxQU7u3WlN/4QjRHcks++bENzLMf3O0Zbdtp//2Hibd6Ru
	2LIiVveOE99DXV/d9x8mnjlaJMnWU3Dgzi1Pt9lWka8qlu5Z+DVV0irTVmJxc9UHB3VDB3vH
	7O8f8v8E8cQsrV7hFb9gw9aEjW4+axJes/h5PQ+acGBr3S9/hQMz194+J5P4XGSLEP8STduC
	7HoN804d49zqDuvT0nq1Ux8trJe5Yht2dEl5CtuTU85X9ZQvFFbHV3p/+ikmYbh3KatjY83R
	yZzzYsyLY93mTWQT0LZhZdgT+eLqGSWW4oxEQy3mouJEAL3ajxTKAgAA
X-CMS-MailID: 20230331034533epcas5p2834dad2bc54ad1a6348895f522400e8c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230331034533epcas5p2834dad2bc54ad1a6348895f522400e8c
References: <20230331034414.42024-1-joshi.k@samsung.com>
	<CGME20230331034533epcas5p2834dad2bc54ad1a6348895f522400e8c@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_204540_910790_16D6074B 
X-CRM114-Status: GOOD (  16.03  )
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

User can communicate to NVMe char device (/dev/ngXnY) using the
uring-passthrough interface. This test exercises some of these
communication pathways, using the 'io_uring_cmd' ioengine of fio.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 tests/nvme/047     | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/047.out |  2 ++
 2 files changed, 48 insertions(+)
 create mode 100755 tests/nvme/047
 create mode 100644 tests/nvme/047.out

diff --git a/tests/nvme/047 b/tests/nvme/047
new file mode 100755
index 0000000..a0cc8b2
--- /dev/null
+++ b/tests/nvme/047
@@ -0,0 +1,46 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Kanchan Joshi, Samsung Electronics
+# Test exercising uring passthrough IO on nvme char device
+
+. tests/nvme/rc
+
+DESCRIPTION="basic test for uring-passthrough io on /dev/ngX"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_kver 6 1
+	_have_fio_ver 3 33
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+	local ngdev=${TEST_DEV/nvme/ng}
+	local common_args=(
+		--size=1M
+		--filename="$ngdev"
+		--bs=4k
+		--rw=randread
+		--numjobs=2
+		--iodepth=8
+		--name=randread
+		--ioengine=io_uring_cmd
+		--cmd_type=nvme
+		--time_based
+		--runtime=2
+	)
+	#plain read test
+	_run_fio "${common_args[@]}"
+
+	#read with iopoll
+	_run_fio "${common_args[@]}" --hipri
+
+	#read with fixedbufs
+	_run_fio "${common_args[@]}" --fixedbufs
+
+	#if ! _run_fio "${common_args[@]}" >> "${FULL}" 2>&1; then
+	#	echo "Error: uring-passthru read failed"
+	#fi
+	echo "Test complete"
+}
diff --git a/tests/nvme/047.out b/tests/nvme/047.out
new file mode 100644
index 0000000..915d0a2
--- /dev/null
+++ b/tests/nvme/047.out
@@ -0,0 +1,2 @@
+Running nvme/047
+Test complete
-- 
2.25.1


