Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB5FC5DF81
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2026 02:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uep7A6RMuuz0CSmyUjrh4/f2t0D65V4l/FS4IRokaiU=; b=Agh3BtwXCFRW5khIsEHf1+fAUd
	QFBOgAn/6Sqi64r/P+TcZ61bBFl+x91Ob4qnf+qfsnijcdpKDuOx4gpPDV0Xf66MAMx3rsmIJWh9V
	K5BDAH/R/X8xJ/+QQBOr4fdZ5clZg1HHLnrWoEC+PCXSw9YRlF3wgtf04eGZhNm8UTb1Z2R+l8csh
	Z3wt4WSfmyKkA4cjgo3/K6I1tFhwz1T9NYBNPbtdcsObbqVrs8j7HNvF84ISRaxPyjTBTFY32RBjy
	6ZBsX6PprF6Mv2GdWVSPHKPTCVombtfOcmCF00EogEQVpUawkpaud6yIWPv6cnTSqnnIUZ3bi1LEL
	vwo9awfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyhNd-000000004is-10vs;
	Tue, 25 Aug 2026 02:59:17 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyhNb-000000004iP-0TJH
	for linux-nvme@lists.infradead.org;
	Tue, 25 Aug 2026 02:59:16 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-395cf2535acso415092a91.1
        for <linux-nvme@lists.infradead.org>; Mon, 24 Aug 2026 19:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787626753; x=1788231553; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uep7A6RMuuz0CSmyUjrh4/f2t0D65V4l/FS4IRokaiU=;
        b=L07QqV+2QXnHgmo+TQVNmZUr/6pelf2W2XAMWWT25oroa8iz34J93w11LlbgilNNmj
         2GtwOzK1dm8HNhVtTR7oT/I2igeEGtJmZunXpfctDi1eT0krfGXoZznMiu4wqcIWOkwq
         Iiej+lLVT4rKe1vVh01kBQewU1c5Jt+pbR8MVAGEjB6GwZWOC+dTfoDlc7y2dDK1M9gj
         rAJoTxr3iKkK4Zg8aB2ktwpSvqGpBU/GtEeHzgJb9sK+zKB8M31kBJcZBnM8vT4ydhHe
         zEFLM/OIHDmYHMOpb1/YED3IKLILjHRVF+rdToElIdV3PXKIOYOY8ZGjDMwv1vWGeg6v
         BsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787626753; x=1788231553;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uep7A6RMuuz0CSmyUjrh4/f2t0D65V4l/FS4IRokaiU=;
        b=g0Va1tFD/xg9jUpmQTC+1UwiA4xHFVakce5x6GgquSixu2RdnY2afHe/O8uX+SF/nD
         wGj6pYJseWCPjO24rsPuKcpofYxtpMWuqFdYLlNKi0glyJ+t/o7RAMa1V2wi4MTPc864
         yRrmSmr4G1DXhLxt51/hwffZ8harZSvjXSAX+R+cPMRRxCRwV1X3k3vg7QZOl3PTi4eO
         74jpEAIWo9rYGaqm0Vm3YyASY5j2z6lMXdEmrMG6owwrBmT4ycxPUWOEeRg80wU0SD/4
         wgWOcTSrkFtdUDb+JoSQEPR06ofyXVjgp9+VXmw+uBt1MADTU/ql+xfoxQHx4UxCAqHO
         Usuw==
X-Forwarded-Encrypted: i=1; AHgh+RpfEz9CCLRZAWSUdXzvx+QjHGm2jEFfwUC0dLHjXB0qdd+IEuqcbNVJMKYY0vqrOBOzyn9/Qt90mm4j@lists.infradead.org
X-Gm-Message-State: AFuF++n8/8HZ2gxL8jokB919//6WPvvM0IVP+aKpujsUspgB6GfeTDmz
	HlfHFfUn6Lozn7MWns+nfooibBahD6AbWzoBBJimb1SZcGS78v0QR5oOAE1XxLk=
