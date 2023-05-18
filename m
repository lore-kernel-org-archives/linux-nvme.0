Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A071AC7EE25
	for <linux-nvme@archiver.kernel.org>; Thu, 18 May 2023 18:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SYvTQXRQAt+UhvcSHAlu/KMmCra1pWnhN1cXvNrvjIY=; b=f+Xzny9xtwpzBePA14YyiEsIqn
	C77pLZY8aEEYIvt89QRAD2briDe0GarEI7ypQuCk7eH289Xe2pY/k6gbwuUpAB3Uu0IJjeDTtSrwm
	MGdsAJgUzsIMqcNc0a8TrELDxH8TxyvbffgMriWt1TZRS25TqBJd+hsinzpS458GHHv6c0pyl4+AP
	/97tR+hExWK3d0W2hEqOp2TxztAUDuHyeUNvODuWpcbYlINXJ1WA20/J1/OblDiQStA53mBQTek11
	9vKrKENUEtnW8rE4IydroonppPktNdHugAcaY5YeJLOXPxNluKQkGvfYjUP3pPndVz1JUD6zkTSDH
	P3Wpq6sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pziRl-00DpOG-1n;
	Thu, 18 May 2023 18:33:53 +0000
Received: from mail-qv1-xf68.google.com ([2607:f8b0:4864:20::f68])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pziRe-00DpLT-1o
	for linux-nvme@lists.infradead.org;
	Thu, 18 May 2023 18:33:49 +0000
Received: by mail-qv1-xf68.google.com with SMTP id 6a1803df08f44-623852980dfso11113886d6.0
        for <linux-nvme@lists.infradead.org>; Thu, 18 May 2023 11:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1684434823; x=1687026823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SYvTQXRQAt+UhvcSHAlu/KMmCra1pWnhN1cXvNrvjIY=;
        b=f2IViaBOIZkfC/xt+FzMDYmK0GcHUclU+ccxI4N7Bwbj/TfaDusa8sTDq9Kb2qBhxd
         tmmGs7caiNuhgtvERhlyiC32zp5vCovLH0pf6jGJzQZzHvu7DPVTDOserFtr07K6dMZ/
         q/E9FcFAOLWkVtDigX07+JV5VrrH+lf2ZDF/TtbV+T18Q44gARWK5QQndlOBuGoSHQM9
         WrhPz0MLI0vyTCumXH5fDnehVlrwHWB5WbAQk0hCdutoxbIzTgJVxyEeOborZPOfKq0T
         alN23w4UA9c6VCnM7vpUbU5wVmgoAq+FBiPRU/XnIQQ1RxnO13a1N7o7QFCSKr1MGxfK
         TGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684434823; x=1687026823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SYvTQXRQAt+UhvcSHAlu/KMmCra1pWnhN1cXvNrvjIY=;
        b=CX0VpJFItYsgG8B1QcVyDQPkh/IdE9uoFxjiKF3JZMQp9Sq0A+iQ7K+kROOLPjajTR
         PD+FHDch0lE/AaWBdOhhzdz1xKRiPh0fYNqGvpHjC1g9HiMmCmkMa4WGHdOUGZnBy3Hq
         X7QS2ASCFrAOrNOE00SZz8oI420voFiOe2ubBMgmOOAWbRS3YeHC5rkrngxgHcMVqldv
         yVkvF4mVjZmaxdkiDwX+scYFO6RqbhJlSsV5uAxYB9uGGBWvJfNdjVK8Xm4uyF7E26HU
         OezKYsCZ2fFZgJkePk2S+9/aFGOcmdSrURn6Qmqn62Wp5ZaXiZnEX31wyhFxLE2vnWdQ
         XbBw==
X-Gm-Message-State: AC+VfDy9VBoL/rfnu46QsezAZI+kC+jRLk1ehP2XgxPhWaVlR4czEZuZ
	1ihhZwy+NsJ4PGh7mBGZDgzRDd7gEKmn2IErkxFAkOrwyadSyZVi/I2Tyov+7LByOg==
X-Google-Smtp-Source: ACHHUZ6r//CAsP++vDugln4YmMHKd6K0qjOEIx8xvfLBcydCS11Y7J6ckucO60+olnZH/Kjh3EhoZLntlZQj
X-Received: by 2002:ad4:5766:0:b0:61b:69b2:f95e with SMTP id r6-20020ad45766000000b0061b69b2f95emr978576qvx.43.1684434823729;
        Thu, 18 May 2023 11:33:43 -0700 (PDT)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id e25-20020a0caa59000000b005ef5456785esm86956qvb.58.2023.05.18.11.33.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 May 2023 11:33:43 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id A538722128;
	Thu, 18 May 2023 12:33:42 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id A10EBE471B2; Thu, 18 May 2023 12:33:42 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
To: Costa Sapuntzakis <costa@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@fb.com>
Cc: Uday Shankar <ushankar@purestorage.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH v3 0/3] keepalive bugfixes
Date: Thu, 18 May 2023 12:33:08 -0600
Message-Id: <20230518183311.3224326-1-ushankar@purestorage.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230518_113347_467430_0F62448B 
X-CRM114-Status: GOOD (  10.18  )
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

While reviewing the Linux KATO implementation in an attempt to better
understand the current NVMe Keep Alive specification, we found a
few issues in the host implementation that could contribute to spurious
Keep Alive timeouts being detected by controllers.

Changes v2-v3 (https://lore.kernel.org/linux-nvme/20230424232225.1975793-1-ushankar@purestorage.com/):
- Patch 3: add a warning log line for long keepalive RTT

Changes v1-v2 (https://lore.kernel.org/linux-nvme/20230417225558.2890062-1-ushankar@purestorage.com/):
- Patch 2: fix indentation, set start_time even when stats disabled


Uday Shankar (3):
  nvme: double KA polling frequency to avoid KATO with TBKAS on
  nvme: check IO start time when deciding to defer KA
  nvme: improve handling of long keep alives

 drivers/nvme/host/core.c | 41 +++++++++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h |  4 ++--
 2 files changed, 40 insertions(+), 5 deletions(-)

-- 
2.25.1


