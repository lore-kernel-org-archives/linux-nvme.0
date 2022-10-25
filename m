Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0F6C04A95
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 14:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-Id:Subject:References:In-Reply-To:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6inl2xUwbU0DfEDCPMZHsKdvYllmDmyCgz5ky/29DX4=; b=2w1a1cTsJhOe9Sii2siVd4DiAD
	ZWNJcgpdgCmoubvEUQ+iz4pSQquhWRjYvYRK1V0zBABwNEkPoa13ZUdqK6kO3oLYv6ksqE5K7YxHl
	c1I56ZRkJYN1pRFcPaY3if5A4vyfJBy4j+L87cha/oiqrgHmmxHu/+4wOj7jXCOed0cqPvUx11oW4
	r8eBVWfEihrDLSIIKnSz5EjNubi1dWcbzoABoZMsAIW28TMYncPFLxodQ2c+yDKfGLBEKUX958Yjf
	BBn9TBNJeK/gT9ItSlKhOLeHQGCuZOnePT7re5KipxnzYowPVrBHbnLgX1oCqU+gjhA+afMoU02WW
	xkzBRYug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onKty-005meW-KN; Tue, 25 Oct 2022 14:27:34 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onKso-005mJ3-9W
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 14:26:23 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9so870877pll.7
        for <linux-nvme@lists.infradead.org>; Tue, 25 Oct 2022 07:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6inl2xUwbU0DfEDCPMZHsKdvYllmDmyCgz5ky/29DX4=;
        b=KZDeeCxM9aUMHVmWF57+BUh0bmaeVwFv2pQip2mnYstZe6AtBtqcs9W8Vf0KF3gDq1
         WUAXi4XcwIVMdLLV46pQLGicLPWjghk7f2Nm41L6/DfWw+XQlk4AKVE4MutFVWLRm+/n
         zKJKGLilV3NiRTUbBR7eY0dF3sNeR4bgAYa3G/KiqkUQMVlYKd9MaIqsm3sYZHGIrHGn
         lyTRV+Cb0ndmv+D46DzAE7pE1PZ4Ifj1NnaJuXQ8KPqOmrC1G1OVh0Op6f1fpyZYxLZf
         qf+E3g/a//mAb/9dSUJ8BvYL0fuNiif7TRmoGvTs1G7tJp0v6ccWqPD7hJvjXR0Y+4W1
         JhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6inl2xUwbU0DfEDCPMZHsKdvYllmDmyCgz5ky/29DX4=;
        b=jVIaQZZE0u4SrF3ZBoOO2Pwi+hrkXQenxToRKfftpMPrdmWK6tsb4Uf5vwe2xV07pi
         lB4JEcI1HkANpZw6BlkarFYbX9v/mCt6Yh5D3Zu9TQmcCz6wO0WVpYNth3WkuKp4ty+R
         rjKwKSiiwb/BHU2U9q1kuCckHpovIZx3EjjfeTMDrCRHO/eOlAJ26u3q6IE/tssS/CKw
         0JLBErbFI9kv1r+os1+MVhJhGU5m55GweukKcuTSUzo8hsY676heQZCRLn3NKpNQeik7
         SBv6HN7c9IXgxxn2Hb2aktOdDC++H8mV9H1wVUjvAMMptVGEogS2IhCYjx3IuT62IPg6
         iAgQ==
X-Gm-Message-State: ACrzQf2vaeX3EsGKLOfnE6HG+okfZh4VYk0FjOpjH37InhoipLyWUHuR
	7N8zuH6FMcN59f9y837mHlKk+A==
X-Google-Smtp-Source: AMsMyM7ay7dDcU7gdgoJax3wbgJfZUZQsW/hxStAj2YCAbwHUi7QDnm7OQ+cno8H/fN6/Ix6ouJpjQ==
X-Received: by 2002:a17:902:c40b:b0:17f:9636:9014 with SMTP id k11-20020a170902c40b00b0017f96369014mr38258126plk.150.1666707979874;
        Tue, 25 Oct 2022 07:26:19 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q15-20020a170902dacf00b0018685257c0dsm1308397plx.58.2022.10.25.07.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 07:26:19 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-scsi@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 linux-block@vger.kernel.org, Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-nvme@lists.infradead.org
In-Reply-To: <20221018135720.670094-1-hch@lst.de>
References: <20221018135720.670094-1-hch@lst.de>
Subject: Re: don't drop the queue reference in blk_mq_destroy_queue
Message-Id: <166670797886.12575.5830280614420890136.b4-ty@kernel.dk>
Date: Tue, 25 Oct 2022 08:26:18 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_072622_363937_74B11EFF 
X-CRM114-Status: GOOD (  13.25  )
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

On Tue, 18 Oct 2022 15:57:16 +0200, Christoph Hellwig wrote:
> currently blk_mq_destroy_queue not only shuts down the queue, but also
> drops a queue references, which leads to the NVMe PCIe/Apple drivers and
> scsi grabbing an extra references. Fix this to help with unifying more
> code between the various NVMe drivers (and to make the code a little saner
> even on it's own).
> 
> Diffstat:
>  block/blk-mq.c            |    4 +---
>  block/bsg-lib.c           |    2 ++
>  drivers/nvme/host/apple.c |    8 --------
>  drivers/nvme/host/core.c  |   10 ++++++++--
>  drivers/nvme/host/pci.c   |    5 -----
>  drivers/scsi/scsi_scan.c  |    1 -
>  drivers/ufs/core/ufshcd.c |    2 ++
>  7 files changed, 13 insertions(+), 19 deletions(-)
> 
> [...]

Applied, thanks!

[1/4] blk-mq: move the call to blk_put_queue out of blk_mq_destroy_queue
      commit: 2b3f056f72e56fa07df69b4705e0b46a6c08e77c
[2/4] scsi: remove an extra queue reference
      commit: dc917c361422388f0d39d3f0dc2bc5a188c01156
[3/4] nvme-pci: remove an extra queue reference
      commit: 7dcebef90d35de13a326f765dd787538880566f9
[4/4] nvme-apple: remove an extra queue reference
      commit: 941f7298c70c7668416e7845fa76eb72c07d966b

Best regards,
-- 
Jens Axboe



