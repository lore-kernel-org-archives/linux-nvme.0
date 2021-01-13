Return-Path: <SRS0=mLmp=GQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200F3C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 14:36:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5DF623432
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 14:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5DF623432
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MG0KGuymwZm1e6ofM+n8oxhk0EgOvMVQMY9ajK8+/7k=; b=T7ZIKWEKQzLs/ih1GeHNOD8WhD
	LKlQvMDE/DUfwz7UwwdxbbXj6opQtBVWWfV9Js/9e7zcNSC/mksq6NDVIGE4vSS93sRI5UbTW0u0U
	yeFxkRYU3OKY7iUnqALnmJS5v+Pvk1bBiEydSOWhLSElHMXJcYMoxrQPvf3X0BfJXTbd7ywW8gRsS
	Qkq8fLKkV5FWMQqkoPRUaQTVe7TDc3PwPRMJkujGKrMm1j+4jsu2Dpx4iq71mdHQ4Q6xxYZZkPfer
	3SST/SSA6xAQbK5MTJlhoE3fhYPLXg7HHjmGel5jzPMw3JXJrZHU6t2MF/YmHgp2VixdWTA5Nv1aU
	xsTO9yUg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzhFY-0000mG-DU; Wed, 13 Jan 2021 14:35:52 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzhFT-0000jh-3K
 for linux-nvme@lists.infradead.org; Wed, 13 Jan 2021 14:35:51 +0000
Received: by mail-pg1-x530.google.com with SMTP id c132so1619746pga.3
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 06:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=/TlnvLx7ddjAC5ZsJ3fq4X0Ew3W76LHWt5ikhRTYZcg=;
 b=SqIVPSa7ld8vacdxcjMGPl8vU6r8fqnPxOWwK3mdg61wZ2g7mLI9XtIqdW0jhNdH+9
 021l5lJQZLhhDP2hZiIooKl+8xFa5fk408q7bFNmdnFVG7LNNmQpUXqRdFQeqdgub7+L
 3RbkkStmIzU4GgQlSjUlwo28I+oD7BI/MWlRkMsgLzFFHyI7PvgXQ7C2JbIXeChjPhZl
 CuDbCbDwAG0rQ5Ky8uKOnImC5VAeAQTsrW5Bd7ihwOQkuoHymSK9folsMJXf1x2PohhL
 AAGDsKRrxnN+0HdUcior/vfaLJlRWwLu1aHSGFcGmASgb0lbtrbPGi8BfsQEvpV5End9
 61PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=/TlnvLx7ddjAC5ZsJ3fq4X0Ew3W76LHWt5ikhRTYZcg=;
 b=RdOvVWVMMs6LdsQ4yFvuXhKnIbicORGr/+2Lq4p8S+7oMTkWLcojgNgfOszztTQpx1
 vtE+CWlXrm7ordtzcDkk65ZurlqF99U7DZIb+fbb0jqL3PPJ0hQJ4Wn3Y/xZfktudIX7
 cVyjifQaPZzp0YStdCm/6Ed3ho13AJl/zEdDIVCxNiqC+RFd41r+5iPDNHjSjcpPSSdz
 cX5wNyliczjLATjWATSLMsq5wn+4pDw3fICmjzaT2eSqn415jdqFz48mywh6lW8mwjTX
 NX3W1+3k1OdV4+ULwi3463idGcolS3GOIincD1evtedrqeaycvb7bDbDcAHo93cQ2Fg0
 /kBA==
X-Gm-Message-State: AOAM532xXATE3L5wdvPajEJ7WUc7hEjhNLN/qF7ezcjlaWujsO6DAJRx
 KP/ytiIv9CNH8tB3VdWNz5z5oQ+EvppsSQ==
X-Google-Smtp-Source: ABdhPJypBfRtX26fQU37uvVOHqmZ2nBLOW3QwcY/MrTfkfTZ9klk1KcvlerY2/6OGQmRU7S9if58WA==
X-Received: by 2002:a62:7f4c:0:b029:19e:23d1:cf0a with SMTP id
 a73-20020a627f4c0000b029019e23d1cf0amr2365473pfd.67.1610548544526; 
 Wed, 13 Jan 2021 06:35:44 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id i13sm2914431pgd.32.2021.01.13.06.35.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jan 2021 06:35:44 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 0/2] nvme: fixes for command retry
Date: Wed, 13 Jan 2021 23:35:36 +0900
Message-Id: <20210113143538.554-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_093547_191348_E62097DE 
X-CRM114-Status: GOOD (  14.23  )
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

This patch series is V2 for Advanced Command Retry Enable(ACRE) feature.

The first patch checks all CRDT(Command Retry Delay Time) [0..2] to
figure out whether CRDT is configured or not.

The other patch has been updated to take internal flag in the controller
instance instead of the module parameter which has been posted in the
previous series [1].  This is based on the review by Chao: Thanks Chao!

Please review.

Thanks,

Since V1:
  - The first patch has been applied (Christoph).  Removed from this
    series.
  - Update the last patch to take acre flag from the controller
    instance instead of module parameter by updating
    nvme_decide_disposition().  (Chao)

[1] https://lore.kernel.org/linux-nvme/20210108144659.7126-1-minwoo.im.dev@gmail.com/T/#t

Minwoo Im (2):
  nvme: check all retry delay times in Identify Controller
  nvme: retry commands based on ACRE result

 drivers/nvme/host/core.c | 18 +++++++++++++++---
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
