Return-Path: <SRS0=kLfw=OL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B01C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 15:17:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F52561184
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Sep 2021 15:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1F52561184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ypY7cTgkFSM++RY0Yy55UD9zosGZZf5YLK3TF2qpfS0=; b=h7faM8lkWygYVK
	1FwFOQqFsURukDvte6Of0EyrqrQi+sLuwyikZ2Zvt8LM6BOfslex9To/tz/k+6h4fVi2TCf+iW0Io
	vWX3d03ygoBxcX/GA5OsVmGvsUpG7+VOEMgwOmcKIOiNj4r3qYFtUteALVumKgfsiO9KD3GeZkTqF
	v80G4ywFmBdr6N2deHqB6As9ayAnCuaaDkcJX79nraDbL4Zj5SMQaSJu5ZW8+MmJJOr0zTdFpbqI8
	tnzBsPoyUmqaaN7psF8lGEl0QcrGG5oLyrWeItxVIoC1AaLDVkDeH6ZKZXuVLj9se1oq5qWGlCYoC
	be3/NSAOOeWLxnAiT4Hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mShVu-004rMi-1d; Tue, 21 Sep 2021 15:16:54 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mShUn-004r6Q-9W
 for linux-nvme@lists.infradead.org; Tue, 21 Sep 2021 15:15:47 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 751961FEEE;
 Tue, 21 Sep 2021 15:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1632237341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6IWG/aUIno0e9Xa4Dpn0+AOP+ac/ygTchuFKHKZqH54=;
 b=kzw18VpMduHbnUfdyEVDe1C1k+Vd9UYRw5QcpYSkRX5PUEI7MPjseYKc+zHwM0i0jwfWf5
 qJEsDelJQ66upGWPQ+UUQIQCIJo9Rp24NtiJWnE0O3l1INnpFkmXpoCTmb++23XJDJJkQa
 4qeB3a6WP8qCuM54tuw2eb8Pj4I7fxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1632237341;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6IWG/aUIno0e9Xa4Dpn0+AOP+ac/ygTchuFKHKZqH54=;
 b=HXCvbZT2IFciPfyIAjN8CjoSiPLUgbtr22SpUxnmpDwwKru6mu3eie5CgtEuIb6/4YoKR4
 veTGBSc3XfXiW2Dg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 44696A3BA3;
 Tue, 21 Sep 2021 15:15:40 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 693BC518EA89; Tue, 21 Sep 2021 17:15:40 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2 0/6] nvme: support unique discovery controller
Date: Tue, 21 Sep 2021 17:15:23 +0200
Message-Id: <20210921151529.29419-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210921_081545_536492_69774BE3 
X-CRM114-Status: GOOD (  11.49  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,

with TPAR8013 a discovery controller can support a unique subsystem
NQN. This patchset adds support unique discovery subsystem NQNs for
both target and host.
For host support a new connect option 'discovery' is added, as we
can't infer from the NQN whether it should be a discovery connection
or not.

As usual, comments and reviews are welcome.

Changes to v1:
- Rebase to nvme-5.15

Hannes Reinecke (6):
  nvmet: make discovery NQN configurable
  nvme: add CNTRLTYPE definitions for 'identify controller'
  nvmet: set 'CNTRLTYPE' in the identify controller data
  nvme: expose subsystem type in sysfs attribute 'subtype'
  nvme: Add connect option 'discovery'
  nvme: display correct subsystem NQN

 drivers/nvme/host/core.c          | 36 +++++++++++++++++++++++++-
 drivers/nvme/host/fabrics.c       |  6 ++++-
 drivers/nvme/host/fabrics.h       |  6 +++++
 drivers/nvme/host/fc.c            |  2 +-
 drivers/nvme/host/nvme.h          |  1 +
 drivers/nvme/host/rdma.c          |  2 +-
 drivers/nvme/host/tcp.c           |  2 +-
 drivers/nvme/target/admin-cmd.c   |  3 +++
 drivers/nvme/target/configfs.c    | 42 +++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c        |  3 ++-
 drivers/nvme/target/discovery.c   |  2 ++
 drivers/nvme/target/fabrics-cmd.c |  3 ++-
 include/linux/nvme.h              | 10 +++++++-
 13 files changed, 110 insertions(+), 8 deletions(-)

-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
