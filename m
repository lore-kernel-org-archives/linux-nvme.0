Return-Path: <SRS0=Gu9/=BD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5420C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 23:06:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BAED206C1
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 23:06:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1G9loNq9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BAED206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3vap2QIyUToUDkUOk4J0XOHTb55SwrANx0fnsjJoXAw=; b=1G9loNq9+EwIzr35C0S8SMAFgr
	QYWV1xoxFwOn23Eb4uaj612MEz2TeAt3837QoQjPz5sJIy3OUvd5H/UjtFqZFkg/N44NPWE6zTnOO
	i+7B3/BOYnhXUqmTMUWuoNMEYer55G0BIPOh9A2nPDOz3bOMgzTYvO613b+fFtuR7INcXW9KpHasj
	/RlYbTdrobagBTRMOU/2SXk3LZgW8476/eVJqqX7ADt8cay/lvNDAaZJVtgDGnGpDdNrHKh7Sf0mG
	uWxjV3xjsRNRVux5KeYWq4QKCMjoox6jrfJx3TF12LnBk9Fvk3FSsQIn/hodZ2mlGjWT/fPdFlhcU
	Y94vpc+A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jz6lW-0002h9-Ok; Fri, 24 Jul 2020 23:06:10 +0000
Received: from mail-pj1-f68.google.com ([209.85.216.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz6lU-0002gU-NT
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 23:06:09 +0000
Received: by mail-pj1-f68.google.com with SMTP id md7so6340703pjb.1
 for <linux-nvme@lists.infradead.org>; Fri, 24 Jul 2020 16:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BzxtXNgeug2CFTKW40YCDivgqdG5PkFlmxelfFGuw74=;
 b=sFCs7pZb6NvziZoj4S71PWIKyaeu4+vmmbUBgHvU0wyEHnE/EANzVZVBPHracHOmiC
 64hW4x5BB0I6NfpwnP7VQVKRSylTv28gOvvyVQA2hXuKF8yFFF8rtu2tn9zZxJin5F//
 0urf2G/Oyo82gyPTOVN3YI85DsDqSWYmtlM6+VMpO0pW7+TNnZpRsFtRzFVvZ3Aqk/Qi
 itvsCm2UXX1Ed9j5XfDw9ao7JtsGEuUleD7w5wakQ3Lvoc9tF41IiTGlkCp+bSrTJkmG
 eFS3GWWsnFAYvYhpfa6ybu6LumSZMf+tk7S0QRaWeV4yNsCEi19vSg5nS8kCTF2JHQgD
 Grfg==
X-Gm-Message-State: AOAM530Lpaiksgvg4dZOtCfBYQcbzQ4lBWEJDmq1x9N9E/g9WVXr8o/l
 Vf61R1IGE8M/5SggHqnBUdSn7/fW
X-Google-Smtp-Source: ABdhPJxEz4o22zqZ7Ti4J/E0+JkMrPIZd/srGdEfINAG4EqoycCT2FEtrdNUAWIIY/GDDJ0iHHmwew==
X-Received: by 2002:a17:90b:3612:: with SMTP id
 ml18mr5668156pjb.193.1595631967204; 
 Fri, 24 Jul 2020 16:06:07 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:ac47:9fc4:b59:66fa])
 by smtp.gmail.com with ESMTPSA id 129sm7552379pfv.161.2020.07.24.16.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 16:06:06 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH rfc v2 0/4] improve quiesce time for large amount of namespaces
Date: Fri, 24 Jul 2020 16:06:00 -0700
Message-Id: <20200724230604.34625-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200724_190609_050207_1AA737F1 
X-CRM114-Status: UNSURE (   9.58  )
X-CRM114-Notice: Please train this message.
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
Cc: Jens Axboe <axboe@kernel.dk>, Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This set attempts to improve the quiesce time when using a large set of
namespaces, which also improves I/O failover time in a multipath environment.

We improve for both non-blocking hctxs (e.g. pci, fc, rdma) and blocking
hctxs (e.g. tcp).

The original patch from Chao was targeted to rdma, hence Patch #4 is just
for testing purposes in case testing with nvme-tcp is an issue.

Changes from v1:
- fixed patch #2 wrong leftovers (start_freeze)

Chao Leng (1):
  nvme-core: reduce io failover time

Sagi Grimberg (3):
  blk-mq: add async quiesce interface for blocking hw queues
  nvme: improve quiesce for blocking queues
  nvme-rdma: use blocking quiesce interface

 block/blk-mq.c           | 31 +++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c | 20 +++++++++++++++++++-
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/rdma.c |  5 +++--
 drivers/nvme/host/tcp.c  |  2 +-
 include/linux/blk-mq.h   |  4 ++++
 6 files changed, 59 insertions(+), 4 deletions(-)

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
