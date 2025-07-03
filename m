Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F903C83F05
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 20:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KVPzloh1oUX1Y6h3ndP8c2+rIYKbbClu7XHnxXtmGIQ=; b=CafHgJ6U3CSo4xxIWsfY0u7dRH
	DvRqDwc3+j0H5MZvurTZ5Q+p9XCT/fb1lIm/+6cDfnVhbdKLjs30NZ4yOLKP6jyplJIm8kUAcnZI5
	Dmtw8+VdABJCZgD8e4Y9JF4mAPA4I536yUb8KA8Koyb25fdtxYvdDD4uVHif08J+ryFjxO56tF/RT
	aabw0Mzzuu7rm9Rpv1hkd9C/zBYoCKaYJpEDEQ4axyU09v6wMg5tMPbHe9iUVN6MvKSX2NE8HYjCG
	YkvmK3vwMuJbGntk+iOvLDDvC4ZpzHv0KzyKtToiY9WIUunRAQh081txPxThU1Xjik7fXcM+F6V09
	cqQUEjXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXQzb-0000000CTJL-2QT4;
	Thu, 03 Jul 2025 20:57:15 +0000
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXLdD-0000000BmQZ-0eva
	for linux-nvme@lists.infradead.org;
	Thu, 03 Jul 2025 15:13:48 +0000
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-2ef891cd058so38029fac.1
        for <linux-nvme@lists.infradead.org>; Thu, 03 Jul 2025 08:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751555626; x=1752160426; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KVPzloh1oUX1Y6h3ndP8c2+rIYKbbClu7XHnxXtmGIQ=;
        b=vB1Hre+VGoCS2o37VLUs9zu31PLs2hd2SNqOp0ZoAJMQPn8a89SkkL89+4XzvHk8lA
         1TtAtFtq35xVIA/yoG0KoaPiRU1Hr+r9VNuRZWDn0WzfLjliWOg5EJnqZp3zGb13GsX2
         woqOV/kwQ9pG+8V9wdKKZYYzea6HtyCfqngIleabCSt4qP/ZhzOKdLr2jfuddkHW8osM
         0eGPSglAbf71PMB3jGHObHI51zdGhCm5URXnM0H2Wp6WgAgutBY26NnYE070loHMhpgs
         ye1NDKEWt+pJkyhh1HW4BF9GlprdRyEapkpiZMiVmY7j14AvxJwkzpidHraBv5Q7V8Ry
         8YZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751555626; x=1752160426;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KVPzloh1oUX1Y6h3ndP8c2+rIYKbbClu7XHnxXtmGIQ=;
        b=LuX9MheV5vS4i01JsjL9X6+BjhjGHBl3Q43PAksPmUFY4IpGo9DqBCZzobkxqQOpSX
         eaf4cSdYtBOAfyzipLMwGTF+y1KHgdlAVOXJpk1SnGi+C9mQCqXfTV8Fp/TM9Dyy0Io0
         Zn1CVXQLyfFMMxn+I5y5Q6Dz4K2NeqVm9AASvOU2yMzRrMNcnuvPBtob/kXpnojdPqsH
         xJkRVL0g+xdpRrm3zLW70ZGXuA4WWkkOHTQF8E4BL7VxiisvJ6W4BwYlwPWhbYG7QgEi
         E11Hm6YUXEctllgX0sP4JQuQdy0/UkC6CmiM0i5JA77hFxjIXTyI1FZjBCF9CH7+NdQ/
         Hu2g==
X-Forwarded-Encrypted: i=1; AJvYcCU4F4+Dc5edcM+jzLT8tfTuI4HR0YUg43UbcEbJS+ViHMhe+j5D/pOmlg7x2SE89U4YxX5ClYIZrDq6@lists.infradead.org
X-Gm-Message-State: AOJu0Yzsqxuj8li9efuZ//Ij0J6CEOyB9HzuzTeIrEU7YsURRMt1S/lV
	m1pa+ZRz7+3F0Q+sM6BrtWlqSkSzj7jNKARC4d8a4/VWrYaDS79sMxKp0A2VXVwjWl2Gb+Li01E
	11+GvWJZV+tsWCcnLfbGiN6JNp+l4XoZeieas888a
