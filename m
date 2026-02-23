Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35AAC636B9
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Feb 2026 03:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ElZtBLCjUNvbNXycyTlMVx1k0HXwEH8PZlA9yTxMClw=; b=IPSBl75KsCZMVyDyFgZ32z4heO
	psosihGBayVIzYEd7dtM6yZ8HEcmaTRVH9VGW3Zis+V070bF0wxp+VsneI+cQrfAjXhNb3DVBFq+6
	j7Y/jCiFERVjsNv7wnEFrIQT80uOo1fsh1vhpSKFzSj//gArS7CMRVLJw6+5/uZq02YN7fJKcZOkg
	m6ZiE8+Z4HI7/HBDdHUXs0VKZzv0hC+thwBwretgAWcr9m4dqS06W3heVRvA284uM6vIkdqtZIRDD
	dgW+xr+pb1kasTtoGznRC9sIhAhUkv2eH4E1LPa3uHjvzQnGGM0sd1Y/Dii7q01BtJbnfZHXA0Zma
	RjdBOjJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuMxr-0000000HBdp-1qxS;
	Mon, 23 Feb 2026 03:50:31 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuMxo-0000000HBcM-36C9
	for linux-nvme@lists.infradead.org;
	Mon, 23 Feb 2026 03:50:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771818628; x=1803354628;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PDj67Fv7CBvZc78I7RRUIl5oyUv0NdaTnY0EWNfx6+Y=;
  b=Er5yMFa/7p41IjomKFDaaHFe7dlAy4Ybua8Njloy8jI8nsgFiKym2qtR
   Bykx4mS2b9NnaqUWgZifZhydfM4+q6hW5aD+csQHkCKQ9MTA4OamRs9uY
   VRn4SfVGBONw773BcbfVkdRQZMsbZKGsS02f1CKEGTLrdu5WSJnSwNqv5
   8XkVTOrPHS+Ro5Ap7NgCEsThdsMd6AelnbWcthNrjCMEXaZv2Rh9+El/l
   bAcUQxqPDSZyfmp+y1ZncQQvAYl4jDtoCmu3VWDz9A8kkEp8w5b0+UXQ4
   4pvZd1V6VwnLL3jmArT0ti55LXCMFoDiT8FIY62Y2fZAHzlg6um0VjDZ3
   g==;
X-CSE-ConnectionGUID: sOQ/AUBCT++1ftnrMELOIA==
X-CSE-MsgGUID: jczaMMWCRJ6LWMgNTNTtrQ==
X-IronPort-AV: E=Sophos;i="6.21,305,1763395200"; 
   d="scan'208";a="140288647"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2026 11:50:25 +0800
IronPort-SDR: 699bce81_BM2TWUlI2It6I5zWTiSJgg6JSyBa0Zl8So7R8VXUimAR9rN
 9BL9DQOy/1usIywZ3vDAVzplRgzZI4x3YH13u7g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Feb 2026 19:50:25 -0800
WDCIronportException: Internal
Received: from 5cg217417w.ad.shared (HELO shinmob.wdc.com) ([10.224.109.142])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Feb 2026 19:50:25 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/3] fix module unload failures
Date: Mon, 23 Feb 2026 12:50:20 +0900
Message-ID: <20260223035023.21902-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260222_195028_913779_B37FEDE7 
X-CRM114-Status: GOOD (  15.59  )
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

Since the recent commit 7c3ad92d3d8f ("check: check reference count for
modprobe --remove --wait success case"), the test case nvme/060 started
printing the error message below:

  modprobe with --wait option succeeded but still nvmet has references

This error indicates that the nvmet modules failed to unload as
expected. While the root cause has existed for a long time, the trigger
commit exposed the problem. I took a look in the failure, and observed
the failure scenario as follows:

- The failure occurs when the test case is executed multiple times for
  different transport types. At the first step, nvme/060 is executed for
  the loop transport. Although nvme/060 was not designed to run for this
  transport type, its requirement check leaves two modules loaded: nvmet
  and nvme-loop.

- At the second step, when nvme/060 is executed for the rdma transport,
  the helper function _setup_nvmet() loads the nvmet-rdma module for
  testing. After the test completes, the helper function
  _cleanup_nvmet() attempts to unload the nvmet-rdma and nvmet modules.
  While it succeeds to unload the nvmet-rdma module, it fails to unload
  the nvmet module because the nvme-loop module is still using the nvmet
  module. Hence the error message.

From these observations, I identified two problems below.

1) The requirement check for the loop transport left the nvmet and nvme-
   loop modules loaded and it affected the following test. In the
   current implementation, the helper function _unload_modules() is
   called once, only after nvme/060 has been executed for all specified
   transport types. Instead, _unload_modules() should be called after
   each run of test test case for every transport. This ensures that the
   modules loaded for the requirement check are unloaded.

2) When _setup_nvmet() does not load the nvmet module, there is no need
   for _cleanup_nvmet() to attempts to unload it. _cleanup_nvmet()
   should unload a module only if it was loaded by _setup_nvmet().

This series addresses these two problems. The first patch fixes the
first problem. The other two patches fix the second problem.


Shin'ichiro Kawasaki (3):
  check: call _unload_modules for each test run
  common/rc: introduce _load_module()
  common/nvme: unload nvme modules only when loaded

 check       | 15 ++++++++++++---
 common/nvme | 14 ++++----------
 common/rc   | 12 ++++++++++++
 3 files changed, 28 insertions(+), 13 deletions(-)

-- 
2.53.0


