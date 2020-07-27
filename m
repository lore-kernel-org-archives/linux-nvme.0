Return-Path: <SRS0=kRiD=BG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A3EC433E5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 22:07:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D1372072E
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2020 22:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KogvxrcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1372072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=H7+sVmubK5LLnZh608p63NtL4SO5OAt+QEeGTZk0LHU=; b=KogvxrcGD5l8u2GyAclcz0awjt
	gQ01wC9xq2/yUprCi6CMaIihBaVYhzgNgCjwFvcox8lOdUP5l+nMjsei/Up6FcV9+bziz5RWfknRT
	l7gzfgpId6KBUg/849RAFY8kW03Y+X6f72N/xihuVUThAyGLGz52VDheac8/7xmJ4CGYOFAud6Tn5
	aPCtyFNY6smzGjnFLkwwoHcp3mxF54nC4GMhlcn+ukkIYfBJ+igOg7konZUFD+we4EX7UwuTEVzl8
	0AEwuTVTJbdveFnfpU1vXvtlFgqitwCdoew9CZaNmCB9RUqPJ+I3fhuIy6Ys7DpryLAMj4WqNwgXR
	/wdXVw/g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0BHI-0005Yj-Lh; Mon, 27 Jul 2020 22:07:24 +0000
Received: from mail-pj1-f65.google.com ([209.85.216.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0BHF-0005Xd-Kw
 for linux-nvme@lists.infradead.org; Mon, 27 Jul 2020 22:07:22 +0000
Received: by mail-pj1-f65.google.com with SMTP id f9so4281205pju.4
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 15:07:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YxOSCyarMo8rd+alRxzcI3/88MQ1TYcQ700rV7z57xc=;
 b=mkdekUDVTA85nomQ2bQnEm5EhtGG/AfG6ck0zvs3OTPkeqplEUUnYrxKFBhI8Kz/G3
 GZ4hvGP6elLjdmJpeUp7khft4pAO719ckCNMlv9Bydumb4TlxalgUdB4m81Ll3dSjDa+
 Oa4c467/K7p95s6JZgPacyl3dRKuieoCrMA6gcr8frJ39gqIJv+A07hvq+UtvHq65Fq1
 965wmzE95uzNqJrd7HmPPSooWZFAMmwiN9rpcfGDccgKbA/5w4sNWTlXv559802u3BTL
 cWuY/WgRzXryyHP78vdr4C0ZokXOvfsWQGO+76CRiup+U7hLsIUJ4LLrvrKTNA6ZiJM6
 eDpw==
X-Gm-Message-State: AOAM530tpEhqYag284zVN34hRwPJ3hv/EZOop9QpStfSYuDAQPYVSJVu
 Yvb/HedD7UJti9yPbvAad12OoGSs
X-Google-Smtp-Source: ABdhPJxf7FRgOdPk5QoVXH2ofVHKyyJCM4+9R4zv4WLmfRw3A3wmDSNBb33BZjq55Q411B8o+Hpt5A==
X-Received: by 2002:a17:902:446:: with SMTP id
 64mr20732180ple.157.1595887639723; 
 Mon, 27 Jul 2020 15:07:19 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:5d7d:f206:b163:f30b])
 by smtp.gmail.com with ESMTPSA id s4sm2309519pfh.128.2020.07.27.15.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 15:07:19 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 0/2] improve quiesce time for large amount of namespaces
Date: Mon, 27 Jul 2020 15:07:15 -0700
Message-Id: <20200727220717.278116-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_180721_736357_2FA8346E 
X-CRM114-Status: GOOD (  13.40  )
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

We improve for both non-blocking hctxs (e.g. pci, fc, rdma nvme transports)
and blocking hctxs (e.g. tcp nvme transport) by splitting queue quiesce to
blk_mq_quiesce_queue_async call_(s)rcu and blk_mq_quiesce_queue_async_wait
to wait for it to complete. These calls are meant to be called in parallel
for different queues.

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

Sagi Grimberg (2):
  blk-mq: add async quiesce interface
  nvme: improve quiesce time for large amount of namespaces

 block/blk-mq.c           | 46 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c |  4 +++-
 include/linux/blk-mq.h   |  4 ++++
 3 files changed, 53 insertions(+), 1 deletion(-)

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
