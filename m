Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D72D43341
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 11:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hv9+pZ/ss6rywmuJoQR8kRzAOIMnUNkjwOob2x9Y7ZE=; b=OVAdu81Aa9XukjcGp90AZZQm0v
	DMiy7X2QAZcfGyiAJ5TNi0c8h3r8oz0PlE1UCBRUk+7TApoeDjddCDRhFjuWJnBdyEe4TuCX058p/
	3jJBM8D6SM2TDE85StViYcvyvFWR//ZxEDmqE0IUbCGXeAOw2RXet8WDMUM6I1jrdNPMu3QtV4sqk
	QmDXbahjhPx+STUkWHF/xRU1ZXg7BdPny0zSbxu/Puun244oypkLm5FQ/Qtse3gbZqBGRkzRSyh1J
	YEK0rxcNxIMvNG+aubuBIdVKTJWGU82AfVtkoR5b2uSL/ErWs2Qr3bPzVciIDGUHulqeTcSd6DpYN
	9UakZTpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t90Sh-00000006dvm-0mE0;
	Thu, 07 Nov 2024 11:14:03 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t90Sc-00000006drt-36Cj
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 11:14:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730978038; x=1762514038;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kANRw7TBXrChwTlASbrwW9v1U1EwvD6o9RmoOHm+Z0k=;
  b=dUtat9I9mSXzI7emZfFiK4HDyxc+bayOojZwTHpVxrH5rvatCV54Proa
   qOcoNrxMz6oiZ6jQS5dtqOu9lBDoeqfEfDTIMPZ/Y3jy7hA3BWJi5CyGS
   hp82sdKMhLPY4dzOruipw9n4M4xVNgM8vUqxb3U4OzrgQ4puxq5QjPZqb
   /jqUSO2DdJdNwH0m9uPlhuQ/TFprck5dH3vZlUV6Nw7cRtYgOmTzH8vax
   2tmEgx9HpxmwdPm7ay50oCuEJuhz2GOZBKmnlrAPV17dQ2xLyRMHqpCTc
   iyoU+WvMnRtP+iw/o1KWD3ou4C3Mq2zpxqeJ1dhprkqzoSZCx+eLu6aGb
   Q==;
X-CSE-ConnectionGUID: dQXDpJ4fSuGxs7ohBOInXw==
X-CSE-MsgGUID: FKP5BC6VToGTSAGOyTbjVA==
X-IronPort-AV: E=Sophos;i="6.11,265,1725292800"; 
   d="scan'208";a="30851676"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2024 19:13:55 +0800
IronPort-SDR: 672c93bb_gwP5x3XzaiqB933zWA9dVn/K62H1g65KASGcmwNhvmOdtos
 lIdEJ9SfgKX1+cLRqu9hKsWH8DXdlAjuGJ1ZsfA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Nov 2024 02:17:31 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Nov 2024 03:13:55 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/8] nvme: prepare for ANA support: cont.
Date: Thu,  7 Nov 2024 20:13:46 +0900
Message-ID: <20241107111354.80606-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_031358_859603_E94ABEC3 
X-CRM114-Status: UNSURE (   9.77  )
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

Hannes reworked the nvme test group scripts to support ANA, or Asymmetric
Namespace Access. This work is tracked with GitHub PR 146 [1]. The amount of
change is large, then I split them into a few series for easier review. This is
the second series, which follows the first series [2]. The all eight patches in
this series are script clean-ups. Review comments will be appreciated as always.

  [1] https://github.com/osandov/blktests/pull/146
  [2] https://lore.kernel.org/linux-nvme/20241030065149.2297405-1-shinichiro.kawasaki@wdc.com/

Hannes Reinecke (8):
  nvme/rc: Implement --blkdev none for _nvmet_target_setup()
  nvme: move _nvmet_target_setup() to common/nvme
  nvme/016: do not create namespace when setting up the target
  nvme/017: do not create namespace when setting up the target
  nvme/052: do not create namespace when setting up the target
  nvme/031: open-code helper functions
  nvme: rework fcloop
  nvme: drop arguments from _create_nvmet_port()

 common/nvme    | 144 +++++++++++++++++++++++++++++++------------------
 tests/nvme/016 |   6 +--
 tests/nvme/017 |   6 +--
 tests/nvme/031 |  14 +++--
 tests/nvme/052 |  10 ++--
 tests/nvme/rc  |  69 ------------------------
 6 files changed, 111 insertions(+), 138 deletions(-)

-- 
2.47.0


