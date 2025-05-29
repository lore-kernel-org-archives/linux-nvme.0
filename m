Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B0C7C54FB3
	for <linux-nvme@archiver.kernel.org>; Thu, 29 May 2025 22:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6YSacIhSUe8j0kgUdoeFBNzPh1NsgF2V23hohzX3NnI=; b=D4bQklyNQeLrf5t4HVI5XTD4/p
	gg6xbE2u6mOLndURuuPdS1EukkHnFz+/wWqp7ahq9+TB7HRDLjk6Bw+r4hh/7CktKJ9gNsvdyKN/I
	w0TOTi1tPJrJ4dJ4IYTKmJJaSPnw897R3RO4l/MhgtPnsKXZEQAY3uNQoTKO6Ro4NqqXlq+37WHc5
	Nyl2Fpm3lFsqBAiSGQAQSvojY3YbZLmP236o2UJTPDO9Zd7ml8UQpk8Da79q0W3Bh5KXcVUXEC8iR
	D0FGAX68726DeNB+ANtctE6LV0h+2UXffg/warC7W9CJba/rs9OdmAZ+Zp0Hg8a+4HKRkde+x4L4+
	/cwSexfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKlos-0000000Gent-3WVy;
	Thu, 29 May 2025 22:33:50 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKloq-0000000GenT-2fgk
	for linux-nvme@lists.infradead.org;
	Thu, 29 May 2025 22:33:49 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-7376e311086so1414400b3a.3
        for <linux-nvme@lists.infradead.org>; Thu, 29 May 2025 15:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748558027; x=1749162827; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6YSacIhSUe8j0kgUdoeFBNzPh1NsgF2V23hohzX3NnI=;
        b=C6/kEi8154PTs7J9AoTWjLMrPeQhhkT7RvWXLXIRA0kEl8+KI7cF7gRTGkbxbaIXud
         Wj/rGqQ8dFy82LrMKmlzZbwVySmTVhcODjxslEnZYgHpVhdovyurUelWZD1vaNoN6npY
         2I94OriXR7MWTbrlwdrUYV4EPfscaRFB/Yh1Bf0Zqc33bi51Jkft74T64+k6OPQTyuIf
         ZHVRQWPqOQbF1VEc9gstNcmysdbSahSbOyzxzaGP1WXdcSupi5WC4ZpFVd4BTWfTo+mB
         0okkyAfxgSY+eNGUcAreJ3gOuEWWNsgEkKCRe6pGG031axQS8iabl3Zm2ppUN3Dgvkxi
         z0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748558027; x=1749162827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6YSacIhSUe8j0kgUdoeFBNzPh1NsgF2V23hohzX3NnI=;
        b=Cg+cKAs61xh0AMTQK4eRvsa6BRwpID0IH96xzKVfjeKaD8lPIMdF6cLHMEyGdVwbfB
         ZxsQrPuMFYz1s1FiRVtn+FVmoTBdkirmQMnAzOP/GcfQcETmRv1PDMeYfb++WeUW5u4W
         Bzw15iemi1/O5hTEZ7zzwkeDaUeuHBDtW3KmTNhVX90XNyz0gBrZPfF7tiVWMP7HXrWn
         OmC0ZVpHdV8TE0xTGJ5hapRfXLakeF7Kcov/GZ8DSVfk2A8LBZYOvpM0Fv4cZjeK2MWl
         v1m65lzMkfqwtqffGCetsdA8kxcXGIL7/Az/bl7MARZPMaztySZKcdifRsF/ozPhpUot
         giag==
X-Forwarded-Encrypted: i=1; AJvYcCVLOz+UkwW5TE6y8gjGm8T9NByfrFIIgxd3ojJ5wWgry3KShg58eFA1IbKrJcWTSDnuyvqaExJrLniu@lists.infradead.org
X-Gm-Message-State: AOJu0YwCwI6/FwEruTVdrGYkRbFIDN7bh0GhSFEKY9nZOSryfxXTVvZ3
	CJoOWB99quDEq4Wk88zfuce+FP0aNmSlYP2N512OhiD330rNHX0paP0QTmHpFBFlJmI=
