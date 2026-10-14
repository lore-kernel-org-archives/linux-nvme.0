Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32F9C3DA7A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 17:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H5/SDgy5hTu2CD41XjtuGv88dGiFiZhvmfIjx1BZnns=; b=oBjhFT4/jtbBMc1F1DHsAjzC95
	E050cfOSPSdQeP6kaA9pFl3GBQztcKuEAVMecKZ4uQ4KqLXUF1o8JLCOEt0DnnkMXUO5hkKGIGXCe
	Cf2J3/wLNkVDxQ/PpnY1T/c5WCZ4YukvzE0yZY7ISvxAbpuaC1SHbq+4aG0GOYmAbnvpKcJDI3857
	sQRbPL1nWZhSE3C+VvoJ8RYEifTOsUwHymjR7OAzUh8FsYKjj5+lbtE7mfcSUap5imySOf9kAsfti
	H4/nOra0j7jeSmeqH7NcKkeC4mpH0xcBVX42rT/Fe1BjInorHKVSh5BIruesNpaLGKPgukuIuHmRx
	CPpMdKBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH2Lo-0000000G3Eu-1ht0;
	Wed, 14 Oct 2026 17:01:12 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH2Lj-0000000G3BQ-2Yd9
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 17:01:08 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4a1880e1bf1so11216385e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 14 Oct 2026 10:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791997266; x=1792602066; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H5/SDgy5hTu2CD41XjtuGv88dGiFiZhvmfIjx1BZnns=;
        b=e5doaIlvKxpEHNns2UgEByLxPWQt6bPW8Gb4/mZfOqxIg5OVqBPFPVBC2MGR5vYxcs
         cLTJvnogWXOFGREmRSWHw4gFKqCeyOqm8WehwoYRNRfXgT13exi7YkFp4f21c7b2u2B9
         YZ6Z2JZYnSYb1aPwU6j/gJGy8vf+k6Gzqvnd06vMD5553FvkhNVQLuHM5LyAgFK4wzg+
         cpsFBaDwKPy3FE9b/CuqzBk2Pim9u5oE+t8rqfb73SY1PFc3nk3toH7EP8LpLo/OEFJi
         QMow8epl1Q294VBuNUrAXtt7APc3ho7hR/zuPsp9Pg+CrDYlTCui0+RdhulmCS7u80RR
         koGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791997266; x=1792602066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=H5/SDgy5hTu2CD41XjtuGv88dGiFiZhvmfIjx1BZnns=;
        b=W6sXik1x6SWB2iSaOclcjJC7x6wQS+NBbB60IV31OO1bBQBkgy0F5l+V6YEeLbO3cg
         GGDpIagiNT4+sIjveLoJFRDmpHl2gqBQvpDA1EAAKSpFzyABsdrmcBcVVw1lq/R1NAYK
         /rFoKJw1GPo018ZL9QqnOe9N9G+Rc4R5CL6Jf0JAstM06rH4h5EdQpdST6sAfSo5YwTm
         O00wAoVn5nXWa0PskA30LXq40if5V9iC6F906ofv+BlVoTr+ozCcntOYaJnX5rvA7dPw
         ekDgIg+FoLuASaVPxer02TyqBNf6HB2kaA0z+TnHVOoZFb+1cYWf3kDHZCgoJlALJAKt
         ogUg==
X-Forwarded-Encrypted: i=1; AKwUvBy7D7l3TufYzmkwxL8QxrvfwwREk4Z09q3OC9oR+DaMjGJ+OcZqf4dPitwh2LYGryh85CCvXI6dIN2P@lists.infradead.org
X-Gm-Message-State: AFq9FYJBafk4gvvhAKyrrS3RvFWQ2SaywimKU6OknKcuh8sG/rKhwWi0
	RtfzddE5nTe4nenayZIZCBqWaerY8+l9damDhm1oiMzE/uFMz7syt1jDEMLaMH/M
