Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9F8C4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 10:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y+vx/Dmo3zwilHel+9Tos0oavMTaD2FGBblN+ELqLzg=; b=chCEScLFOqHjGJTNd9s4dOYzJO
	Bkcal8mYgqIT64W6gTE49juMRiAVMDXbaxWtl0QLiTi6RK8v/+tMgcJPR5LFb+LJLLgrAsV2lL+dT
	y1XYK49BNmbn5bBNzbsD4dQPTVsWRtGnYZovskYlhLWlEoO8eWQFSPVQX2x4Rq+ytGSVMyanFci1g
	wn/kZpZqzVmS8FGwH116LSxfjdFde/ZLnshs3csdbwIExzn3td7BQcMPiohlG7SXIN/xZCsRSqi+M
	DSA06TSekv4xpV8+BAjKPQLq6vIyaTks3CwVkvXyXGNe+cfJaU3FYNzK0t+8mZ6DVQtSiOi256f5Q
	Ug2sitpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwg7F-0000000Bnvv-0NJ7;
	Tue, 16 Apr 2024 10:32:41 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwg6p-0000000BnZ6-30P0
	for linux-nvme@lists.infradead.org;
	Tue, 16 Apr 2024 10:32:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713263535; x=1744799535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iSWpKJYKZ6ojughWXi5bAnIYQCqtRZAVPjo0ZXW3z2c=;
  b=qjKyczNN+sdIZwgpGqp2e/1KiE95z6yXMiLmhRuSJb/W8eDDVN7A1goP
   v1XING4ILbXrXSauSwaE2a6FRiSNQ93KLOYRE+VYFq1xJBX3Io3vUc+uI
   WGnWM07GvFsR9sil5HX08qzHcoC4gHaEIEncihhy/hsojDWlGkvu5Ffks
   6jO28YUzAjtvydpaolJIEu9ETKbvUuXue+c6YWAzerB9hxAmDiKWj967w
   LEpV11SU6Jw4xYb5fMML5tZWRt0GVqqp/nbZ20bJ638Y2gQ6jmsOukZC7
   BTU79AQKmnFqsKHKXKcttd10XIw+VWfA/3frVm6cTJNio0zyAO6xQ6Npo
   Q==;
X-CSE-ConnectionGUID: XPpYbhhFQ9CJ+OtzempGHw==
X-CSE-MsgGUID: /2qJCz8CRkex5tyas0CShw==
X-IronPort-AV: E=Sophos;i="6.07,205,1708358400"; 
   d="scan'208";a="14796907"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2024 18:32:15 +0800
IronPort-SDR: rRj0cOVyZwalT0F9JbCT7yr03wqiCB2YOG/SjQM9NGRUSxoTx2gwx77Xqosq+TkbkPkJ9QD8SX
 U5A7XpTNobqQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Apr 2024 02:34:54 -0700
IronPort-SDR: gdDVjzw5yeREpsJsPl6S4V0Vd7JglNw+93JGKMAg6SjK8W7fbPpuTnhIFLlZSCpYEDThY/x1tY
 Jw5Lff2+HtTmmK75DlYezQGRLhpoDmdVBRK5KOevrLuO8EIH2BMhUUy4CvdpBC2jlbP+LomfAc
 4GjKFbA58P9XjyxFAbQRnAogXsxA3vzv9jhP2lQG7rdJwxi+/LEVFH21ydb1l/lxJH8L7a6/6p
 3ogW5YKOGiELbtw7ICuzMG8Q/7VS0KZPhtdYAfmK3OD7+bMZh8SF5F5GFvv2Jnv+f4ltf9ZT2v
 cZE=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 Apr 2024 03:32:14 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH blktests v2 07/11] nvme/rc: introduce NVMET_BLKDEV_TYPES
