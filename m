Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938A9CDE008
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 09:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7DzD3U3iDBh2MhudNMQ5tBeVHk0YLvDRALHx7DAM6Fk=; b=eQ1Y43cEwAZWnPwtcpNo6Jweqz
	T2/imXp3tgFG/jSmltNMZ2mD2GfpEEO7FNn7fi5YK8XNlpsm9q6ElPPozQq0mMPIG61TbA8xorq+9
	d/9sjdP4h1Y/lur75JxMcwOp7unxNWy9aQhl+h1TrNXybvGNN16b/0Y5jr2Ho3c3ELYqPuBs9wR0+
	8W4MO2KXF2VSvm205Ve5oOZYecbsvchx9IZuDcWPVqG8BXyrPhB1CFDylk6otyEzQGw9lDRxuO5IB
	f39ARdyFbdcDBOX+ZGaNeh8wWkxjiuMAPwqJ1kvBilZxhnAmAcPBM1oRCkqW/RKCKCLUqsL7xw+4d
	MeNwjr3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd3Dd-0000000B25J-1kie;
	Fri, 26 Jun 2026 09:51:29 +0000
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd3DZ-0000000B24Q-2RRq
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 09:51:27 +0000
Received: by mail-dl1-x122c.google.com with SMTP id a92af1059eb24-137eb0d76beso1033355c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2026 02:51:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782467484; cv=none;
        d=google.com; s=arc-20260327;
        b=aK/PpZsslkp61CN3dQEl+RRVoVcdzBgLpTcVyY9TX4K2FvirtzAZlYz1m7MGKYipH3
         M/eTZilvp8tXgmnLe9nuXxnJlMcwX9GMjuwQeR1DVmBSF5Ij3XfWjiA6aMm2r/HW0d4i
         PUF8LG/cRelTeVy65nWYpqeZwiZbfAAjyxtzTAie4wWFL0hzQx/7gh6fV/3bH+2mMDGf
         +eLjcGa4hJBIjETXC+pP19k85UF1YEFTTmHS/ZOM+seeoSZO/m4wQ7vZAmOScOqbA8G3
         axtJ2xvtcoWTOV+EjmuPBAiI90TbGPK4mxJuNJ52knyG/ucXeVmvl+fqfpH7laJ7SDRX
         dylA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7DzD3U3iDBh2MhudNMQ5tBeVHk0YLvDRALHx7DAM6Fk=;
        fh=0oVVR8snTq+zkuB1xb7I8KzhUQtt/GkMd+y05rp/bW0=;
        b=RNXxodEvKQmydUg9gfhTbTQbKdGmK27J6z5P0GrqgHKYJCk7tDAeEeYJsOMY0KP6Uc
         9DbLvBKbPzN/7m0w6FWmpb+u60x6VUsrOqve7hGZPtYJd0OLgWjNyD3Mu6toFefUqoUR
         oUhpiVWeLvy4Sk/2w/y1YgDGuU1ADAkSGDRQi4FFROsZ0gybsHEwsIxCYmlhgZvzClM/
         z0DztQtmOX9puaYpo+IfTWQTHDZRPN9v41t0KTWJVs/vQ8tPGZAa4uBldSoMguzFpyjH
         6PSb695jZg4bVHYXGJLqsMX3waUyt90OM8IAiB1x2HszJtPN/lIGBeufEgcOUwQzgOyd
         82vg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782467484; x=1783072284; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7DzD3U3iDBh2MhudNMQ5tBeVHk0YLvDRALHx7DAM6Fk=;
        b=j/QGI37BGUXbh77qg3KDbtc0/G6y3YUQzT8h4sNb9fE0DqH81G1ALZcXCxwNck5vc6
         PJycZTqxDeyTQx3FF8VJACT6egD2gPYJcDczGPc4sryp2luYT3oyI81RTZd1KC/GsaCB
         Nltsqf5aAZWHO0Q8ce4iv22e0avA//hvJVQZyEL0dCOyB1PTOf8J3ruFWhT80N5UlCUq
         +qcshna5UcqyT3pnS1qdRnqMxaAtikETT9gspzIxqqj74ogbkX01QseMyMTxAd8XZ/8u
         cynjLyFwSEzqZdtLNUHbiQshimGV3lCYGChisxxGIswzaJQ2PxD8YkZESDzCNN1njl6G
         gvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782467484; x=1783072284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DzD3U3iDBh2MhudNMQ5tBeVHk0YLvDRALHx7DAM6Fk=;
        b=i8+u9ewwIwvE9qdVI1jmtR6LVG0QMEggvsI1Uw0davybnU9EX9mA6Ksi89yjFewJEc
         oyQ8hz3nPqSslXJIm5BOQgGI6i8IUiljTBzWSksTeAcYJ/CjLiaeI61wvchBnUZbv6yx
         cPy7PLzHhgQ9/qyUA7n+ApyedmU14Jj1j1BziOwJH9pS0LtxylIK1vtO7uU8mbJLyJNF
         ulyqWzLT3alvNnhglYTpmggZxwR1grhHKQVd8sYgn6mh0/hfz3KWUnMQvgOj6kwSQCZp
         i/CFBg2I3ge+0EBsSRgl6E1JAHENSxhlar73Eh7FLvl4U4bcwRJzQWVC/KQMzOPv8PZG
         clzA==
