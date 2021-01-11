Return-Path: <SRS0=B93q=GO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A358C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 18:15:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61671207B1
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 18:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61671207B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CmtItqUKDfE6Fy90D+Ng/4tGn9bsLW1WRkD0cKeLrUA=; b=BORvKI7ua2WEAr3eQ3Lb8n8Ma
	9CFrzWGXFwtMzWgTy/zKRG1EtoIHmVdaC2Sk6sJfCh2nhnfM5GvovrgRlf2JurMNImZsM3DYgLjZc
	DRV7Z13t3iMmw3LISBwh2RtGRV8fe/+2VhyN+fMPVkOvh056Bl4XlnLX5z1KHRE5WNyd61Ci6jrNV
	NvR510NT0LkaHMIGiwLllg6J5GbABoYtvfz5HtEsEktSi1410bv5VOOw1nDWV4m5vwcivG5y0XzMw
	l9CO258AgMQ8Tl94u32YfZ9dv8lav6plSu4xebk0FlJaVcVULzpspHErpbugORb1NeN5AX/pzwzH4
	zg+2n7P9w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kz1jI-0005Hx-RG; Mon, 11 Jan 2021 18:15:48 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kz1jE-0005FZ-4k
 for linux-nvme@lists.infradead.org; Mon, 11 Jan 2021 18:15:45 +0000
Received: by mail-ed1-x532.google.com with SMTP id cw27so738737edb.5
 for <linux-nvme@lists.infradead.org>; Mon, 11 Jan 2021 10:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RcqeDQE5LH6fB8dKfgjP3DrZ9mN0XGhWSFEEnVxfPPA=;
 b=Q1oOEB13Vdab2t3qwH8Zwl05Ng6pBt2qINhmY3XojRUsq2UuxwBZ0II2OqOaSRmynn
 nRtgPruahcr+LSQX0HuLn9BdXu9wAKrJJT0NSsyJhhLrqpKxaEBIxlnnHe/TV63uwVw9
 m3ABg1HXuu7GDDjdA9S78T59C9YJAcVrpRxIq2UZr25qcUTKgkpcHRq32tFB2GyzwTNn
 VsSVg/zh3PCsa9r0QCUTaV+mk0iZk4gJgRDRmhv/laSNTX4zUvoYFIH4Raxj98ZmZ/cW
 0u7jYbdci3CVsGamDshB8OyIUKZhXq9bw4CbyOsmAdgMxrVRt82NIMH5suCp4asoceJY
 uL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RcqeDQE5LH6fB8dKfgjP3DrZ9mN0XGhWSFEEnVxfPPA=;
 b=E9HGh5wWoM6O8wE8UzAw4s/nkPCjY8DILIqOI+MSkMTf9/NpkNBnmGKsme5mnTF/34
 qbpJzHd4uxCAtORXUn9kLsMPOt2izo6sJjXcDjlO3Q9lz3mLq/3HZFmnPFar/b1CcX5y
 wUppVovnF2IwiujwSV7z5VOfeOap65Or9eedApiOayWJQNAl5/UspA7FMGP6lIvrSzw0
 JhEAoEhqGy4Mv67z9eADCIK0XHGP47Z+UmaUHdrKw3PiBRP6aaY63Ho5pYIpoQ/nb7oa
 iwB1gL42OBQAeilujnoS0KD8bKOCos9v5Q48lMCqjSb7lcx4e/esxD6GS0bKUsPpzMej
 IMSw==
X-Gm-Message-State: AOAM530q+lQrKoECSl90eMBtqLvVMMwo4gadZlo37s4hey4syU1LsuSN
 n0YAQZHAw+0qar1gNFB9Zub76miTY+X8i29t8Q==
X-Google-Smtp-Source: ABdhPJxSKTIJIOYWpNVP5ohJgBgBTu87uL/BXE8BXfqusJA8HocWzSfztjJiiBKcH+VYM30fnvze1mg6lpuQ3bXOZuI=
X-Received: by 2002:a50:bf4a:: with SMTP id g10mr443744edk.201.1610388939997; 
 Mon, 11 Jan 2021 10:15:39 -0800 (PST)
MIME-Version: 1.0
References: <20201112140752.1554-1-rach4x0r@gmail.com>
 <5a954c4e-aa84-834d-7d04-0ce3545d45c9@kernel.dk>
 <da0c7aea-d917-4f3a-5136-89c30d12ba1f@grimberg.me>
 <fd12993a-bcb7-7b45-5406-61da1979d49d@kernel.dk>
 <10993ce4-7048-a369-ea44-adf445acfca7@grimberg.me>
 <c4cb66f6-8a66-7973-dc03-0f4f61d0a1e4@kernel.dk>
 <cbe18a3d-8a6b-e775-81bb-3b3f11045183@grimberg.me>
 <26a1cd20-6b25-eaa6-7ab6-ba7f5afaf6dd@kernel.dk>
 <81cdcb58-9a23-8192-6213-7f2408a3b8ee@grimberg.me>
 <CAKeUqKKHg1wD19pnwJEd8whubnuGVic_ZhDjebaq3kKmY9TtsQ@mail.gmail.com>
 <CAKeUqKK3yykq8LNv1CCHZTHSz1=bzBaCwVQmi6bhpbYzqVJsqQ@mail.gmail.com>
