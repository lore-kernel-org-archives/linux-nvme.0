Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EB0C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2026 06:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d4qCJSbwRvjJi29QkSJn6kYfBFh2rHegeHabowjGHFA=; b=GzA8e+KTQ7xsn/zNsNfPajgGe/
	VxCM6jIAscUyk/bh64TkeSHcV/qbcsRtb1StUl5pMBZSQxnthMDug7PCng/qc7Wy0C3CIOrL+yEUO
	VUPwldAL6NrbDGtsgroKdUfbNwD5bSSo1djRS47IsDnE1dwhffFH7MaWeNBPDNWVd7VJRLYP4pbH1
	nPdZabEZAaZ/MZnD4mhlQPXWpZBVoY/NjC5kBY+Ugh6xC7tWfeTGsPECADEamvLQqIdPLNfaQ5r0B
	iO9Aj/NSIcqmDQZwZqudHjuLhNHI0n4fZeiLFEvgxChpVjVCJKB3kHJxaifPsOxZZJyMkMJX1SbzX
	m1zOmTkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we52P-0000000DjYR-0c7Z;
	Mon, 29 Jun 2026 06:00:09 +0000
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we52M-0000000DjXs-3Qka
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jun 2026 06:00:08 +0000
Received: by mail-dl1-x122c.google.com with SMTP id a92af1059eb24-139f3eaaa49so577366c88.0
        for <linux-nvme@lists.infradead.org>; Sun, 28 Jun 2026 23:00:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782712805; cv=none;
        d=google.com; s=arc-20260327;
        b=gfmekNhl+lQZB7eWT8b+txCHesIQfbQMxMVXSvC9BRDZpIvAkbcyAFYFwhU/C4sNoZ
         2fG5jnk/GN4rlpfTcgl51vJIzMXMJqJghPRZyes7eYRuYFEMh4iS1b9yG9tlrMF33z3v
         C7TkwqVKdpX6I6sdMSZOnYv08G5CrGZ1YgdNr+ztZx4euRN9+CX+Kx5AOnPYmqdnHEGA
         Oht+oXrYKJbZ7n27ykoul5tyGpttOyIvhyNE8VRBXIqhvVlLgUvQwlT1kVCSbGBejtOk
         TQR5vtfzfRWescLUyQk0Kmw/1oPV1TSSn2a96m7f+z7Zs5JgYxuJrE76tohAz7Qnu+NO
         HZog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=d4qCJSbwRvjJi29QkSJn6kYfBFh2rHegeHabowjGHFA=;
        fh=Uw/mbiO5FTPXKRSrwWSq0/+HfEVWWJP2hiD5gTllayQ=;
        b=ndrssG6IEBHTSyu6NsXIjmHDmfCNB//q4fW9I+ske1QjxNfGDhpRHd1HOsMIG2r+f/
         SDUNe4/u327qcu13W5e2u668TboHM6eKgSPqvZ293jL0sftFdQ3NIC84HYypHV2Vlw8G
         +ghce0B39sPF8LbVpn5FXRPrOXcTxk1qcz90R3Ar3iGoOJGsMhF4IqscGss2yvPLgxFM
         aJAbr+PQVmcY0nyr5PEo35nSCdsx7SgdCrfynb6RnTDs7rQv5JJ3E+WhRx5ocsy7Oxdk
         uc/VlFhsRWPcNDSwDmlnjr6/9nFkjSc7inSrf1qoXVWTmgHxk8qfLu+WycXxooMfbuuh
         2tag==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782712805; x=1783317605; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d4qCJSbwRvjJi29QkSJn6kYfBFh2rHegeHabowjGHFA=;
        b=O/2JSJT6LWdTB54cqTtPeNdqcjnLmXZVtaa4z/kHkc4jfGCA3UJTXP1iNl80uKyWav
         ruegLURqQFdk2wtTZPXJN47mM6EJov/LrKjpY/KkYmJZjzEwAhkQwLpi9sPN3f21J5TM
         sRRbSrFc3wEQMyg2UuSCs5kPG2oIS1ECDZcYrKm3tQ0XzANWZLGZLoVWpgpb6ezXGzeo
         ZZifL/V+Ssrjsdj5EJHRLirbQdcj9q0v9mS4EglJccaigx0coxbIcuKTNJ0vrMmLBxHf
         /r6QzXAXy4px5rMR+MfokJ/QE/fGlJxL6i+pdNbAan0bwcYSm618Dc9jV6MOIwyIPDn/
         tGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782712805; x=1783317605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4qCJSbwRvjJi29QkSJn6kYfBFh2rHegeHabowjGHFA=;
        b=VxulLi5gqrimmZ21vk/YRiZxD4y9OcgttavI+6E0cP+fAENW+bVyE6/TguBRkXhU4i
         ZGVfNqhC4zBv7MwmvfdBL4QI/TrkB77gESBwATEpRDYmEo6Z5pQW6s1Ik2X6MQTJ4+0N
         EQ2wMO99+Eieb4fnc4L/cUxGWPLdWP7gYSpmaXwEtvdxPKOH3KUNfRX16tIN6ZtK8aLP
         Yr9C1jVn1ZGSphzYKKC+k8fY03FVwJf6/W9+yn4ZVo8RB1z3e+Xj0jJ1yYyovAxY2aN9
         chB5I3MqtPtqUzlFLKUDhOGB0OavqPTAb28o0gbEVDwIxUW3hMXnAc1YkqSkRwJRw3HI
         S45A==
