Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6139AC77B61
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Apr 2023 18:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QDKweJNl1igqzxsduVu9aBlFR3YZ0Azh02nrtffVtIc=; b=0X+ybcTk9Ys7c5XonEbfyuDNW2
	Ge/n5NHXTarOJHUzFYqHmnTXSsHITOA34exk9URuF1a0uKNsqYEcTIjH/oRwkYhGU+4tbtSpGaaty
	G1knyroUT5CVeDK+C/UG016jJUqsgrkhNFvRQc2fr6NUOQgIqIlkAckWzNkz7N2FkHTxvjwJbxSnQ
	axV4elqhDGM6aQratc9IjsqvWzXtqimSjThkNMjwkw8eUz4oFSWwJ2YWe4RoxXd18X2sJ36VDqgOe
	+iMCTV5rQN7grzHFKSfMDHSC3HvpMC7LD4MgLi/LGHu0ARfqrYfHRHDZBNr8eBsgYpVMR5v8RjHz4
	TLVUiH+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1psSfn-00BSiZ-1U;
	Fri, 28 Apr 2023 18:18:23 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1psSfk-00BSfA-2A
	for linux-nvme@lists.infradead.org;
	Fri, 28 Apr 2023 18:18:22 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50a145a0957so19971165a12.1
        for <linux-nvme@lists.infradead.org>; Fri, 28 Apr 2023 11:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682705895; x=1685297895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDKweJNl1igqzxsduVu9aBlFR3YZ0Azh02nrtffVtIc=;
        b=lw6yYnqYMgfIxqiU3gX3LIZuSiuYqVVrqowvq+IfiwQ5/TE0HLY5pKjGlCc1QZ/FWi
         7SPNYZ8/q90aCo9FM59fzDqmsRD7abVg9UyrOx7eYhrVAn8RFPL5y3lCWUAmogppORjl
         tjgdytsystpgkuP9yg+oT/Iye9EuwnOnm68tliV2S1GOI3+PXx9xSOOcBpYAHUBqk2Ap
         ft2i0PKSwMbR4RnEEFFIQqy0d695iosjtL5GmevRQ14p+itpoGK3gKiDGYmPLtl8j9do
         hV4JXD5O+M2dKfbiCV9r1AFHiJArDe6j7yPoR1PIM8wtCzgcXRdVA5TDXv/2vTIl3prM
         WGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682705895; x=1685297895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDKweJNl1igqzxsduVu9aBlFR3YZ0Azh02nrtffVtIc=;
        b=GhRvw9mq18B7eEH/Kf31jfVhFPe7zMW/CLOV80D8633HoqaQe+myOap1xAvn4Go48P
         1vEmjesdDw+IgEfuh4m1aBPJuq9EKXAl0F20vrWCeb/sAyLo3tXlyCHSldyScnXxbnuW
         V2B69hNDnyzZ0QgjhafK6kJhGDBPA67yfMnnOVDfu8VJkZaBLE1EuNFFXewvuC4TbthD
         j0QVjYvKOtnaZyiW9oxFEf3EVoE3ZgbqAfSg+cDYWPsuzI4SPFuQR3wgchxVrZGLzRyt
         A1QNABECidIaC/JAuDUio2/Ut8XRwqAJ59NiZ/w0iUMzO/fO1M0sP5eAwUTdkbMzheSS
         ITFw==
X-Gm-Message-State: AC+VfDz+XaeqQLfDmWLhM9FhjP+J12/j2WuQWpeBAbjWPrqTDiYtsLHG
	6Oz0/MqjU6HCXe68VFTVesr9m81SomsUMRPzVbwvN6/R+p0=
