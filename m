Return-Path: <SRS0=zgHd=LK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B788C48BE6
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 21:19:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F38A1613DE
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 21:19:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F38A1613DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=CpFSocpycbxRfZ5ykgcPkYsrm++mt0MYN3OFlSrHvnU=; b=f16Pu/8Fdzpms9
	6L3ZodzFrv0KQ2A8dvxlO0KFIpzYOOcGfmFmzxQAL6exPdqsktRSNZmCwpSwrIlndgxR09w2rn7Ub
	nOadKYBhDKjPaMSsuFKpeeWedQdTsQVJ9wob1yTi6oN7F6r3iUkRQi+BT9/mFSCmnnceyjS07Iy9+
	/sqFeWadnjlUvuURIbR9ftPNuNmYxYR2e1CUcAeu3bPw21ANGhaDXUKHx30FgPIqMsFsgGfkBD6bU
	7UcFhDsbMGuz9zsIMfjm3rmsM9PMUfsbYACDABFdxq3fJMueRWYjGqF9Y6xlRErUKu4hYSkgqIPy5
	P1OihtRCtsZrD7oAOhAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltcwo-007jzo-Q4; Wed, 16 Jun 2021 21:19:42 +0000
Received: from mail-pl1-f172.google.com ([209.85.214.172])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltcwl-007jyn-S1
 for linux-nvme@lists.infradead.org; Wed, 16 Jun 2021 21:19:41 +0000
Received: by mail-pl1-f172.google.com with SMTP id v12so1785483plo.10
 for <linux-nvme@lists.infradead.org>; Wed, 16 Jun 2021 14:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=miqJ1PsXzVbxg5gD3T+sIalsdVawGHO0KzI0UvfKD8Y=;
 b=dSyDutxU+hDIXNrFrhnj55bdFcg38PG5Xwc5psokipBvQSE3c3x+a9h+JfWfelhMye
 D7Vl9iKJmxopyQ+d0xI0bi/AxMNIoi15BiRiQIBUW8irbdqaG8I9DZHqyY/pDJoaaB/9
 7wo+GexzX0msd0z/ZbsrV4tvoYMuxSyzhnHWWGI1aK6dJfKyGC5WBykrpeQySEPVRlaS
 HfiMq48mN0G6+4O1A32PGN+0QaDLjysCWtrQW+ybJEMzQQrrj9pmCjEOhB/AvutZZG7d
 dyTuDCburp4EPt4bVS04szgxQ683Phq2PMaKlrESPpQPksvrBTtUyCiKufuWOG4Ygiad
 Htyw==
X-Gm-Message-State: AOAM5302r1/WQ5mNnrCc1H8kHekZN7SYYhWt82/TCkNOGP6TeyGzS10I
 vfimLmTrIUC+a0NVXuTyR0ldQbCiWZU=
X-Google-Smtp-Source: ABdhPJwCG/GQjVlkXZkIgo6T4D4sWL6x1j11MoLnaFUCpm8nkk2vLUx1npCiO6zG6NA7ydeQZZMHQQ==
X-Received: by 2002:a17:90b:517:: with SMTP id
 r23mr1825859pjz.209.1623878378690; 
 Wed, 16 Jun 2021 14:19:38 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:1036:8496:ef40:673a])
 by smtp.gmail.com with ESMTPSA id e188sm3003046pfe.23.2021.06.16.14.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Jun 2021 14:19:38 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v3 0/4] nvme: protect against possible request reference after
 completion
Date: Wed, 16 Jun 2021 14:19:32 -0700
Message-Id: <20210616211936.451128-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210616_141939_944629_B2074742 
X-CRM114-Status: GOOD (  11.70  )
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

Nothing in nvme protects against referencing a request after it was completed.
For example, in case a buggy controller sends a completion twice for the same
request, the host can access and modify a request that was already completed.

At best, this will cause a panic, but on the worst case, this can cause a silent
data corruption if the request was already reused and executed by the time
we reference it.

The nvme command_id is an opaque that we simply placed the request tag thus far.
To protect against a access after completion, we introduce a generation counter
to the upper 4-bits of the command_id that will increment every invocation and
be validated upon the reception of a completion. This will limit the maximum
queue depth to be effectively 4095, but we hardly ever use such long queues
(in fabrics the maximum is already 1024).

Changes from v2:
- cc linux-nfs,linux-kernel for patch 1/4
- fix expected genctr print in patch 4/4
- match param_set_uint_minmax indentation
- collected review tags

Changes from v1:
- lift param_set_uint_minmax and reuse it
- simplify initialization in patch 3/4

Sagi Grimberg (4):
  params: lift param_set_uint_minmax to common code
  nvme-pci: limit maximum queue depth to 4095
  nvme-tcp: don't check blk_mq_tag_to_rq when receiving pdu data
  nvme: code command_id with a genctr for use-after-free validation

 drivers/nvme/host/core.c    |  3 ++-
 drivers/nvme/host/nvme.h    | 47 ++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/pci.c     | 17 ++++++--------
 drivers/nvme/host/rdma.c    |  4 ++--
 drivers/nvme/host/tcp.c     | 38 ++++++++++++------------------
 drivers/nvme/target/loop.c  |  4 ++--
 include/linux/moduleparam.h |  3 +++
 kernel/params.c             | 19 +++++++++++++++
 net/sunrpc/xprtsock.c       | 18 --------------
 9 files changed, 96 insertions(+), 57 deletions(-)

-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