X-Forwarded-Encrypted: i=1; AFNElJ+Zr3/UZzY6s1qsYfyaFgZ1F/7/28XL+GCYkZZ6Ql3y9e3jpwIv6iamYW3Rr+nbmoHkZar1h4go+KlU@lists.infradead.org
X-Gm-Message-State: AOJu0YzLfMlSFnFR8/olj1d8fxrW8OeijkM1soUjFTcVEPTDJMRtN+vF
	XjQj3RbtyjUEF0Cnffn4ScUprDnTdYtU8Ef7ezJ3Tplol5zLbF8BvKrZQLrBeKS5RwCtXZ/iOH5
	ZgQShAeDoPJK+TeVxhSOQMskqgCdNsWw+o73sh8Ym
X-Gm-Gg: AfdE7clbXVg43kiQiNV9D6bNoKdwsvCN2FQArjR4eMHyeoAIhf+iV11oKhz8ZrBABHE
	IYbj0nc6cvmNT/xc9kDz7mVnxewcr0qCjtia5/3hSoVdKBUSKJRvZNH1Cf56x/Lw3O9aucwHnAL
	C+67L6bdOgEHRCekHibVaMf8DHOdA0/owbK/jJUjcXkyXcd6WeDL7byot+WPC+wb79pKgVcHms/
	eHqhx5sRRUNCpDlwBJxQ1NgL4sP/sfRBaTpiv2fLwBqy6YIQEMToutWnJ9wVP5Voi7MlNoIl3um
	TfH/qA==
X-Received: by 2002:a05:7022:3d0f:b0:132:f16:a574 with SMTP id
 a92af1059eb24-139dbb1868amr11770147c88.7.1782712803998; Sun, 28 Jun 2026
 23:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260614131541.2017845-1-nilay@linux.ibm.com> <20260614131541.2017845-6-nilay@linux.ibm.com>
 <20260626064050.GE10731@lst.de> <e1c60afc-423b-47ec-9c38-db1397d8838f@paulmck-laptop>
 <CANpmjNPPF3TYx6qPzLO-DbQE6qvL_g6r3jYnGCk3aqeiQnnL5g@mail.gmail.com>
 <41a4cb5a-077c-499f-b060-2a4263303350@paulmck-laptop> <CANpmjNPAYsiQ=eiZ=0g579j1uO+-23ZXAhRA7M3uM-B8NdHg1g@mail.gmail.com>
 <62bbec8e-6eb5-4024-acba-6be1e7f33080@paulmck-laptop>
