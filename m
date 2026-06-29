Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB292C43327
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2026 08:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R306nIEUMHCgOYSTCOetNbPPgKocAGg7PlE/TvfoMxc=; b=fHBTC2YIGEdhONI87AxUpu5dXu
	JOgk+dQS6pPjYacm/04LHVMLo4RyXv4FdRRsqDeoE/6m8FyWSvsoUqTQMwOZm380X+FM0aex+njf6
	lWabzAGNOO5JuzIDWbePnmB4bohn4mlR1Cg+UdM9hsYK6+kdUzVcg0h6k9HLQ7qA/qyai/hIgdwfo
	ylnDjNQw329don39YHTKnCQOkjkc69YDzR9b0cX7ek/NmLDw2zH9XyWGxP5wbnORooCtUrv72R9R4
	dsaLEJx9C2vk6Rll8HrBplk1We5bGdKkCRn8DdMItXDR/UVlYWkRmdRDhesqBU9Hv7A8LHr84aThm
	106wC7dQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we7gD-0000000E2KA-3xbI;
	Mon, 29 Jun 2026 08:49:25 +0000
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1we7gB-0000000E2JS-2Goq
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jun 2026 08:49:24 +0000
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-1384ebe7a10so5815013c88.1
        for <linux-nvme@lists.infradead.org>; Mon, 29 Jun 2026 01:49:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782722963; cv=none;
        d=google.com; s=arc-20260327;
        b=drBYu34112Rysc187M10JtwOzAUzYfMvd13/Q+L/1+fUguN7083HGSQL/BWAUQTXn/
         xREvuV7mjMn6Ki0p/EL4W6d0tnUBj1Qmk3T/v2nWWadXf6kzbsPKRxq/Rw9fhs96puJR
         jg9z7JUS6pOpgQ+jXODO9NFXpwT50PTWZFknUxS6NjIHacbz5/POUOD43czbXuMxoS65
         tUutjQmpj/ZmmParS7caKuIbdAxG+uv6MOe/Dd+a7QKsFaMp4KwvmCfyWlh1I/KcSfse
         OzZjK91vg3I6aGk/X/1YLgN5/vHRfKfZhHv5zE0echKBy06tqHZVBOosOwfrgc6wphGZ
         zNnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=R306nIEUMHCgOYSTCOetNbPPgKocAGg7PlE/TvfoMxc=;
        fh=WRGvI53oJaf+Z575dIkmq/uFiavZVs73mYuF503OcMc=;
        b=rJVnYwG7xeSUbl3SWh2ZAK23d2jep8w8ZIJSfG+jvIs2gPSHyWHbW14NUwPaxCpHNk
         3lGhctLtq3KOcesiYhdnqJ0rreSwfRNLbiU0P7y6zoaLk0PQcE2FRInIKMbecpTpFR9s
         8ALS0EAcoTUf2kAlYL8Qj3cFeGoQvMuReNYmStZP/ikTJ5y+82uWu17eRbzY9dcWdRed
         8H0blGKyqCZHE3d/uUspHwJc3hFleFdWeCBXSOkBMmD7rDSTz3rxvJkcUpSPVTeNgBkZ
         tLTZZlyU7Y7Wc2DIGTYDqaVrRntZoTMd1gD8oNs6CQeaiH50JmdeqFAJ0KVa+stb2l6C
         srBw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782722963; x=1783327763; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R306nIEUMHCgOYSTCOetNbPPgKocAGg7PlE/TvfoMxc=;
        b=vpw0fIG6jRn7hrq0sK/fQQW8OD9pvPVLdzUrz9r2ta2eWJ74asqQiKii4DelM5LI7/
         2r+Dacd6rKnvCMF1tnuHzpRbD7KO9vDH4er2XcbDVYCL9B+Fqi3gswiyfoyspYpwr1h+
         ABCqEwiLHFNCKoH29LhGYm3UasqIeCtO7d4zZo0RCO2Cpj7B35/LUkhy9A3xks2pPsxl
         lGBzMk+ABxqXvoMYNceyVRe3z+EtN3sqOaXivL7I6TH2hOX53TV+ZgqPWJiupzZkT1hr
         irgpY3XiGWJSnKkDjDbqF+yN/6It3yYtaQ4lNe5QkrQvH6jx+luZcix68epbigxCe0ea
         Poxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782722963; x=1783327763;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R306nIEUMHCgOYSTCOetNbPPgKocAGg7PlE/TvfoMxc=;
        b=q4MtO7R7PXlPgbzVoK4EiJ2jzVSCWoen7vjpqqumljDrMVq+8mxEKCofTBm9eL0BwS
         W1r51z8TxXuCimHQrs00X7RoSwirKE4sCUjasQacT2vPWNCutKMpnR1vC+mqeYFUVSgj
         JF51vZB8B4fU5FN0N2zyVhNX5Lsq1BO4o+EsPGpSDkE/gN44wZZAwEYvwtT8HgfEKglj
         JV4XDCPaRHSgu1QH0coDOng1PyJyN/dhpl5kncXUiWjWDHBZJtW3MMm2+RPY/TD0xCma
         zXPcZOJdzyWSOwkQa2oQBxEe/xlm09R+pb9rZTZzgz56z2HjJ0GoO4YaarvGkziHkUDt
         w74A==
