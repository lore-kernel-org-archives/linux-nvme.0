Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15CDCA6019
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2026 14:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/deJepVSy1q46FcuWbk27eGOV5yZN7U0qk5r5k6TxfI=; b=E85IS1OtdFzyEygE0WHGoxbqFG
	fANsI4NtPgbVbOVmUlLJyUzBtV8JWA4mSPHnKJYcv5oeZMo80GfMOivE2lMrKqAZ04etwpAUxqrWU
	0tN6iAcAovfDbZ9NDdyCMjjx1kqujSD8EWopbgFbn6HCGzFWtN+Jwuj7VxCTag9VSa7+sFYxdaWxj
	hNRnxH+yW8AavJ3Yc5lbfcv/nqFTVxW9jwF5IHc19RtusjFCbxjUaXfGRss5bvEpwDbX/+jmUj6hJ
	zAPGY+exCtZOXKB3newVsvkqp1vSEHfVjwIqKGkeMTf+O2+60OK6HR4cI9oT+igGFMnSI+PTT4rbe
	V2gaHbeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFC40-00000006VYJ-3adU;
	Fri, 09 Oct 2026 14:59:12 +0000
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFC3x-00000006VXX-3toD
	for linux-nvme@lists.infradead.org;
	Fri, 09 Oct 2026 14:59:11 +0000
Received: by mail-dl1-x122d.google.com with SMTP id a92af1059eb24-144e1b6d52cso6198c88.1
        for <linux-nvme@lists.infradead.org>; Fri, 09 Oct 2026 07:59:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791557949; cv=none;
        d=google.com; s=arc-20260327;
        b=poruIzJVry6CJrVOF5a6xI8HJUoBoWqQ7aslzD6CF3nrq/75zUje/CAYQ9UNrfd/Dd
         AF/M89onyQAZVyvqta9dQPpWg0uOn/2Al1bmLSCA+nJfsUjPJPtZtUxgnB3eE32uZ2MF
         ea1IpT+voPb9FAOGSulXb9d/CxjL2DWmomdgkTEc63EGmU4xsAvw3mzQWz/tlfEchYfY
         u95H1zTxLSZWIdN78NSqMxZJqG9iuFbd/Vf3fWFln5kxWCFA1G7ZmKlRlhyHOAWY3BgE
         k0qz4NZ8sq2tvQ3zqy0mqJgKsGWjff2fXSt9p1BQI0KVScWXyWrOg9p2ij/ZeOl702dO
         bfDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/deJepVSy1q46FcuWbk27eGOV5yZN7U0qk5r5k6TxfI=;
        fh=PVAj2D/H4a33QQKWq/kYyLpg8GACDIEItH7YvKFLVYA=;
        b=jJhbczXTIsDW70AdHI6ZNxhiJwNc9VXPgupPps4YmuTaSqq6BYGJakGJrw4ScRhJif
         8I6vBBvJD+TRXqmV9QeEa2mMcQuk7U2lk1nr0DXQpBlHuqGpLFFum6BmgYmmrAOtbksE
         fxz0m8SFspCpAcxNiEhRzkBSafeb4gf45rdVaUnR5Zo46Ex1JcCRq9quS28M7ZHG3cnt
         0y5UG+QFtVC0biX/96rfizA1EaD5mAm5bAMqH9djmvlqyXXb8WzslfUZCsIO5+zETbIk
         8dCtisNpIUKpLGQAo8lcTLrBs32FqNQ1MKGNvOUWadl4buKEVzFpZUe5quNlkvyiO7yG
         INnA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791557949; x=1792162749; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/deJepVSy1q46FcuWbk27eGOV5yZN7U0qk5r5k6TxfI=;
        b=pr0qRQDSDN8Z/YlMntBRccUDbI5Z1ILw3wY8I4GlNY/cTlZbhwbP04gdVB78fpMAb9
         +syhvNf3ll8CCSkurhx44toSTfmt2uyNlC42QEDFWsmPiiHrqNxAMxA30M7MSFTy0Z0l
         8MxcWUikw966K1b+ufTagqsP/aZDwzgvN0O3s8cxDKC0OJOaHwZY34Gd2MBdSSLPEfyl
         IePpD5VSypUPNpHgz9jH1ZVBF+QFzaz5meTuBPTHzFS5B2oBOV98hVHnMXuQShw6Yjtv
         4QIgNfg7BkZ1RgJJWHXEHhNuYdNFV648izlflWpu1qMFofk7VmlLd+FFit+1UCQHlIXL
         BDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791557949; x=1792162749;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/deJepVSy1q46FcuWbk27eGOV5yZN7U0qk5r5k6TxfI=;
        b=vRH3HcycjnFu2LObdx72YFocnsmBNPjmX/831hqOZBi4O0klK7HnQSUwEGgfIqbYwh
         wN/t0eLU/DUAPpjsWCR+AAUd0Qnc662wyyZ1WOnHKIlsFzmZrMJzpqa6qSIaXh8yZnHP
         Jsgr+g2CAA+xD+HwSKEclBZRJJFx2oquaSY4ChsXRKIwvDQqea9W4HIQIAorqRnZq/ZD
         pOsTtPV6lJMdsB18ppPHeeFS9a6xezkmh0VI9HVUIk8QrvBJJYJ+J/csARXEPGrfUezL
         a55u79Lv9BNUDxS45BXDfBkJK91ORP814hhcMxkabfbNYlVjBlcFqPAwoMhssbbUH2e4
         2v+w==
