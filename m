Return-Path: <SRS0=nD3g=I4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C122C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 11:59:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04C7960190
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 11:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C7960190
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tUJSKvB2mvbXkI6Wr5ddbinrth2iU9ICiMew7zUhOuw=; b=EQs/R7vf2AIp4JhAnRdiZZ3h2F
	0jjgX4y6JwSuCeSA/OwL9Fl5SWYuWjGKSApGGxItX13KenRYKDQEmSpafvVAH5Lc3SsqWv9NSKVWk
	iCqUu/YxofRpzOyARNNGlZZHTd1ufLF+pEDuAWwgpVpVR1ADLMBZJKDRknECeVrqNOQn1iZFDnC++
	Yisqjiic5iy9y60CHmYUiOlZkJoaxuPMJoqp5dD1+OszNp3lDjvMkbu2SG5jMHHdwfnsdgtbzAnV9
	7rz2/An/WDVcYhnfaeB+42Bp8BpJIBpbw2GhgnMZofXLsdRwYeGJeCXNh+pW5I4ulngPMtXYn/z6O
	bGgc2EXA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRD23-003dWd-S5; Tue, 30 Mar 2021 11:59:39 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRD1x-003dVw-72
 for linux-nvme@lists.infradead.org; Tue, 30 Mar 2021 11:59:35 +0000
Received: by mail-pj1-x1030.google.com with SMTP id
 nh23-20020a17090b3657b02900c0d5e235a8so7566536pjb.0
 for <linux-nvme@lists.infradead.org>; Tue, 30 Mar 2021 04:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4eKRHkXJ6Am+4HxdI12A///kfZ8Bgq98hLV2va1+k/c=;
 b=Lx6SqJAG/ldaPN1I/EEokM1FnXS58g/mQmPPQsXpu2S1TODuSCZRupRfdt03l1eLzq
 PJmKKrcD6gBm2d9t+GbD7UT8PCcAY6lm/glEOaFlJsvOubJoV/GS8Ytvm7nPqnX1bAJJ
 Xhx4/JSJzKMkFsOTcwRZNANiNhDiWXcqEb3s62wtkPTFwLCEy7U3B708BPBsoe3yMD8n
 ifRwIcEIQ+CFbtE8KXNSUwTE3ihhiQ1SUiO3HUVfqk5Gby4cgQc7b9kzGWH+2+nvOr0y
 aT/WDmCjr0vv0ClzidMxm5zBvnwKFoLpbA/+gtBoF4ec+upCJZqta1E9rCSOx41/0SNX
 dugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4eKRHkXJ6Am+4HxdI12A///kfZ8Bgq98hLV2va1+k/c=;
 b=rIJ4JrlbnSNSdbRBhZnyj914P1oxZGbc+ZmpStRkfvA9RAh8qGW0RRij1DEXyokbGy
 ywrv2qCjEWrZ70LkH2NL5DKnm5Ro1jPUzyeWYxi0onb+41gdyjLiRt7qYo6WfQXrQIik
 tv1wUPwkHOnDisaIvYfTOjLDQ9FB7sAqQmqbJ9Tv6c6850lmIsF8cE871QQTvxgrSm6t
 XunJ8LEghlVm11BNT09nWhLj/lWSh1wESIUcB/6yAoSz/WrWxtK9ATgxNz/FHfUrhIIu
 GZ6dtcQxhBF2LJHquWCjB8WYofs/QkssOz9CkwWBC81W/YPjpuuGFt727LXjU7PVZLPs
 w0SA==
X-Gm-Message-State: AOAM532doeTB3q1eGRpxCArlHhtLRiJzRATZR298iMLNnpHLbXws5rA4
 so/686k0K05wHY+n9xqRFdM=
X-Google-Smtp-Source: ABdhPJzdgL8bpIUSGeXgitXIP2P28cg68fMHLfl6RJ86kJP+Cp4m2QpDL3gxjEfUt1MJGUplBXMRkQ==
X-Received: by 2002:a17:90b:e01:: with SMTP id
 ge1mr4070991pjb.117.1617105570615; 
 Tue, 30 Mar 2021 04:59:30 -0700 (PDT)
Received: from houpudeMacBook-Pro.local.net ([61.120.150.74])
 by smtp.gmail.com with ESMTPSA id a204sm20088284pfd.106.2021.03.30.04.59.27
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 30 Mar 2021 04:59:30 -0700 (PDT)
From: Hou Pu <houpu.main@gmail.com>
To: sagi@grimberg.me,
	hch@lst.de,
	chaitanya.kulkarni@wdc.com
Cc: linux-nvme@lists.infradead.org,
	houpu.main@gmail.com
Subject: [PATCH 0/2]  Improve response status code of nvme target
Date: Tue, 30 Mar 2021 19:59:05 +0800
Message-Id: <20210330115907.15432-1-houpu.main@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210330_125933_522484_53A5B5A8 
X-CRM114-Status: UNSURE (   8.21  )
X-CRM114-Notice: Please train this message.
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

This series includes some improvement of response status code.

Hou Pu (2):
  nvmet: return proper error code from discovery ctrl
  nvmet: remove unneeded code from nvmet_alloc_ctrl()

 drivers/nvme/target/core.c      | 1 -
 drivers/nvme/target/discovery.c | 6 ++++--
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
