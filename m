Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3146C77B6F
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Apr 2023 08:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lj+X+1eWuufx3sjqnSb3PoSOXfcGlQpL6wfdEMwEW8o=; b=TSFu9MG7jg8rCyRr+dWnRrN8Rc
	Rux23vsTbHDNgF58UAhwXl+F5C/22GEuwb0fQAzU+YM80iOK/BllAD+7CHbZL1Ncx9X8bUVlO48EK
	bHgThm6zCqCyxPjTDlTbSINJey9OTHAEfcgdGqZTFGJ8BG5RBYGC+0TlZKxF7VTZxfU+3xABhv/Eq
	xVR+dCffQVTyyoylOfTSP//+lzpy5QySno1fpJy86CDxg/upKBwbwhXfdZkLYpn+xyNp9CJjtGSQH
	7ZXPHDOLJeQQ+vZfEwT1VaFF8u/cx9FsyrRrL8fPx4dRnfbavHnqNOQIDHgVs5Umlll4OfmImJjjn
	bND4Dr8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmsg5-005SRr-1T;
	Thu, 13 Apr 2023 08:51:37 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmsg0-005SQh-0L
	for linux-nvme@lists.infradead.org;
	Thu, 13 Apr 2023 08:51:36 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230413085124epoutp040242d74945aa984ec3534f550b576e20~VcnVzr_VY0103901039epoutp04q
	for <linux-nvme@lists.infradead.org>; Thu, 13 Apr 2023 08:51:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230413085124epoutp040242d74945aa984ec3534f550b576e20~VcnVzr_VY0103901039epoutp04q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1681375884;
	bh=Lj+X+1eWuufx3sjqnSb3PoSOXfcGlQpL6wfdEMwEW8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bnKCBuseoLutqoiRk1Bpk53W7fNR6VayfCMfze9URYIlJf3V+jiciEq2kHWFVroJ9
	 d2G4vriPuJHC4yJTpe2uRv0houJzDwHAD2z/cB4sosD9HYPZDCCJk4cw/iiLQ9pXLP
	 OXovHOdyJgXfbjd/o0t7NM//ZrfuZQv+8+2BIUpw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20230413085124epcas5p3c88bb03a5f123e364082c54c419a2213~VcnVk8nfK1049810498epcas5p3v;
	Thu, 13 Apr 2023 08:51:24 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4PxtbZ58Q5z4x9QG; Thu, 13 Apr
	2023 08:51:22 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8A.F6.09540.A82C7346; Thu, 13 Apr 2023 17:51:22 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20230413085121epcas5p2d19f099bd1d1d15f95acb2e88a5f3963~VcnTTteo32735427354epcas5p2l;
	Thu, 13 Apr 2023 08:51:21 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230413085121epsmtrp2508de1e6c8216c9a189986969be677b2~VcnTTESLS0480004800epsmtrp2K;
	Thu, 13 Apr 2023 08:51:21 +0000 (GMT)
X-AuditID: b6c32a4a-4afff70000002544-2b-6437c28af504
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	40.7C.08279.982C7346; Thu, 13 Apr 2023 17:51:21 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20230413085121epsmtip1be45dfb9da8df66cbab55948bead01e2~VcnSl54Pv1180611806epsmtip1j;
	Thu, 13 Apr 2023 08:51:21 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: shinichiro.kawasaki@wdc.com
