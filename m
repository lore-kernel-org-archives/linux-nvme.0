Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F626C7115B
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Jun 2025 18:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vDt9Tud6S9Roh6W5bYJpXYlaicNuFd+r8htTFd4j9Iw=; b=fpxWtvnQRf/y5vKWLOy9bsBdq6
	NRFiR8uxihacwaN/s/kX0GLqKOfGz1edH5DlI4zDis663Sr9Ssa3QgWDL7/D0wcmayD5cCF2bmK46
	qc/Rza73Y6+TItC+UTA7tB0kUc/WNg0bZ2joBRKjhY6Bo4Jhqya48RTMMrWQ9WKMKaDLJelHIDjFx
	GT3sg0dK+DC/ImQMjyGHXP3xBJ9LPdLNmE23PN+rIAC4RJHMUCmAuXeh6S2nmJ6iqV3z+iKw/wV6X
	8+ZRAAkGwgFQ/VfOUvqJHFSs2ZKrtCI6IiCHx6Kdbze5EuCuhQGYA2EXfSy4yC1KlJbcyeYUWq2Y3
	YpR4CGvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSgak-0000000GNTS-3cvr;
	Fri, 20 Jun 2025 18:35:58 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSgZD-0000000GNG5-0i3H
	for linux-nvme@lists.infradead.org;
	Fri, 20 Jun 2025 18:34:24 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-747abb3cd0bso1584147b3a.1
        for <linux-nvme@lists.infradead.org>; Fri, 20 Jun 2025 11:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750444462; x=1751049262; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vDt9Tud6S9Roh6W5bYJpXYlaicNuFd+r8htTFd4j9Iw=;
        b=bZRC7U0kLw1RVauNUQ0qw36wHBiOTYtXgtXqbxD6BQXRDsF2ALQlxNg4XzqCOLX4L8
         A4L0K+RS/dvvbQZslPPG9PQLTwkT+dZmjTNfXrp4S77AS2ZW0EsG6u+W23kc/WWo+2K0
         bvJNjUbaWQa92t0z0MooaWwjNzEk8tGc0Y8pFn2xLtsgFT/DfXt4jz4wm+xL5wYObjzw
         gRo4APe6tqmbAxa4Z1Qd6odQGoMj11xr/TnOn+xI3fybbEFIoxXElB/pt9nDL8QyEoJR
         EBzdZUGm8qKGVNTebCvdvuo5jkTHJA/6fvGQNl0nyUglDmndezhvIiSLmq+mcH9UBhSj
         7XTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750444462; x=1751049262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDt9Tud6S9Roh6W5bYJpXYlaicNuFd+r8htTFd4j9Iw=;
        b=t6mAxw39LUYRN7uKy5aGNPBkWD7Y3ISmzBAbP1q8Dt0iPFduGi+92xFRVPUs+CG4N7
         bZoEOj+nheYssIcJtr/zTfFs3zfvISoip/jXVGonQ6drM0T2yqJSFZGpE0BfehIyxxvt
         MordAkd+CQjPdAX45sxijlmbGFwhIwm9QaTKL2rRoOAZbivBbWoD/sJTwjomHktIepVm
         fjp0juVWkv5Os0fRaOhQQYOxR93dWnwXobKmyVLMafiwoejIt9orTx+VGI2cmRqOeZxp
         /bTBMj1Fd01NekmQXq8LCLT+0evUvn8UGE6SvRxFfDrGMBwcV5VLmAVfmnCGSFFU3zPE
         VF1w==
X-Gm-Message-State: AOJu0YwuXePgNdg/p14wxqSlf5B55IvaYWiuNOP4tkFBp2FLlgnr2hE9
	2UDEQF10Kno1rH+48xyULfhe96CLpgGYgpn57OWCRCIbgYSwJ7BlyduF6hXZy/QkOcY=
