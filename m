Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA65C433E6
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 13:31:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7EAE23A58
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 13:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7EAE23A58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rffs+WYVkQ6GiJwplZ21cQCQGyTw2W6PkxL9tw3ww84=; b=GrbcnprgxoNOvHSofRw2MNEvht
	25hjX99JpxHU67EC3FH2+9HunJ/sPaQNoKFNVkvw0VZqPgWHITR9ys1ppw/yfAmTnOljl5xCEsMo1
	33GRu3AC2rQNnRH3TuqgrrBGYgicgVjEX9utmBr7l3W/n7nxdkaVyVZcI4jYZIWejNdAUAR1KPXu9
	AHbGlS97UBZr11js2iP/C5/mih02RjbxHR4NNJ0v4dLpFOPGTl1oZ2YMQJl/zzLqf7deMs4EYcOTd
	R6QtVStxapbmXtYSEzox+bt5DvWF8KQ414tBUYhhVkXWU1qrToIFjPoE7YYLyrdO2P1nwejPRJw3V
	vmAXRmaw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l02ih-0001Rt-Kf; Thu, 14 Jan 2021 13:31:23 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l02if-0001RF-M0
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 13:31:22 +0000
Received: by mail-pf1-x42b.google.com with SMTP id x126so3334337pfc.7
 for <linux-nvme@lists.infradead.org>; Thu, 14 Jan 2021 05:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=4H9YjBNMVAROXOnZO8WHitqaBFbRcp4EDhjK1fSukvY=;
 b=oawDNDbI0Cv4ZxNVB9yUvKSwHwJbiVftbMZqPaaOzVffNQtgYgfFPc+oHdwB7Nom2d
 GB9WUbq8MeE4lQWHQbcwlrQ2Agkm9v71vWhzW1YeJx7tDWBKJbpmFpRsAq49DC/QluNG
 n1wZvkb9DvK0yr5O4Z2Q1BIZuVuxjuc7y1GJWboiIWCqlgovKeaUElReKfIFJm6IFX73
 Tne1n7nfZ6H+C3BfFy7Im6wdexfM/IkgtyRvJ1KsyM/41wZu4yESvRZwSC86Vbym89cE
 FrqAci4FrHJgbRNjIii7ad74OPVK31l/1dxjr7eVlrw5N0iDcv2bB8109HnmmH2RE4X/
 mtaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=4H9YjBNMVAROXOnZO8WHitqaBFbRcp4EDhjK1fSukvY=;
 b=if5zkZwtAA/p7TAQt2+zi/Mq7j5jTfEl/TpqbdhxTm8S4igKwOKe84UtA9gUuyN9BH
 SaeZQRSF8NyYUyuXREKZl4XbZjCFS50VYNLy9P/G+lL2FkM3Omxh7jWRx56eLIJ6FMIu
 eefPBeOvAqWk5+wR6PHjqTKVWj0NlnKjZhuc9+XLKwBNdNDUcOpO5kU/OeEKePu+djja
 bPPdx93AsMwfE7HGSt1PBIuXoEyRe1WOCarci+xFq7mXu8M2wO4X3uX4VruUwtuKXHpF
 YjJRCeuy346VjJt6g7xAn8JrL/cfRMAsBzomYgtxOGas0Rve5Z6C/1U7VC2+Xt7YJyOz
 JPpQ==
X-Gm-Message-State: AOAM5302NKBEg+vaMv9zUOJZDVLwT7XImWBQleV41k4x3vAHhP9x9gys
 12gP65Im4Wq8r4Rmr8CsapTSdRl6/Z9njg==
X-Google-Smtp-Source: ABdhPJyzCPAJKhGVI2JOzQVQavstdjr8NGc2smSBEO8pMsFK0hdAHZnXQO3TBCsInFVdru1kHFw+mQ==
X-Received: by 2002:a63:74b:: with SMTP id 72mr7618105pgh.4.1610631079145;
 Thu, 14 Jan 2021 05:31:19 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id gb9sm5549860pjb.40.2021.01.14.05.31.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Jan 2021 05:31:18 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 0/3] nvme: fixes for command retry
Date: Thu, 14 Jan 2021 22:31:07 +0900
Message-Id: <20210114133110.20779-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_083121_925448_B26E07F5 
X-CRM114-Status: GOOD (  11.97  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello,

Here's V3 patch series for Advanced Command Retery Enable (ACRE).  This
series enables command retry feature based on a flag introduced to nvme
controller instance in this series.

This patchset placed ACRE flag check first than REQ_FAILFAST_* cmd_flags
checking.  It makes Set Feature for Host Bevior in reset_work more
meaningful.

Please review.

Thanks!

Since V2:
  - Update commit description more informative. (Sagi)
  - Split [2/2] patch into two patches. (Sagi)
  - Fix condition to return COMPLETE in [2/2]. (Chao and Keith)

Since V1:
  - The first patch has been applied (Christoph).  Removed from this
    series.
  - Update the last patch to take acre flag from the controller
    instance instead of module parameter by updating
    nvme_decide_disposition().  (Chao)

Minwoo Im (3):
  nvme: check all retry delay times in Identify Controller
  nvme: introduce acre flag in nvme_ctrl
  nvme: retry commands based on ACRE flag

 drivers/nvme/host/core.c | 18 +++++++++++++++---
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