Date: Tue, 16 Apr 2024 19:32:03 +0900
Message-ID: <20240416103207.2754778-8-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
References: <20240416103207.2754778-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240416_033215_990025_B1D22186 
X-CRM114-Status: GOOD (  15.56  )
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

Some of the test cases in nvme test group do the exact same test for two
blkdev types: device type and file type. Except for this difference, the
test cases are pure duplication. It is desired to avoid the duplication.
When the duplication is avoided, it is required to control which
condition to run the test.
    
To avoid the duplication and also to allow the blkdev type control,
introduce a new configuration parameter NVMET_BLKDEV_TYPES. This
parameter specifies which blkdev type to setup for the tests. It can
take one of the blkdev types. Or it can take both types, which is the
default. When both types are specified, the test cases are repeated
twice to cover the types.
    
Also add the helper function _set_nvme_trtype_and_nvmet_blkdev_type().
It sets up nvmet_blkdev_type variable for each test case run from
NVMET_BLKDEV_TYPES. It also sets nvme_trtype from NVMET_TRTYPES.

When NVMET_BLKDEV_TYPES and NVMET_TRTYPES are set as follows, the test
case with _set_nvme_trtype_and_nvmet_blkdev_type in set_condition() hook
is called 2 x 3 = 6 times.

  NVMET_BLKDEV_TYPES="device file"
  NVMET_TRTYPES="loop rdma tcp"

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 Documentation/running-tests.md |  5 +++++
 tests/nvme/rc                  | 22 ++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 144acd1..6d2f8ae 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -109,6 +109,11 @@ The NVMe tests can be additionally parameterized via environment variables.
 - nvme_trtype: 'loop' (default), 'tcp', 'rdma' and 'fc'
   Run the tests with the given transport. This parameter is still usable but
   replaced with NVMET_TRTYPES. Use NVMET_TRTYPES instead.
+- NVMET_BLKDEV_TYPES: 'device', 'file'
+  Set up NVME target backends with the specified block device type. Multiple
+  block device types can be listed with separating spaces. In this case, the
+  tests are repeated to cover all of the block device types specified. Default
+  value is "device file".
 - nvme_img_size: '1G' (default)
   Run the tests with given image size in bytes. 'm', 'M', 'g'
 	and 'G' postfix are supported.
diff --git a/tests/nvme/rc b/tests/nvme/rc
index d44a1c1..f678128 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -21,6 +21,7 @@ export def_subsys_uuid="91fdba0d-f87b-4c25-b80f-db7be1418b9e"
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
 nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
+NVMET_BLKDEV_TYPES=${NVMET_BLKDEV_TYPES:-"device file"}
 
 # Check consistency of NVMET_TRTYPES and nvme_trtype configurations.
 # If neither is configured, set the default value.
@@ -54,6 +55,27 @@ _set_nvme_trtype() {
 	COND_DESC="nvmet tr=${nvme_trtype}"
 }
 
+_set_nvme_trtype_and_nvmet_blkdev_type() {
+	local index=$1
+	local bd_index tr_index
+	local -a blkdev_types
+	local -a trtypes
+
+	read -r -a blkdev_types <<< "$NVMET_BLKDEV_TYPES"
+	read -r -a trtypes <<< "$NVMET_TRTYPES"
+
+	if [[ -z $index ]]; then
+		echo $(( ${#trtypes[@]} * ${#blkdev_types[@]} ))
+		return
+	fi
+
+	bd_index=$((index / ${#trtypes[@]}))
+	tr_index=$((index % ${#trtypes[@]}))
+	nvmet_blkdev_type=${blkdev_types[bd_index]}
+	nvme_trtype=${trtypes[tr_index]}
+	COND_DESC="nvmet bd=${nvmet_blkdev_type} tr=${nvme_trtype}"
+}
+
 # TMPDIR can not be referred out of test() or test_device() context. Instead of
 # global variable def_flie_path, use this getter function.
 _nvme_def_file_path() {
-- 
2.44.0


