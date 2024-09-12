Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E04EE6452
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 06:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SE9LIOwkjlEL7sHCbOPzYyJF6hq/kiPdh3gkrbLFHXw=; b=icKU/lP9Onn7NHKUXGJuTkYR+V
	O877Ld38u52jFM0g1BcPwEuPGZ97DlL0fjVg1RSNh70aDNDuDFXa4dzsUB+QDaAzHSz+1kZ77/alo
	GX/BGgegxGHYkAubxQw2iQ23qZ85WWAid9Z6EI2ue9HVaYidwAgCKeDd5TePQKyPyULSlyT67hyBZ
	0TjGMf8zCanEzQpppZ1AEC2mA6BFqD7vXmnYxLSYkiROLQY9TF6emmflTJBZ7vw3G9BSyI+XZ4c2/
	LmbSgRzfkq5h9S00id3u5gXdWNgsltXrwOm/+mgwFepQt8XpEUhW34zs+tUIXYH8XW3bdgwu6ekF/
	4+Gx7Bxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sodYc-0000000C3M3-2qLI;
	Thu, 12 Sep 2024 06:43:58 +0000
Received: from mta-04.yadro.com ([89.207.88.248])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sodYW-0000000C3Im-186w
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 06:43:54 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 7E5BBC0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1726123424; bh=SE9LIOwkjlEL7sHCbOPzYyJF6hq/kiPdh3gkrbLFHXw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=TcLRc7vWQWyJVfXeBOkXbhEzkXfnqXvHpLiCXH10re6GR6pv/RVZKT2YjoS+XkNv8
	 8ExlZKANPagwXc8sOvOZHl8w9po+QPYReyh9+1K/2fwOxPrQdisocdYj2aajTmeIsw
	 0tnP2/6ENeuXmUXUvs1SR5LYt+rsYMKqRnnwZGAXNryqJqqv6x7z4AJ9sbdX3JR+gv
	 1+XATxk6LX+UZODeSTX/BO7JHXEmsy5cL22m1TDbBnmF4qmuuMti8tIhNK6/u2PNqE
	 gv3l7NFf4EiIoERgrJdpSGkh1/iiZQ9rOgkmbq+9S2GMZ0hLycv+SVmdoZh7EvR7L/
	 a+csHTf6D3YkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1726123424; bh=SE9LIOwkjlEL7sHCbOPzYyJF6hq/kiPdh3gkrbLFHXw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=LoTvN0c89H8pH1QO2JArLr80mTtec/jzMyk52LrUfRGXYL7hkP1bfxKZ7j3DX5dHS
	 /jjgKjfKifSHBBNqUWLuKF25aSQqy+CDZJVYPg7mIvt96wDMGw6rt0RopQP/+CCdnc
	 Fchpj8NfKM9LAjV5js+zJhVQRfO170KKeZZ3dYBPyZ/NQij27RTnfSpSgZKvu5IL9t
	 TC+ZFt+LGw/EWmai3Y8N7/dSSc4dZKRC6+pGH7FMWlFIYWDCrqsqmBgPICpQ1oc21J
	 n1lTxFJermswbuCdnSl7YLM2wJ6OtoGASWHdPWZE6oSKyDAvPkRkIndZrSm9B4y5H1
	 dx4F5fBphoYXg==
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, James Smart <james.smart@broadcom.com>
CC: <linux-nvme@lists.infradead.org>, <linux@yadro.com>, Dmitry Bogdanov
	<d.bogdanov@yadro.com>
Subject: [PATCH 0/7] nvmet: support of Fused operations
Date: Thu, 12 Sep 2024 09:42:52 +0300
Message-ID: <20240912064259.5228-1-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-Exch-05.corp.yadro.com (172.17.10.109) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_234353_041160_2A30D9C1 
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

Hi,

This patchset introduces a support of Atomic Test & Set (ATS) primitive.
It's implemented by means of Compare And Write fused commands in nvme target.

That allows ESXi to use Linux NVME Target as VMFS datastore storage.

The first 3 patches add a single Compare command support.
4th patch an refactoring to have a common point in the command execution flow.
5,6 patches adds support of Fused commands.
And the last patch allows to send fused commands by nvme io-passthru tool
for testing purposes.

The patchset based on nvme-6.12.

Dmitry Bogdanov (7):
  nvmet: add support of Compare command
  nvmet: bdev: add support of Compare command
  nvmet: file: add support of Compare command
  Revert "nvmet: Open code nvmet_req_execute()"
  nvmet: add support of fused operations
  nvmet: make fused commands be atomic
  nvme: allow send fused commands

 drivers/nvme/host/ioctl.c         |   6 +-
 drivers/nvme/target/admin-cmd.c   |   6 +-
 drivers/nvme/target/core.c        | 391 +++++++++++++++++++++++++++++-
 drivers/nvme/target/fc.c          |   6 +-
 drivers/nvme/target/io-cmd-bdev.c |  34 ++-
 drivers/nvme/target/io-cmd-file.c |  21 ++
 drivers/nvme/target/loop.c        |   2 +-
 drivers/nvme/target/nvmet.h       |  16 +-
 drivers/nvme/target/rdma.c        |   4 +-
 drivers/nvme/target/tcp.c         |   4 +-
 include/linux/nvme.h              |   2 +
 11 files changed, 473 insertions(+), 19 deletions(-)

-- 
2.25.1


