Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8738AC433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Oct 2022 09:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ELo8dLo8R9gKdevwXg1T9ddeDjUEA9y1TimZiBY1kMY=; b=C1gcO2lYFnTYvdlTpURQS2a0ME
	EhOvqv9rlC77/3pxTjxFI65YLJSGTLsJHHJMjZ5BcP4Woxn8hWbQ6fYGkgP8Yu7rc6Pcvq+0RUYgE
	Dwe0uLILcR7fZKPSA9rg91OH8A5O57/ny73bL7bKCdQGE7WgUxXU9vv+I2YPu3bwzt28UEJJyYxST
	V63cqwzRIbvR+cpkzQHesJYDXXofTypZaQJyhMX8O99sy5Ryb+x3ol5zeKQImwZHZWQo60CbbCpSB
	jkfK92KgaUsCm+6U4/J4U+O3N32gmxwdP4aRMjbLRI4ApXOa0rO92Zs6eXlz49iZjMdQUTnIBdqfi
	uITV9UJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofHzM-0057Wi-3P; Mon, 03 Oct 2022 09:43:52 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ofHzI-0057TW-Se
	for linux-nvme@lists.infradead.org; Mon, 03 Oct 2022 09:43:50 +0000
Received: by mail-wm1-f42.google.com with SMTP id e18so6631005wmq.3
        for <linux-nvme@lists.infradead.org>; Mon, 03 Oct 2022 02:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ELo8dLo8R9gKdevwXg1T9ddeDjUEA9y1TimZiBY1kMY=;
        b=zQAYS+HHj1CBKSzAdhkJTBbuwO8xnOeKa/ZiG1vUamqaKP2F4YKNpAi/d0OM4KlFBc
         RJ7SKjLqwT/9A5DHKQSu48GJyz7XzRHo/lX29gFQEwEd3XspjTqjWK8RA4bVjZf/ix3D
         ZNUGwHwH7gsAGNDyC8dT3K+6wTsEAwcTkKEqzpKERECveYwXgw6NYqnC0Ru4+hYsGx+2
         0lWLuNijgNkzn8z5qZrEUvKhh0G6oXyZKc/8BG6PKAMWqQ9RpRl2DwocDCPJnn/m19NR
         5fpEWdlIPlsCGlbFBxppK38mcfF1Hev5k0GsFkugMgQ2EWVxXZVxkWwF2FxUwYJF2feE
         bqgA==
X-Gm-Message-State: ACrzQf2wKmDRHLjRxPZrHVD96SRDlNWDWdc8HtnrQJc1RT+AOtzU5gSs
	4Uy4eLfTCwVE/+oiG6MnDt5U4kbYO5I=
X-Google-Smtp-Source: AMsMyM77o9080Y6cjd9/mDSo5KqUGKdxlffz7oxtIUwxuss5Qq9dQvDwBGyWwoL7avK0CfvSG4j2uw==
X-Received: by 2002:a05:600c:1e24:b0:3b4:6c1e:8bb7 with SMTP id ay36-20020a05600c1e2400b003b46c1e8bb7mr6589942wmb.1.1664790226711;
        Mon, 03 Oct 2022 02:43:46 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bk14-20020a0560001d8e00b00228d67db06esm3545586wrb.21.2022.10.03.02.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 02:43:46 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org
Subject: [PATCH v2 0/2] nvme-mpath: Add IO stats support
Date: Mon,  3 Oct 2022 12:43:42 +0300
Message-Id: <20221003094344.242593-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221003_024348_948409_1BA947C0 
X-CRM114-Status: GOOD (  14.92  )
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

I've been hearing complaints about the fact that the nvme mpath stack
device does not expose IO stats just like any normal block device,
instead people need to check the bottom namespaces hidden devices,
mapping back to the mpath device node.

This really sucks, especially for observability hooks/plugins that
I've seen people do.

This series make the nvme mpath device expose normal IO stats. Given
that nvme-mpath doesn't have any context after submitting the bio, we
use the core completion path to start/end stats accounting on its
behalf, a similar practice that we use for other multipath related stuff.

While we are "double" accounting every request, this is a preferable
approach as opposed to try and locally collect/combine accurate stats
from multiple bottom hidden devices in the driver, or teach the block
layer to do so.

Local tests with null-blk + nvme-loop did not show any noticeable
performance degradation (within 1%).

Feedback is welcome.

Changes from v1:
- split into 2 patches, one prep and second is nvme-mpath stats
- fix possible use-after-free when ending request and accounting mpath io
  stats
- mark REQ_NVME_MPATH_IO_STATS to allow user to disable stats on the mpath
  device (also in the middle of a request).

Sagi Grimberg (2):
  nvme: introduce nvme_start_request
  nvme: support io stats on the mpath device

 drivers/nvme/host/apple.c     |  2 +-
 drivers/nvme/host/core.c      | 10 ++++++++++
 drivers/nvme/host/fc.c        |  2 +-
 drivers/nvme/host/multipath.c | 25 +++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      | 13 +++++++++++++
 drivers/nvme/host/pci.c       |  2 +-
 drivers/nvme/host/rdma.c      |  2 +-
 drivers/nvme/host/tcp.c       |  2 +-
 drivers/nvme/target/loop.c    |  2 +-
 9 files changed, 54 insertions(+), 6 deletions(-)

-- 
2.34.1


