Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D56C7619A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 22:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J8z4ld9M7fftUfGlVauhoYGNSHVLLFw30U9QnPZZQ0Q=; b=WmWiq0QqtZyEOMF3jRafs1wGNh
	W9i6fTcjQQ+2Bkev+hCN7JxgK6ivY0JDz8QDbAeKRxSrgNuRQVN2Zk7qXImOnebQbrMhzXXDM6gWF
	zxsfZGTHSRsMGbSlJTNLiFff11fSPtTq1DOTB33LGCwj+YhQ6Pk/8jf1jkjfnK0vtzJcYg8fB7Ff+
	9ouMCkGCx3GpcJKLgsIE9VlLyf89QMyNHgvVn3awQQ2ME34WgH6OR8fLh9qXBevasjBFqpyrCksRY
	oLQS8xBK9mOy6S9K8iZ2KlWPuJNzhuh5uSYfx0nnV79FmQNyLZsSo9AiuxLFAYsiiO3lIti+g8Yp2
	yX/1ubLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmMn8-001HVd-2y;
	Tue, 11 Apr 2023 22:48:46 +0000
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmMn6-001HUt-1Y
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 22:48:45 +0000
Received: by mail-wr1-x42a.google.com with SMTP id j1so13071835wrb.0
        for <linux-nvme@lists.infradead.org>; Tue, 11 Apr 2023 15:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681253321; x=1683845321;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J8z4ld9M7fftUfGlVauhoYGNSHVLLFw30U9QnPZZQ0Q=;
        b=WBSt0uIWmzOcToKeWQxxdMApFSn0OOldxgDCfvBJZx439ZuHjAjl7STB4wvunzSCfJ
         G6RUXJWdWqBr0oFqcYNS7oE/cjx9KIqAbF9IKvqjv+hXQPE+fKxKCs3pVWTz377VIBmT
         ZZnz42ge0iJN9NPXjE459lPWPobVpXzc1vRFn9XqVfxtgRWzWpJpckw1C/1Uqk8dr3jr
         RLeIr8jCRByAjdlESGggC3jQJzwUA3o3BYEHDjBcQcaZh8ywo7FyyMdEGQNlpO+uUeuw
         ZhefFtWIqAStgA4PHeGrUztkjvUmscroMon9eulPSIn4lImiTpYJaddZsRHdZbwWZIX4
         K/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681253321; x=1683845321;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8z4ld9M7fftUfGlVauhoYGNSHVLLFw30U9QnPZZQ0Q=;
        b=hv8cw3atqDm6r0l8eH5vlTW6fu46giTFJaRqoX7wA7KrmsyZSlAEqctnZJfp+afxvs
         cjeG6oa5arz8mMSHb2x0KryXmd2SP59P1Lzy9MEbFwAYEcGnejnrkSp/ywDkB78uokzJ
         4op6vaGGO4Rmji+D00sL24WxCJzOBuCqfgJw5Nm/RQXVDahj1J50IXwjCH1KgNzZU2Mk
         qMDVFqpBcDBvfCmnY7B6A9+pPrqZYE2yRyaMKfsjvn4rYhYqCB5+Sp7KaViRdQZ8j0v6
         abfWxFHXBbdGpUL0BqnPVqk1QK/alL6X5l9RxONITDrR1/fxDziH8lDyjzmmmeARf5Ir
         NGSw==
X-Gm-Message-State: AAQBX9dVYKDlbhGkniXDXvY8ThC7j01SKQxVeLhTV4eHq3DHglLBq2AE
	CUyFPsok73AJap3NNgJHDdzOsUZAHc363Chao08=
X-Google-Smtp-Source: AKy350bm9/hkzTmDMITQuK1I1lLskq3ilk2A747iayl3f0ls6saSW3UKC/7hJzvOXLGaj1dw8xncoyujhc8923PdMRY=
X-Received: by 2002:a5d:6803:0:b0:2ef:bb9f:f5bc with SMTP id
 w3-20020a5d6803000000b002efbb9ff5bcmr960994wru.14.1681253321374; Tue, 11 Apr
 2023 15:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20230210180226epcas5p1bd2e1150de067f8af61de2bbf571594d@epcas5p1.samsung.com>
 <20230210180033.321377-1-joshi.k@samsung.com> <39a543d7-658c-0309-7a68-f07ffe850d0e@kernel.dk>
In-Reply-To: <39a543d7-658c-0309-7a68-f07ffe850d0e@kernel.dk>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Wed, 12 Apr 2023 04:18:16 +0530
Message-ID: <CA+1E3rLLu2ZzBHp30gwXBWzkCvOA4KD7PS70mLuGE8tYFpNEmA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF Topic] Non-block IO
To: Jens Axboe <axboe@kernel.dk>
Cc: Kanchan Joshi <joshi.k@samsung.com>, lsf-pc@lists.linux-foundation.org, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	io-uring@vger.kernel.org, hch@lst.de, kbusch@kernel.org, ming.lei@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_154844_540246_1AEDD03B 
X-CRM114-Status: GOOD (  18.78  )
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

> > 4. Direct NVMe queues - will there be interest in having io_uring
> > managed NVMe queues?  Sort of a new ring, for which I/O is destaged from
> > io_uring SQE to NVMe SQE without having to go through intermediate
> > constructs (i.e., bio/request). Hopefully,that can further amp up the
> > efficiency of IO.
>
> This is interesting, and I've pondered something like that before too. I
> think it's worth investigating and hacking up a prototype. I recently
> had one user of IOPOLL assume that setting up a ring with IOPOLL would
> automatically create a polled queue on the driver side and that is what
> would be used for IO. And while that's not how it currently works, it
> definitely does make sense and we could make some things faster like
> that. It would also potentially easier enable cancelation referenced in
> #1 above, if it's restricted to the queue(s) that the ring "owns".

So I am looking at prototyping it, exclusively for the polled-io case.
And for that, is there already a way to ensure that there are no
concurrent submissions to this ring (set with IORING_SETUP_IOPOLL
flag)?
That will be the case generally (and submissions happen under
uring_lock mutex), but submission may still get punted to io-wq
worker(s) which do not take that mutex.
So the original task and worker may get into doing concurrent submissions.

The flag IORING_SETUP_SINGLE_ISSUER - is not for this case, or is it?

