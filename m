Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40788C43458
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jun 2026 15:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ql3hsSXP3C2fOa2356mv/iAPOPvRxyuDpwITLIsY99M=; b=0UwkgvXVQe+tb14Myb51rNDIWV
	0gjPVrfTIuQu8ZIM8MWXwhJU2xCAWVW59oVYW+6Aax0no1jXkRnXdD/sI1zwQKK1cUK8iv3ojlQ2E
	afiWHA4HBZoKXSkaFf6GrPEzVpROMASJ7pNw2GrlTVIhGwPjC6dZRs0ZMxsWUdUAG6VkUIXv0G7Qs
	z+tlNRUiEmVlTfsBCTufWDZRYhcq8zYKx85KqQraUs/l3/3Nn7Zlg6tYnzJTQ+J88fH0FVzSt5BdY
	Kx+gpumFnFTZrZFK5B4yKPPHhagU76akQGEBscMoahZqgMVtyQt2H1iecUyBclP/vKaodVUxzT0eA
	iNbtDSqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdV7u-0000000Cbhu-2X11;
	Sat, 27 Jun 2026 15:39:26 +0000
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdV7r-0000000CbhV-2VLZ
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jun 2026 15:39:24 +0000
Received: by mail-dl1-x122d.google.com with SMTP id a92af1059eb24-139eea1aeb0so2218106c88.0
        for <linux-nvme@lists.infradead.org>; Sat, 27 Jun 2026 08:39:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782574762; cv=none;
        d=google.com; s=arc-20260327;
        b=dAz/RMQjTqVZPKgbsqVPckFbrBSriUTnVFQXCGoIZTqRTBdO+Vi1sq4kQ0hI8YoOZr
         4YKOFJD3/s/Mj57LBofrJpvM9GkjNB84TY4oUS70caa6Xbg9v7oTd/IrS9Ylner3/2o8
         XYXanb3TPpF0Y9JJkSaJva2QXIC9cdO012yr8EnxkcORi8IotT+ehTgog48oRsWrTtBK
         iRHMZvfuUo7n4lEpCAdFsoN9iN34oIm7S62zNOTb+2QuSOLt9ByHwHPuLhmovQtOk6eb
         n3kpEfzlj6v6bqsF1QZDrSOoCMIRsVOlCM7nYdgDeEFKFRFYZOT1kiXfGkXNsLN79Mpp
         ExqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ql3hsSXP3C2fOa2356mv/iAPOPvRxyuDpwITLIsY99M=;
        fh=iTeDBqt2Kq3x0ZVS1nBI35yq777VBwTLBTPrr85J38I=;
        b=psx23VGcfRjFHPvpQG8InnU7mbmnj9lPMXsNg9D8phPV3L6n1pp9ic33BNdPv37UnU
         0TRxGPlWO2VYRZlPgaEVY0N/g09HRXFWukggXrDoEsxD7Z7BBsyMKJQ0S2c2PsAwr3ky
         Ez5qvcLPdAcbeyrqeR3FLYi8y/va6W+fgpsOOMOnFTzv6NiNvEI17Xlhv0mopAs7qzu+
         WLdYxF+bfmWRmPn3RwGYCq6MmoYkIaHvyZ7SiAymufnmf//tuGPER9l/qMaf8tkVozSR
         MLdIVxJ9zNMdw/wDPX1PxgSToAz4aiSFtIGaAhaYJ8KSDfRWfU9ESTDgq8LvjNYox4wp
         iysg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782574762; x=1783179562; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ql3hsSXP3C2fOa2356mv/iAPOPvRxyuDpwITLIsY99M=;
        b=gMKP5AlWG1wqSE+RDfRScAHnf1HAwY54hqNZj1uCmN2M7Wb1h8VbvgxtP8wjtwB11D
         apMP8tqIZBCjD5+jSRlBsTYh5+peKlSKNSzWyAql4hxjtcsNcQ5N3NcHlJGy0x/k+/Zv
         NYsMQfWN7TQjwKFSSdH/eeBCPwcGg0zLqcDG5N7TCblBKE1Uui4hctdPd6iqlBeQwNYu
         E/o0qDt88XSmqhjJIFYk9zglg0TOKWvexrU84VJyebba+RX1ZY9ZhnFPFLYttKHt33Rq
         QllHva6jGUBurdk9TKd/p7et+8drt2Bqfhzyr6Ey9SuZbrKuNp+xr4Yd0NQHcfZbt5W3
         G3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782574762; x=1783179562;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ql3hsSXP3C2fOa2356mv/iAPOPvRxyuDpwITLIsY99M=;
        b=eQYOF1kfXO6GaQyWxYdfUjpeqp9au5VOSNWVWj5PCG7+P8S2B9zbcmP3DfotJo9Tn8
         M7Wk/xgyiNf03ORIBk8jD/Pf0is7+5DOcXcyYSJUmiq8SD7d8MozfgzgmlkYPvurmATv
         jk+jvR5R0pbLMRCdVnrMOgxFMiaoOXyVUP+k2mgHzDVMmINUKLOJZx6FCqBw3Eo4Pr6T
         o26+0CBb4w4+Bt3CrMKYzP/NtCOWyf6YvqXQwX5EYH3vkc/22Kas7auw+TM0eyZWTyXU
         zx9Z38yHEfZihyOXGMGKOYzMmX9Q6bsz38u8yzsf4AagDY32/GzHg9zST1NGTJH5QJ5g
         e20Q==
