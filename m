Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D10C3DA7D
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jan 2023 10:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ok709+7dp4DV19iS7OyPJz49N/z9O0IN0h40skFh8yY=; b=1VdGI60ahBupW3UA+A/pVj95nX
	fsTcpCvCgmSpoIwE2OVQXLoAWp34wSxG/IcX+AKB1D85L0KLGPV+eTLRChOyn8rgeR17U4VySYpN8
	JYQOcGH/PfWdC5kU1C+ck2EFgqlg56on/x30LnIQAd+uCbcx+ywAupYQpwDdvacnUtrYRFhX8v6Z+
	7U0tU0nxnU6Ho8cuRc11WRGHzRX3lWssoudYZAOzly0mt0c+IkmCXAifBBc0a+McDXjjss2zp88gK
	Au5QDoGI6bQAmtRNJKEdnKq2KnYO5TkwXsl10uA6G5R8bDhphS/7jdEK/pu4HERyyoyZJfxQskrcO
	BeiEKN+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCeR5-000hBE-D0; Tue, 03 Jan 2023 10:22:23 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCe9m-000bgv-Uu
	for linux-nvme@lists.infradead.org; Tue, 03 Jan 2023 10:04:32 +0000
Received: by mail-pj1-x1029.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so30581849pjj.4
        for <linux-nvme@lists.infradead.org>; Tue, 03 Jan 2023 02:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ok709+7dp4DV19iS7OyPJz49N/z9O0IN0h40skFh8yY=;
        b=B/+TcVrVJF9/adrAOkhF28a3Hg5EJa+SxjnWUMUoXTyQxHE1t6jzuwmXzvmKzgg//j
         ptWqwYs9PexhIxQDdGqk2PcIElGWU5MY6rydUP3v5DoAuj9i93rucYH0LhjxfGtQWJqv
         n7x2Tqaqoh/wYp4pqUeWFOfNOGKs8F4D61FSNFiNHHhQR3edU2YR0jD4Br4FCUZ6Pk0f
         EHbTASvNGr35LFznHZrRAx7mHx/NOHQxAxj0XlwY4n5/RsBvuTNpILI/zKJtx4Pzz6cw
         bFUDGo/aDQ0wBbnbbm/OAVIkW1RSH+2UDzHwqxydlAY0Lrq853vFi4m6bonC9/TfWW6B
         PcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ok709+7dp4DV19iS7OyPJz49N/z9O0IN0h40skFh8yY=;
        b=TbEC6Ds/Huo86pMci4O5wQj/it93RNBDKvBxYwbhzbU2mqe6GLR3fFb+80ZF0GoMgn
         VwlXXha1xDh1Q2xCsBv1eDiWnmd5S/PlHFT7hqtc9noqTP+wYL7zooOKF4GdTxQmSYvZ
         hpQ5zvw9wnr2KAztFNKNsulGu4RtEicS2z63eyY22XngVhpHVMeELTXFnEtii5TdlovH
         ansl3ZeS5+Q2hoi4wFZyT1RA4parmBdOOQE4JS7rxeo6IfL//rnPhI+2tpHXmtlOgQBx
         ZYFr69II2SC5nkbBUGbwwHbRB4ITwv6odFzeGj33zLXT9EaHV++rTE1ERWF0Lunkl6dG
         d0pg==
X-Gm-Message-State: AFqh2kqrLeTMhgW2EfaiVLf86vkEz6LMUC5ouBNFdhgDercUDbJ1Y/BO
	RRB+RrNWMaO+z5kG11lntQNyOKSvyIZxoQ==
X-Google-Smtp-Source: AMrXdXujFUtQ60Frd17Dr4QElRgNPY7I1Dv79kawR2KUQ8nFilsWDaSpYYFgu1/zQ20nVgC7P8HE0g==
X-Received: by 2002:a17:90a:eb07:b0:223:afb8:a2aa with SMTP id j7-20020a17090aeb0700b00223afb8a2aamr45319284pjz.26.1672740266502;
        Tue, 03 Jan 2023 02:04:26 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id j14-20020a17090a2a8e00b002187a4dd830sm14311691pjd.46.2023.01.03.02.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 02:04:25 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: james.p.freyensee@intel.com,
	ming.l@ssi.samsung.com,
	larrystevenwise@gmail.com,
	anthony.j.knapp@intel.com,
	pizhenwei@bytedance.com,
	ap420073@gmail.com
Subject: [PATCH 0/4] nvme: fix several bugs in nvme-fabric
Date: Tue,  3 Jan 2023 10:03:53 +0000
Message-Id: <20230103100357.875854-1-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230103_020431_045292_627A06F1 
X-CRM114-Status: GOOD (  13.65  )
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

There are several race conditions in the nvme-fabric scenario.
It fixes these bugs as well as a memory leak.

The first patch fixes kernel panic in delete controller logic because 
of dereference of an uninitialized controller.
Currently, controllers can be deleted with the sysfs.
It should be disallowed before controller initialization.
But it is allowed always.
So, the delete controller logic possibly accesses uninitialized 
controller resources, which results in kernel panic.

The second patch fixes kernel panic in reset controller logic because 
of dereference of an uninitialized controller.
This issue is very similar to the first issue.
The solution is very similar too.
It prevents resetting controllers before the initialization of the nvme 
controller.

The third patch fixes a race condition between nvmet_ns_disable() 
and nvmet_ns_enable()
nvmet_ns_enable() and nvmet_ns_disable() should not be worked concurrently.
But, it is possible.
So, hang occurs in the nvmet_ns_disable() due to a race condition.

The last patch fixes a memory leak when a tcp target is released.
When a host sends a reset command to the target, a target calls 
nvmet_tcp_free_cmd_data_in_buffers() to free resources in the CMD.
It internally possibly skips freeing resources due to some condition.
At this point, a memory leak would occur.

Taehee Yoo (4):
  nvme: fix delete uninitialized controller
  nvme: fix reset uninitialized controller
  nvmet: fix hang in nvmet_ns_disable()
  nvmet-tcp: fix memory leak in nvmet_tcp_free_cmd_data_in_buffers()

 drivers/nvme/host/core.c       | 31 +++++++++++++++++++++----------
 drivers/nvme/target/configfs.c | 14 +++++++-------
 drivers/nvme/target/core.c     | 10 ++++++----
 drivers/nvme/target/nvmet.h    |  8 +++++++-
 drivers/nvme/target/tcp.c      |  9 +++------
 5 files changed, 44 insertions(+), 28 deletions(-)

-- 
2.34.1


