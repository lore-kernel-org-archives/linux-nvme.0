Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D18C83F25
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jul 2025 17:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lP3G/wJM1Wp+pfYiqb1DhyhcLv09fZo8xbwvzVKzBtg=; b=bxyR3U1jqkyC3FU/i6RIKJyT3U
	rfylruxKrWUnyvmzrCUdp7LUZi8FiV5t4uhxhbMdLR7C1PFJaJoEljYJgYUO8IDvPqpYyQ/zZWGzy
	lM+4x/gdgW/+aBneW+WE+3VxS+NLP2qTYvwRsSjk8PgMQNK9t9zbSU0BTc10Rf4LkGfi5XDjUITqm
	yLaUkmAUjGKgjCjQuDCuuMmFXsskB2iXbxq2Y0IU2KLkQsqHKbI9lKoj1g1Z8o3RvFYd29goAFdz1
	HWSm40Ys5lTQth154eIG3tCu8t5hKwzvVzyFuB8/qc4GjUHSRayvpzBo53yozQU8SST3fHTzuQz/k
	v9Vk31pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uduiL-00000000MzG-1S6n;
	Mon, 21 Jul 2025 17:54:13 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uduRj-00000000Kjg-3CKv
	for linux-nvme@lists.infradead.org;
	Mon, 21 Jul 2025 17:37:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1753119423; x=1784655423;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1MlHeSe7t1aUihxUN09tzbsm8J3JjC8wXjw9GYBK/YE=;
  b=kAiG3T2DNvussNxrRPy/yepXYNvsedNrgX2csNUm9jNqE90ir4GrnEcZ
   rFW9lXCjQcrM/TNPKoLg+CY4VrlSdNXOfK3xl6cZODk4Dp4ZN1t3F6/ga
   GqTtKa+QKc8KIdwJyRl05Nw379CaXjm3QyMG5u9Z5QKhDM3uJTXlwpwEX
   6gR2Rgr1IMovDRgIVMy+PSGUMaENE8Aq0t+lcH3Br2Yu7uFsn1UZ0426k
   VBIa5mdrzHse4rgWLGtddVI657AGekM3BzPNNFz+OgK0v1ZUbmgYyv+ap
   Dh7VzXKoOFFWmGgG/6WTvTnoZD5wCmStQoi5Z+Rxkj4muqA07heVzG3V0
   g==;
X-CSE-ConnectionGUID: GoMxJYneRTGV4tfqxj8/Uw==
X-CSE-MsgGUID: /DeHb7ByQVe19I+8b2ic5g==
X-IronPort-AV: E=Sophos;i="6.16,329,1744041600"; 
   d="scan'208";a="93974983"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2025 01:37:01 +0800
IronPort-SDR: 687e6c12_eOYVVV9W/hFQDUjm3h1nnCOKRG1LQOcg7XuicD1hvWKRpZB
 5mFt2vVrCNS+iRddyj4OZTitHxrJlFCFAItwKaA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jul 2025 09:34:27 -0700
WDCIronportException: Internal
Received: from ros-3.wdc.com ([10.23.145.79])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Jul 2025 10:37:01 -0700
From: Kamaljit Singh <kamaljit.singh1@wdc.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: cassel@kernel.org,
	dlemoal@kernel.org,
	kamaljit.singh1@wdc.com
Subject: [PATCH v4 0/2] Support for Administrative Controllers
Date: Mon, 21 Jul 2025 10:36:58 -0700
Message-ID: <20250721173700.4153098-1-kamaljit.singh1@wdc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_103703_833510_99AD7F78 
X-CRM114-Status: GOOD (  10.52  )
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

Patch-set summary:
------------------
[1] add capability to connect to an administrative controller
    - New function identifies an administrative controller via the 
      controller's CNTRLTYPE
    - Prevent I/O queue creation for administrative controllers by
      overriding the controller's queue_count and setting it 
      to 1, so only an admin connection is allowed to be created. 

[2] prevent admin controller from smart log fetch (LID 2)
    - Conditional around nvme_hwmon_init() now disallowes administrative 
      controllers during controller initialization.

Changelog:
----------
Changes from v3:
  - Remove inline helper nvme_override_prohibited_io_queues() and 
    move code directly into nvme_init_ctrl_finish()
  - Add more detailed comments and changelog to patch-set

Changes from v2:
  - Avoid calling nvme_override_prohibited_io_queues() from 
    RDMA and TCP (nvme_rdma_setup_ctrl()/nvme_tcp_setup_ctrl()) fabrics 
    drivers by moving it into the generic code under nvme_init_ctrl_finish()
  - Remove export of nvme_override_prohibited_io_queues()
  - Change announcing of administrative controller from dev_info to dev_dbg
  - Coding style change. Remove parenthesis in nvme_admin_ctrl() as 
    suggested by Damien

Changes from v1:
  - Remove check that disallowed zero I/O queues for an I/O controller
  - Create helper nvme_override_prohibited_io_queues() for identical code 
    in nvme_rdma_setup_ctrl() and nvme_tcp_setup_ctrl() 
  - Separate into multiple patches
  - Revert naming of nvmf_discovery_ctrl() back to nvme_discovery_ctrl() 
  - Move nvme_admin_ctrl() from nvme.h to core.c


Kamaljit Singh (2):
  nvme: add capability to connect to an administrative controller
  nvme: prevent admin controller from smart log fetch (LID 2)

 drivers/nvme/host/core.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

-- 
2.43.0


