Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238E0CA9ED1
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2026 09:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bLXlg2Zl+SnMXYI2B0PTH2g6n6WahQOBn4X4k4dpYkc=; b=rVVWstYNJbyedDQwlp9ckYuve+
	qVjsrPBk4n02jge0zzYMEy7gEFjCdTHRxmSu8tnbrnwL2Vl7voyF0xY0gObN7WkdoAQqyoTVEajLa
	4fjUyz6uVz8po2STyzw6NTHTIKT1o2V4TKnwFJMAX8njBTRh9B75lozaTTh2VZdJ1smX8peog1TOX
	hAferv2A4dsxrdWTm+/BTufXMhTbFqpOI8McMnqboIJiA08gr+WuNSKL5GQlcGguzOqf6XlKl040+
	DJQ+4cIL2e9HeZc5kJckprdP6uzbFUwdqfhF15yAjGxn23Bn5u5d4Kf1Mkg5uo+a2gST3h79SvpOi
	bSmYMd4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGCAT-0000000A2Il-1CUT;
	Mon, 12 Oct 2026 09:18:01 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGCAO-0000000A2IM-3oxF
	for linux-nvme@lists.infradead.org;
	Mon, 12 Oct 2026 09:17:58 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so20815ad.1
        for <linux-nvme@lists.infradead.org>; Mon, 12 Oct 2026 02:17:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791796675; cv=none;
        d=google.com; s=arc-20260327;
        b=nbJufKIxbPvtjU4N38mA6CBNh39oeXICKWnWt/NFKEFRAiOutKgUjw587mFXlky7hV
         FqqgunMhXpTNiYEo6ffXt+X7Ox88TkO5qobUjN9nhgVF+L6PPDzEYkCH+U+rsJD3hVGC
         fRP4O/BU+jiOWVsF5oLo89kTRomKu55jXQgl+8Vuv9z716YbQITirLlLQd+BWKSgLc8g
         0s0iBrNIpQsrf6e1tjiqvbEzm9d7l8ag/AcnpHbr/bMSvFfSVo/Wf+pLx6gr8ePtoASt
         Sr4jsZMTeEnxOQxYlY0+CMF/WAumPfZinNUDM8tSREzV9TQafvbGSJEKjwYDgxmrtz1M
         roPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bLXlg2Zl+SnMXYI2B0PTH2g6n6WahQOBn4X4k4dpYkc=;
        fh=ARWKiqpXVvDxbZw7X8U1YgWI974VQ/ZJWAWY3WNUMaY=;
        b=SM95c7bAOsW4pnZZ91N1I5atzRqedg/jMseW3b/W33+ZJaeLywgEgWeWeCc096aDxv
         WtFb0qhWufcdPM4fUVNEkQzBDMwFxBHtwaav0Yms1X8n+jS3ZdGGVVwLu2GAIm28WLRD
         w7l0RY+DL8R7FZhtm5wJmf9IPgry6V3us3d5U5g6Hq6bsVGcN5nphvfimBca5axsa0NU
         NbmnFN3QNABd4xP7gfjdfZP3fO1kByZXZqmYv8FQPTcy4UmzCxjnIewSNyhd7Zy0qjIK
         E5WYcN1wbeFzPwh+oSsnNMki+F5FayoEme6Q4FOHOCVtaI62CklEG6LH53smAooJ/reO
         iL8w==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791796675; x=1792401475; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bLXlg2Zl+SnMXYI2B0PTH2g6n6WahQOBn4X4k4dpYkc=;
        b=dk0s9DNzTtA5eqvxZSPRC8oEGlGKdtgLIKE2iNGFdOOuJxbnEhg0lVzgmkI4HKGr3n
         6tN/z2rSW+IRKlCn7ifJXv7m4JCmMuHJ4ksodiWkcoC1gi9IfASYnbVMfBG4mLpJ22ae
         8LVxLdRyS0C3/uxIK6wbekzB/cRpJ+c+9dCmhAwF9wFovt7GX4AGIC6iisBizllE/lKA
         H+wSEA42CSN/YB8RTC+gd+Gn9vYW00P1KdrC4mtGUNO8o+JBcx4g1U2qn5C5S4uZj1jh
         9LBU2KL0ulK+MF8KXtctugBmEso6FvZijGhXuFqz+CfBE8TTX/bQIQvWPkCdfqLSMIdk
         NhfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791796675; x=1792401475;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bLXlg2Zl+SnMXYI2B0PTH2g6n6WahQOBn4X4k4dpYkc=;
        b=c0nwPstQIKRNVZ3YCbD9+/bGwsXXTSktCWq3xmcplCDubGL05sQbBP/IU5iDIfowPP
         CCYmNrKkZIAb4xDZ+3ZDyXBUBQCV7u5KDX+8B+2rrsSrqE08adb3YK212gmKN2VDb3TU
         9Lefw+fOs7hbw47yixoyhEaMsFgn8VJZftsNyvQefV2M+1s14PaNsECJBNM2WPuR5yWb
         5nYMHrW/Z+VwWJXOxL5cTjEP50RCzqCOyUN47mZt/vZFpU8JwWwUOIwcfFZp7LTLfuqZ
         eYPUBlNqO6FIlQBMaVlkm49p/DnkeGONDWCL02Gf0y9W9bTjuTSOjCGVOWJ2P6riw628
         5cmQ==
