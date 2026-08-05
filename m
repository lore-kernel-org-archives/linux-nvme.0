Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B090C55174
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2026 05:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mVzP3t6LdG/m43xya1XscvQphQcxqXB62CElHaO8srQ=; b=ImppOLEeQ4EegD/eQNxt3limcs
	QH+Fz3UaUNHZ0ZyGWK+9co3GehO6x+wKG4IqraaTV1QVY+z0m6V/WhKN9jp7DVxQ8Vxct8lKVVtJy
	MZzshKFjLboZstTgj10OO4/QwtFLFcctpqA/lfMrtna+erT5bUanIeJYQ9a82witbQ0hvUyzbniXy
	7YPffrgLA/sPQVbbGdEGDVfV2nE10mQLumcuflINRbBl2undQqG/jBDzd4M8Fs2IOwwR7dxFZ24gs
	p01aKzKL58Ol20CI/ZmwfOB75bbrl80IpGAHyhh7ZIFeL37lKM5xsA03hl5noN2bHTBwZFMuIqpgc
	oqsWZ4hQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrTxN-00000003FWU-3ss2;
	Wed, 05 Aug 2026 05:14:21 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrTxL-00000003FW6-0Vzp
	for linux-nvme@lists.infradead.org;
	Wed, 05 Aug 2026 05:14:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1785906859; x=1817442859;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GDWRY1qJDCJvB8rcApUaUTP/QnbYfPXSobau6Sz6Y1g=;
  b=b/+jFuvDY2ItU3xGW5jNwo7ZT/Wf5k4f/bx4nOdDphTZcjuv63XDvdw2
   nwuKHkzrI5vG7UsDSM5AxVrBOoT6eKjkOuAs+TcVsoAHxXohSBtYRlF+1
   3SD4VYKwJzzhpssYjLF1jDfjZVtQmk6T3za87UUGxen69LJ4oFE/KQF5k
   idrl33ye31WKrBfBBC1fLU3LluOkdjw1xBv2JCnkYuaExGniQIlwAM4qt
   0K1wxBoK/PGF+QiNmFwYI5JrfK2dGXucmY2SP/8FIiiHYObQJxX17BgKQ
   W5Dxo+srKT0fjyd0aqthlm6XElpdPzLi/EkgfO5tja9EMzaCHg6OmmVj4
   Q==;
X-CSE-ConnectionGUID: QgklgNoIQ8KTjvOBL7Gx7g==
X-CSE-MsgGUID: 6JFjPjSySQq3cCAP4Cgbyg==
X-IronPort-AV: E=Sophos;i="6.25,205,1779120000"; 
   d="scan'208";a="152217459"
Received: from unknown (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Aug 2026 13:14:18 +0800
X-CSE-ConnectionGUID: YJ4KuDqhQ3ykTvSLgXkBKg==
X-CSE-MsgGUID: uglt0WIdT8O44dlLLDsxqA==
IronPort-SDR: 6a72c693_n/OUkTWTSBKtubdK8gvE6oKpu6P0g6eSi+YX7fuMQe0oz9e
 RF/Bwbv6aM3pyZm6YwjRv90fpwKB3Ewr6nOwsqw==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Aug 2026 22:13:55 -0700
X-CSE-ConnectionGUID: kLlmbRTdSlSLSrfJmdRemg==
X-CSE-MsgGUID: dIv3PcyQSnGAx7B5UmZrSQ==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai1-o.wdc.com with ESMTP; 04 Aug 2026 22:13:55 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: John Garry <john.g.garry@oracle.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] nvme/068: check module reference count with patience
Date: Wed,  5 Aug 2026 14:13:53 +0900
Message-ID: <20260805051353.2037772-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260804_221419_264351_31AF44A8 
X-CRM114-Status: GOOD (  17.23  )
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

The test case nvme/068 fails depending on the system it runs on with
the failure message below:

   nvme/068 (tr=rdma) (NVMe multipath delayed removal test)     [failed]
       runtime    ...  11.357s
       --- tests/nvme/068.out    2026-08-03 17:24:32.394566266 +0000
       +++ /home/runner/blktests/results/nodev_tr_rdma/nvme/068.out.bad  2026-08-03 18:15:17.461243816 +0000
       @@ -1,3 +1,4 @@
        Running nvme/068
        pwrite: Input/output error
       +module refcount not as original
        Test complete

The test case checks the reference count of the nvme_core module. If the
count is not the expected value, it fails with the error message.
However, when the test system is slow, it takes some time until the
reference count gets updated. When the check is too early, the count
mismatch happens. To avoid the unexpected failure, repeat the reference
count check.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
I ran the test case nvme/068 with the patch using the kernel that does
not include the commit below:

  3f150f0f010f ("nvme-multipath: put module reference when delayed removal work is canceled")

And I observed the test case failed. When the kernel includes the commit,
the test case passes. This indicates the patch does not break the
reference count sanity check capability of the test case.

 tests/nvme/068 | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/068 b/tests/nvme/068
index 4aee95b..7e39e17 100755
--- a/tests/nvme/068
+++ b/tests/nvme/068
@@ -27,6 +27,19 @@ _delayed_nvme_reconnect_ctrl() {
 	_nvme_connect_subsys
 }
 
+_check_nvme_core_ref_count() {
+	local refcnt i
+
+	for ((i = 0; i < 10; i++)); do
+		refcnt=$(_module_use_count nvme_core)
+		if [ "$refcnt" != "" ] && [ "$refcnt" -eq "$refcnt_orig" ]; then
+			return
+		fi
+		sleep 1
+	done
+	return 1
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
@@ -98,8 +111,7 @@ test() {
 	if ! _nvmf_wait_for_state "${def_subsysnqn}" "live" ; then
 		echo "subsystem did not return"
 	fi
-	refcnt=$(_module_use_count nvme_core)
-	if [ "$refcnt" != "" ] && [ "$refcnt" -ne "$refcnt_orig" ]; then
+	if ! _check_nvme_core_ref_count; then
 		echo "module refcount not as original"
 	fi
 
-- 
2.54.0


