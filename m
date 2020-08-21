Return-Path: <SRS0=kXjr=B7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFDEC433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 00:30:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23DEB206B5
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 00:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rd11jzKU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23DEB206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=j5fNvxcTEowplpbjQFwYsEGSNBBBZW/zA8MXibn4p/c=; b=rd11jzKU3A3MotJ/p3JJ60TnXo
	wAhvxVGuVYhb8OeW3Mdd6Bt5JvlFXjRzW53FbzFbVt86bdSKqt/AjytuWEObu6gar/HIk/dAPGlN2
	auLhHobP1a2qtB/iUsYP/9fDKk+bEB3YotHyRcf2MQa+rBtDJ81yrrX+WMh622dH2+9+EvqhE3W0J
	tTPDgmFARh0l0w2AHauif91hEv9Kv37ZY8RQoj0nCGL5czPZzSM+EzQyx6nGe0clFgWzHcbgLKukD
	2erHaKChRlUaH+AG2MjvemkwewAXBSJi9++CerGcgE12ciYT2whmQtm/S7admzD1qBYB+4T8OFYF/
	H979Ie9w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8uwr-0001p6-92; Fri, 21 Aug 2020 00:30:25 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8uwo-0001oJ-Ih
 for linux-nvme@lists.infradead.org; Fri, 21 Aug 2020 00:30:23 +0000
Received: by mail-wm1-f51.google.com with SMTP id x5so200105wmi.2
 for <linux-nvme@lists.infradead.org>; Thu, 20 Aug 2020 17:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XB/lXNRVDf6dy5hTMGUhjH+26NyDzmWZWR8JXbU96rY=;
 b=LDCwKUuPcd1cOthfcfALOeIrMohCj4tSKgQbUN38JW0jpZYxwVMszph/lJYN8U8jC6
 MvN+u/WqLeIp2zNo5ag3JHo9TtYKt0vYu6e73NgRXiH9RIWjMU5yoW7triJX3n9Pf6C6
 qzNEO/SZbXYkVD0rHMCKphQEDVup5A8gltVc2JFfR1RVnV+UvUzrtO/Mcs4nfOvnXzqy
 zqH0cXmaqqP+L2SaQKIqMcSgg7KqgbWhT+4qhOyHfVYSMaChuumruPi5+44U+JJjAtZc
 QVyK9AmWwtac5CcbjlILY9ThnR3uaMbBInNVs6Mg01mnCY2z0eyD1xnJMl6Iadf9YtS5
 mIkQ==
X-Gm-Message-State: AOAM533xZxwTOfVo/GY5u1KTNCYGplrgvSK5tEWB1bKPnADWMd9GtUdT
 NHdAR+8nqYB2FLIcdOxcCJI=
X-Google-Smtp-Source: ABdhPJwwYYNHx/iUopSAOL5k8qeQjrRuIOYlrnxHg8gbWQMYfl+mUFlOpSy1/9nYad7G/d/JIlMEDA==
X-Received: by 2002:a1c:6087:: with SMTP id u129mr889634wmb.157.1597969821199; 
 Thu, 20 Aug 2020 17:30:21 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:7ced:8569:4373:1bd3])
 by smtp.gmail.com with ESMTPSA id g12sm682194wmh.40.2020.08.20.17.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 17:30:20 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] nvme fixes for 5.9-rc
Date: Thu, 20 Aug 2020 17:30:15 -0700
Message-Id: <20200821003015.682013-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_203022_632654_7CB09552 
X-CRM114-Status: GOOD (  13.00  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hey Jens,

The important fix here is the nvme-pci boot issue reported
by Ahmed (addressed by John).

Other than that we have:
- nvme completion rework from Christoph and Chao that mostly
  came from a bit of divergence of how we classify errors related
  to pathing/retry etc.
- nvmet passthru fixes from Chaitanya
- minor nvmet fixes from Amit and I
- mpath round-robin path selection fix from Martin
- ignore noiob for zoned devices from Keith
- minor nvme-fc fix from Tianjia

Please pull.

The following changes since commit 58d7a4ff70d18ec6dfb128626b19ae00d0f98264:

  blkcg: fix memleak for iolatency (2020-08-19 08:09:39 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.9-rc

for you to fetch changes up to 729d1456ea5fc53629a182e6590fd5fb1a2ab562:

  nvmet: Disable keep-alive timer when kato is cleared to 0h (2020-08-20 12:06:53 -0700)

----------------------------------------------------------------
Amit Engel (1):
      nvmet: Disable keep-alive timer when kato is cleared to 0h

Chaitanya Kulkarni (3):
      nvmet: add ns tear down label for pt-cmd handling
      nvmet: fix oops in pt cmd execution
      nvmet: call blk_mq_free_request() directly

Chao Leng (1):
      nvme: redirect commands on dying queue

Christoph Hellwig (4):
      nvme-pci: fix PRP pool size
      nvme: rename and document nvme_end_request
      nvme: refactor command completion
      nvme: just check the status code type in nvme_is_path_error

John Garry (1):
      nvme-pci: Use u32 for nvme_dev.q_depth and nvme_queue.q_depth

Keith Busch (1):
      nvme: skip noiob for zoned devices

Logan Gunthorpe (2):
      nvmet-passthru: Reject commands with non-sgl flags set
      nvme: Use spin_lock_irq() when taking the ctrl->lock

Martin Wilck (2):
      nvme: multipath: round-robin: fix single non-optimized path case
      nvme: multipath: round-robin: eliminate "fallback" variable

Sagi Grimberg (1):
      nvmet: fix a memory leak

Tianjia Zhang (1):
      nvme-fc: Fix wrong return value in __nvme_fc_init_request()

 .../fault-injection/nvme-fault-injection.rst       |  2 +-
 drivers/nvme/host/core.c                           | 86 ++++++++++++++--------
 drivers/nvme/host/fc.c                             |  6 +-
 drivers/nvme/host/multipath.c                      | 69 +++++++----------
 drivers/nvme/host/nvme.h                           | 31 +++++++-
 drivers/nvme/host/pci.c                            | 17 +++--
 drivers/nvme/host/rdma.c                           |  2 +-
 drivers/nvme/host/tcp.c                            |  4 +-
 drivers/nvme/target/configfs.c                     |  1 +
 drivers/nvme/target/core.c                         |  6 ++
 drivers/nvme/target/loop.c                         |  2 +-
 drivers/nvme/target/passthru.c                     | 25 +++++--
 12 files changed, 148 insertions(+), 103 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
