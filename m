Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA03D6EC07
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 13:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/9feaozb1zOiya1cknn15Uj/d89wK6AMV6gFqKbEZhE=; b=VCWy5IawZeLKmErGA2wa/b/AsG
	I+Xua18U7RPYo7B23jF9GO8a4FPKa8y8oV2wgQKFeilaaqKJ/8gTyQ2tzSBXeC4r7UtVJIzq1mWDd
	lfRsvEhs2BYupxcSqKo6ELLp4BnAhLTfxncnOAmCzFbQM/2Wd/4wFYRNO2dpzLaeBoVz2FEl1L17z
	qUHN7M2TQo/v8h8138QQynmcHet9XcuGAG5QSnqZBqAiKQPnXwT89eULNpj8LY6iSGeZDdYdfXTgR
	wkpM0Td8p7kfTSiueQeu1yV240l6rdJmT4rGZxPIYfk0P5Zlt46F6Xx+cCLPpOwzFMvRrUp6sQb61
	Jgk1Yjrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tH10q-00000000BK4-3z6i;
	Fri, 29 Nov 2024 13:26:24 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tH10o-00000000BIH-0Rxp
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 13:26:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732886782; x=1764422782;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9PcsignMLdTKmptFIqP6sC0I14iN1+9cHnLjKSOtUdc=;
  b=Oj9XLI2p655mv9NxryqCK8BFj+4EdlfoGQaadiRYd/m60t5OnSZJq5k9
   LwXfFifytawpFfUbfm2Av3U1GS+CI5JM7vwKxDiOk/cvFYNcbKUyaszOy
   g7CLu3QxY0R8OlFw4NTQP3+dtj9z3HhaLmwXStqV/UrKv+jSNnjxWtqDR
   edX0YqM6Mu3a4s6qei70oWeMZCz4ofulI1iRBRzh8X9q+t02uN1qLZKj0
   qa5XGZEqWGFJH6RN123PxQ8tqvAi5/qH6Z3xgyfoY6r/5UZE9/i6MMa5+
   T8L6ALjDS9Uu67L3medbNWNP6x61EHureGBUArJdDfR3A+SAdxpwvTv4o
   g==;
X-CSE-ConnectionGUID: r2Ugd+lUTFmFT0dT5heD0A==
X-CSE-MsgGUID: k8R+2i2DTim78USJoDJCaQ==
X-IronPort-AV: E=Sophos;i="6.12,195,1728921600"; 
   d="scan'208";a="32015168"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2024 21:26:18 +0800
IronPort-SDR: 6749b25c_RRCQbyN+1wYhLz5nhVSUyst0a6tIhAC/JA+UQDPfC4iaZKi
 2A9f/DygDJBkOqisKxnipdTpvCsVnlY62JTzLsw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Nov 2024 04:23:56 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 29 Nov 2024 05:26:18 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 0/7] nvme: add test cases for ANA support
Date: Fri, 29 Nov 2024 22:26:10 +0900
Message-ID: <20241129132617.400429-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_052622_214462_1DBC4D27 
X-CRM114-Status: GOOD (  12.91  )
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
the last series, which follows the second series [2] and a follow-up fix [3].

The first 6 patches in this series prepare for the new test case addition. The
7th patch add the test case for basic ANA support. The last patch add the other
test case for rapid namespace remapping.

  [1] https://github.com/osandov/blktests/pull/146
  [2] https://lore.kernel.org/linux-nvme/20241107111354.80606-1-shinichiro.kawasaki@wdc.com/
  [3] https://lore.kernel.org/linux-nvme/20241120102051.247995-1-shinichiro.kawasaki@wdc.com/

Hannes Reinecke (7):
  nvme/031: open-code helper functions
  nvme: add _setup_nvmet_port_ana()
  nvme: add _setup_nvmet_ns_ana()
  nvme/rc: add argument '--ports' to _nvmet_target_setup()
  nvme: delete all ana_groups when removing a port
  test/nvme: add test for basic ANA support
  test/nvme: add test for rapid namespace remapping

 common/nvme        |  55 ++++++++++++++++++++++--
 tests/nvme/031     |  14 +++---
 tests/nvme/055     |  97 +++++++++++++++++++++++++++++++++++++++++
 tests/nvme/055.out |   5 +++
 tests/nvme/056     | 105 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/056.out |  14 ++++++
 tests/nvme/rc      |  31 +++++++++++++
 7 files changed, 312 insertions(+), 9 deletions(-)
 create mode 100755 tests/nvme/055
 create mode 100644 tests/nvme/055.out
 create mode 100755 tests/nvme/056
 create mode 100644 tests/nvme/056.out

-- 
2.47.0