X-Forwarded-Encrypted: i=1; AKwUvByfs6fJC84VYkTAdQkIiIh8a/e4Vh8fDJh1VtYPkz6TiAG1l8XRq+mcH72EB7smYElmKLwOqzwGiWSC@lists.infradead.org
X-Gm-Message-State: AFq9FYKfOZcN7uyym835ni4DIlul8EP2V4KHagZfLtt82yw2o7D23/mP
	1cxePssDhj83qbyoiASXFW5zVj+kcPKLtdFniEwr+4BAxknd15fA9Z/ewhgsOAANy+axGDHe8kA
	ieYZt84KUSXPwXnG44Y2iKZRY7BJWlP8b3PNEnem9
X-Gm-Gg: AYBFou1PpAB45Xhamq5FKoPC9BfjipL+vW0RGd8ai91F8IPM7HPwrz4w819Jj9AP06y
	CfqJHS8eUhQKoMslVdLiLFllIR7swl5HFxMVTilQKY3odnhUk9PZCLpcO9cQ5vg2Zkf6vq8TjEb
	g3PK2NnXncnRzJBxgMLtyIuMM7paaFunPyqsWlEFaW1+BLRxY1m32lSHwZ20LE5hVm7A3WJq+Vv
	sXyQT4EncSe1s9FN5g3RSVO3eHtDPI3eYKQ29MWPrCNzKHw+odfU06XNpgokdsKsQo8onYm6xb3
	CGubgoquLt4oy8yUx+9lcS6mzeosCT0xNWWTbGig2qR9eBipdLa5a1Bi
X-Received: by 2002:a17:902:cf0e:b0:2e6:f400:5655 with SMTP id
 d9443c01a7336-2e87b9c037fmr5398945ad.3.1791796674314; Mon, 12 Oct 2026
 02:17:54 -0700 (PDT)
MIME-Version: 1.0
References: <20261009050556.2817978-1-namjain@linux.microsoft.com>
 <MN2PR02MB6863FBC36CE4F1D6419F0E8BD4922@MN2PR02MB6863.namprd02.prod.outlook.com>
 <04d88297-1732-4761-ae82-d68c441a7156@linux.microsoft.com>
 <3f4a11ea-bbc0-4dc5-9720-3447346739cf@linux.microsoft.com>
 <CAMOZA0Ljw-DueDP3WvmtYe4x9Y_fNaptAo+3Hv8xzYHOZi9vbQ@mail.gmail.com>
 <CAMOZA0KJoS4GFrKmaGa7+qMCNktTUg-YpkzX_EoA2KfAW3iN_g@mail.gmail.com> <53b199f9-56f6-4b44-93a5-be6437fd3fc4@linux.microsoft.com>
In-Reply-To: <53b199f9-56f6-4b44-93a5-be6437fd3fc4@linux.microsoft.com>
From: Luigi Rizzo <lrizzo@google.com>
Date: Mon, 12 Oct 2026 11:17:16 +0200
X-Gm-Features: AclHuK8b7Ekjps9gFjWxZLvZacLyDyhJhw6UHMDi-KXrVX-gzw676mEw94bJiKQ
Message-ID: <CAMOZA0JrxakyxxYPu72hk-jWQpW33-0BGFkZX-n_3D+28eDuGA@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20261012_021756_957994_D7DBF8BA 
X-CRM114-Status: GOOD (  36.92  )
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