X-Gm-Message-State: AOJu0Yzbh2BFkgNKBulKbocoHoTSuO6h2OCZqretK2LFI8qe4J97yPgA
	dxXl+Fh49hZC8QtU7viFzKT87YzHpr2sUkdAgDEdJp1iEE9335KYnsyUWd6oNguAn80S+JvmK5W
	NqRsmZAdnTww3+X8DQJfT5Q9JyjYHqVOR0nfq7aXv
X-Gm-Gg: AfdE7clnYsI+UR/NKFw87yxQHLNJz2Ipz45ilZ1mzUdi5b9lUEpsbadbBTtsq8HjJRO
	gqwgU5kUFPKcS4SX9Jl2pKRSrr5Gq5bvHM1F4si4+5HUfNAAy62lhqe2VNwOFH028ZjyMmM6CnE
	H6Q5FgJ7edWCFRuVxOUTuHm2ZItMGL8M+UFvgdRqDJ/cFMw9P+eOB5xzlq3B6sH4EWmAZTfN7zn
	PLFr4MhAJ5XracbIR96klvPVD6pWwb6z876KFeRKDGNWLBThuvUHuqRF/pZGdOkaIorgBY=
X-Received: by 2002:a05:7022:671e:b0:139:ed59:4b7f with SMTP id
 a92af1059eb24-139ed594c18mr3274184c88.47.1782574761047; Sat, 27 Jun 2026
 08:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260614131541.2017845-1-nilay@linux.ibm.com> <20260614131541.2017845-6-nilay@linux.ibm.com>
 <20260626064050.GE10731@lst.de> <e1c60afc-423b-47ec-9c38-db1397d8838f@paulmck-laptop>
In-Reply-To: <e1c60afc-423b-47ec-9c38-db1397d8838f@paulmck-laptop>
From: Marco Elver <elver@google.com>
Date: Sat, 27 Jun 2026 17:38:44 +0200
X-Gm-Features: AVVi8CcY72eiQSqqfOnNUbkjHVpyP1vLIROe0kZUzvGL2u_Bo-28M4sO6vRrmL4
Message-ID: <CANpmjNPPF3TYx6qPzLO-DbQE6qvL_g6r3jYnGCk3aqeiQnnL5g@mail.gmail.com>
Subject: Re: [PATCHv2 05/17] nvme: add Clang context annotations for nvme_ns_head::current_path
To: paulmck@kernel.org, Nilay Shroff <nilay@linux.ibm.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com, bvanassche@acm.org, 
	gjoyce@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260627_083923_690064_BE1359FA 
X-CRM114-Status: GOOD (  24.37  )
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

On Fri, 26 Jun 2026 at 20:36, Paul E. McKenney <paulmck@kernel.org> wrote:
> On Fri, Jun 26, 2026 at 08:40:50AM +0200, Christoph Hellwig wrote:
> > On Sun, Jun 14, 2026 at 06:45:20PM +0530, Nilay Shroff wrote:
> > > +++ b/drivers/nvme/host/multipath.c
> > > @@ -231,8 +231,16 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
> > >     bool changed = false;
> > >     int node;
> > >
> > > +   /*
> > > +    * This helper is used by namespace failover/teardown and I/O policy
> > > +    * update paths. We only compare the head->current_path[] pointer value
> > > +    * and do not dereference the referenced namespace, so suppress the
> > > +    * context analysis warning for this lockless inspection of the
> > > +    * __rcu_guarded pointer.
> > > +    */
> > >     for_each_node(node) {
> > > -           if (ns == rcu_access_pointer(head->current_path[node])) {
> > > +           if (context_unsafe(ns ==
> > > +                           rcu_access_pointer(head->current_path[node]))) {
> >
> > I think we need a helper for this, as for a simple pointer value
> > comparison without a dereference we don't really need either
> > rcu_access_pointer nor locking.
> >
> > Maybe somthing like a
> >
> >       rcu_compare_pointer(rcu_pointer, nonrcu_pointer)
> >
> > ?
>
> We could provide something like this:
>
> #define rcu_compare_pointer(rcu_pointer, nonrcu_pointer) \
>         context_unsafe(rcu_access_pointer(rcu_pointer) == (nonrcu_pointer))
>
> Or maybe rcu_pointer_equals()?
>
> Marco, thoughts?

I see 2 options:

1. rcu_compare_pointer / rcu_pointer_equals as proposed. It's more
explicit but does add some friction during Context Analysis
enablement. But this only makes sense if there are cases where
rcu_access_pointer() should be used under the RCU reader lock, which
led me to the next suggestion...

2. Redefine rcu_access_pointer() to just not require the RCU read-side
lock to be held as:

> #define rcu_access_pointer(p) context_unsafe(__rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu))

[ Or alternatively wrap __rcu_access_pointer() in context_unsafe()
  (similar to rcu_assign_pointer and friends). ]

I think rcu_access_pointer() is in the same category as the other RCU
pointer helpers, although currently only the pointer update helpers
imply context_unsafe(); I think it might have been an oversight
initially, and we should change rcu_access_pointer() to match. There
should be no reason why an rcu_access_pointer() should be protected by
the RCU read-side critical section, since it's not meant for
dereferencing the pointer (that'd be a bug; its documentation also
says "Return the value of the specified RCU-protected pointer, but
omit the lockdep checks for being in an RCU read-side critical section
[...]").

If you agree there should be no cases where an rcu_access_pointer()
should be guarded by an RCU read-side critical section, then I think
this is the simplest and correct design, and avoids expanding the RCU
API.

Thanks,
-- Marco

