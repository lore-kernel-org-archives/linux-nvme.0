Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCDCC44503
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 08:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fsvCqyZcUVB22iSZ3crExKDcCG92305efa2wsETQa6E=; b=mFtyVqYWE4oqHine6Ufrw9HM5f
	EjyWNM9R5Lm4VhJhI5nmZgDOFGgCzdkUgXicTI7UCQ99f4HvQbmutF9NEJsp31nVh7UtlTver9fIw
	rct5AxvIN+Vnc95deBCT007Oo43HgJ+qQGjzoaIeZoQzAXiMKo3E1F9tThuM710weIYSMp1HW9Rbn
	MAKppBRJnCfv3aqkcY7PmjyKMNzPKQFd7fMINVI6pcPAABiaP2NjKG91xwCYlr1uqf6bI3HU0G8jM
	NVB73Z2gxn8L9YxJME1HMrZ5ZwljZzRJ0xFHgDH+by7X3KV5q1qqOfhpe9ctM/i+dkFG1iVhaqqXx
	aqW1DFdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whkWn-00000001eNP-1aNo;
	Thu, 09 Jul 2026 08:54:41 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whkSF-00000001Y9a-1N99
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 08:50:11 +0000
X-UUID: 1acd705c7b7311f1aa26b74ffac11d73-20260709
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:788f2ea1-9b07-4d85-9110-781dbc55c3c6,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:788f2ea1-9b07-4d85-9110-781dbc55c3c6,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:50bfe9d9d3f7d298236c0ce866c44650,BulkI
	D:260709162249S5RUH8GJ,BulkQuantity:1,Recheck:0,SF:10|66|78|81|82|102|127|
	136|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,
	Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1acd705c7b7311f1aa26b74ffac11d73-20260709
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1630952228; Thu, 09 Jul 2026 16:49:32 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Yao Sang <sangyao@kylinos.cn>
Subject: [RFC PATCH blktests v1] nvme: check user queue limits across namespace rescans
Date: Thu,  9 Jul 2026 16:48:26 +0800
Message-Id: <20260709084826.3208740-4-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260709084826.3208740-1-sangyao@kylinos.cn>
References: <20260709084826.3208740-1-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_014959_775812_14A4B836 
X-CRM114-Status: GOOD (  15.35  )
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

NVMe namespace rescans should not reset queue user caps on the namespace
head. Add a regression test that lowers max_sectors_kb, optionally lowers
discard_max_bytes, optionally disables write_zeroes_unmap_max_bytes, runs
nvme ns-rescan, and verifies that the user values are preserved.

Mark the test as zoned-capable so it can run on ZNS devices as well.

Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
 tests/nvme/068     | 151 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/068.out |   2 +
 2 files changed, 153 insertions(+)
 create mode 100755 tests/nvme/068
 create mode 100644 tests/nvme/068.out

