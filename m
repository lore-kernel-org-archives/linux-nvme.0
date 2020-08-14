Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CB8C433E3
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 20:42:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0FA6206C0
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 20:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KnjSOUGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0FA6206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EuH9VlDxFuS6yTwYLHCh/ARcuXJQgIj1ZpdWbmt1+g0=; b=KnjSOUGwvSEGBkKmlRqC+TSGX6
	A/b61Y+IJ9+0TCfqkm4b2m73jqJRxh7ugJwAGKCTPS3wSrhGceIFUVzGAYlEsYfxMWnF0FeY6Lrju
	BwqoDpZWUGIVrRWAZnESEkbeeABj+lnhihhu298r4cXNlpny8cbWsYhGoP6Ak0+JqpOlCChb5Kypn
	pDloz3IKvyw4zXhc0AMzXdhzWHuU4MPkg0dwO4xpsYYdpng6Zu+fO3l+sB/D6vscsPVux5IhsuPHZ
	vi0a3ERBgrXeQVuUPaAWufRMpnT7vbenH742/NuE8jnY8AD0iZBKiSAtyz7TNCKu4NR1V++FRsLAp
	My4yqZtg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6gXG-00036F-PY; Fri, 14 Aug 2020 20:42:46 +0000
Received: from mail-pf1-f173.google.com ([209.85.210.173])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6gXE-00035t-2d
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 20:42:44 +0000
Received: by mail-pf1-f173.google.com with SMTP id x25so5120891pff.4
 for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2020 13:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+W4KnhHjLq7M/e6IoNDZ/KmR9EwAiayQgo/OjvzCfpM=;
 b=RhkDgg1Bym856N893FDtSwa1saqQRfVDoBjZF2gLHaLX3avZRNafQsKBfaeS2/5t5D
 NQ2m47ujLeseKOJvDGkGrmVo9hxvwjM4zMISd9NaFMIcDQSpIw+H5aYssYVkWOxC7kas
 0g2LiLT5JLD8yZKfrNrnRHNxBKGpRda7VdsibvNP+SGhbVaj0qdIlD/0v/mZR1hvyBO8
 ToOK6iBb5fKUYzDNLw1/4vihc4o8vqSJhx7Pw4MTbbSHsc3z/pT8CvV+aYFUn7qV29Ag
 QQKIvO8F4HLkpQfbMnaRn8BhQyQAyokbJR07+N2nhbqBh0deyl9cSWyGsCnGf5/pgl/L
 x5dg==
X-Gm-Message-State: AOAM531kJGlk23WqVH3ozllovuZzVA5a65azxeRLWdAiDTXQGS+CgI1z
 H+5gRfyi/69HTNnF8oVkS7DngHcpndWa8A==
X-Google-Smtp-Source: ABdhPJzfPkGDcECHTKWhcXzjVWkbxlQzGL115NFmctg0BPPTS+YvNC5Dlg3nicN3qZqF6DvEIjTSCA==
X-Received: by 2002:a63:8f41:: with SMTP id r1mr2737007pgn.375.1597437762298; 
 Fri, 14 Aug 2020 13:42:42 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:51f:3472:bc7:2f4f])
 by smtp.gmail.com with ESMTPSA id
 l63sm9141125pgl.24.2020.08.14.13.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2020 13:42:41 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCH rfc 0/3] Fix a possible infinite loop when iterating over a
 discovery tree
Date: Fri, 14 Aug 2020 13:42:36 -0700
Message-Id: <20200814204239.751787-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_164244_170965_2CB5D716 
X-CRM114-Status: GOOD (  12.42  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Today we can easily get to an infinite loop if the discovery tree itself
contains a loop (via referrals). So if we have a discovery controller
A referring to discovery controller B, and in turn B will also refer
to A we will never finish the discovery loop.

The reason is that we blindly connect and discover to every discovery
log page entry that we find (i.e. referral to another discovery controller).
However, we are not able to detect loops, and we just continue indefinitely.

Fix this by tracking every controller we are connecting to, and then
if we see a discovery log entry that we already saw while iterating the
discovery tree recursion (or should I say graph in this case).

Sagi Grimberg (3):
  nvme: add fabrics discovery controller default port number
  fabrics: move connect_args extraction to a dedicated routine
  fabrics: fix infinite loop is discovery recursion contains a loop

 common.h     |   3 ++
 fabrics.c    | 114 ++++++++++++++++++++++++++++++++++++++++++++-------
 linux/nvme.h |   1 +
 3 files changed, 103 insertions(+), 15 deletions(-)

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
