Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2874CC4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Nov 2022 12:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7HRUTm/HDd/79pZLj7ke4I0y92JSxt5kxA62qQmyk08=; b=B4HTNc5htdZf8F9KTYWEBaSwnn
	sax1IrUwHmXROb1aseyTMU/lmbQ603DF93+lXGQ6T6+ETgkANlpIGf4UQvpabkAYslkdasldbTUUB
	DxN7iph/rh6JMGzvg7co9Xz0aUHN29xCNo1I3khhpWFT/MW6QBBDkwWTScakRJmmjycoiGc0gzKix
	uV3qOlLXgzQUYUHxkr7u9ISM9m39TyamTpvI7G032e9zb8v8kpLLxALF34wKqvdlbMKQJqeWeFIkg
	GOs+/e58H5C9YpPbg7D6yKoHY3le0kBLUrigxAuJpIr6DSCl1sb5MMAe57EX+S4OLdcHIhN9xV8h2
	KYjz1/Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ow0Wb-003tVk-EP; Fri, 18 Nov 2022 12:31:17 +0000
Received: from [2001:4bb8:191:a0ee:6e05:c552:a35b:761c] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ow0WZ-003tUb-A5; Fri, 18 Nov 2022 12:31:15 +0000
Date: Fri, 18 Nov 2022 13:31:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvmes fixes for Linux 6.1
Message-ID: <Y3d7EA+VHiylXGu+@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The following changes since commit d7dbd43f4a828fa1d9a8614d5b0ac40aee6375fe:

  blk-cgroup: properly pin the parent in blkcg_css_online (2022-11-14 12:13:19 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.1-2022-11-18

for you to fetch changes up to 0a52566279b4ee65ecd2503d7b7342851f84755c:

  nvmet: fix a memory leak in nvmet_auth_set_key (2022-11-16 07:20:56 +0100)

----------------------------------------------------------------
nvme fixes for Linux 6.1

 - two more bogus nid quirks (Bean Huo, Tiago Dias Ferreira)
 - memory leak fix in nvmet (Sagi Grimberg)

----------------------------------------------------------------
Bean Huo (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for Micron Nitro

Sagi Grimberg (1):
      nvmet: fix a memory leak in nvmet_auth_set_key

Tiago Dias Ferreira (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for Netac NV7000

 drivers/nvme/host/pci.c    | 4 ++++
 drivers/nvme/target/auth.c | 2 ++
 2 files changed, 6 insertions(+)