In-Reply-To: <CAKeUqKK3yykq8LNv1CCHZTHSz1=bzBaCwVQmi6bhpbYzqVJsqQ@mail.gmail.com>
From: Rachit Agarwal <rach4x0r@gmail.com>
Date: Mon, 11 Jan 2021 13:15:28 -0500
Message-ID: <CAKeUqKJKXP8iJY1x=wXc7Vz+qQPhP=MaUmy71x2f2H_YdHf_8w@mail.gmail.com>
Subject: Re: [PATCH] iosched: Add i10 I/O Scheduler
To: Sagi Grimberg <sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210111_131544_263204_CA656359 
X-CRM114-Status: GOOD (  37.40  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Qizhe Cai <qc228@cornell.edu>,
 Rachit Agarwal <ragarwal@cornell.edu>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, Midhul Vuppalapati <mvv25@cornell.edu>,
 Jaehyun Hwang <jaehyun.hwang@cornell.edu>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@lightbitslabs.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

[Resending the last message] Happy 2021 everyone!

> Dear all:
>
> Hope you are all well.
>
> Sagi and I were wondering if you have any additional feedback on the
> updated patch? (@Ming?) We have been receiving a lot of
> interest/questions from industry on incorporation of i10 in the
> kernel. If people do not have additional feedback, it would be nice to
> move this forward.
>
> Looking forward to hearing from you!
> ~Rachit
>
> On Sat, Nov 28, 2020 at 12:49 AM Rachit Agarwal <rach4x0r@gmail.com> wrote:
> >
> >
> >
> > On Fri, Nov 13, 2020 at 4:56 PM Sagi Grimberg <sagi@grimberg.me> wrote:
> >>
> >>
> >> >>>> But if you think this has a better home, I'm assuming that the guys
> >> >>>> will be open to that.
> >> >>>
> >> >>> Also see the reply from Ming. It's a balancing act - don't want to add
> >> >>> extra overhead to the core, but also don't want to carry an extra
> >> >>> scheduler if the main change is really just variable dispatch batching.
> >> >>> And since we already have a notion of that, seems worthwhile to explore
> >> >>> that venue.
> >> >>
> >> >> I agree,
> >> >>
> >> >> The main difference is that this balancing is not driven from device
> >> >> resource pressure, but rather from an assumption of device specific
> >> >> optimization (and also with a specific optimization target), hence a
> >> >> scheduler a user would need to opt-in seemed like a good compromise.
> >> >>
> >> >> But maybe Ming has some good ideas on a different way to add it..
> >> >
> >> > So here's another case - virtualized nvme. The commit overhead is
> >> > suitably large there that performance suffers quite a bit, similarly to
> >> > your remote storage case. If we had suitable logic in the core, then we
> >> > could easily propagate this knowledge when setting up the queue. Then it
> >> > could happen automatically, without needing a configuration to switch to
> >> > a specific scheduler.
> >>
> >> Yes, these use-cases share characteristics. I'm not at all opposed to
> >> placing this in the core. I do think that in order to put something like
> >> this in the core, the bar needs to be higher such that an optimization
> >> target cannot be biased towards a workload (i.e. needs to be adaptive).
> >>
> >> I'm still not sure how we would build this on top of what we already
> >> have as it is really centered around device being busy (which is not
> >> the case for nvme), but I didn't put enough thought into it yet.
> >>
> >
> > Dear all:
> >
> > Thanks, again, for the very constructive decisions.
> >
> > I am writing back with quite a few updates:
> >
> > 1. We have now included a detailed comparison of i10 scheduler with Kyber with NVMe-over-TCP (https://github.com/i10-kernel/upstream-linux/blob/master/i10-evaluation.pdf). In a nutshell, when operating with NVMe-over-TCP, i10 demonstrates the core tradeoff: higher latency, but also higher throughput. This seems to be the core tradeoff exposed by i10.
> >
> > 2. We have now implemented an adaptive version of i10 I/O scheduler, that uses the number of outstanding requests at the time of batch dispatch (and whether the dispatch was triggered by timeout or not) to adaptively set the batching size. The new results (https://github.com/i10-kernel/upstream-linux/blob/master/i10-evaluation.pdf) show that i10-adaptive further improves performance for low loads, while keeping the performance for high loads. IMO, there is much to do on designing improved adaptation algorithms.
> >
> > 3. We have now updated the i10-evaluation document to include results for local storage access. The core take-away here is that i10-adaptive can achieve similar throughput and latency at low loads and at high loads when compared to noop, but still requires more work for lower loads. However, given that the tradeoff exposed by i10 scheduler is particularly useful for remote storage devices (and as Jens suggested, perhaps for virtualized local storage access), I do agree with Sagi -- I think we should consider including it in the core, since this may be useful for a broad range of new use cases.
> >
> > We have also created a second version of the patch that includes these updates: https://github.com/i10-kernel/upstream-linux/blob/master/0002-iosched-Add-i10-I-O-Scheduler.patch
> >
> > As always, thank you for the constructive discussion and I look forward to working with you on this.
> >
> > Best,
> > ~Rachit
> >

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