X-Gm-Gg: AYBFou2cPGAabI61EPfVGwuNCYopmO/40MJJiYfBrSArMwEv5PghrcqIdR7ttDZyyqw
	zxzouDTE2E2Ca1KW/F3jDW4bijtcxESgtrafGXF2w+rg3csrlgIS7rYL5XZ7RP5ETp8hlhds7o8
	gL02l4irNCsfasc+shAHaVtq9cy9TX9MfoctTHc0+rF8wbqzNhlSLDHHfcw11VQGORfPclvy6SY
	KGlCRIBlXrrwuz2m89Ee08Zd1bRl+7cHfHdUxd9Jtd4hUePAQ8dwp1JvVd57uTj8OAMr/NCijzJ
	izN0yzDy9iw9OtwVqOdbLDPzIWlutGsuz6afNUzw3xkClOfgAddEnKgHksY5HUIaZuZie7Vqlxw
	4Pe/sqRdLCUMzkw7m+oOFZ28csEVUb3vR0zImcaFugbmH9xJq4aJZ5jKkiJPSRkryD+/0c6IdEU
	X4XEqiP4+3YxH5Z35HnsOO/pQUwL7cPlpsCy3XU4RcAgHrXH3w0pckiiGXZY4MvnhGdYaBL3HE7
	j0a6fkO1AeRhKUnWrbnNuCb6xNEW9lqWPtlyAFd8bQH9A==
X-Received: by 2002:a05:600c:620e:b0:4a1:7c56:d4e2 with SMTP id 5b1f17b1804b1-4a18e4b2aebmr348258765e9.16.1791997265682;
        Wed, 14 Oct 2026 10:01:05 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.109.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9a8a22sm5349415e9.5.2026.10.14.10.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:01:05 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-block@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org
Subject: [PATCH blktests 4/4] nvme/073: test that nvmet rejects a zone report NUMD that wraps
Date: Wed, 14 Oct 2026 19:00:41 +0200
Message-ID: <20261014170046.2516-5-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014170046.2516-1-parri.andrea@gmail.com>
References: <20261014170046.2516-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_100107_666148_BF8F8105 
X-CRM114-Status: GOOD (  15.23  )
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

Verify that Zone Management Receive rejects a NUMD whose byte count
wraps a 32-bit calculation, while accepting an ordinary request. The
test runs on every configured transport.

The test fails on the unpatched kernel and passes with the fix applied.

Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 tests/nvme/073     | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/073.out |  2 ++
 2 files changed, 48 insertions(+)
 create mode 100755 tests/nvme/073
 create mode 100644 tests/nvme/073.out

diff --git a/tests/nvme/073 b/tests/nvme/073
new file mode 100755
index 0000000000000..c6d3d29f4b906
--- /dev/null
+++ b/tests/nvme/073
@@ -0,0 +1,46 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2026 Andrea Parri
+#
+# Check that the NVMe target rejects a zone report NUMD whose byte count
+# overflows a 32-bit value.
+#
+# Regression test for patch "nvmet: zns: reject a NUMD whose byte count wraps".
+
+. tests/nvme/rc
+. common/null_blk
+
+DESCRIPTION="reject an NVMe target zone report NUMD that wraps"
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_require_kernel_nvme_target
+	_have_module null_blk
+	_have_kernel_options BLK_DEV_ZONED
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local dev
+
+	_setup_nvmet
+	_register_test_cleanup _cleanup_nvmet_zoned_target
+	if ! _nvmet_zoned_target_setup; then
+		return 1
+	fi
+	dev="/dev/$(_find_nvme_ns "$def_subsys_uuid")"
+
+	_check_zone_report "$dev" 64 15 0
+	_check_zone_report "$dev" 64 0x4000000f 2
+
+	_nvmet_zoned_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/073.out b/tests/nvme/073.out
new file mode 100644
index 0000000000000..ed6690e578688
--- /dev/null
+++ b/tests/nvme/073.out
@@ -0,0 +1,2 @@
+Running nvme/073
+Test complete
-- 
2.53.0


