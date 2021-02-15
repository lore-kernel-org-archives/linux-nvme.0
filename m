Return-Path: <SRS0=Cnjr=HR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD898C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Feb 2021 13:06:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A33B64DEC
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Feb 2021 13:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A33B64DEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SkRlV8Z57lm3QpYS7sgYKxZsCedEwSX8Zwd2HpA3SEc=; b=WYS+coSlPqeExnT+DAnW49d+/k
	lS9VmRBEIUJtoPkxDQhbXM1vw1aoBt3lCl1g1ylmZadq7mUFz5GPtx1zzC6eiBzcfbHhR67QrcCnX
	qrsfArLO2nGYlndIhv9b/l+4OehBoHJjUoj5e/cQroxVhcOyIzxts819ibVNIIrmB3fsZ+hYUB24U
	9DGf1kjOmrC3lwP8/ArNrpZgHBAck1zUREUDCH8ME9zK/hyFdCshTlMc6g/t7AZ1iPt5MpJllHJnQ
	UvPBgyKzSEnrH2XltfGuicyYZOJ/ITbbLpqMN1OP54o1hHLcslKEkczC1NrhYbqXcMJ62uEQ03srr
	PnrWuGAQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lBdZm-0006hV-Dj; Mon, 15 Feb 2021 13:06:06 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lBdZk-0006fh-1L
 for linux-nvme@lists.infradead.org; Mon, 15 Feb 2021 13:06:04 +0000
Received: by mail-pj1-x102a.google.com with SMTP id gx20so3902249pjb.1
 for <linux-nvme@lists.infradead.org>; Mon, 15 Feb 2021 05:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=i/fS4Y3Otvx3oWyrxi4GU369s4aD1jUc3wRSqdU6+3A=;
 b=s5GmOaeXE9N3/iWrFnvPeI3wZPIzktWHKFXqlKyWz23bxn4zRODJn7g7+q8TsnZl9J
 JqQSSJHlte+EOFbYdbEJQcFxw+CronMIwbLjnlAYoY8zV8nxVAD7MKA9YFOZNq2eM2hF
 ZgQ1O27bwTa7mBtUCJUKqMrBlRxUwHIhR0lwH1ZbwOLLU6ye9g30PMksgvS4bTmKTyQv
 6UoVW7u5agL7Z48SVkCJJ/hDcb5TkR27mDBjpC7sWBoLC1xPsRjjc3ChdSNDfmJVQtE9
 0eCG8FI5ZvdgZVP1xP9weN+8bu1zvqsZI8guo5zdjNbyjb7lZrROyTH5jNgQb8uy3p6z
 Y7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=i/fS4Y3Otvx3oWyrxi4GU369s4aD1jUc3wRSqdU6+3A=;
 b=iX+qzp2Ltv/4WqgFCVTCUExy74k3Qtbzi4iusTxu/gIReB0eCVZ436S0oGR2TJlE0V
 02K9cTmpd2aqv1AOYKaXMHNE8HGgM/gTus8cRLJwS40BzRp/RPpkPAazTwAb1l6hAcEp
 oXt7Zqghe3eeNJo/6mHywUQeNs6F3EvdLXDbsNQiwWBIA4rSBYjHaZlnOSFIo10a1cuL
 NR0Uw5Ke+TPB96aspMptfiwP2jqVet7b0PGAW61Te3M9X7wh6lxMteK7wbtt69UUQMnZ
 EZhBboIQSTsudP9O4Ewy9mkz+AYzkiAg8X8GDEljB3HA0hFYh+Ys3b+aVKUeexj9HzN9
 osuw==
X-Gm-Message-State: AOAM533IIGqofh4jBVasVgJWDFgDABat5fjV/xg+coosXtXCFGjIXVdc
 kkbmo4tgavf8iCyamUCdtypSpYnDBBuPzQ==
X-Google-Smtp-Source: ABdhPJxzsz/6ODrrwEu8xDi3TuvD7k817Px2DLDI/YXwYBPVGTmv7/XXGQjaP+IWBWZry0MTWguZrg==
X-Received: by 2002:a17:90a:1b6c:: with SMTP id
 q99mr15821219pjq.137.1613394360346; 
 Mon, 15 Feb 2021 05:06:00 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id q13sm11334490pfg.155.2021.02.15.05.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Feb 2021 05:06:00 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/2] nvme: add command retry driver control flag
Date: Mon, 15 Feb 2021 22:05:52 +0900
Message-Id: <20210215130554.32387-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210215_080604_125963_B8C59874 
X-CRM114-Status: GOOD (  10.91  )
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

This series is to support command retry for passthru commands via ioctl.
This patch introduced `driver_ctrl` flag to the passthru ioctl command
structures by replacing the existing `rsvd` field with `driver_ctrl`
flag.

This flag can be used to give some control flag to the driver from
user-space.  The first flag introduced in this series is
`NVME_DRIVER_CTRL_RETRY` to make command retry-able in failure case
without DNR status.  (And of course, in case it's not a path-related
errors).

Please have a look.

Thanks,

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