X-Gm-Gg: ASbGncvkAQCC404izxt+cqXVUpSKdxDeh7HBA70vxr+0AryZ1YkYukx2xChc9dfmNi8
	lb2Em8eZpjs9Nsqi+7LCJlL9/mPePYkToqMh5QA0ZTGU2hLwgyO1mbpDbxauVMHQvVrpcy3ovyS
	txneTKYM/b5LEqzCRlMUgDfdXksyBTat8F+iF28yE9VsCQx4VB2YJ1n6aXHnkTc67rRAG9cl607
	6fGmBAT/6aRhaTCoHepM9kzE28pjt8N2BbkMe2hZ+o8tbrkbD5sHOPbK29F6Kizk1w7ascJqm+C
	O/PXeeYd7dE6pQmbwmd7GS5o9udAMXty8HDkLww2zDHItR+tu+oAEPyzBtMHKB+Qx37ZeuhOtaB
	YXgq+AuI=
X-Google-Smtp-Source: AGHT+IHZj/1Shba20OZmM3OFPzAX7htJw4MOn1JwrvwJXkeYQGktsBWAgY05GzRUNgBCepuiRXfRSg==
X-Received: by 2002:a05:6a00:2d1d:b0:737:678d:fb66 with SMTP id d2e1a72fcca58-747bd94c561mr1395176b3a.5.1748558027606;
        Thu, 29 May 2025 15:33:47 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-747afeab33dsm1810293b3a.41.2025.05.29.15.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 15:33:47 -0700 (PDT)
Date: Thu, 29 May 2025 15:33:45 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Michael Liang <mliang@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>
Subject: Re: [PATCH] block: Fix blk_sync_queue() to properly stop timeout
 timer
Message-ID: <20250529223345.GA2013185-mkhalfella@purestorage.com>
References: <20250529214928.2112990-1-mkhalfella@purestorage.com>
 <aDjcA_H7Ec9VICps@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDjcA_H7Ec9VICps@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250529_153348_825589_23EA97A8 
X-CRM114-Status: GOOD (  22.96  )
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

On 2025-05-29 16:13:23 -0600, Keith Busch wrote:
> On Thu, May 29, 2025 at 03:49:28PM -0600, Mohamed Khalfella wrote:
> > nvme-fc initiator hit hung_task with stacktrace above while handling
> > request timeout call. The work thread is waiting for itself to finish
> > which is never going to happen. From the stacktrace the nvme controller
> > was in NVME_CTRL_CONNECTING state when nvme_fc_timeout() was called.
> > We do not expect to get IO timeout call in NVME_CTRL_CONNECTING state
> > because blk_sync_queue() must have been called on this queue before
> > switching from NVME_CTRL_RESETTING to NVME_CTRL_CONNECTING.
> > 
> > It turned out that blk_sync_queue() did not stop q->timeout_work from
> > running as expected. nvme_fc_timeout() returned BLK_EH_RESET_TIMER
> > causing q->timeout to be rearmed after it was canceled earlier.
> > q->timeout queued q->timeout_work after the controller switched to
> > NVME_CTRL_CONNECTING state causing deadlock above.
> > 
> > Add QUEUE_FLAG_NOTIMEOUT queue flag to tell q->timeout not to queue
> > q->timeout_work while queue is being synced. Update blk_sync_queue() to
> > cancel q->timeout_work first and then cancel q->timeout.
> 
> I feel like this is a nvme-fc problem that doesn't need the block layer
> to handle. Just don't sync the queues within the timeout workqueue
> context.

Agreed on nvme-fc should not sync queues within timeout work, and I am
testing a patch to fix nvme-fc. At the same time blk_sync_queue() should
provide a guarantee that q->timeout_work will not run after the function
returns, no?