X-Forwarded-Encrypted: i=1; AFNElJ+y40LcsSUrd49nVpt8khWz60rQDwDEkkdY0uJmxXM/Vi1KVvpprM02ReBOIpZVz1qTnGJBo+uyNred@lists.infradead.org
X-Gm-Message-State: AOJu0YzCgriNzQa4Jf0qCQONUOx0UnMWyJ3WMarOaCtS6JGMAk3/V90V
	erddDKiot47bEgG835qKIcw38o8Zgy1skijvk1EXGgU7Avir8897UYPpTUAZMMbPQQ7wia8ImTe
	/hIHCPmMnC01Zq/FoELo4jy90mN1JpXZvXMNEhArF
X-Gm-Gg: AfdE7cm+CayAaCGlwo5afJ0CUGVDLY0HFlsgOfHd/U0oVSuEJoRpow4n6UA8ldcFbgr
	SfGVTQrbwN7j97doELa7HMwod8Bjhp2Qunyk7teoWRhi3vXKDlRD8Z8/WdlEM3Jk3aXcNcbJWGy
	645hawW+ERDFGBsoDSZ/RObyNZcoPzbEnidFEkpTKcgZel526NMdpBIJN1Qq9UREnQmbgkN1dp7
	mxqwQjvj0iP9iJKrAHTujauqmG3XJ8NTtRJrGxfeHHxhZnOf48XnE1c7G8uFFpl03nzG3A=
X-Received: by 2002:a05:7022:421:b0:137:ee9a:2acf with SMTP id
 a92af1059eb24-139dbb5b0c1mr15634454c88.24.1782722961692; Mon, 29 Jun 2026
 01:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260614131541.2017845-1-nilay@linux.ibm.com> <20260614131541.2017845-6-nilay@linux.ibm.com>
 <20260626064050.GE10731@lst.de> <e1c60afc-423b-47ec-9c38-db1397d8838f@paulmck-laptop>
 <CANpmjNPPF3TYx6qPzLO-DbQE6qvL_g6r3jYnGCk3aqeiQnnL5g@mail.gmail.com>
 <41a4cb5a-077c-499f-b060-2a4263303350@paulmck-laptop> <CANpmjNPAYsiQ=eiZ=0g579j1uO+-23ZXAhRA7M3uM-B8NdHg1g@mail.gmail.com>
 <62bbec8e-6eb5-4024-acba-6be1e7f33080@paulmck-laptop> <2a3c6a56-a9a6-461e-80ca-c0f2b4203bff@linux.ibm.com>
