Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E593C07548
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Nov 2023 07:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QHgNTVzM8jBCwf7tKgh3yA2raHP+TB58FpYuagGAsoI=; b=hjc5rjt3tTCvhhnFEa7sEPlifY
	p5BbF06NwJ0hmJSmwDO13aIQ6gMTCWwS7X2lQtd4/m8ludx2cmF8bgC5lB6JLh0QJTzQQE0rSCGz1
	6x1asfHVI6n08aOcnJWRV2SjFMuxNK8MJMcLPRBVgP7Bp7npZOtq4xBQ89ZkMyWPhRuBTZyDzLCMe
	IzmwE/LGm8ox/gixmVnv2yJROltlZ8smCBRMzUiXPZ134i/Pds19uokSv2pB5O8aWsxar9RE8yf73
	ITKmlHPNEq3MC9Xy3VfszUWWPPEWe1Bx9hfpKmzT3WbvX6twm+wNrbyQi0krwfzVBpLNmoFR2Pvgv
	IxC0lYMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r39t7-0005Rm-1m;
	Wed, 15 Nov 2023 07:00:37 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r38pK-00HXqF-2L
	for linux-nvme@bombadil.infradead.org;
	Wed, 15 Nov 2023 05:52:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=QHgNTVzM8jBCwf7tKgh3yA2raHP+TB58FpYuagGAsoI=; b=eOqj2je6xWrj8obNobNyEVZbkO
	0oJqSIry/kIjVFVLUL3VDRv6//AR6RaEPVcQQ1vCCYzxu3RGmkizCKt12jvUlOWCV6f7G+CmS8yzR
	vRMluK1Q6zQWsCjtC2S+YrA7EKuOGwDb95pjrh7HKzfhElhg1emjfPpwKwYQqAbDEUKYh4eFZS9jY
	f4rAAp1GjM0ATDxc8fXRKRhdadtWHyiJqxf/wRRldjH2bsNpVga5hIWuLV68i8AXgWp+MmyRm6P0j
	+2LYezAD/e8ySxJU+w9lyIL//TLlwyUOlkLtxnFDitfnn23MPX/kw8FCGmw89z1gF5RSJErMf+4a5
	FR5xR2cg==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r38pG-003kpj-0F
	for linux-nvme@lists.infradead.org;
	Wed, 15 Nov 2023 05:52:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700027554; x=1731563554;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XuGMDp+MYlIW2ppNs8zzsWYAuUNTvQjHo1ZIFlWJOKI=;
  b=f6tsHCOxoBlrjupY7mU34CI0/Ir1EZkM1Y5U2hofTm/NnWx6GV3H/Q4O
   9uOFCW///rs/MaRIzfUYahdY5CguKRxVaiDNCemvM066hnS+kRxBwSL0U
   +w1VFgRFGiHGqrQbg7zRghqZKia/jTc8pCDYeBlHWa3Z8YC3btHqLgYEH
   LvJvp4PoIEifWZEFXy/HH8SGAu0BhdTqM1s7q0S4aMY5YQdufcKEwAY9W
   Xg9Z3+N5weNSOA0t9ZfRfgKbv3slD+fT8PXwwMyym2dd1/ek0LVcf3v+q
   X4Oh8f0DPeFfYquKLnXzwgiVvZIKtBjDVzDvF4mNFni1LiMpYQ0/W6cD+
   w==;
X-CSE-ConnectionGUID: PJZUKFGhTpyMLr1LlAIMlQ==
X-CSE-MsgGUID: 3d/M9bCiTdiNUAyRBztqWQ==
X-IronPort-AV: E=Sophos;i="6.03,304,1694707200"; 
   d="scan'208";a="2313704"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2023 13:52:21 +0800
IronPort-SDR: tjxZudIXjSFpp9zt3OZbNnyjxpNZU++AZp5S7pxu7mX2AXaz5m4fvyD3dKZ9g8gwPuqkeCUYHu
 gKqfhTkEkikx+46+FHSiRtwj5ozw8WZYUTVuS/A3MbvmfQD4u/rVIm7M8A9NWJkCI7kgGWziAi
 tibOfAp0CtHjTnqDHBxA1w+FO1DZkAOOQCcVMos1PwFiMzuva16zHq7cVnqp2MUQLZr0489Axy
 ZFTScQxKsCxG8vskLeAx7Oh1yKa0FdTjfZXVV2OPZcrPoRIDs96MD+QjkcLkFObWAhDejbPaZH
 SBY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Nov 2023 20:58:08 -0800
IronPort-SDR: vZERQIrBW0NT+fgf7ylgTTwXX76YXbJwski8BkY/3fsWjYdeHMR2J4tXRPGe28nDJtfH9iEUXa
 Q9FG/RaMS9MJvl807IZMDNMU8k2HYMAyj56KQp3s7kF2HxEK2Iqihj/RITRDmeTdoj5ehK40pe
 Z+hvkmXkI7YZdnUVh13gZZ29JoRbv4aJgxeG/X8ZbhC4/pvZ1HgT3PV+6o9rP1hP71XGO2/8Ot
 ASzv1PgNODENT4nFNycbOqtGUCy8UmTWgInwPtlA0lGoUE+/OV2XAqMuIHc6phuJ/qbvYYhHXQ
 oZY=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Nov 2023 21:52:21 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/2] nvme: require kernel config NVME_HOST_AUTH
Date: Wed, 15 Nov 2023 14:52:18 +0900
Message-ID: <20231115055220.2656965-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231115_055234_675895_434203D3 
X-CRM114-Status: GOOD (  10.86  )
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

Yi Zhang reported test cases for nvme authentication feature fail with
linux-block/for-next kernel [1]. I observed the failures with kernel v6.7-rc1.
Chris Leech pointed out that the test cases require kernel config option
NVME_HOST_AUTH. This series modifies the test cases to ensure the requirement.
The first patch introduces a new helper function. The second patch adds checks
for the requirement using the function.

[1] https://lore.kernel.org/linux-block/CAHj4cs8yZ4-BXqTK4W0UsPpmc2ctCD=_mYiwuAuvcmgS3+KJ8g@mail.gmail.com/

Shin'ichiro Kawasaki (2):
  common/rc: introduce _kver_gt_or_eq
  nvme/{041,042,043,044,045}: require kernel config NVME_HOST_AUTH

 common/rc      | 17 ++++++++++++-----
 tests/nvme/041 |  1 +
 tests/nvme/042 |  1 +
 tests/nvme/043 |  1 +
 tests/nvme/044 |  1 +
 tests/nvme/045 |  1 +
 6 files changed, 17 insertions(+), 5 deletions(-)

-- 
2.41.0


