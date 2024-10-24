Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5704DD0BB4D
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 01:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gb9qqYMgzbZITSs9j7JvnMtnNlqiV3Uxy9rGnrlZ9rM=; b=lozS2iFbBHVeiLPORWioriasC1
	UC2Y2+IuBdfVV7xb7i2lNnrtTF4Z6oiozoD57WOzd5zU5n1O7OFkinLdvvmkIh8Aq0X/LBruq0OSk
	/2xfDZBBmL5j9e6yke68Rc6ywyI3/RlCmiHvL6b/RoRJfpErjvKYCiHplq2dBrGNmwQSstX4FOPXT
	MUcJG24H/Y2R8OMCSRemjYLlnLRskiuwjJr0KPNOvgq+Jggkg4S+x7lwAK1NhOhilesy4eyJZ4ZB4
	zIDIcbx67B9TG4m3Efty8k6gWudxm8O1/6sdDaYiWxSfeF5YOpfyjuJSHy4RwxRGVKFvREqUU/sob
	fzJ1bRGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDM-0000000GMaF-1J03;
	Thu, 24 Oct 2024 01:00:36 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDH-0000000GMWc-2FCs
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 01:00:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729731631; x=1761267631;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RVlg0xPgN02r+XN4YknB41on5mnWEBvmHYDer0kcM1s=;
  b=QsauIUgFcyp+6cbR1qjF4xAHN76SSBQmXE0r2FVr4leJ4JL9fr+hwpyc
   ZnxxPD2UXA5l3ddcQn5hkm6JTnH2/6IPOH5iHXW6PZQXdCsTUYBvTSElJ
   YgLZ0Eo3lwvjNfELWdlbZRRiOFmsSjZyN3euksfTy2MTqU7OMUNBY4Cni
   sjhUuM3H1Ym5BWKJs77tPkwlYtnNBtIFx95U5sTHT+gunroqLnlqzYaWj
   EheTpe88fS7tGLEkMtY6tcSKEumk4e2u+WoX6AEDLkgbhlGvh4VtNR8Wj
   NDt7Qc8JY0FLxm54cyiNgA6iExVzXq+2ZgoOpx5fCAIrbBxsf65VXJRth
   A==;
X-CSE-ConnectionGUID: t0m2KDAESVWMri99wvwW6w==
X-CSE-MsgGUID: i/GSJ6PmRfusSsAMlAmHOQ==
X-IronPort-AV: E=Sophos;i="6.11,227,1725292800"; 
   d="scan'208";a="30211069"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2024 09:00:26 +0800
IronPort-SDR: 67198f12_TVOij3wBQZG8tFIbO/MQGrl5Fw0Mnpu6TE9+hDsN+VvZTS7
 isFl02W4IfpNuRjlZr65JMb4gynAnB/VKlpqjMg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2024 17:04:34 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Oct 2024 18:00:26 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 00/15] nvme: prepare for ANA support
Date: Thu, 24 Oct 2024 10:00:10 +0900
Message-ID: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_180031_663935_159B91F7 
X-CRM114-Status: GOOD (  16.37  )
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

Hannes reworked the nvme test group scripts to support ANA, or Asymmetric
Namespace Access. This work is tracked with GitHub PR 146 [1]. The amount of
change is large, then I split them into a few series for easier review. This is
the first series, which prepares for the ANA support. Review comments will be
appreciated. It consists of a number of improvements, such as port handling
improvements, helper function simplification, code readability improvements, and
so on.

  [1] https://github.com/osandov/blktests/pull/146

Most of the patches were authored by Hannes. On top of that, I added 5 patches:

 - 4th 5th 6th: fix issues the 3rd patch caused
 - 11th: fix an issue the 10th patch caused
 - 12th: fix an existing issue found during this work

The 3rd patch caused the failure of the test case nvme/037 with fc transport.
I'm not sure if it unveils a kernel bug, or if it should be fixed in blktests.
I found the following change for the test case avoids the failure, which
adds short waits after nvme disconnect and target cleanup. Comments on this
change by nvme-fc experts will be appreciated.

diff --git a/tests/nvme/037 b/tests/nvme/037
index 33a6857..e00f632 100755
--- a/tests/nvme/037
+++ b/tests/nvme/037
@@ -36,7 +36,13 @@ test_device() {

                _nvme_disconnect_subsys \
                        --subsysnqn "${subsys}${i}" >>"${FULL}" 2>&1
+               if [[ ${nvme_trtype} == fc ]]; then
+                       sleep .1
+               fi
                _nvmet_passthru_target_cleanup --subsysnqn "${subsys}${i}"
+               if [[ ${nvme_trtype} == fc ]]; then
+                       sleep .1
+               fi

                if [[ -z "$nsdev" ]]; then
                        echo "FAIL: Failed to find passthru target namespace"

Hannes Reinecke (10):
  nvme/038: use nvme_trtype instead of hardcoding
  nvme, md/001: make trtype argument to _create_nvmet_port() optional
  nvme: sanitize transport parameter in _create_nvmet_port()
  nvme: return error from _find_nvme_ns()
  nvme: simplify _get_nvmet_ports()
  nvme: check for controller device in _nvme_connect_subsys()
  nvme: pass in port parameter to _nvme_connect_subsys()
  nvme: delete all namespaces in _remove_nvmet_subsystem()
  common/nvme, nvme/{016,017,052}: improve _create_nvmet_ns()
  nvme, md/001: support only long options for _create_nvmet_subsystem()

Shin'ichiro Kawasaki (5):
  nvme: introduce wwnn/wwpn helper functions
  nvme/{rc,002,016,017,030}: pass port ID to genctr helper functions
  nvme: fix fc port clean up failure
  common/nvme, nvme/003: add --no_port option to _nvme_connect_subsys
  nvme: remove "local -n" from _get_nvmet_ports()

 common/nvme    | 281 +++++++++++++++++++++++++++++++++++--------------
 tests/md/001   |   6 +-
 tests/nvme/002 |   5 +-
 tests/nvme/003 |   3 +-
 tests/nvme/016 |  17 ++-
 tests/nvme/017 |  18 ++--
 tests/nvme/030 |  15 +--
 tests/nvme/031 |   2 +-
 tests/nvme/038 |   2 +-
 tests/nvme/052 |   8 +-
 tests/nvme/rc  |  43 +++++---
 11 files changed, 265 insertions(+), 135 deletions(-)

-- 
2.45.2