diff --git a/tests/nvme/068 b/tests/nvme/068
new file mode 100755
index 0000000..a7786db
--- /dev/null
+++ b/tests/nvme/068
@@ -0,0 +1,151 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+#
+# Test queue user limits across NVMe namespace rescans.
+
+. tests/nvme/rc
+
+DESCRIPTION="check queue user limits across NVMe namespace rescans"
+QUICK=1
+CAN_BE_ZONED=1
+
+requires() {
+	_nvme_requires
+	_have_program nvme
+}
+
+_test_dev_nvme_ctrl_dev() {
+	local ctrl
+
+	ctrl="$(_nvme_get_ctrl_list | head -n 1)"
+	if [[ -z "$ctrl" ]]; then
+		return 1
+	fi
+
+	echo "/dev/$(basename "$ctrl")"
+}
+
+device_requires() {
+	local ctrl_dev
+
+	_require_test_dev_is_nvme
+	_require_test_dev_sysfs queue/max_sectors_kb queue/max_hw_sectors_kb
+
+	if ! ctrl_dev="$(_test_dev_nvme_ctrl_dev)"; then
+		SKIP_REASONS+=("unable to find NVMe controller for $TEST_DEV")
+		return 1
+	fi
+	if [[ ! -c "$ctrl_dev" ]]; then
+		SKIP_REASONS+=("$ctrl_dev is not a character device")
+		return 1
+	fi
+}
+
+_cleanup_queue_limits() {
+	if [[ -z "${nvme068_queue_path:-}" ]]; then
+		return
+	fi
+
+	echo "$nvme068_max_sectors_kb" > "$nvme068_queue_path/max_sectors_kb"
+	if [[ -n "${nvme068_discard_max_bytes:-}" ]]; then
+		echo "$nvme068_discard_max_bytes" > \
+			"$nvme068_queue_path/discard_max_bytes"
+	fi
+	if [[ -n "${nvme068_wzeroes_unmap_max_bytes:-}" ]]; then
+		echo "$nvme068_wzeroes_unmap_max_bytes" > \
+			"$nvme068_queue_path/write_zeroes_unmap_max_bytes"
+	fi
+}
+
+_check_queue_limit() {
+	local queue_path=$1
+	local attr=$2
+	local expected=$3
+	local actual
+
+	actual="$(cat "$queue_path/$attr")"
+	if [[ "$actual" -ne "$expected" ]]; then
+		echo "ERROR: $attr changed from $expected to $actual"
+	fi
+}
+
+test_device() {
+	local queue_path="$TEST_DEV_SYSFS/queue"
+	local ctrl_dev
+	local max_hw_sectors_kb
+	local max_sectors_kb
+	local discard_hw_bytes
+	local discard_granularity
+	local discard_max_bytes=""
+	local wzeroes_unmap_hw_bytes
+	local wzeroes_unmap_max_bytes=""
+
+	echo "Running ${TEST_NAME}"
+
+	ctrl_dev="$(_test_dev_nvme_ctrl_dev)"
+	nvme068_queue_path="$queue_path"
+	nvme068_max_sectors_kb="$(cat "$queue_path/max_sectors_kb")"
+	nvme068_discard_max_bytes=""
+	nvme068_wzeroes_unmap_max_bytes=""
+	_register_test_cleanup _cleanup_queue_limits
+
+	max_hw_sectors_kb="$(cat "$queue_path/max_hw_sectors_kb")"
+	max_sectors_kb=$((max_hw_sectors_kb / 2))
+	if ((max_sectors_kb == 0)); then
+		max_sectors_kb=1
+	fi
+
+	if [[ -e "$queue_path/discard_max_bytes" &&
+	      -e "$queue_path/discard_max_hw_bytes" &&
+	      -e "$queue_path/discard_granularity" ]]; then
+		nvme068_discard_max_bytes="$(cat "$queue_path/discard_max_bytes")"
+		if echo "$nvme068_discard_max_bytes" > \
+				"$queue_path/discard_max_bytes" 2>/dev/null; then
+			discard_hw_bytes="$(cat "$queue_path/discard_max_hw_bytes")"
+			discard_granularity="$(cat "$queue_path/discard_granularity")"
+			if ((discard_granularity > 0 &&
+			     discard_hw_bytes >= discard_granularity * 2)); then
+				discard_max_bytes=$(((discard_hw_bytes / 2) /
+					discard_granularity * discard_granularity))
+			fi
+		else
+			nvme068_discard_max_bytes=""
+		fi
+	fi
+
+	if [[ -e "$queue_path/write_zeroes_unmap_max_bytes" &&
+	      -e "$queue_path/write_zeroes_unmap_max_hw_bytes" ]]; then
+		nvme068_wzeroes_unmap_max_bytes="$(<"$queue_path/write_zeroes_unmap_max_bytes")"
+		wzeroes_unmap_hw_bytes="$(<"$queue_path/write_zeroes_unmap_max_hw_bytes")"
+		if ((wzeroes_unmap_hw_bytes > 0)); then
+			wzeroes_unmap_max_bytes=0
+		fi
+	fi
+
+	echo "$max_sectors_kb" > "$queue_path/max_sectors_kb"
+	if [[ -n "$discard_max_bytes" ]]; then
+		echo "$discard_max_bytes" > "$queue_path/discard_max_bytes"
+	fi
+	if [[ -n "$wzeroes_unmap_max_bytes" ]]; then
+		echo "$wzeroes_unmap_max_bytes" > \
+			"$queue_path/write_zeroes_unmap_max_bytes"
+	fi
+
+	if ! nvme ns-rescan "$ctrl_dev" >> "$FULL" 2>&1; then
+		echo "ERROR: ns-rescan failed"
+	fi
+
+	_check_queue_limit "$queue_path" max_sectors_kb "$max_sectors_kb"
+	if [[ -n "$discard_max_bytes" ]]; then
+		_check_queue_limit "$queue_path" discard_max_bytes \
+			"$discard_max_bytes"
+	fi
+	if [[ -n "$wzeroes_unmap_max_bytes" ]]; then
+		_check_queue_limit "$queue_path" write_zeroes_unmap_max_bytes \
+			"$wzeroes_unmap_max_bytes"
+	fi
+
+	_cleanup_queue_limits
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/068.out b/tests/nvme/068.out
new file mode 100644
index 0000000..28407c6
--- /dev/null
+++ b/tests/nvme/068.out
@@ -0,0 +1,2 @@
+Running nvme/068
+Test complete
-- 
2.25.1


