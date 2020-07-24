Return-Path: <SRS0=Gu9/=BD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E00C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 21:55:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E0F02070E
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2020 21:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u5XH+nIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0F02070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VLyvf/zt42ohcVQs5sZVCiiUy1hUQQspYrvbtEylyPE=; b=u5XH+nIUKEUzOjIPtJeY9JpKP/
	j1CKS1IdVFIAz6ly0TLYR8Q2EvnWpSEBHrIuPt3RaAwD62R0tA9Pgx82sRAln9iDMXMgd//xhkaHL
	8PNRnFF/g61Xjs9gyr8+8MFeyP6awTU4rFqvs37e0lhIYcOLtSK8VOG/AQQ18pLxKn6D9Vr8O/Njy
	ldck2Bt6/vLPz4zf+lpqGxDDo+D097lfrNLnPyO/l2jtWHlbmTEM0RPOF806uoiBMn4V1lJMcYM92
	koXdb/zcBFOimrs95QrKadHol8ryRixhBxyS5AxbOHtled4JDFUs2Ga6709ZHs/+EaOHiHh59LWTu
	1Snjn8rQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jz5ec-0003Pd-Q1; Fri, 24 Jul 2020 21:54:58 +0000
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jz5eZ-0003PH-Ns
 for linux-nvme@lists.infradead.org; Fri, 24 Jul 2020 21:54:56 +0000
Received: by mail-pf1-f194.google.com with SMTP id w126so5838310pfw.8
 for <linux-nvme@lists.infradead.org>; Fri, 24 Jul 2020 14:54:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=t15taSB6K9sfXPu6uqHtGy3WZmNVaZpCeSZahDtKNTY=;
 b=j3CtIFh99OiZ5AZoz/bblbizSFN3iZyBdtNi2t6yzK3t5cGQoc7+E/KrawhIGo5WT0
 e7AH9jCC6awEO/2BWOXdg3t8K5QzRy0RjOyBukFTIjXf5iRylBFas7Wddx4Wm2tUfktz
 QyL7ZXDcg1V1WfrKHdjn++Qsgk94JKeV3EImFR6xnCsufCaOy4Edg6S6EySD2V47KnJs
 CuF6pzqdk+5MxUzA9i9dY6+AqJDrUMazsGixb364KshpelWzmUy+vd+GC73FwvC8fYFQ
 QxUzf5bQOkQD6m1I5Odn+y/BGbb58apM77OCMi6XmA9LmNCyIcWkr/dPaKCSctRGlr+9
 wHiQ==
X-Gm-Message-State: AOAM531NXybNxxRAonlqSl2N3d/PFCQakKiUxGUU0wiH/6Mrwj8WuBbl
 jPh/Gg437xpqQ3AKMF9v9lrrjkL4
X-Google-Smtp-Source: ABdhPJxrAD+Z1oDT+o4PRC7Aa0utwuo92Rjnti13GJFkqmr0TTqCUssd5kHeN3ZCgXowZL/eN5y5xg==
X-Received: by 2002:a62:d103:: with SMTP id z3mr10121773pfg.317.1595627694189; 
 Fri, 24 Jul 2020 14:54:54 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:ac47:9fc4:b59:66fa])
 by smtp.gmail.com with ESMTPSA id 144sm7565112pfb.31.2020.07.24.14.54.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2020 14:54:53 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH rfc 0/4] improve quiesce time for large amount of namespaces
Date: Fri, 24 Jul 2020 14:54:48 -0700
Message-Id: <20200724215452.26401-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200724_175455_821178_46F5B063 
X-CRM114-Status: UNSURE (   8.87  )
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
 drivers/nvme/host/tcp.c  |  1 +
 include/linux/blk-mq.h   |  4 ++++
 6 files changed, 59 insertions(+), 3 deletions(-)

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