In-Reply-To: <2a3c6a56-a9a6-461e-80ca-c0f2b4203bff@linux.ibm.com>
From: Marco Elver <elver@google.com>
Date: Mon, 29 Jun 2026 10:48:43 +0200
X-Gm-Features: AVVi8CdPNt55cb_aOM8utWRPaEro_-3FFLUGGrqayor104H15-chWhJATM9y5ws
Message-ID: <CANpmjNNVw9rR5J-Bd3FL9Cxss3b+mN-XCGsg1c9HrTa70S0HEQ@mail.gmail.com>
Subject: Re: [PATCHv2 05/17] nvme: add Clang context annotations for nvme_ns_head::current_path
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: paulmck@kernel.org, Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kbusch@kernel.org, sagi@grimberg.me, 
	axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260629_014923_585236_9AAEDE10 
X-CRM114-Status: GOOD (  44.58  )
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

On Mon, 29 Jun 2026 at 07:20, Nilay Shroff <nilay@linux.ibm.com> wrote:
>
> On 6/28/26 9:37 PM, Paul E. McKenney wrote:
> > On Sun, Jun 28, 2026 at 08:00:00AM +0200, Marco Elver wrote:
> >> On Sat, 27 Jun 2026 at 19:14, Paul E. McKenney <paulmck@kernel.org> wrote:
> >>>
> >>> On Sat, Jun 27, 2026 at 05:38:44PM +0200, Marco Elver wrote:
> >>>> On Fri, 26 Jun 2026 at 20:36, Paul E. McKenney <paulmck@kernel.org> wrote:
> >>>>> On Fri, Jun 26, 2026 at 08:40:50AM +0200, Christoph Hellwig wrote:
> >>>>>> On Sun, Jun 14, 2026 at 06:45:20PM +0530, Nilay Shroff wrote:
> >>>>>>> +++ b/drivers/nvme/host/multipath.c
> >>>>>>> @@ -231,8 +231,16 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
> >>>>>>>      bool changed = false;
> >>>>>>>      int node;
> >>>>>>>
> >>>>>>> +   /*
> >>>>>>> +    * This helper is used by namespace failover/teardown and I/O policy
> >>>>>>> +    * update paths. We only compare the head->current_path[] pointer value
> >>>>>>> +    * and do not dereference the referenced namespace, so suppress the
> >>>>>>> +    * context analysis warning for this lockless inspection of the
> >>>>>>> +    * __rcu_guarded pointer.
> >>>>>>> +    */
> >>>>>>>      for_each_node(node) {
> >>>>>>> -           if (ns == rcu_access_pointer(head->current_path[node])) {
> >>>>>>> +           if (context_unsafe(ns ==
> >>>>>>> +                           rcu_access_pointer(head->current_path[node]))) {
> >>>>>>
> >>>>>> I think we need a helper for this, as for a simple pointer value
> >>>>>> comparison without a dereference we don't really need either
> >>>>>> rcu_access_pointer nor locking.
> >>>>>>
> >>>>>> Maybe somthing like a
> >>>>>>
> >>>>>>        rcu_compare_pointer(rcu_pointer, nonrcu_pointer)
> >>>>>>
> >>>>>> ?
> >>>>>
> >>>>> We could provide something like this:
> >>>>>
> >>>>> #define rcu_compare_pointer(rcu_pointer, nonrcu_pointer) \
> >>>>>          context_unsafe(rcu_access_pointer(rcu_pointer) == (nonrcu_pointer))
> >>>>>
> >>>>> Or maybe rcu_pointer_equals()?
> >>>>>
> >>>>> Marco, thoughts?
> >>>>
> >>>> I see 2 options:
> >>>>
> >>>> 1. rcu_compare_pointer / rcu_pointer_equals as proposed. It's more
> >>>> explicit but does add some friction during Context Analysis
> >>>> enablement. But this only makes sense if there are cases where
> >>>> rcu_access_pointer() should be used under the RCU reader lock, which
> >>>> led me to the next suggestion...
> >>>>
> >>>> 2. Redefine rcu_access_pointer() to just not require the RCU read-side
> >>>> lock to be held as:
> >>>>
> >>>>> #define rcu_access_pointer(p) context_unsafe(__rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu))
> >>>>
> >>>> [ Or alternatively wrap __rcu_access_pointer() in context_unsafe()
> >>>>    (similar to rcu_assign_pointer and friends). ]
> >>>>
> >>>> I think rcu_access_pointer() is in the same category as the other RCU
> >>>> pointer helpers, although currently only the pointer update helpers
> >>>> imply context_unsafe(); I think it might have been an oversight
> >>>> initially, and we should change rcu_access_pointer() to match. There
> >>>> should be no reason why an rcu_access_pointer() should be protected by
> >>>> the RCU read-side critical section, since it's not meant for
> >>>> dereferencing the pointer (that'd be a bug; its documentation also
> >>>> says "Return the value of the specified RCU-protected pointer, but
> >>>> omit the lockdep checks for being in an RCU read-side critical section
> >>>> [...]").
> >>>>
> >>>> If you agree there should be no cases where an rcu_access_pointer()
> >>>> should be guarded by an RCU read-side critical section, then I think
> >>>> this is the simplest and correct design, and avoids expanding the RCU
> >>>> API.
> >>>
> >>> I don't know of any uses of rcu_access_pointer() within an RCU read-side
> >>> critical section, but code in a function that might be called both within
> >>> and outside of a critical section might well use rcu_access_pointer().
> >>> In other words, it should be OK to use rcu_access_pointer() within an
> >>> RCU read-side critical section as well as outside of one.
> >>
> >> Thanks, yes, that's what I wanted to confirm; i.e. it's ok to use
> >> rcu_access_pointer() within and outside an RCU read-side critical
> >> section.
> >>
> >> In which case, my proposal (2) to make rcu_access_pointer() not warn
> >> on accessing __rcu_guarded pointers outside an RCU read-side critical
> >> section should be the simpler and more generic change (vs. adding a
> >> new rcu_pointer_equals() helper).
> >
> > As shown below?
> >
> > My guess is that this change makes it unnecessary to have a separate
> > RCU-protected-pointer comparison macro, but please let me know if I am
> > missing something.
> >
> >                                                       Thanx, Paul
> >
> > ------------------------------------------------------------------------
> >
> > commit 32c1e63fee171f7ed8cc986ec64f576ee80bccab
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Sun Jun 28 09:00:01 2026 -0700
> >
> >      rcu: Mark __rcu_access_pointer() as context_unsafe()
> >
> >      A simple comparison of a pointer returned by rcu_access_pointer() results
> >      in a context-analysis warning for lockless inspection of the RCU-protected
> >      (also known as __rcu-protected) pointer.  This can be suppressed by
> >      placing context_unsafe() calls around calls rcu_access_pointer(),
> >      but this is messy and distracting.  This commit therefore wraps the
> >      underlying __rcu_access_pointer() macro with a call to context_unsafe(),
> >      thereby informing the context-analysis code that rcu_access_pointer()
> >      may safely be invoked outside of an RCU read-side critical section.
> >
> >      Reported-by: Christoph Hellwig <hch@lst.de>
> >      Suggested-by: Marco Elver <elver@google.com>
> >      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index 5e95acc33989b6..e40dc2e20c5b1f 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -490,12 +490,12 @@ context_unsafe(                                                         \
> >    */
> >   #define unrcu_pointer(p) __unrcu_pointer(p, __UNIQUE_ID(rcu))
> >
> > -#define __rcu_access_pointer(p, local, space) \
> > +#define __rcu_access_pointer(p, local, space) context_unsafe( \
> >   ({ \
> >       typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
> >       rcu_check_sparse(p, space); \
> >       ((typeof(*p) __force __kernel *)(local)); \
> > -})
> > +}) )
> >   #define __rcu_dereference_check(p, local, c, space) \
> >   ({ \
> >       /* Dependency order vs. p above. */ \
>
> I have tested the above patch with an __rcu_guarded pointer accessed
> outside an RCU read-side critical section while Clang context analysis
> is enabled. I can confirm that this change suppresses the context
> analysis warning when the pointer is accessed via rcu_access_pointer().
>
> With that, if you send out this change, please add:
>
> Tested-by: Nilay Shroff <nilay@linux.ibm.com>

Thanks for double-checking.

Reviewed-by: Marco Elver <elver@google.com>