X-Forwarded-Encrypted: i=1; AFNElJ8aNF33G5dugNwuS2XroRHSdflHJ+b9NfmhkA/O0H6ZISqv5vf+Ukae56yQ2SN/QhspzQ3bDMV5Sv24@lists.infradead.org
X-Gm-Message-State: AOJu0YzW4hO5MayFaW3aHdgazzMlFskP3q94ozw9CE9uq+nVZ1LwGxEH
	SuuP8011UZlWTr3cteb9F55N/HCV86mTis1JlNMDZCGyZMje3mUMHqaJFoWpRsyJjXY9dcakPpF
	YyZPyA0kPFVieSIV1kTqGQuEiMj7BlYpFNibuEFnf
X-Gm-Gg: AfdE7ckFPGmKWbeIyf1ukfwQqdugKZEsOH7vg6i4NeJ/1rDjpXw0R9FxHlg6JWStJwL
	qNcEElEotDJb85jScKO7e4OBEFUlD8RHJ0Goz428ZUwIrg4S8cGCbcGfyzVZj8EdgLLao/eNpfi
	4tLv9h5xJNQqrKb/Ceas1r+QyYPo5daVZ9E3tac6GeXibNS6xnPKnQJN5LgxIvFE8r/JaUjTYBV
	4OQxdZssyItoyYitrIYR90nxuwah861HUe6TNILHhmMw1zw8q01sMO0oxGuj+yugCqCH5M=
X-Received: by 2002:a05:7022:130d:b0:128:d396:f2ea with SMTP id
 a92af1059eb24-139c3c44cc1mr7662031c88.11.1782467482904; Fri, 26 Jun 2026
 02:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260614131541.2017845-1-nilay@linux.ibm.com> <20260614131541.2017845-12-nilay@linux.ibm.com>
 <20260626064721.GA11106@lst.de>
In-Reply-To: <20260626064721.GA11106@lst.de>
From: Marco Elver <elver@google.com>
Date: Fri, 26 Jun 2026 11:50:46 +0200
X-Gm-Features: AVVi8CeEUJuNMMKe1RlR5d-5xh8sYdf7NbOTe6AafYbvn9QM5pSriuXf_gmmOr8
Message-ID: <CANpmjNNc0YaFWv9yW_AT3fPX1cOY7k5no2kKqvSTijnp_GV=Gw@mail.gmail.com>
Subject: Re: [PATCHv2 11/17] nvme: add Clang context annotations for nvme_queue::sq_lock
To: Christoph Hellwig <hch@lst.de>
Cc: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kbusch@kernel.org, sagi@grimberg.me, 
	axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_025125_625223_52C47A97 
X-CRM114-Status: GOOD (  16.60  )
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

On Fri, 26 Jun 2026 at 08:47, Christoph Hellwig <hch@lst.de> wrote:
>
> On Sun, Jun 14, 2026 at 06:45:26PM +0530, Nilay Shroff wrote:
> > Accesses to sq_tail used solely for tracing are annotated with
> > context_unsafe(), as they only require a lockless snapshot of the

This sounds like an intentional "benign" data race...

> > value. Likewise, nvme_init_queue() and nvme_free_queue() operate on
> > queues that have not yet been published or are no longer reachable,
> > and therefore do not require sq_lock protection. Similarly,
> > nvme_alloc_sq_cmds() allocates memory for nvme_queue::sq_cmds for
> > the queue which is not yet published or in use and hence it's safe
> > to annotate all these helpers using context_unsafe.
>
> Accessing scalar fields without lock is pretty common.  Don't we
> have an annotation that only requires the guarding lock for
> writes?

If the writes can happen concurrently with readers these are data
races. I'd probably annotate the particular reads with data_race(...):
this will both tell Context Analysis this is ok without a lock, and
also if KCSAN is enabled, not to report these data races when actually
observed at runtime
(https://docs.kernel.org/dev-tools/lkmm/docs/access-marking.html).

