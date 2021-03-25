Return-Path: <SRS0=zNYX=IX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E6FC433C1
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 12:31:46 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A79C761582
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 12:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79C761582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oI07KHSC2swHe7N/Kn4Oe5a2CuOK2QAyg92ZYJOb4Jg=; b=kJlv24EIRpqams51wO+2sdxHhy
	NbiMf//JlI6umeTxfbJpsQhx+xFA98RwVxjbOVRSXeMLpKy9VsnPO4wxer1aTM8UCZ4diz+VSbRyr
	l8LG0QlpSQ0Kkf769sag7m8mWnfgRtmLMkowgWorutUrbqszHSy0MHLF/FroVfU17AIcoHtSQDIQi
	gUvdyCN6POQEo9kFlJpQ2ORc8YpcUQD5LEWUzIwziq1V85QJmfJgRcl2rPCYSLWjzU8KOV1a1HbN4
	m3RI65e1a1IzG+FBsXPY9BF04fxtLJOb8ht7DZY+ZIVFHMxEiK6wrCePdVhH45AfNYLaPXuvOI/PP
	WWNgBkzQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lPP8p-001O6J-SH; Thu, 25 Mar 2021 12:31:12 +0000
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPP8i-001O4n-5h
 for linux-nvme@lists.infradead.org; Thu, 25 Mar 2021 12:31:06 +0000
Received: by mail-pg1-x534.google.com with SMTP id e33so1602950pgm.13
 for <linux-nvme@lists.infradead.org>; Thu, 25 Mar 2021 05:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=siU5lf8W/Lq43U3BnUaIsu6jotAeeDb8kMwQ/KEr8Os=;
 b=noa4UDE+S0BSEim5Oy/N6j66ZN2Xb5r4sl8enpsGQXiHE9GF5I2AzetBHp8ZUAf6h0
 pPa+ORy4a05NyqLxucZFFKubJA6vMk5c0aHUOTzGKl9WP/AiMR2zLsOOBugBjvXt6CM6
 46ryxYTM5rLxW1h5K5fPeEOwHsKsfzn5/tc6ukxXw3U7P5GMWrIYBTO/FXqExy8T1c+L
 Np2GuJ9DK6O5Sa0VSsGMYM1mnwFKPpGCqURi2DTEr026lWrxGSm9xwG8AEwTsPiBjv08
 xA/y7iEVDHReDIwyHAqE6RnH7Rj/m8s20bptDbh1XjwtFsNv/PE3VQIBeuOPQzWjzFGZ
 r73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=siU5lf8W/Lq43U3BnUaIsu6jotAeeDb8kMwQ/KEr8Os=;
 b=l9z9Dd3Iq7UzKtNqkaxF9xAKeX0Unr5ZGjjYguehliF6xvKeWyWQVz25p3VosAr+sE
 /9xkwgyvx59FYeGNY4mn1nlUWW5I0Dhgk3Couk9OgBOMDxpIUZr5huUGSlPStcGDYLBx
 lrimMUTXZxrz////gzuu0hDLtn1H4l9TYZPgEV/CZBI+uc5jJVuMu2qn0rheXSiObYQf
 vheSla9UG0+CUbzySeBXuMP7m6PfNIqLBoQi4uWysvSbNSL8wur7BJzJkbUv21Dm3qxd
 YixRrfcibCKSgxnb+AU+T/zw3mAwLcvv6/PlpX9Z1h19fLEnvqoxwwsn67yzTGkzv+J2
 2Pew==
X-Gm-Message-State: AOAM530zW53Jbo1RBoRX4OhgXWCjXwIwP4CoCgkog7HKoj08VAnynvZb
 l9HQTgbaGx343pC623KL1Gyw+Y2Gqj8+ww==
X-Google-Smtp-Source: ABdhPJxDu+O0GnY2tKv6Z0YWrsju9983R5RKriLrhPXPQdSiTBnPBxUwHnYM3BQ5xiYqum52beSxOA==
X-Received: by 2002:a17:903:31cc:b029:e4:bd48:c8e3 with SMTP id
 v12-20020a17090331ccb02900e4bd48c8e3mr9377966ple.40.1616675462487; 
 Thu, 25 Mar 2021 05:31:02 -0700 (PDT)
Received: from localhost.localdomain ([58.127.46.74])
 by smtp.gmail.com with ESMTPSA id z192sm5636832pgz.94.2021.03.25.05.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Mar 2021 05:31:02 -0700 (PDT)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH 0/1] nvme: introduce generic per-namespace chardev
Date: Thu, 25 Mar 2021 21:30:47 +0900
Message-Id: <20210325123048.94784-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210325_123104_512331_E3C023A7 
X-CRM114-Status: GOOD (  11.34  )
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

Hello,

This patch introduces per-namespace character device to I/O in case that
blkdev is not initialized properly.  Userspace applications are able to
I/O to the generic namespace chardev even there's no blkdev properly
initialized.

This patch is derived from Javier's patch series [1].  Changes from the
previous version are:

  - Update naming convention for the chardev exactly the same with the
    blkdev:
        /dev/nvme-generic-XcYnZ  to  /dev/nvme-generic-XnY

  - Re-consider the multipath support.  Rather than exposing all the
    path-specific namespace path with controller(e.g., nvmeXcYnZ), only
    expose head namespace instance in case of multipath.  Otherwise, it
    will expose all the blkdevs created.

[1] https://lore.kernel.org/linux-nvme/20210301192452.16770-1-javier.gonz@samsung.com/

Minwoo Im (1):
  nvme: introduce generic per-namespace chardev

 drivers/nvme/host/core.c      | 170 +++++++++++++++++++++++++++++++++-
 drivers/nvme/host/multipath.c |  17 ++++
 drivers/nvme/host/nvme.h      |  25 +++++
 3 files changed, 209 insertions(+), 3 deletions(-)

-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
