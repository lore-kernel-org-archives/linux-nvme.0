Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4A4D74977
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 06:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xOwkH2yalxba9fAonMT4NeW8UqYVuS+yFiIqULQVuRI=; b=1c2lz7cjd8XWYTJnSJ6FSkHkU9
	nB9NrDInshInBtwRa8T9tzN1/wQp56gXGJQm5uWJCnhzNEH5X5Gyu4pbsHAeHM9Btc78C3hXiDSwi
	FFgIJ3GLFixLyVBjkeOHShmkaXoPws1mrSRkpIK27Hnwzv0exBKpcxnFngfe+SJDb7numeh3f/epv
	jTHETsY6syanmVuxecltNcG4Su5GYJMMEVUeifgRstGYdrc/P/xKquneUpLH+rQOQzFOZAi/u7FAQ
	YvYggeZaa9z87Gbq70zX2X9O7pgRbEutLP3NR0jrRtX7gmTgz4Gxa+y1rFOCw2yqhTnfUiB38okjh
	dJz9L1hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t62Yg-0000000H2Dr-297f;
	Wed, 30 Oct 2024 06:51:58 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t62Yc-0000000H2AZ-1pGk
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 06:51:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730271114; x=1761807114;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+6Re9lcAmeJKuEcEgey6g3R+4Q9Mh/555EQdXHe706U=;
  b=DIrsdxbH/C8HekCDsvmdGxPmXGWs9yCKSPl9sCYqVJMQEdJNBgnru8jH
   NX9gO0La/2yUBarNcc54BBT9LS6RIA8hbT1OJbqIWWU4ajJraGwvVo7jQ
   yhUKlo4BFH4QDGZRNblLabE9OX6d2fXaiN3fs7f0l780jxyw1TKsRyqu5
   /zPDrzLObxsi1rEDX3i3nesDTRaOT3Xoio4b1Q9Xshf3v8N8RSew6IOk/
   O5Nc6wC3Aq8Xyv+IbwLC1AHMA7KQjT0o+zE/Vb6col1i642gCgYY1Q0/8
   Pk0/+KDHPQmzhSe4xVKRdAXoN1KenfaHWyPqeUP3RpWA7B9lLbOPZkBiq
   Q==;
X-CSE-ConnectionGUID: NI3RZW3HRo6tiAIzTxyFbw==
X-CSE-MsgGUID: tm2DGRt7QQ6hRNEVxmE8HA==
X-IronPort-AV: E=Sophos;i="6.11,244,1725292800"; 
   d="scan'208";a="31314328"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2024 14:51:50 +0800
IronPort-SDR: 6721ca58_LikZ2IB42dLVOYoblkaLz04Ww8LSHSIYNC6//A5BXgqYpSe
 I+d20buvAM2mi4LSF1+FPKYJvsmKz44mNSiLxWg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Oct 2024 22:55:37 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Oct 2024 23:51:51 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 00/13] nvme: prepare for ANA support
Date: Wed, 30 Oct 2024 15:51:36 +0900
Message-ID: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_235154_499182_5021968D 
X-CRM114-Status: GOOD (  15.06  )
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

The 3rd patch caused the failure of the test case nvme/037 with fc transport.
I found the following change for the test case avoids the failure, which
adds short waits after nvme disconnect and target cleanup. I expect Daniel to
follow this issue (thanks!).

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


Changes from v1:
* 3rd: Improved commit message per review comment
* 10th: Introduced "local -n" nameref
* 11th: Use "--port none" instead of "--no_port"
* 11th: Improved condition branches in _get_nvmet_port_params()
* Dropped 12th patch, which removed bash "local -n" nameref feature usage
* Dropped 13th patch, which should be reviewed later

Hannes Reinecke (9):
  nvme/038: use nvme_trtype instead of hardcoding
  nvme, md/001: make trtype argument to _create_nvmet_port() optional
  nvme: sanitize transport parameter in _create_nvmet_port()
  nvme: return error from _find_nvme_ns()
  nvme: simplify _get_nvmet_ports()
  nvme: check for controller device in _nvme_connect_subsys()
  nvme: pass in port parameter to _nvme_connect_subsys()
  common/nvme, nvme/{016,017,052}: improve _create_nvmet_ns()
  nvme, md/001: support only long options for _create_nvmet_subsystem()

Shin'ichiro Kawasaki (4):
  nvme: introduce wwnn/wwpn helper functions
  nvme/{rc,002,016,017,030}: pass port ID to genctr helper functions
  nvme: fix fc port clean up failure
  common/nvme, nvme/003: specify "--port none" to _nvme_connect_subsys()

 common/nvme    | 271 +++++++++++++++++++++++++++++++++++--------------
 tests/md/001   |   6 +-
 tests/nvme/002 |   5 +-
 tests/nvme/003 |   3 +-
 tests/nvme/016 |  13 ++-
 tests/nvme/017 |  14 ++-
 tests/nvme/030 |  15 +--
 tests/nvme/031 |   2 +-
 tests/nvme/038 |   2 +-
 tests/nvme/052 |   8 +-
 tests/nvme/rc  |  41 +++++---
 11 files changed, 257 insertions(+), 123 deletions(-)

-- 
2.45.2