X-Gm-Gg: AR+sD12Ai+/Thzt4KKkGJracisS8K49Art5VPRxF2kX4TgDJfRx8ZXV62FzVKIhFd+o
	7e7cbh7BXNuqvRjQs4Rf0Vi39hzyTcOaVjCfYx3ejXsQ814I1Xng3xTq2+q4GN7h8cZDA4j5KcL
	m1NjiVA12EpX8FQqlvlnP2sTv9l29Pqz5ecTIdDNg+5JVv07g8DVKId1yBsdEp55lx+mnooVIa4
	W/M5TUWn1Zp9n9hyC0xLblFUJm14RjoEqpILpnK2YlShbetRVYYmeZiugWfhCh1uM7Xg0aDF7jB
	q8gNonPKzgYL+YOrHRNH5/lLKXdnIHR8Tjj8dFSwGb9qWHrEWqQrkMQn3BYQoPLB/toiJU62c5q
	T7AAOz0gwj4MoszKbKdNHych9Ddcc0NvcW6QhbxJ1nwb2SQ51Z7DiZ3WM5p8rJ1bDGCxPam7OJ/
	78jg2X5itK17/Xf8GARNlELas6vFedqb1nX9FCmp9gvU4Je3D2eoLF1HmEG9YYLPLan4ux4xwKC
	Rho9Vh6E2R8X+YwUBQNr6pq70tI4w==
X-Received: by 2002:a17:90b:1c02:b0:381:10a3:8b10 with SMTP id 98e67ed59e1d1-39645ace043mr4137497a91.14.1787626753330;
        Mon, 24 Aug 2026 19:59:13 -0700 (PDT)
Received: from anuj-MacBookPro ([2406:7400:63:4a2f:bdf1:9d16:ebc0:4899])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f920e0desm2570011eec.24.2026.08.24.19.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 19:59:12 -0700 (PDT)
Date: Tue, 25 Aug 2026 08:29:05 +0530
From: Anuj Gupta <anuj1072538@gmail.com>
To: Fengnan Chang <changfengnan@bytedance.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, jun1.zeng@intel.com, Guzebing <guzebing@bytedance.com>, 
	anuj20.g@samsung.com
Subject: Re: [PATCH] nvme-pci: add adaptive interrupt polling
Message-ID: <rf622zppbkxqcydbuwfifpyeyem3mjc6ris6zjutvzil2p3f5b@33tczg6j52ge>
References: <20260818033846.53790-1-changfengnan@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818033846.53790-1-changfengnan@bytedance.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_195915_157048_DE589BFB 
X-CRM114-Status: GOOD (  14.36  )
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

> +/*
> + * Drain CQEs from IRQ_POLL_SOFTIRQ and compare completion progress with the
> + * IRQ baseline.  Re-arm while within the allowed lag; leave poll mode on lag
> + * or teardown, and start another window only after a faster full window.
> + */
> +static int nvme_adaptive_irq_poll(struct irq_poll *iop, int budget)
> +{
> +	struct nvme_adaptive_poll *adaptive = container_of(iop,
> +					struct nvme_adaptive_poll, iopoll);
> +	struct nvme_queue *nvmeq = adaptive->nvmeq;
> +	unsigned int completions, limit;
> +	unsigned long flags;
> +	u64 deadline, elapsed, now;
> +	DEFINE_IO_COMP_BATCH(iob);
> +
> +	spin_lock_irqsave(&nvmeq->cq_poll_lock, flags);
> +	if (unlikely(!test_bit(NVMEQ_ADAPTIVE_POLLING, &nvmeq->flags))) {
> +		completions = 0;
> +		irq_poll_complete(iop);
> +		goto out;
> +	}
> +	if (!test_bit(NVMEQ_ENABLED, &nvmeq->flags)) {
> +		completions = 0;
> +		irq_poll_complete(iop);
> +		nvme_adaptive_poll_end(nvmeq, false);
> +		goto out;
> +	}
> +
> +	limit = min_t(unsigned int,
> +		      budget,
> +		      NVME_ADAPTIVE_EPISODE_CQES - adaptive->completions);
> +	completions = nvme_poll_cq_bounded(nvmeq, &iob, limit);
> +	adaptive->completions += completions;
> +
> +	if (completions >= budget &&
> +	    adaptive->completions < NVME_ADAPTIVE_EPISODE_CQES)
> +		goto out;
> +	irq_poll_complete(iop);

If the last drain reaches NVME_ADAPTIVE_EPISODE_CQES with
completions == budget, this calls irq_poll_complete() but still returns
budget. irq_poll_softirq() will then call list_move_tail() on an entry
that has already been removed.
Should the full-budget case always goto out and let the next invocation
complete and evaluate the episode?