On Mon, Oct 12, 2026 at 10:19=E2=80=AFAM Naman Jain <namjain@linux.microsof=
t.com> wrote:
>
>
>
> On 10/9/2026 8:28 PM, Luigi Rizzo wrote:
> > On Fri, Oct 9, 2026 at 1:27=E2=80=AFPM Luigi Rizzo <lrizzo@google.com> =
wrote:
> >>
> >> On Fri, Oct 9, 2026 at 12:17=E2=80=AFPM Naman Jain <namjain@linux.micr=
osoft.com> wrote:
> >>>
> >>>
> >>>
> >>> On 10/9/2026 12:21 PM, Naman Jain wrote:
> >>>>
> >>>>
> >>>> On 10/9/2026 11:24 AM, Michael Kelley wrote:
> >>>>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, Octo=
ber
> >>>>> 8, 2026 10:06 PM
> >>>>>>
> >>>>>> On systems with several fast NVMe controllers, completion interrup=
ts can
> >>>>>> keep returning to the same CPUs faster than scheduled work can run=
. Each
> >>>>>> handler may drain only a small number of completions, but the comb=
ined
> >>>>>> interrupt stream can still prevent scheduler and watchdog progress=
.
> >>>>>
> >>>>> See this recent proposal [1] that sounds like it is addressing the
> >>>>> same or a
> >>>>> similar issue. And there is this [2] more global approach. It's
> >>>>> worthwhile to read
> >>>>> through the discussion on both threads. I haven't done a detailed
> >>>>> comparison
> >>>>> of either vs. your proposal.
> >>>>>
> >>>>> Michael
> >>>>>
> >>>>> [1] https://lore.kernel.org/linux-nvme/20260818033846.53790-1-
> >>>>> changfengnan@bytedance.com/
> >>>>> [2] https://lore.kernel.org/lkml/20260819124341.4185621-1-
> >>>>> lrizzo@google.com/
> >>>>>
> >>>>
> >>>>
> >>>> Thanks for sharing these Michael. I'll check more on these, and try =
it out.
> >>>>
> >>>> Regards,
> >>>> Naman
> >>>
> >>> ++ authors of these two series, for awareness and if there is some
> >>> configuration in their patches I should be trying to fix these lockup
> >>> issues.
> >>
>
> Hi Luigi,
> Thanks for looking into it.
...
> GSIM was creating gaps for individual sources, but the other NVMe
> sources sharing that CPU were filling most of them.
>
> I traced irq_handler_entry/irq_handler_exit with trace-cmd for the four
> NVMe queue vectors routed to CPU0. The test used GSIM fixed at 10 us
> with all 56 data-NVMe I/O vectors opted in.
>
> Without timer push, I recorded 37,218 NVMe handler invocations in three
> seconds. The median handler duration was about 2 us, but the median gap
> between NVMe handlers was only 4 us. The p99 gap was 872 us.

(medians are not a good metric in an environment where there might be
a lot of idle runs because a previous, delayed run already consumed all CQs=
.
You may want to look at the full distribution, I expect to see a step at so=
me
point, the exact percentile depends on how many queues share the same CPU)

Just a clarification, the pattern I expect on CPU0 is something like this
NVME0 NVME1 NVME2 NVME3 TIMER_PUSH NVME0 ...
what is "mediam gap between handlers", is it the time between NVME0 and
the next NVME0, or between any two NVMEx and NVMEy ?

> With timer push enabled, the same three-second CPU0 trace contained only
> 531 NVMe handler invocations, and the median gap increased from 4 us to
> 517 us. This confirms your diagnosis, adding one delay per additional
> source restores a real CPU-wide gap.
>
> The full QD256 workload then completed without a soft lockup or kernel
> taint. There was a significant cost, though. The delayed completions
> accumulated into much larger CQ batches:
>
>    - median NVMe handler duration increased from 2 us to 3.1 ms
>    - p99 handler duration increased from 106 us to 7.1 ms
>
> For comparison on the same workload:
>
>    fixed 10-us GSIM + timer push: 1.906M IOPS
>    adaptive GSIM + timer push:    1.712M IOPS
>    threaded NVMe IRQs:            3.165M IOPS
>    NVMe IRQ-poll fallback:        4.986M IOPS
>
> So the timer-push idea does prevent the lockup, and the trace confirms
> the multi-source gap issue. On this NVMe topology, however, delaying all
> sources creates very large completion batches, and the NVMe handler
> still drains each batch without a bound in hardirq context. That causes
> the large throughput and tail-latency cost above.

Yes, without touching the nvme handler to limit the number
of entries processed in each run, there is only so much
a generic solution like GSIM can do.
This definitely warrants some NVME-specific changes
such as those proposed by Fengnan, and they are in line
with what NAPI already does by using a bounded batch
and rescheduling the handler.

I am a bit surprised by your numbers regarding the differences with
and without timer push, so I would like to understand
the numbers better.
(As an aside, 10us is really a bit too short for GSIM delay, because
almost 50% of the time gets eaten by the context switching.
At least for an initial assessment I would start testing with a fixed 30-50=
us)

Can you clarify the following, specifically for the "full QD256 workload"
- how many vectors are sharing one interrupt CPU (the previous test says 4)=
,
  and how many interrupt CPUs are used in total ?
- From my experience (different environments), I have measured
  < 1 queue - 1 interrupt CPU - 1 user thread > saturating at 400-600KIOPS
  (I don't remember whether the bottleneck is the user or interrupt CPU).
  At those rates, 256 outstanding entries may take some 500us to be process=
ed.
  so it seems strange that the median NVME handler (per queue?) takes 3ms.
- these times will be scaled down if each drive uses many queues so the
  average throughput per queue will be lower, and such to keep the total
  rate for each interrupt CPU below its 400K cap.

My expectations is something along these lines:
- the outstanding CQ queue cannot exceed QD ie 256 in your test
- worst case each handler should run at most some 500us
- four queues will create a total QD=3D1024 so the interrupt CPU
  will take at least 2ms to drain them

cheers
luigi

