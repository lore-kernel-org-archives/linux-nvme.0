Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6364E98DF5
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Feb 2026 07:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=K3yYdkpsBmqluxlH3qg/ZMXJ3t7IJl5A4lcx6XWBCuc=; b=0OldUUtIRU9QG/N6voIbAY+2XJ
	flDNM+pHuj/QKVy6buF6MtvzFl1+mRDNBrQ1SngenNGGRxJqoU6EjI7X5+QFJBB44UY2MEe+/RGje
	7CIztOBQtvZfjxH2zC86kPcCCIIRNyRb7WgCXQ5MXQN2k4S2n74h8SbiOjAlLCFrrQbaYOfmitUr9
	OXZoFmse2Y9s5rfEBtgcLTCfkQVBX8GJUrF7xE5nNIuPpRpSi2bC74vSSABTXhd38wl6Lc5dmRPBh
	PwMlL7hd6EflYgmtgnDPtvaIAesVu77OdAdByPiVBP4qVaX7WnOMkLhhI8f5NGE6R/Vw1gOfJRn3E
	gu7O6DUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuQZB-0000000HOOB-0l5c;
	Mon, 23 Feb 2026 07:41:17 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuQZ8-0000000HON3-0zgn
	for linux-nvme@lists.infradead.org;
	Mon, 23 Feb 2026 07:41:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771832474; x=1803368474;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wHEyzeUjCtjHyHbnsYoszk/C1HYDn6Hf89D2hkGqffM=;
  b=F6FDNe4C62xOhl+qf0Ut2HIMwYx6pwpd5liKC2kLXz1PPL4GsQq8VM2/
   fXS9n+JLVbhM5uJkDKosmgXtr9GebDCzOukYXGVdWbRpi5UaCD4u5aEwu
   LfxRBSWmTvyjWwvvjRsmIJ7Plr2j2WwGBtGEzqFYi90JJekbJ2aXBAJkX
   92oQH+rEPlgSDBlcmDmMtRMBUvuCiLdvhXBSFnmsFWtYV0tfeGXoqy2vH
   vzKzHOd8RD6lwnaIoYgtDR2PccjxNyPRPjEilQGazNkwfVzDEBPo7tyJc
   3m0LPKjeYD40jZiyRxFzDGpjJ9vziFpM4tEAoAPXoElpJGsd6ClJl58uN
   g==;
X-CSE-ConnectionGUID: 2aoi0FA1RIe4neWkL/sPUg==
X-CSE-MsgGUID: 0FRiXaWFRBa+tMw+/x2j7w==
X-IronPort-AV: E=Sophos;i="6.21,306,1763395200"; 
   d="scan'208";a="141214628"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2026 15:41:12 +0800
IronPort-SDR: 699c0498_257rYvd5IlKKxeuOs4x7dx48VfT7C3pR0mPF7rRbDfZnDaK
 1PsKJhBbsQ0fdnpzkfYOGBVgOe5DFCwO8QwdqWw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Feb 2026 23:41:12 -0800
WDCIronportException: Internal
Received: from 5cg217417w.ad.shared (HELO shinmob.wdc.com) ([10.224.109.142])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Feb 2026 23:41:11 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/3] misc fixes
Date: Mon, 23 Feb 2026 16:41:07 +0900
Message-ID: <20260223074110.144758-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260222_234114_303378_EAFE7A70 
X-CRM114-Status: UNSURE (   8.35  )
X-CRM114-Notice: Please train this message.
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

These are miscellaneous fixes. They are not critical but worth fixing.

Shin'ichiro Kawasaki (3):
  common/nvme: do not call 'nvme id-ns' to non-nvme devices
  check: increment bash requirement version from 4.2 to 4.3
  src: add nvme-passthru-admin-uring to .gitignore

 README.md      |  2 +-
 check          |  6 +++---
 common/nvme    | 10 +++++++---
 src/.gitignore |  1 +
 4 files changed, 12 insertions(+), 7 deletions(-)

-- 
2.53.0


