Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C2F606A31C
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=PbqokmjW;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.a=rsa-sha256 header.s=dkim.wdc.com header.b=WJMUO0T9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=tLCFMiSIks5DPLg6euHvMe58ubzuaKQx3twJFEtnd1A=; b=PbqokmjWwDCpiFcWe47III/ciq
	uV/AMd6t68D/GjlOiVLhP9puzaxwGbcPHjUMCla+TQdGQUz1n6fO7FiYl9G5SBpEAc1JtFyLutlMS
	WzWNHyd0vYmlNX2XoN/ZrpJFGJ6IKTjaK9+SK/xNDIfALgEAzFrR8e0apcBTbR7HeQnFd+hm3Bj8e
	0QidPpa2LGlct4sW6EkzK+go1A1JBuSK7voPUZfRaeNCG1YVr2BD+8tfZ88UUjqlVngnqfDUKPU8s
	8celPtOZ+5MZqJ+dxZoV9DtJ/6Otxh+9489Z6Yk2FTd/VPAb1qIaq0ierA4xtbNDui4gzgYNi8MXV
	2GOmPEcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ1b2-0000000G6eC-0vQv;
	Sun, 08 Nov 2026 12:02:04 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ1aw-0000000G6dT-0eKK
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 12:01:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1794139317; x=1825675317;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H87s+Riz/TDE+YQSsKMT66/4xfi1kh+zCrO4tlQ/Ezs=;
  b=WJMUO0T9TFgmbDFxb2XcU203pnTZW8NdadaA7qivmshxOO3g3yc6LbNK
   k6wrAv6Zpl9TtxH9EsPwpjuYTnAzYy/hH/rb3fJHS8BGOAccQApYAMZOV
   71Vz5hUc7w9uephNMS7rRpWKeqfb1HGoIzWRk0BC5uWHLnlkYqYXCEjFD
   a4P/JLb8gHYEg7YyH2lGGrnGizvcBO+/KX+PC4GP1iGt73wtBZL8OKhpo
   g46sYf4wbcNmK7QYyJNyfGA0ZdnjvL2i6gh2bnU511NH4Y0q8eIu59kZ2
   2m3qs7o3dJna05S7gGcnCmOQP0ZjRPcDG1Ncs276/eKPcGz38xT+1/Omw
   w==;
X-CSE-ConnectionGUID: H1bI8CzNTYuDSHVNQgVA5w==
X-CSE-MsgGUID: /r4dO/weS3mkqEEVrHjzgQ==
X-IronPort-AV: E=Sophos;i="6.27,202,1786982400"; 
   d="scan'208";a="158625197"
Received: from h199-255-45-14.hgst.com (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Nov 2026 20:01:56 +0800
X-CSE-ConnectionGUID: dFcGDGRAT/eDjNSizGqpmw==
X-CSE-MsgGUID: rG8/PlcVTKOQnFZeHPcB6A==
IronPort-SDR: 6af064b4_LfK89wNyQJ+dwZYnNZKE+N2UqitJmHVpKgGY0CWU8BWQAuD
 38lgP+C2+qeRHKW+GgLPscFbTluoLOqkkTPZS1Q==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Nov 2026 04:01:56 -0800
X-CSE-ConnectionGUID: 4lnsgi1ZTbKOldmeke/xIA==
X-CSE-MsgGUID: mxvThsusTDmIMIQS1GXa1g==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai1-o.wdc.com with ESMTP; 08 Nov 2026 04:01:55 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-rdma@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Surabhi Gogte <sgogte@purestorage.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH RFC 0/2] RDMA/cma, nvmet-rdma: fix a lockdep WARN
Date: Sun,  8 Nov 2026 21:01:52 +0900
Message-ID: <20261108120154.148824-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_040158_245216_0957EFEC 
X-CRM114-Status: GOOD (  15.82  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since the commit 2a8513091d2f ("nvme-rdma: parallelize I/O queue
allocation and startup"), the blktests test cases nvme/004 and nvme/031
often fails with rdma transport due to a lockdep WARN, which is a false-
positive. Please refer to the first patch for the details of the WARN.

This series addresses the failure by reclassifying the handler_mutex of
the port listening cm_id. The first patch introduces
rdma_reclassify_id_for_listen() to RDMA/cma, which sets a dedicated
lockdep class to the handler_mutex of the specified cm_id. The second
patch calls it from nvmet-rdma for the port listening cm_id.

I made this series as RFC, because I was not so sure whether adding a
new function is the best approach. Another idea was to add a new
argument to rdma_create_id() to tell the cm_id created is for listen
of not, but it will touch a number of drivers. Yet another idea was to
add another work in nvmet-rdma to defer the connection establishment
[1], but adding a new work for the false-positive WARN is not desirable.
Then I think this patch series is the best solution at this moment.

Any comments will be welcomed. Thanks.

[1] https://lore.kernel.org/linux-nvme/at36um4zrsfOr3kh@shinmob/


Shin'ichiro Kawasaki (2):
  RDMA/cma: Add rdma_reclassify_id_for_listen()
  nvmet-rdma: use a separate lockdep class for the listening cm_id

 drivers/infiniband/core/cma.c | 13 +++++++++++++
 drivers/nvme/target/rdma.c    |  2 ++
 include/rdma/rdma_cm.h        |  6 ++++++
 3 files changed, 21 insertions(+)

-- 
2.56.0


