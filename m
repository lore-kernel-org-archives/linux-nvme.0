Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F86C10F16
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Apr 2024 08:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EHSptxT/NSuYZEsj+2JXmzwh5C2Ivk7pbvWBiobsXwU=; b=LPLDe3XdskBNiz7KQwgUAsUD5Z
	W4zO/VRD795Wt1Go454KZgwUbSbyClHdtdjCUUk1BJmOicIrEbx6EvlP8h8eDBJEzLi4I4GbH/fqI
	qcf7F7RsXk0dEtQuBaPCPWFbN6KD6+2cYV/qHW4U8CxeXfEgOJtBuj9ND2Ppak/oDeDJaHJIGVKH/
	PLiglJz1D5ZQI+8LwcypBnjtvxKcjfXK8ydVEwU9FpEXQTBPq0ElzA939PJ0aOQjMJiP2WF71OH+/
	3Tkwl4xgfaqX4pPVUVq2MAsihxtrtxPl5pRiq93X+zxrlc+BPWEE3DNIIsGSZVAfjoARMg1e0EgK9
	BlZTL7yQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzXYP-00000003CFe-3vnS;
	Wed, 24 Apr 2024 08:00:33 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzXXx-00000003Bmj-2cug
	for linux-nvme@lists.infradead.org;
	Wed, 24 Apr 2024 08:00:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713945605; x=1745481605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tGY6fd0PKJRJ+c573V4B+/BeY3ESXX4f9SxgBT516LY=;
  b=GTu5GLX8e5fdf3e5HgNInB0+0TEg8fjkiSho5jzT+m4EjSKAGyWGpHC8
   /Zv+yH6NioiAY13f7/eqfoYGBEBPwpu4loaWGdH3hB20WFxSDtwrp8iGO
   mGHPfiQdqUH7J1UzUPi6BoRCcknXemCU1p+9CKFa0Z/Rh9MPN/cNaHeHW
   p0lEh+TjwoGthIsKcH5G3Js+ZvOWVhkQcARAYKxWAAxfaAnM0F0DbnDkv
   Mk7BgopOiGYyITJKzCwymgfzzNVpcU+6FdaNgm6NzFH4WcZ0Xl2ikgPQY
   N5uvCGMWoAWNcS5QG3UBsyQCZ6Kr8fdUaQ2tCc/uE4XFRv2a8EVBRUjD+
   Q==;
X-CSE-ConnectionGUID: iBlu2p9GTO2mImw0C/UCGg==
X-CSE-MsgGUID: DSnKFQ9USqqYy5fE+SMtaQ==
X-IronPort-AV: E=Sophos;i="6.07,225,1708358400"; 
   d="scan'208";a="14738269"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Apr 2024 16:00:05 +0800
IronPort-SDR: ur1IrLVOK9raOVgUDTOS8Ukc40BLOj5gd9qy3jsjNHkgrreshdrbe4S1kV5BYfrdT87vMG+k4b
 DpuLvvYvBPODvRgyDyf0KRBS56d3pLEG2Qxs6Ftau+GYWROMV0IHhzK1DmiUdXRzrqXgaxl89H
 OhHnNj7AxiJrpnuXBJeH8XoGSc0KBCKZfP/1Y3L4HYv2Lp0f/bnIcnZ7NA6qUoQfEzXd7Z6Z5V
 3d5e0H4V+A0sTIJ+V2Asl+EabM4lFcF4krEtDHG7kkHtd274DGrMrqUn6oOi1QXiZkfvQeZjmJ
 1S4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Apr 2024 00:08:15 -0700
IronPort-SDR: 1GChv3wADjXNeXIlpYLQmCSm5xc5biJkfcbVcALA+mSe4B1ZFgsvHGu7izbaS5LxuCouLHTWnW
 vpKyqoL0tF84N5ukoaaqJTJLUe718pZ5TKmNuh9x1eZa98/5WyYvbM1/MdmL4zpMiRdwaduf8F
 ASdfV11LsQ4q71SAYQng2RDLFmMe0dA3U1opq7XxpTW10KOUwIC+sO0lbzLlM6yGEQE8Ue8mUF
 vL1swgm2pP8g2ClQlkcEnP82GHqMxD/OJTM6+Gy+RhFAkFyl5GIfQ6ZEW6I0JtK0oDkU2z0/MG
 V9E=
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Apr 2024 01:00:04 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagern@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH blktests v3 08/15] nvme/rc: introduce NVMET_BLKDEV_TYPES
Date: Wed, 24 Apr 2024 16:59:48 +0900
Message-ID: <20240424075955.3604997-9-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_010005_873735_B6061956 
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

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Acked-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 Documentation/running-tests.md |  5 +++++
 tests/nvme/rc                  | 22 ++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 571ee04..64aff7c 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -108,6 +108,11 @@ The NVMe tests can be additionally parameterized via environment variables.
   tests are repeated to cover all of the transports specified.
   This parameter had an old name 'nvme_trtype'. The old name is still usable,
   but not recommended.
+- NVMET_BLKDEV_TYPES: 'device', 'file'
+  Set up NVME target backends with the specified block device type. Multiple
+  block device types can be listed with separating spaces. In this case, the
+  tests are repeated to cover all of the block device types specified. Default
+  value is "device file".
 - nvme_img_size: '1G' (default)
   Run the tests with given image size in bytes. 'm', 'M', 'g'
 	and 'G' postfix are supported.
diff --git a/tests/nvme/rc b/tests/nvme/rc
index ec54609..a31690d 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -22,6 +22,7 @@ _check_conflict_and_set_default NVMET_TRTYPES nvme_trtype "loop"
 nvme_img_size=${nvme_img_size:-"1G"}
 nvme_num_iter=${nvme_num_iter:-"1000"}
 nvmet_blkdev_type=${nvmet_blkdev_type:-"device"}
+NVMET_BLKDEV_TYPES=${NVMET_BLKDEV_TYPES:-"device file"}
 
 _NVMET_TRTYPES_is_valid() {
 	local type
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