X-Forwarded-Encrypted: i=1; AKwUvBxZJXHL6v3mnZLdNcLjq+0HbTbeSNZ0BsbflaNg06JHCWhpTMqoJf3+twhUFkZJXKfz5FuUL6m43tGG@lists.infradead.org
X-Gm-Message-State: AFuF++kupCIDgKypaGDbKjIP9GYxSazDqctAkMdRSAb5/pETynMltTeA
	XQDSQxBEecUN4YWZuweX1mHFfkFIi52Zda7A9ZYgFH2qnvXScUNQjTB3Z7k5hYUWjcdsTACjTby
	Mk1U3lVUvjRuqiTJV+NoYOoWIE0TUC2Uu6sqM4G0/
X-Gm-Gg: AYBFou0PlhhDXnrC4RfkW/rowGcp1ozWxShy7JlEAj40q/D3lR5Y5n+OV3/pwYQ1VUa
	SZHvKgQWip2R+G9ycVXsry/+ZPILbzOrHjhkgFmh6xnp5UTfkcjpN4yuduTlnccq5dAOw3+N9yE
	XMaLvYpu4gP2Qo4A1FC2viV2RWCgRZ9sTRLSZkg3B7pbylLGsGN//sMORcErta+YVs6CaIRSmpH
	n4T5BNhAl+SYOfOCaCvqyb76ElpgjP5S7a3WtYXooCqrqaUz0EYqWlwn4eJEz8EsbPLkHWIis+j
	hge+169z1meTMAoegnMnefWQ+VSmvI+D3xq54fKxpRxuI1KgO0QNoUdH
X-Received: by 2002:a05:7022:40c:b0:151:f5f7:b423 with SMTP id
 a92af1059eb24-16a4cec574emr313527c88.10.1791557947600; Fri, 09 Oct 2026
 07:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20261009050556.2817978-1-namjain@linux.microsoft.com>
 <MN2PR02MB6863FBC36CE4F1D6419F0E8BD4922@MN2PR02MB6863.namprd02.prod.outlook.com>
 <04d88297-1732-4761-ae82-d68c441a7156@linux.microsoft.com>
 <3f4a11ea-bbc0-4dc5-9720-3447346739cf@linux.microsoft.com> <CAMOZA0Ljw-DueDP3WvmtYe4x9Y_fNaptAo+3Hv8xzYHOZi9vbQ@mail.gmail.com>
In-Reply-To: <CAMOZA0Ljw-DueDP3WvmtYe4x9Y_fNaptAo+3Hv8xzYHOZi9vbQ@mail.gmail.com>
From: Luigi Rizzo <lrizzo@google.com>
Date: Fri, 9 Oct 2026 16:58:29 +0200
X-Gm-Features: AclHuK-m9limdcYUcwxZk2GykJcipkv6UowoA2Ws1KR0RewlWyRADdHddO4VXeo
Message-ID: <CAMOZA0KJoS4GFrKmaGa7+qMCNktTUg-YpkzX_EoA2KfAW3iN_g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] nvme-pci: yield completions under scheduler pressure
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, changfengnan@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261009_075909_975380_1A05AA84 
X-CRM114-Status: GOOD (  42.37  )
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

On Fri, Oct 9, 2026 at 1:27=E2=80=AFPM Luigi Rizzo <lrizzo@google.com> wrot=
e:
>
> On Fri, Oct 9, 2026 at 12:17=E2=80=AFPM Naman Jain <namjain@linux.microso=
ft.com> wrote:
> >
> >
> >
> > On 10/9/2026 12:21 PM, Naman Jain wrote:
> > >
> > >
> > > On 10/9/2026 11:24 AM, Michael Kelley wrote:
> > >> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, Octob=
er
> > >> 8, 2026 10:06 PM
> > >>>
> > >>> On systems with several fast NVMe controllers, completion interrupt=
s can
> > >>> keep returning to the same CPUs faster than scheduled work can run.=
 Each
