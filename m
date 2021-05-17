Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C69FC433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 18:00:27 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3715E611BD
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 18:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3715E611BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uvjgCC9+yQCu/eBArx5pBQYNeazxkoMlsDXGIDvMIwI=; b=TNGAwicONoGowW7kRl6N6GGts/
	RWxBiw1P+OB9SBz2JomzOwe8EVN8XBLOrflbs3EtuRWfrRAV2ZBH7uIN8QiZ6/n7nuA+pxzU4lc2I
	es/6LorJMuXKRi7BsL2TM8oODuFyoioC8EJgF85Fvn2ymky+82mkVnCY4HNECFeQ5e65Iv9F88fWi
	KhUeOCVe0cT6fhYmZVAFgLqCDRBcmHX2Tblfs3Hao1V0N36OeZUtwGy2DvTgr6vo4D693j9Z3csyB
	NBRhXUNw5p64qdcTI63ZOTmN3wiJKGw5lf/pOasHJNpokbE8IwfJtPEnzC1wR8MbPO+6f+EGskxpo
	gUmKJ3MA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lihXC-00Fjr2-PC; Mon, 17 May 2021 18:00:06 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lihX6-00FjpO-VX
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 18:00:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=55UQGHLd8TZAJZJEMw4lY31e3x3q+HMkVRLMOynLQBY=; b=xHYW9OBVEYvfz/EHIno4CFhJ4D
 MRsQzLe9M3eL969WQ24YWXHeOObQsKpNEgmaLoBgsTTLOa5sNN9+3OYze++kbSQ12YrxK9rf8Sl34
 2/6n315T/2gLFK13MQ+DjMGkWa47Vw/5xGwhvncM9AcZzDvkyPswoIr2SRy/TrtR7zrmBj7QF8m7V
 7YdGCufn9gyBG4mVjDsXgfzb8jS5N7F3fr5FWtQtyiat2Uo04gP+Y0sj2nvoZT1kkJAmW0dflZvh8
 TTIYqEkcGJt1d0vkIoOSWAEsIlH5xemQTp3Op22vSNqAXIZ8ZBMlLs3dYl2Ixu2CTjjLg2TpXtpF9
 vncFUdcg==;
Received: from mail-pj1-f44.google.com ([209.85.216.44])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lihX4-00E2N4-I8
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 17:59:59 +0000
Received: by mail-pj1-f44.google.com with SMTP id
 b9-20020a17090a9909b029015cf9effaeaso43008pjp.5
 for <linux-nvme@lists.infradead.org>; Mon, 17 May 2021 10:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=55UQGHLd8TZAJZJEMw4lY31e3x3q+HMkVRLMOynLQBY=;
 b=b1bqvbAxon06aO6sd0untKnVq8TfLCmp00dHc1Te87aigDeQEHM1G1vvH9XKWMUvQ2
 qWHXoVQuz21LkKa0eU+1qjGm/bIm/34b5CsYGOywwBXVr8hh59WZdXKvZG6TNQV9Tv5K
 IPNF69YNNKwf5sxSc0P/gfC/FG/JnDkp+E956CrQvYfAzGOtc5qRcs43osmti1vyLNXc
 bLrH8vzMiBqN5c5bH5QVa7OS8u9ebFT8J7dMznJQSkhp9fH8eYXLuuayqjWbnQ6zuy4Z
 7DaGMjqtluvtDweyv7+B4YM0Z1sQeyBaqNpsWdIkLvAcPNqu3cDYvTYX5WZt39bKQo+g
 h8Cw==
X-Gm-Message-State: AOAM533fQG5MoKFfbXIJIEeOivruaQeho36FpEUkxvl1qWVytnl27CVy
 /U2rTdaZn0CyhjvqrY50Zvl7BwJUvRs=
X-Google-Smtp-Source: ABdhPJzPcwtpJuKqQ4V1wglr0/sNuKZyU9Lz5FbbU7YuFVp8ywIU0NzmjX7WDzWANjv8Te+vCIMKpw==
X-Received: by 2002:a17:90a:542:: with SMTP id h2mr355389pjf.82.1621274397543; 
 Mon, 17 May 2021 10:59:57 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:e600:1f8f:de79:17f9])
 by smtp.gmail.com with ESMTPSA id mp21sm97196pjb.50.2021.05.17.10.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 May 2021 10:59:56 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Cc: Daniel Wagner <dwagner@suse.de>
Subject: [PATCH 0/3] nvme: protect against possible request reference after
 completion
Date: Mon, 17 May 2021 10:59:52 -0700
Message-Id: <20210517175955.602725-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_105958_615609_EDCE9D01 
X-CRM114-Status: GOOD (  10.98  )
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

Feedback is welcome.

Sagi Grimberg (3):
  nvme-tcp: don't check blk_mq_tag_to_rq when receiving pdu data
  nvme-pci: limit maximum queue depth to 4095
  nvme: code command_id with a genctr for use-after-free validation

 drivers/nvme/host/core.c   |  3 ++-
 drivers/nvme/host/nvme.h   | 47 +++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/pci.c    |  7 +++---
 drivers/nvme/host/rdma.c   |  4 ++--
 drivers/nvme/host/tcp.c    | 32 +++++++++++---------------
 drivers/nvme/target/loop.c |  4 ++--
 6 files changed, 69 insertions(+), 28 deletions(-)

-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