X-Gm-Gg: ASbGncuJh1atoftuUxnOllbiosfLgimfZzqOKL27l7dW4l34NCn66YpZXxxPwM3kePX
	Sg0j6wil+LKz4rFJ6N0Xh65rdrIiwbSFapc27uP0vQUd6pvkKSa7LIJC65Wpz8rpHVSF10H5J64
	FfxYspfOPyIMtGdGpsB5fJ9+cxpRkGMDKyK5QPbvohtfrfmG1atnM=
X-Google-Smtp-Source: AGHT+IFNofYLmKV5Ky0RG07x0qI3JXTBrrZQnExq8xPcLRUNb9KWtuoW/38SR0jSXaannNWxKg0dLKoxlfAIQh14pQs=
X-Received: by 2002:a05:6870:288b:b0:2d4:e101:13ec with SMTP id
 586e51a60fabf-2f5a8d3f1b6mr6005725fac.33.1751555625656; Thu, 03 Jul 2025
 08:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAL0q8a6pOBZbWYdwKzC1U-PuH4rgf2miv0jcF=fWVZt_dUZHmw@mail.gmail.com>
 <20250630133343.GA26040@lst.de> <aGLyswGYD6Zai_sI@kbusch-mbp>
 <20250701132936.GA18807@lst.de> <aGRMilWhgF4z0WOf@kbusch-mbp>
 <20250703093042.GA7387@lst.de> <aGaTw7SzermpfiD7@kbusch-mbp>
In-Reply-To: <aGaTw7SzermpfiD7@kbusch-mbp>
From: Ben Copeland <ben.copeland@linaro.org>
Date: Thu, 3 Jul 2025 16:13:33 +0100
X-Gm-Features: Ac12FXwWdPQaun6KP1n2WG90MWR4J8ZJY7tGLBNOTSkceZgMU661bsKnTuwWQZc
Message-ID: <CAL0q8a62bcjkJdKjTUbEOXMRfaCr1eB4YWeNugdRO1GjLLQe0g@mail.gmail.com>
Subject: Re: next-20250627: IOMMU DMA warning during NVMe I/O completion after 06cae0e3f61c
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, lkft-triage@lists.linaro.org, 
	regressions@lists.linux.dev, linux-nvme@lists.infradead.org, 
	Dan Carpenter <dan.carpenter@linaro.org>, axboe@kernel.dk, sagi@grimberg.me, 
	iommu@lists.linux.dev, Leon Romanovsky <leonro@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_081347_197687_17019DD2 
X-CRM114-Status: GOOD (  19.47  )
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

On Thu, 3 Jul 2025 at 15:29, Keith Busch <kbusch@kernel.org> wrote:
>
> On Thu, Jul 03, 2025 at 11:30:42AM +0200, Christoph Hellwig wrote:
> > I think the idea to reconstruct the dma addresses from PRPs should
> > be considered a failure by now.  It works fine for SGLs, but for
> > PRPs we're better off just stashing them away.  Bob, can you try
>
> s/Bob/Ben
>
> > something like the patch below?  To be fully safe it needs a mempool,
> > and it could use some cleanups, but it does pass testing on my setup
> > here, so I'd love to see if if fixes your issue.

I have tested it on my system and can no longer see the regression.

Happy to retest when the patch goes through.

Tested-by: Ben Copeland <ben.copeland@linaro.org>

Thank you!


Ben

>
> Thanks for confirming.
>
> While this is starting to look a bit messy, I believe it's still an
> overall win: you've cut down the vector walking in the setup path from 3
> to 1, which reduces a non-trivial amount of overhead for even moderately
> sized IO.