> > >>> handler may drain only a small number of completions, but the combi=
ned
> > >>> interrupt stream can still prevent scheduler and watchdog progress.
> > >>
> > >> See this recent proposal [1] that sounds like it is addressing the
> > >> same or a
> > >> similar issue. And there is this [2] more global approach. It's
> > >> worthwhile to read
> > >> through the discussion on both threads. I haven't done a detailed
> > >> comparison
> > >> of either vs. your proposal.
> > >>
> > >> Michael
> > >>
> > >> [1] https://lore.kernel.org/linux-nvme/20260818033846.53790-1-
> > >> changfengnan@bytedance.com/
> > >> [2] https://lore.kernel.org/lkml/20260819124341.4185621-1-
> > >> lrizzo@google.com/
> > >>
> > >
> > >
> > > Thanks for sharing these Michael. I'll check more on these, and try i=
t out.
> > >
> > > Regards,
> > > Naman
> >
> > ++ authors of these two series, for awareness and if there is some
> > configuration in their patches I should be trying to fix these lockup
> > issues.
>
> I see your thorough analysis below, thanks for the details.
> Is there any reason why you used nvme.use_threaded_interrupts=3D0 ?
>
> Setting to 1 moves the work to a kernel thread and seems to be the
> best way to prevent too much work in the hardirq and the soft lockup.
>
> I am surprised that GSIM fails to prevent the soft lockup, though:
> under high load the sequence of events (starting from unmoderated)
> should be the following:
>
> 1. HW sends MSIx interrupt, not blocked by anything
> 2. SW calls handle_fasteoi_irq() --> handle_irq_event() --> ... -->
> action->handler() which starts processing
> 3. HW possibly sends another MSIx interrupt
> 4. SW handle_irq_event() completes
> 5. SW irq_start_moderation() starts the timer, __disable_irq() and
> sets IRQD_IRQ_INPROGRESS | IRQD_MODERATED
> 6. if #3 happened, or another HW interrupt comes before the timer expires=
:
>   SW handle_fasteoi_irq() finds IRQD_IRQ_INPROGRESS | IRQD_MODERATED both=
 set,
>   and does not call handle_irq_event(), postponing the call
> 7. when the timer expires, the pending interrupt is reinjected.
>
> The above suggests that we should see some pauses between runs of
> action->handler(),
> at least for a single queue per CPU.
>
> Do you have any way to look with perf and bpftrace at the CPU
> processing interrupts,
> to see what keeps it busy (the pause between 6 and 7 should keep it
> well below 100%)
> and try to verify whether the calls to hndle_irq_event() are actually spa=
ced
> as the sequence above describes?
>
> Having multiple interrupts on the same CPU mean that the gap
> between interrupts for one can be used by others, and that may
> definitely make the CPU 100% busy in hardirq.

Following up on the multiple interrupt sources on one CPU, you could
try something like this:
every time an interrupt source comes while the timer is active,
increment a counter.
When the timer expires and the counter is > 0, add as many "gaps" as
there were sources.
This should restore the invariant that every interrupt source gets one
run per moderation interval,
and the adaptive control loop should adjust the value to hit the target

--- a/kernel/irq/irq_moderation.h
    +++ b/kernel/irq/irq_moderation.h

    @@  struct irq_mod_state {
    +    unsigned int        kicked;
         unsigned int        sleep_ns;
    --- a/kernel/irq/irq_moderation.c
    +++ b/kernel/irq/irq_moderation.c
    @@ bool irq_moderation_do_start(struct irq_desc *desc, struct
irq_mod_state *m)
             /* We need moderation, start the timer. */
             m->timer_set++;
    +        m->kicked =3D 0;
             hrtimer_start_range_ns(&m->timer, ns_to_ktime(m->sleep_ns),
                            slack_ns, HRTIMER_MODE_REL_PINNED_HARD);
    +    } else if (READ_ONCE(irq_mod_params.timer_push)) {
    +        /* Timer armed: record the kick, timer_callback() will
push it forward. */
    +        m->kicked++;
         }
    @@ static enum hrtimer_restart timer_callback(struct hrtimer *timer)
         lockdep_assert_irqs_disabled();

    +    /* Push the timer forward by sleep_ns for each kick received
while armed. */
    +    if (m->kicked) {
    +        hrtimer_forward_now(timer, ns_to_ktime((u64)m->kicked *
m->sleep_ns));
    +        m->kicked =3D 0;
    +        return HRTIMER_RESTART;
    +    }
    +

cheers
luigi

