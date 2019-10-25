Return-Path: <SRS0=pUqL=YS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73DEC47E49
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2019 20:26:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 921B421D82
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2019 20:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="asmsFf4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921B421D82
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:Message-Id:Date:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=GGvPNFs/V3cP5cRWARTGYw40PmWv/WlQPfdCqFaeLyU=; b=asmsFf4c48+nXD
	gWiI8I3d4zyWA2g6xcr1x9Voa/QLiD3VmAWM7aHyIVwQv75Qm9WwA2iEC4dFbWKWOoc/FxTAqq9NN
	euDwoC2/7zoH9AwLS1hiV37dyyN9Hv42ayqvKM1QJGwolzxxduWmMvk+rSmvbs5dj3FYadQ2EP92l
	gVv8CYiVKDoawChdYoUwD6Q7VKC/tgFNeM+Momv68lrjf+WTKP4txlPSDKdIeMg2ecBQtZ/s3UZsH
	pRGxOIZBMFeVkK6/LEq16aulDacNW4PNci0gweULJvkVZb3s1ese+XS2OkYRMzlinkHpE/l4hlsl1
	UD3hMg18ct/Np7QaBPJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iO69W-0007Z1-Lo; Fri, 25 Oct 2019 20:25:42 +0000
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iO69T-0007XS-4l
 for linux-nvme@lists.infradead.org; Fri, 25 Oct 2019 20:25:40 +0000
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <gunthorp@deltatee.com>)
 id 1iO69R-00078b-Ir; Fri, 25 Oct 2019 14:25:38 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1iO69Q-00038u-Ip; Fri, 25 Oct 2019 14:25:36 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Date: Fri, 25 Oct 2019 14:25:32 -0600
Message-Id: <20191025202535.12036-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, Chaitanya.Kulkarni@wdc.com,
 maxg@mellanox.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [RFC PATCH 0/3] Passthru Execute Request Interface
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191025_132539_223753_82A8D6B7 
X-CRM114-Status: GOOD (  11.02  )
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
 Stephen Bates <sbates@raithlin.com>, Keith Busch <kbusch@kernel.org>,
 Max Gurtovoy <maxg@mellanox.com>, Logan Gunthorpe <logang@deltatee.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

This is just an RFC meant to get some early feedback on the core
interface for executing passthru commands that will be needed
in the upcomming nvmet passth patchset.

The first patch moves the calls to nvme_passthru_[start|end]() into
a common helper such that all passthru requests will call them.

The second patch does a bit of code reorganization for the third patch.

The third patch proposes a new nvme_execute_passthru_rq_nowait() interface
for the nvmet passthru code. For commands that have no effects it is
simply equivalent to blk_execute_rq_nowait(). For commands that
has effects, it pushes the command submission to a work queue. This
requires adding a work struct to nvme_request.

The code that will use this interfcae can be seen in the WIP passthru
patch[1]. It helps clean things up considerably from the last submission
of the patch.

Thanks,

Logan

[1] https://github.com/sbates130272/linux-p2pmem/commit/a468e458795e6df6483ad8c98635536d6da31064

--

Logan Gunthorpe (3):
  nvme: Move nvme_passthru_[start|end]() calls to common code
  nvme: Create helper function to obtain command effects
  nvme: Introduce nvme_execute_passthru_rq_nowait()

 drivers/nvme/host/core.c | 228 ++++++++++++++++++++++++---------------
 drivers/nvme/host/nvme.h |   7 ++
 2 files changed, 147 insertions(+), 88 deletions(-)

--
2.20.1

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
