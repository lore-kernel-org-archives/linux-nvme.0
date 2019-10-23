Return-Path: <SRS0=6M3L=YQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF64CA9EB6
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2019 16:36:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1280720650
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2019 16:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZNw1fFUt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1280720650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:Message-Id:Date:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+5EvfXAXRoRcMuQF8gnOsFTI/VDUPbk8ztjLxO9yK90=; b=ZNw1fFUt+x3Vz0
	nzvrDaZoCwLwEm4RqhcaCoB1lvaUdOq3IBh7RMN5gJzkf+3ZH40MPJA/V2snrOeiqABAFbHh4r1Kn
	7B/TyUujTtA6RmXyo7yoPS3jHa0uzMyyV88StF3kaosZsusOt9JeOikEd6YBVjThlWzdLdpd3MLfM
	kQpJE48f4LnCCP9e0URK0TTlhcAnHwBZ8jG/hmF7TrMPUoc2II8oay0wrXWJqK1d11SyJA0ZVLKzh
	mPnrO3KQWF4jCE84ROLgueqS455VCGjLsJmEtyMauQZ3N1ELGD7pFbpyVrNFkHIU/IjmBJuYQVd3Z
	6c8OQBQdxPQFRqp4FMZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iNJcF-0007jq-QX; Wed, 23 Oct 2019 16:36:07 +0000
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iNJc7-0007c6-WB
 for linux-nvme@lists.infradead.org; Wed, 23 Oct 2019 16:36:01 +0000
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <gunthorp@deltatee.com>)
 id 1iNJc4-0006Vr-8G; Wed, 23 Oct 2019 10:35:59 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1iNJc2-00016T-Fw; Wed, 23 Oct 2019 10:35:54 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Date: Wed, 23 Oct 2019 10:35:38 -0600
Message-Id: <20191023163545.4193-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, maxg@mellanox.com,
 sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 0/7] Remove data_len field from the nvmet_req struct
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191023_093600_354258_B1E444E7 
X-CRM114-Status: GOOD (  10.33  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>, Max Gurtovoy <maxg@mellanox.com>,
 Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

This patchset is a cleanup in preparation for the passthru patchset.
The aim is to remove the data_len field in the nvmet_req struct and
instead just check the length is appropriate inside the execute
handlers. This is more appropriate for passthru which may have
commands with unknown lengths (like Vendor Specific Commands).
It's also in improvement seeing it can often be confusing when
it's best to use the data_len field over the transfer_len field.
The first two patches in this series remove some questionable uses
of the data_len field in nvmt-tcp

Most of this patchset was extracted from a draft patch from
Christoph[1].

The series is based on v5.4-rc4 and a git branch is available here:

https://github.com/sbates130272/linux-p2pmem/branches nvmet_data_len

Logan

[1] https://lore.kernel.org/linux-block/20191010110425.GA28372@lst.de/

--

Logan Gunthorpe (7):
  nvmet-tcp: Don't check data_len in nvmet_tcp_map_data()
  nvmet-tcp: Don't set the request's data_len
  nvmet: Introduce common execute function for get_log_page and identify
  nvmet: Cleanup discovery execute handlers
  nvmet: Introduce nvmet_dsm_len() helper
  nvmet: Remove the data_len field from the nvmet_req struct
  nvmet: Open code nvmet_req_execute()

 drivers/nvme/target/admin-cmd.c   | 128 +++++++++++++++++-------------
 drivers/nvme/target/core.c        |  12 +--
 drivers/nvme/target/discovery.c   |  62 +++++++--------
 drivers/nvme/target/fabrics-cmd.c |  15 +++-
 drivers/nvme/target/fc.c          |   4 +-
 drivers/nvme/target/io-cmd-bdev.c |  19 +++--
 drivers/nvme/target/io-cmd-file.c |  20 +++--
 drivers/nvme/target/loop.c        |   2 +-
 drivers/nvme/target/nvmet.h       |  10 ++-
 drivers/nvme/target/rdma.c        |   4 +-
 drivers/nvme/target/tcp.c         |  14 ++--
 11 files changed, 167 insertions(+), 123 deletions(-)

--
2.20.1

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