In-Reply-To: <62bbec8e-6eb5-4024-acba-6be1e7f33080@paulmck-laptop>
From: Marco Elver <elver@google.com>
Date: Mon, 29 Jun 2026 08:00:00 +0200
X-Gm-Features: AVVi8Cfb0BWu513O42GKJA2A1V_7XVUctAXaRc91r15-yInvHgkk3vzA-WrYgDs
Message-ID: <CANpmjNOJ6HnkjsGR-7pn=3uy1nOOgFGC-FXVd4idbF-KrHqaNg@mail.gmail.com>
Subject: Re: [PATCHv2 05/17] nvme: add Clang context annotations for nvme_ns_head::current_path
To: paulmck@kernel.org, Nilay Shroff <nilay@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kbusch@kernel.org, sagi@grimberg.me, 
	axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260628_230006_914771_5A34876D 
X-CRM114-Status: GOOD (  48.15  )
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

On Sun, 28 Jun 2026 at 18:07, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sun, Jun 28, 2026 at 08:00:00AM +0200, Marco Elver wrote:
> > On Sat, 27 Jun 2026 at 19:14, Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Sat, Jun 27, 2026 at 05:38:44PM +0200, Marco Elver wrote:
> > > > On Fri, 26 Jun 2026 at 20:36, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > > On Fri, Jun 26, 2026 at 08:40:50AM +0200, Christoph Hellwig wrote:
> > > > > > On Sun, Jun 14, 2026 at 06:45:20PM +0530, Nilay Shroff wrote:
> > > > > > > +++ b/drivers/nvme/host/multipath.c
> > > > > > > @@ -231,8 +231,16 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
> > > > > > >     bool changed = false;
> > > > > > >     int node;
> > > > > > >
> > > > > > > +   /*
> > > > > > > +    * This helper is used by namespace failover/teardown and I/O policy
> > > > > > > +    * update paths. We only compare the head->current_path[] pointer value
> > > > > > > +    * and do not dereference the referenced namespace, so suppress the
> > > > > > > +    * context analysis warning for this lockless inspection of the
> > > > > > > +    * __rcu_guarded pointer.
> > > > > > > +    */
> > > > > > >     for_each_node(node) {
> > > > > > > -           if (ns == rcu_access_pointer(head->current_path[node])) {
> > > > > > > +           if (context_unsafe(ns ==
> > > > > > > +                           rcu_access_pointer(head->current_path[node]))) {
> > > > > >
> > > > > > I think we need a helper for this, as for a simple pointer value
> > > > > > comparison without a dereference we don't really need either
> > > > > > rcu_access_pointer nor locking.
> > > > > >
> > > > > > Maybe somthing like a
> > > > > >
> > > > > >       rcu_compare_pointer(rcu_pointer, nonrcu_pointer)
> > > > > >
> > > > > > ?
> > > > >
> > > > > We could provide something like this:
> > > > >
> > > > > #define rcu_compare_pointer(rcu_pointer, nonrcu_pointer) \
> > > > >         context_unsafe(rcu_access_pointer(rcu_pointer) == (nonrcu_pointer))
> > > > >
> > > > > Or maybe rcu_pointer_equals()?
> > > > >
> > > > > Marco, thoughts?
> > > >
> > > > I see 2 options:
> > > >
> > > > 1. rcu_compare_pointer / rcu_pointer_equals as proposed. It's more
> > > > explicit but does add some friction during Context Analysis
> > > > enablement. But this only makes sense if there are cases where
> > > > rcu_access_pointer() should be used under the RCU reader lock, which
> > > > led me to the next suggestion...
> > > >
> > > > 2. Redefine rcu_access_pointer() to just not require the RCU read-side
> > > > lock to be held as:
> > > >
> > > > > #define rcu_access_pointer(p) context_unsafe(__rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu))
> > > >
> > > > [ Or alternatively wrap __rcu_access_pointer() in context_unsafe()
> > > >   (similar to rcu_assign_pointer and friends). ]
> > > >
> > > > I think rcu_access_pointer() is in the same category as the other RCU
> > > > pointer helpers, although currently only the pointer update helpers
> > > > imply context_unsafe(); I think it might have been an oversight
> > > > initially, and we should change rcu_access_pointer() to match. There
> > > > should be no reason why an rcu_access_pointer() should be protected by
> > > > the RCU read-side critical section, since it's not meant for
> > > > dereferencing the pointer (that'd be a bug; its documentation also
> > > > says "Return the value of the specified RCU-protected pointer, but
> > > > omit the lockdep checks for being in an RCU read-side critical section
> > > > [...]").
> > > >
> > > > If you agree there should be no cases where an rcu_access_pointer()
> > > > should be guarded by an RCU read-side critical section, then I think
> > > > this is the simplest and correct design, and avoids expanding the RCU
> > > > API.
> > >
> > > I don't know of any uses of rcu_access_pointer() within an RCU read-side
> > > critical section, but code in a function that might be called both within
> > > and outside of a critical section might well use rcu_access_pointer().
> > > In other words, it should be OK to use rcu_access_pointer() within an
> > > RCU read-side critical section as well as outside of one.
> >
> > Thanks, yes, that's what I wanted to confirm; i.e. it's ok to use
> > rcu_access_pointer() within and outside an RCU read-side critical
> > section.
> >
> > In which case, my proposal (2) to make rcu_access_pointer() not warn
> > on accessing __rcu_guarded pointers outside an RCU read-side critical
> > section should be the simpler and more generic change (vs. adding a
> > new rcu_pointer_equals() helper).
>
> As shown below?
>
> My guess is that this change makes it unnecessary to have a separate
> RCU-protected-pointer comparison macro, but please let me know if I am
> missing something.

Looks good to me. Yes, this makes a new comparison macro unnecessary.

Nilay, does this work and simplify the patch for you?

>                                                         Thanx, Paul
>
> ------------------------------------------------------------------------
>
> commit 32c1e63fee171f7ed8cc986ec64f576ee80bccab
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Sun Jun 28 09:00:01 2026 -0700
>
>     rcu: Mark __rcu_access_pointer() as context_unsafe()
>
>     A simple comparison of a pointer returned by rcu_access_pointer() results
>     in a context-analysis warning for lockless inspection of the RCU-protected
>     (also known as __rcu-protected) pointer.  This can be suppressed by
>     placing context_unsafe() calls around calls rcu_access_pointer(),
>     but this is messy and distracting.  This commit therefore wraps the
>     underlying __rcu_access_pointer() macro with a call to context_unsafe(),
>     thereby informing the context-analysis code that rcu_access_pointer()
>     may safely be invoked outside of an RCU read-side critical section.
>
>     Reported-by: Christoph Hellwig <hch@lst.de>
>     Suggested-by: Marco Elver <elver@google.com>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 5e95acc33989b6..e40dc2e20c5b1f 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -490,12 +490,12 @@ context_unsafe(                                                           \
>   */
>  #define unrcu_pointer(p) __unrcu_pointer(p, __UNIQUE_ID(rcu))
>
> -#define __rcu_access_pointer(p, local, space) \
> +#define __rcu_access_pointer(p, local, space) context_unsafe( \
>  ({ \
>         typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>         rcu_check_sparse(p, space); \
>         ((typeof(*p) __force __kernel *)(local)); \
> -})
> +}) )
>  #define __rcu_dereference_check(p, local, c, space) \
>  ({ \
>         /* Dependency order vs. p above. */ \