X-Gm-Gg: ASbGncs1OJNxllIlJW/UHKpg/czNlnA0faEsgb4cEePZrg7nMb7pEYk6f7BSCxuPobb
	5cu8Fs4vutN0gjIhtzfBKYm2uyciW2cE2mGUb2bHVJ/4ieg7JwufuxJHXf3Cyd4uq2ZFbjlKtpQ
	iU1lYfn/5Catgfexxg/eHz2OXiHQOS+NDebQren6msXmv2y9Cw1mcy4gY4ujQLkj7Svxa2Corn4
	RwiOpKy0ZlI2qsDALRG3e+gq4NyP+csd5xn7bAavjKwfTKr08Z3So/nJxTawWWjKSHOTciGkGk5
	BTc5llB3uw9p1SdVtorLkmjSX0GOUy5rPoeXAVnSBJMZFXQBDgmojOwXIHG+i+JfBg9i2YpL2Bs
	hR5s8ZRZv4TQPhYuAVg==
X-Google-Smtp-Source: AGHT+IGUb3KaVzKScxOQe9ijMlNd3nszvLLdCk8NMLmcsF4xnEod7cES0/O1shuIaHHP3sZwlCs2Cw==
X-Received: by 2002:a05:6a20:1593:b0:21f:54e0:b0a3 with SMTP id adf61e73a8af0-22029176202mr5488182637.2.1750444461926;
        Fri, 20 Jun 2025 11:34:21 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7490a6bd5c7sm2588559b3a.165.2025.06.20.11.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 11:34:21 -0700 (PDT)
Date: Fri, 20 Jun 2025 11:34:19 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Yuanyuan Zhong <yzhong@purestorage.com>,
	Michael Liang <mliang@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>
Subject: Re: [PATCH] block: Fix blk_sync_queue() to properly stop timeout
 timer
Message-ID: <20250620183419.GC4836-mkhalfella@purestorage.com>
References: <20250529214928.2112990-1-mkhalfella@purestorage.com>
 <aDjcA_H7Ec9VICps@kbusch-mbp>
 <20250529223345.GA2013185-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529223345.GA2013185-mkhalfella@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250620_113423_349882_727D00E3 
X-CRM114-Status: GOOD (  27.06  )
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

On 2025-05-29 15:33:47 -0700, Mohamed Khalfella wrote:
> On 2025-05-29 16:13:23 -0600, Keith Busch wrote:
> > On Thu, May 29, 2025 at 03:49:28PM -0600, Mohamed Khalfella wrote:
> > > nvme-fc initiator hit hung_task with stacktrace above while handling
> > > request timeout call. The work thread is waiting for itself to finish
> > > which is never going to happen. From the stacktrace the nvme controller
> > > was in NVME_CTRL_CONNECTING state when nvme_fc_timeout() was called.
> > > We do not expect to get IO timeout call in NVME_CTRL_CONNECTING state
> > > because blk_sync_queue() must have been called on this queue before
> > > switching from NVME_CTRL_RESETTING to NVME_CTRL_CONNECTING.
> > > 
> > > It turned out that blk_sync_queue() did not stop q->timeout_work from
> > > running as expected. nvme_fc_timeout() returned BLK_EH_RESET_TIMER
> > > causing q->timeout to be rearmed after it was canceled earlier.
> > > q->timeout queued q->timeout_work after the controller switched to
> > > NVME_CTRL_CONNECTING state causing deadlock above.
> > > 
> > > Add QUEUE_FLAG_NOTIMEOUT queue flag to tell q->timeout not to queue
> > > q->timeout_work while queue is being synced. Update blk_sync_queue() to
> > > cancel q->timeout_work first and then cancel q->timeout.
> > 
> > I feel like this is a nvme-fc problem that doesn't need the block layer
> > to handle. Just don't sync the queues within the timeout workqueue
> > context.
> 
> Agreed on nvme-fc should not sync queues within timeout work, and I am
> testing a patch to fix nvme-fc. At the same time blk_sync_queue() should
> provide a guarantee that q->timeout_work will not run after the function
> returns, no?

Following up on this patch. I think the issue with blk_sync_queue()
needs to be addressed. If adding a queue flag is not the preferred way
to do it, please let me know what do you suggest and I will make the
code changes.

