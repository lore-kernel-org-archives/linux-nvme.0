Return-Path: <SRS0=mUlG=GL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CBEC433E6
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Jan 2021 14:47:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A9BF2396F
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Jan 2021 14:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9BF2396F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JaKxuBg0okUdPNPkORES1Z7HMA+OBuFoc4ac8xrtTYc=; b=Zb63ykaSizEFQPJtcJ8sRPHI2z
	0toJbXqIUjlOMyauei8R1E32tEUJjwC/ni/9e/r3PeYUDGRyOOOxgIC9GPiYIw/w7VH4qjXKJrqRh
	/Y1/NQLMoWif2/Rm5aJQmTGDW1WKnLJ6R5jrFQ1XOli6DXSLHgR5MxgvkTSQumNrn6a1S5oKVyzQ3
	erCOFhtPo2bnG5SMLR8Mgbxz+GOhIGM8BvcO+4sIBobXbT7Lgl/3Iz4evOcExkLGCM+yo21zWaFLT
	Xg9+rsD/PUfgnSA/dYiYW+EOWMPPM9mB66Jm6NFEdwvHldJROrBMVajI3W6yH/WJheyXXihgcU6Mv
	9hGyzD6g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kxt2p-0003Fe-Aq; Fri, 08 Jan 2021 14:47:15 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxt2m-0003Du-G3
 for linux-nvme@lists.infradead.org; Fri, 08 Jan 2021 14:47:13 +0000
Received: by mail-pf1-x436.google.com with SMTP id q20so3095692pfu.8
 for <linux-nvme@lists.infradead.org>; Fri, 08 Jan 2021 06:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=udFlHWWsYKd93Fj6eJVuxxKeBnR/PwNSLkPOVUbmbSc=;
 b=BCq4dUCln45cQW7Swh4kpfoJweOzsTjo2mgF/LYWkFbhxVmbtqHm4InYsyNm66F3ik
 dBLeR4wPckAwr0YuzbzDw/ZQWg4RDq8KwUrrTr0Hyrc8xraDu5FDUPpFTs9qdCemcr95
 clQFXP3nVjXmMJUZQkanqp/oJOWH3Ohz+ykjo90OAFWXL1TrLqPZf/plKerERCeaEtBH
 8RUeTZjvjKOfzVaWipPE2dd38pCaRXP7tebq4eBImuT7DfeJCz/ab4vcK/Qi5ID4M68D
 Vh4IZHTVY3DaGaaSgSr+sYYR+yyN7r934WbzamQMdoU+spvaMWZL3A1tt7f49JLI0EGN
 xbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=udFlHWWsYKd93Fj6eJVuxxKeBnR/PwNSLkPOVUbmbSc=;
 b=abzQi77ZsJ4jrVYoleb9Mu4Uiw8Rgnvvrfbi7a/us0jIstxLEEs3xus+nxn6bkeZ40
 7vC2ctYKUZTjB35AUsk3NcwKGYqywyrTfxC7em3gjmOZXWmficfQvSMdtowNCT7blKEx
 MBTuh979Op+TU0S7ss3B9FfiW5TcuoRiTaHTWYs1Jq1Ps2/6HnOxpOJM7lzd6KtNcYiz
 ceC0JhApYYluQQ7fgUZ/BC7I6ux6jwQ9S6ncpizwY1iYdM6MqjasFxh34yHCn20eXrtf
 hf+0asLOOWqcwLT/XAZ4sncyIXPhBprHjTfvPnGEk6yGRv+P+3za0ljHKgD/Sg84AGG5
 R3iA==
X-Gm-Message-State: AOAM530+j2iyTz5hWktKOL/QG7PpdYbYs3xrl7o/9fDPXktKFK1vqtSK
 6tcLoQqCWdqD5vir/ZsDhGZVIXDuXPsp2A==
X-Google-Smtp-Source: ABdhPJyQXw+fLCyJZvIcfzIvKwTJr5tq8P31Uo5DlIlHYt6Lt4dg195ENuPbWDYYhM6ksPZFrSyeWQ==
X-Received: by 2002:a63:515f:: with SMTP id r31mr7384741pgl.210.1610117228735; 
 Fri, 08 Jan 2021 06:47:08 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id w11sm9875391pge.28.2021.01.08.06.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Jan 2021 06:47:08 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/3] nvme: fixes for command retry
Date: Fri,  8 Jan 2021 23:46:56 +0900
Message-Id: <20210108144659.7126-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210108_094712_585614_AEF49F9B 
X-CRM114-Status: GOOD (  11.31  )
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

This patchset fixes command retry feature in NVMe core driver.  The
first one supports command retry delay for admin commands also.
Earlier, we only supported I/O commands and this patch made it support
for admin commands too.  The second one fixed checks for whether to
enable Advanced Command Retry Enable(ACRE) or not by checking all
Command Retry Delay Time(CRDT)s from only a single one CRDT[0].  The
last one added a module parameter 'command_retry' to enable the command
retry feature in this driver.

Please review.

Thanks,

Minwoo Im (3):
  nvme: support command retry delay for admin command
  nvme: check all retry delay times in Identify Controller
  nvme: add parameter command_retry to enable retry

 drivers/nvme/host/core.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