X-Google-Smtp-Source: ACHHUZ7tgrrVWCotI4i/B+EZ/L7fo8HDafefhEN2/3XEhSu5Gza0oJ45DrpYwTKWn67iEC1N16pxisxBIAiNGjgNml0=
X-Received: by 2002:a17:907:86a3:b0:95f:af3a:be8c with SMTP id
 qa35-20020a17090786a300b0095faf3abe8cmr7684723ejc.18.1682705895017; Fri, 28
 Apr 2023 11:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAPiksxOuMyosYh0Ky==jfRcgWpGs5-4SxwfxpaLND5kHsOpq+w@mail.gmail.com>
 <528f9679-1b07-f3af-c936-06ec1e316720@nvidia.com> <CAPiksxOQsF0-p_pwFQQhG7r5WERrRKv9R_w3Bgxp=qCBcPNc+w@mail.gmail.com>
 <ZEre23NoKOB56eDj@kbusch-mbp.dhcp.thefacebook.com> <CAPiksxOEFDjHh4OrkcuBCMe59vf8_CE=AHeCN_+yFCe3_ry-2w@mail.gmail.com>
 <ZErr8OV5JRpUityQ@kbusch-mbp.dhcp.thefacebook.com> <CAPiksxOu2W62bP9fFuHvxjACz+cvxH58fEkoFvALKFdHax3Tcw@mail.gmail.com>
 <ZEvpoiDVFuOs8wyw@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZEvpoiDVFuOs8wyw@kbusch-mbp.dhcp.thefacebook.com>
From: Wang Yicheng <wangyicheng1209@gmail.com>
Date: Fri, 28 Apr 2023 11:18:03 -0700
Message-ID: <CAPiksxMs00uLcOxxxKXUPpJEgCCEHDVx3JVKbe2AivHCJ553wA@mail.gmail.com>
Subject: Re: Seeking for help with NVMe arbitration questions
To: Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230428_111820_709256_B4F69570 
X-CRM114-Status: GOOD (  35.17  )
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

> You might expect that a new command placed on a shallow queue will
> be handled ahead of a command place on a deep queue at the same
> time. Indeed, some implementation may even show desirable results
> with that scheme, but the spec doesn't really guarantee that, though.
Thanks Keith, that makes total sense... This also aligns with what I
experimented with (please see below). I was hoping to see task2 would
benefit from a larger queue proportion but it didn't.
1. W/ default queue set-up, ran 2 identical randwrite FIO tasks (3
identical jobs each) to the same set of CPUs. The 2 tasks got the same
performance
2. Changed to 1/64/2 queue set-up, FIO tasks were the same, despite
task1 went to default queues and task2 went to poll queues. The result
was very close to test 1. Task2 did run faster but the difference was
trivial (seemed to come from IO polling instead of queue distribution)

Then this confuses me with the motivations of introducing different
queue types. Doesn't it aim for providing some sort of prioritization?

Best,
Yicheng

On Fri, Apr 28, 2023 at 8:43=E2=80=AFAM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Thu, Apr 27, 2023 at 05:36:12PM -0700, Wang Yicheng wrote:
> > Thanks a lot Keith! This is very helpful!
> >
> > 1. Then do you see a way to prioritize a specific set of IOs (favor
> > small writes over large writes) from the IO queue's perspective?
> > Initially I was thinking of WRR, which later turned out to be not
> > supported. If I want to leverage the IO queues to achieve the same
> > goal, from what I understand I can simply send small writes to poll
> > queues, and allocate more of those queues. Say on average small writes
> > take up 20% of the total IOs. And if I distribute 40% of total queues
> > as poll queues, in some sense I give more weight to small writes and
> > thus prioritize them.
>
> You might expect that a new command placed on a shallow queue will
> be handled ahead of a command place on a deep queue at the same
> time. Indeed, some implementation may even show desirable results
> with that scheme, but the spec doesn't really guarantee that, though.
>
> For a pure software side solution, you could use an ioscheduler and
> set your ioprio accordingly.
>
> > > > 3. Say I have only 1 default queue and I submit an I/O from some CP=
U,
> > > > then there can be a chance that the I/O would need to cross CPUs, i=
f
> > > > the default queue happens not to be on the same core right?
> > >
> > > If you only have one queue of a particular type, then the sysfs mq
> > > directory for that queue should show cpu_list having all CPU's set,
> > > so no CPU crossing necessary for dispatch. In fact, for any queue
> > > count and CPU topo, dispatch should never need to reschedule to
> > > another core (that was the point of the design). Completions on the
> > > other hand are typically affinitized to a single specific CPU, so
> > > the complete may happen on a different core than your submit in
> > > this scenario.
> >
> > 2. You mentioned that completions are affinitized to a single specific
> > CPU. And this is exactly what I observed in my test. This also seems
> > to cause worse performance. Is there a way to query that affinity or
> > is it invisible from outside?
>
> To query a queue's affinity, check /proc/irq/<#>/effective_affinity.
> You can check /proc/interrupts to determine which irq# goes with
> which queue.

