Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E02ACDB466
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jun 2026 01:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZdA6Nd8QxzLAsEpKY/KeJ+uDI39xjhRtSPoh0SeX7iY=; b=NERvljENdYVOu6V/Py6/nkdh1i
	gKFUye3gVFBbkSJs/nnW2U6NM987HrLEwg/kgjhayJLpoJ69P5TaH0oty/aAVmCHR4xR6gL7WShqh
	fR9DOM55Vmkq8j2iiemCbEvheAVvMyP7ewyQ8735X5PnkLTHg6iPjzAYhgFd+aFL5IiZWrjj6A/u0
	gvidxINhpXCA4diqXBcr8/ys+pCrfCX1OC9niBhyuhvUgfJUWgvwKbDfGNrhE3J4/FRMAqKbG7Vpn
	xadr38Ev+M0bqX51qL/TD6n83fpaGXBRsCCMGiiJTeXqlcQsIqLTV65XcVVkoSzpmmCL5uhZuSyk1
	kH/KVJlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waO7L-00000001v32-0u3D;
	Fri, 19 Jun 2026 01:33:59 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waO7I-00000001v1f-0NwH
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jun 2026 01:33:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1781832837; x=1813368837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FaMx/M9PDL8MpM+PXkXQpldp47IIOrdDenyCLbVDXcE=;
  b=nAxnh64uV9xhKYAO5hcHL3IK2zF0FdHrgkDslS1PnWVV1g1tI91vp/Dn
   V9jCWbuErKMj2gESGPSz37ln6dRx3MSvZ4fr3TTg4d7YcnxNbwaLZwQdH
   b1MajC03Z6YIxVCmO3AGzTkfajfPhigNPHyRbD5xi/S16EO0C+DivlHaL
   5c1pEN8UUDxtB1beriKJFoSvGpAl2MWyv9MgSk8r5H3n81813zB3Umr6t
   NHABvyk+HeJk8NaDJatkywMrU0MEKBbadCnGMbO9mAHsX00dnWGlaWSPd
   tk8qCRaBb4pJTModb/UTIGfQW8bcibyut6QoAEw0IRf0FDnnyj2OqTNha
   w==;
X-CSE-ConnectionGUID: E2mfGD0iRxmJJZdZIPoqQQ==
X-CSE-MsgGUID: pH5+JnFWQLyFw/NVg9KWoQ==
X-IronPort-AV: E=Sophos;i="6.24,212,1774281600"; 
   d="scan'208";a="147932160"
Received: from unknown (HELO uls-op-esad2-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2026 09:33:54 +0800
X-CSE-ConnectionGUID: TZSgRBZ6TyC96yxblkY/sA==
X-CSE-MsgGUID: aU7HHbngQvSdOo+IR+yqNQ==
IronPort-SDR: 6a349c6c_3zVy5yu74tTuJxK++FfY0KRfGtNud0juQe7ylGdUwNAzvUx
 qu5xI0ppx0XSzEXDry0u0ndbWhtVTuUlR1wZJ2w==
Received: from uls-op-esai2-o.wdc.com ([10.248.3.38])
  by uls-op-esad2-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Jun 2026 18:33:32 -0700
X-CSE-ConnectionGUID: GFG/uxESTtOeVCfPcSpJxw==
X-CSE-MsgGUID: npjZvh5MQi6M6O95gSjY1g==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai2-o.wdc.com with ESMTP; 18 Jun 2026 18:33:32 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/2] nvme/060: suppress "nvme connect" failure for rdma transport
Date: Fri, 19 Jun 2026 10:33:29 +0900
Message-ID: <20260619013329.558580-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619013329.558580-1-shinichiro.kawasaki@wdc.com>
References: <20260619013329.558580-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260618_183356_190325_60DA0300 
X-CRM114-Status: GOOD (  14.55  )
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

The test case nvme/060 often fails for the rdma transport with the
message "FAIL: nvme connect return error code":

nvme/060 (tr=rdma) (test nvme fabrics target reset)          [failed]
    runtime  86.258s  ...  23.604s
    --- tests/nvme/060.out	2025-08-26 21:28:52.798847739 +0900
    +++ /home/shin/Blktests/blktests/results/nodev_tr_rdma/nvme/060.out.bad	2026-06-18 15:36:18.239424796 +0900
    @@ -1,2 +1,3 @@
     Running nvme/060
    +FAIL: nvme connect return error code
     Test complete

The test case repeats nvme connect and disconnect while controller
resets are repeated in parallel. In this situation, connect failures are
expected and should not alarm users. Suppress the failure message for
the rdma transport.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/060 | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/nvme/060 b/tests/nvme/060
index 9e694af..49786af 100755
--- a/tests/nvme/060
+++ b/tests/nvme/060
@@ -19,6 +19,12 @@ set_conditions() {
 	_set_nvme_trtype "$@"
 }
 
+filter_connect_msg() {
+	if [[ ${nvme_trtype} == rdma ]]; then
+		grep --invert-match "nvme connect return error code"
+	fi
+}
+
 filter_state_write_msg() {
 	grep --invert-match "state: No such file or directory"
 }
@@ -56,7 +62,8 @@ test() {
 	# The target reset is triggered with an even number timeout, while the
 	# host reconnects with an odd number timeout.
 	for ((i = 0; i <= 5; i++)); do
-		_nvme_connect_subsys --keep-alive-tmo 1 --reconnect-delay 1 --no-wait-ns
+		_nvme_connect_subsys --keep-alive-tmo 1 --reconnect-delay 1 \
+				     --no-wait-ns | filter_connect_msg
 		sleep 3
 		_nvme_disconnect_subsys >> "$FULL" 2>&1
 	done
-- 
2.54.0


