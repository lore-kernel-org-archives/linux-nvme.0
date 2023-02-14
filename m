Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D81C61DA4
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Feb 2023 04:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zuEzgGJoDZg8698gBZtbifYbWC5ZsLSm/Faw8ByxUzI=; b=wx2Tuc8BXYPjbaHR3rBBHpc+oT
	eDDA+vSMLmSS+VyUDKpfKaTQl2N6S5+8LnwVTeUMN17MCLq/oZvaQbwYfhY7M1fvwNE6liT1airFD
	BKCtaL0wP1uRoGmKuvvo78DyAJPyq9pWW5SsWNEJ9EWHn0Dg8Tz6JvD3J8jNYXvW+ggfekIqS+n4k
	VGAmPo1W74CBIt4/YqnGwcIZlTmDncQvy1kvQy1J8hnx4CHy8D4tz/xMT3EeBQ362VwVTiFs+5eDW
	qXO4Tjcp2SIgBWa4ngIIc2rCFX1E1/nSv0WFCdt6RYBC72RRahyoM9F7CRqdu8OuOlEDqj56c1YAM
	A1O+h4eQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRnEJ-00HRrG-TH; Tue, 14 Feb 2023 04:47:48 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRnEG-00HRpY-2h
	for linux-nvme@lists.infradead.org; Tue, 14 Feb 2023 04:47:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676350064; x=1707886064;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Sc142Jy+ziYe78cjwUYErAIuc/8pTQXPHMQPiJZynuE=;
  b=IZ7I71HLOzquGzWW780RDal1ZRTqbFxjlf2Bpqa7IpHelQODVPtnaCCP
   nKNeg50tHMLNMTPeoIQHTGYqzI3un3yzCwclx2uR3oUf8e8nB6lK0GO1a
   FkIj+fsp/qUHK78wka6dqGV3nYOmMYyTNH6v0xganjBgy429UnULOrVLZ
   LKLFDV6V/ZtxxP7qE0/w60/XjX+84Xsss4O8gOglGWlxqeM5Bx8eZsbZI
   p3WgNQFutKTRZBQyYztvXoeaeBJKmtY7plBPyT2VGdOGc7ynUM6l7IDo6
   zEE7Dqxr4jOW7D1h52fOd0//YchjwBWyX0xrw9cBtVdgDx2uh9qrIrmyg
   A==;
X-IronPort-AV: E=Sophos;i="5.97,294,1669046400"; 
   d="scan'208";a="223261585"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2023 12:47:40 +0800
IronPort-SDR: F7MQDHMeOKFipv2uf0V9dUFTBadhPaUbaeWrQUtrVPNUkBMHdpc07xFdXmgZsAit0VdLtUKS8T
 xC9vACWHJFNs8RIbbHwbCRtNbnZy33rVGLGUpeKoMMlc8zU13z7VSiefAz/m1JaaajmsUGG7YS
 5V3yvObCwXVKvDQ4GfUCEmXkbOK6Yndat4jZvqhluQUOSTa5qJ5MGr5Zj5Qn+GonOEzXElxqz7
 xW2Zb917ANfL7AWUwVDliwxjfBYyvb593PipRU1JgX4CiW1Z399ehtnLRpy7eYVf5AExAPhw4I
 LPM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Feb 2023 20:04:49 -0800
IronPort-SDR: L+0XHXPaT5SyGkILI6YYB40V670zJfw9Ev0VFlMEzskZ8Gy1ftLf800VwWeRfC3srqKfEtkSKl
 dbn1AuRMRZUwa2X7P+PswPHlQokW4jYZb5UUMOclxGWVwuTsnb8xgY4h+xi+oeASk/dqrLdNKG
 BO+MXb8Qkn1aa6WzpNurwvL6OaVNSYmIXpsU/2CAt0WSy2fO+KIqzpNWof0vaga+rZXWHzPeQg
 OJ/87fdvrtDlEyvxA9lHGwu4huPPN97svlG2M2O9jEmwKsIKiJvP3AOWhKmYBfUjqr+M+taUmg
 kTw=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.207])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Feb 2023 20:47:40 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 0/2] nvme: add test for unprivileged passthrough
Date: Tue, 14 Feb 2023 13:47:37 +0900
Message-Id: <20230214044739.1903364-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_204744_244115_33789728 
X-CRM114-Status: GOOD (  13.29  )
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

Per suggestion by Kanchan, add a new test case to test unprivileged passthrough
of NVME character devices. The first patch adds a feature to run commands with
normal user privilege. The second patch adds the test case using the feature.

Changes from v2:
* Added the first patch to add normal user privilege support to blktests
* Adjusted the test case to the functions for normal user privilege support

Kanchan Joshi (1):
  nvme/046: add test for unprivileged passthrough

Shin'ichiro Kawasaki (1):
  check, common/rc: support normal user privilege

 Documentation/running-tests.md | 10 +++++++
 check                          |  1 +
 common/rc                      | 13 +++++++++
 tests/nvme/046                 | 50 ++++++++++++++++++++++++++++++++++
 tests/nvme/046.out             |  2 ++
 5 files changed, 76 insertions(+)
 create mode 100644 tests/nvme/046
 create mode 100644 tests/nvme/046.out

-- 
2.38.1


