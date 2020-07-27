Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC63C433E5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 23:10:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 565A920729
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 23:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bQpFHANT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 565A920729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=G6/ZPKtmn2mzDfaTwXfoQF4S9CSQEIGw4TNvU/QU66U=; b=bQpFHANTObGjVv+tz9gB0WKvIT
	o1x4lzPQU5ni1jhBvYXHgCs48Ih7iHZMpOOaMaqzpvUE2JdPnBPf65QJCyxL53MrLLecHGqMg3reH
	H3ovzE8TCg37J/TRYg8V0lagGZt4qlLiSlAsTmjJxVrarUKbfjuH4huuB2gokewCoJSsUUh6Vfq+V
	kQ2+8JLzj18SYdH3w5qK/1MkOf3W/DNeu3bQ8a2kSDsu81yEL96BI2g7k3HMyKlDoC5xXNyakCo18
	ixsFR0engmnE1wbCiAJWmg5CNgSdr84aj6pCeddpW/ghh2fTyYu1Vitf3Wx+qQPhmXXSd78eO+alL
	YeMfPGvg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0CGK-0006Cn-VS; Mon, 27 Jul 2020 23:10:28 +0000
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0CGJ-0006CC-5D
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 23:10:28 +0000
Received: by mail-pl1-f195.google.com with SMTP id k13so1135288plk.13
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 16:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=s7HvE7cCk+QXElSFNz6NUM8zZE/EqHMoDCQdYPstf08=;
 b=IxWuTl1aLJQGckIjGkBstoJCgluXeP0fEPYebcgxNb3ERW+olf+NxBIDD/Dn81jndJ
 OuLFBOJIlKxQkwLVIkkHpomSDQYLNHgeOJVXXfyXtI504MpaLpwW8un3xvZP0WFBQM9b
 dkDLTQBiKd+PHW/TO0I699ZAu3EWAvv4okG2H+1HukgowEtieO588BPqhAH/0R8HNNpC
 KCpWMeq+AtplS+E8a/RbHZndoXLgyzz7Ns7rCLeVK1ig4hkA7M1pqzUURSMJbe3vHi/z
 +1iFvyj7mkcyTUIPODPZ1Fs33L2jWetltHG9o8JniCL+NDsJklfEjiNEKK51mzRBJVvy
 VQeQ==
X-Gm-Message-State: AOAM533zdpXCAdktSVzXM5asxhXbLmgYYvCh2HbiEEBVRtSu+LjkwAsI
 hAkrN/arLtEIQlBmRBL/YOOURcF1
X-Google-Smtp-Source: ABdhPJx7LHZGg8iU5uE+1Tv25WzLucK/Z41popy2MTwXO+9/xIZXLSbghsX29tkbwFA4+eDsITraiw==
X-Received: by 2002:a17:902:7b85:: with SMTP id
 w5mr20109833pll.22.1595891425539; 
 Mon, 27 Jul 2020 16:10:25 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:5d7d:f206:b163:f30b])
 by smtp.gmail.com with ESMTPSA id z190sm7407171pfz.67.2020.07.27.16.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 16:10:24 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v5 0/2] improve nvme quiesce time for large amount of
 namespaces
Date: Mon, 27 Jul 2020 16:10:20 -0700
Message-Id: <20200727231022.307602-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_191027_258062_6BC20413 
X-CRM114-Status: GOOD (  12.60  )
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
Cc: linux-block@vger.kernel.org, Ming Lin <mlin@kernel.org>,
 Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This set improves the quiesce time when using a large set of
namespaces, which also improves I/O failover time in a multipath environment.

We improve for both non-blocking hctxs and blocking hctxs introducing
blk_mq_[un]quiesce_tagset which works on all request queues over a given
tagset in parallel (which is the case in nvme) for both tagset types (blocking
and non-blocking);

Changes from v4:
- introduce blk_mq_[un]quiesce_tagset as one interface
- move nvme core to use this interface

Changes from v3:
- make hctx->rcu_sync dynamically allocated from the heap instead
  of a static member function

Changes from v2:
- made blk_mq_quiesce_queue_async operate on both blocking and
  non-blocking hctxs.
- removed separation between blocking vs. non-blocking queues
- dropeed patch from Chao
- dropped nvme-rdma test patch

Changes from v1:
- trivial typo fixes

*** SUBJECT HERE ***

*** BLURB HERE ***

Sagi Grimberg (2):
  blk-mq: add tagset quiesce interface
  nvme: use blk_mq_[un]quiesce_tagset

 block/blk-mq.c           | 66 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c | 14 ++-------
 include/linux/blk-mq.h   |  4 +++
 3 files changed, 72 insertions(+), 12 deletions(-)

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