Cc: linux-nvme@lists.infradead.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH blktests v3 2/2] nvme/049: add test for uring-passthrough
Date: Thu, 13 Apr 2023 14:20:24 +0530
Message-Id: <20230413085024.49750-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230413085024.49750-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7bCmlm7XIfMUgxv9IhZH/79ls5i/7Cm7
	xb5Zng7MHpuX1Hv0bVnF6NF+oJspgDkq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ
	0sJcSSEvMTfVVsnFJ0DXLTMHaI+SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8Ck
	QK84Mbe4NC9dLy+1xMrQwMDIFKgwITujZdljpoKJAhX/f9g2MM7h7WLk5JAQMJHY/uwNexcj
	F4eQwG5GiZV7TzJDOJ8YJaa1TGSFcL4xSrS1HmaHaXmxeCVU1V5GiXvTzjGCJIQEPjNKdK+N
	6mLk4GAT0JS4MLkUJCwiIC+xcnYzK4jNLOAucftJDxOILSzgKTF39zywOIuAqsSJ/7uZQWxe
	AQuJSxcXsEDskpeYeek72F5OAUuJTRdeQtUISpyc+YQFYqa8RPPW2WD3SAjsYpe4/vktG0Sz
	i8TJnVOgjhaWeHV8C5QtJfH53V6ommSJSzPPMUHYJRKP9xyEsu0lWk/1M4P8wgz0y/pd+hC7
	+CR6fz9hAglLCPBKdLQJQVQrStyb9JQVwhaXeDhjCZTtIbFw23EmSFD1MEpsWd/ENIFRfhaS
	F2YheWEWwrYFjMyrGCVTC4pz01OLTQuM8lLL4dGanJ+7iRGc2LS8djA+fPBB7xAjEwfjIUYJ
	DmYlEd4fLqYpQrwpiZVVqUX58UWlOanFhxhNgWE8kVlKNDkfmFrzSuINTSwNTMzMzEwsjc0M
	lcR51W1PJgsJpCeWpGanphakFsH0MXFwSjUwyX4vvfVhy3vNW9FvIqbNzX9SUCXg6HnxyeYg
	sTVz96rpHtJxi/umxHzFZ89XaZvFHYskZzp/krVSCCo8JCfKc/hUhvveFqHSZsNH9iJikZ8f
	SHvdK9P5Ov2Up8aktrCG9putnUev/noR/cTymNK0qAdznaTT5K0s1QzCeso2P1jE9+1z/C/v
	7x+FNn7rY3vbJ9egtPd+3NIdC5a943D6fWun8QpO5oL3TkWhqs9SijtqbpkGH26aHax4t3D9
	tzZXtQtrKhf56/S+4LpwOz45T2T3+eputQWvO558169zOJvF9ku79YfcuuVuIZvPL1l8dJUC
	p+n+65nRu77MyDj4o/xD/nINYbcDzy3U9y2XVGIpzkg01GIuKk4EAFAk8u31AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKLMWRmVeSWpSXmKPExsWy7bCSnG7nIfMUg+VrzC2O/n/LZjF/2VN2
	i32zPB2YPTYvqffo27KK0aP9QDdTAHMUl01Kak5mWWqRvl0CV0bLssdMBRMFKv7/sG1gnMPb
	xcjJISFgIvFi8UrmLkYuDiGB3YwSk2cvYYZIiEs0X/vBDmELS6z895wdougjo8SUq0+Bijg4
	2AQ0JS5MLgWpERGQl1g5u5kVJMws4CmxfqI8SFgYyJy7ex4riM0ioCpx4v9usPG8AhYSly4u
	YIEYLy8x89J3sFWcApYSmy68BKsRAqr58PQdG0S9oMTJmU/A6pmB6pu3zmaewCgwC0lqFpLU
	AkamVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwSGppbmDcfuqD3qHGJk4GA8xSnAw
	K4nw/nAxTRHiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qB
	qV69l+P+/CqbCLeDH3bN0f/GMzNnudyZ+HeJyVY/tdYFb+1crG8k8Ifl2rftNw6cU4qtfnDx
	0OE1GmrMy7bvesmY277ooNgfFhnT4CPtz+Xsfn2cMHUDh8ehBTN9pk6YGTlx7YN4pwfbNvyX
	nHZ+Wt5v5WX7l1UUVzvILGDhq1qf8++o/F1dt9D4Jrt5InvWaS7ROflBxH2mF/PJmJOrkr2f
	NIRlKnfGMmupbQ08b8bn5BO59+86I7P393ebrtM9JrTp6u5Vb7wWPH1cueZH1b3UNQmrwm4f
	eXlJYvrVn1lxc5+cEDAxXenwba373heyMY9nLuHXOVB6KOuYrL18v9q9m9az5jDPiOJYfLLS
	IfCdEktxRqKhFnNRcSIA7sEr87gCAAA=
X-CMS-MailID: 20230413085121epcas5p2d19f099bd1d1d15f95acb2e88a5f3963
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230413085121epcas5p2d19f099bd1d1d15f95acb2e88a5f3963
References: <20230413085024.49750-1-joshi.k@samsung.com>
	<CGME20230413085121epcas5p2d19f099bd1d1d15f95acb2e88a5f3963@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230413_015135_065927_3C8C86E9 
X-CRM114-Status: GOOD (  16.33  )
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
 tests/nvme/049     | 54 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/049.out |  2 ++
 2 files changed, 56 insertions(+)
 create mode 100755 tests/nvme/049
 create mode 100644 tests/nvme/049.out

diff --git a/tests/nvme/049 b/tests/nvme/049
new file mode 100755
index 0000000..f72862c
--- /dev/null
+++ b/tests/nvme/049
@@ -0,0 +1,54 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2023 Kanchan Joshi, Samsung Electronics
+# Test exercising uring passthrough IO on nvme char device
+
+. tests/nvme/rc
+
+DESCRIPTION="basic test for uring-passthrough I/O on /dev/ngX"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_kernel_option IO_URING
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
+		--numjobs=1
+		--iodepth=16
+		--name=randread
+		--ioengine=io_uring_cmd
+		--cmd_type=nvme
+		--time_based
+		--runtime=2
+	)
+	local fio_output
+
+	# check security permission
+	if ! fio_output=$(fio --name=check --size=4k --filename="$ngdev" \
+			    --rw=read --ioengine=io_uring_cmd 2>&1) &&
+			grep -qe "Permission denied" <<< "$fio_output"; then
+		SKIP_REASONS+=("IORING_OP_URING_CMD is not allowed for $ngdev")
+		return
+	fi
+
+	#plain read test
+	_run_fio "${common_args[@]}"
+
+	#read with iopoll
+	_run_fio "${common_args[@]}" --hipri
+
+	#read with fixedbufs
+	_run_fio "${common_args[@]}" --fixedbufs
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/049.out b/tests/nvme/049.out
new file mode 100644
index 0000000..c172030
--- /dev/null
+++ b/tests/nvme/049.out
@@ -0,0 +1,2 @@
+Running nvme/049
+Test complete
-- 
2.25.1


