Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70847C77B71
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Apr 2023 08:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=88Xr0yx58XqZJmxu4bMMhXYH0sWThF6GMrgw+s7HUak=; b=B3n5MjGXGiNijskl1opRqAYjcS
	s4Lf33uG60YMNByjQcDkQ7Kcv7eFQSAQZLT/7edT5+L5pi5wbuhHe1qEXoO97sYsNqCEVBLCbnjOn
	AfisrIX2C2wc4x8kHKRMUn86V2Rdkq+Z5QPhmltcG5Nq1v2Hg5eoDk+Mx8TBunTl5ynYmKE88q7NQ
	2e/0K8ZXMJMOaX8DOzLdAAA8DZGrCflriHnqqiDzzFLuKRBa/iDbXNTPcHgm3Zz/kwftI9RW5lzhV
	dQWOUcqxauIifidexPgQ/Shbu3CWdocHGhd4Nh7rhPy42oJolBSafDJRzHyomab7FdHJgNVu+pl4i
	1RreOVsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prE4h-000VJ7-2t;
	Tue, 25 Apr 2023 08:30:59 +0000
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prE48-000Um5-2x
	for linux-nvme@lists.infradead.org;
	Tue, 25 Apr 2023 08:30:27 +0000
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-953343581a4so804604666b.3
        for <linux-nvme@lists.infradead.org>; Tue, 25 Apr 2023 01:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1682411420; x=1685003420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88Xr0yx58XqZJmxu4bMMhXYH0sWThF6GMrgw+s7HUak=;
        b=F0IISRr4sT3y7mi4tVPSLZr3osIYsuNdqnruDnQVwYBhuw1h6u975I178mVxu7vdJJ
         CxYOrM7fpGC8yyNmXo+0chvXJKJ8VVR7YDV33KfBo6o9QhK352xX62uCfaEu76F8ndMO
         rki4xStOT/wZC3rLUxC4AAFw+iKDh4Crue/vCGfpASVf40SYA38T3jT7stkU+1cot3Pa
         55QuHcALpf38tmbItkd/US1Y8TIERWm2X3n8oQN1EcWKPGMKtAOXNvRm0J6PYLcX04hE
         x1EP2Awqfq9FYlT2f3hj0GuHx39UEnTV8TwIQDnVLVew1Jvxw+UNGAiQI2BEBVrX8bg0
         tPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682411420; x=1685003420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88Xr0yx58XqZJmxu4bMMhXYH0sWThF6GMrgw+s7HUak=;
        b=Uje8L40D3yzG587OtCDOgc5yrhyl1ftCsHZH5wkPgCwVm/k84EFr0LHf0BL7uQAVV0
         yeiOO4C530iqiNkUgT+/W824UW91k8jbp3Sc4RKp5fjSr9xW8s3mDCFW6vMEsHa9pZB4
         8EdUvm9Bge/XBXyqLqYXevI4pZuPwZLQZ/sUXwi5EPVguorxQWDJg1Cjx1WsKEug9tAe
         vnvDcM72vXmyA0AH1y6ZgKJC8zDPlTt9JL2j1sv2fJipwBqmynbVe57E+7tO/jaFOJjh
         YqN6bBqDZIN9Gt6rb2gd7w5kXG6j3nw6Uy6VT3LH/sMwPN3a+P9G6I+7RryP/qYLcM6g
         I9Qw==
X-Gm-Message-State: AAQBX9fdc+t1ADP83uih1Oz6wW2oQ4MtKvvVPfvQ6QG+WRHUZbuCWjbv
	W/rBZsUIcmhkV98ppjRrvCgrf3XEyI0Z5LF2NtDi+w==
X-Google-Smtp-Source: AKy350b2xeDumbZI/sk+mZ3Iqh02vZiQKW45K/czWanvQ2RB7nqZ/s96EkyakZ8ek80+JNlhxEQHIpWFTd/zFdHITFM=
X-Received: by 2002:a17:907:a042:b0:94e:cbfb:5fab with SMTP id
 gz2-20020a170907a04200b0094ecbfb5fabmr12155022ejc.75.1682411419899; Tue, 25
 Apr 2023 01:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230413062339.2454616-1-fengli@smartx.com> <20230413063317.2455680-1-fengli@smartx.com>
 <7f553d34-9ada-426c-4847-c7cd1aba64a8@grimberg.me> <E23A9D5C-35CF-412C-AE35-37389242BC71@smartx.com>
 <03a47920-9165-1d49-1380-fb4c5061df67@grimberg.me>
In-Reply-To: <03a47920-9165-1d49-1380-fb4c5061df67@grimberg.me>
From: Li Feng <fengli@smartx.com>
Date: Tue, 25 Apr 2023 16:32:27 +0800
Message-ID: <CAHckoCzBBmn8kCuD+ssRKApvFYNxedj_RkqsvgDis+iwV8g-oA@mail.gmail.com>
Subject: Re: [PATCH] nvme/tcp: Add support to set the tcp worker cpu affinity
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230425_013025_192321_72B96ED1 
X-CRM114-Status: GOOD (  34.52  )
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

Hi Sagi,

On Wed, Apr 19, 2023 at 5:32=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
>
> >> Hey Li,
> >>
> >>> The default worker affinity policy is using all online cpus, e.g. fro=
m 0
> >>> to N-1. However, some cpus are busy for other jobs, then the nvme-tcp=
 will
> >>> have a bad performance.
> >>> This patch adds a module parameter to set the cpu affinity for the nv=
me-tcp
> >>> socket worker threads.  The parameter is a comma separated list of CP=
U
> >>> numbers.  The list is parsed and the resulting cpumask is used to set=
 the
> >>> affinity of the socket worker threads.  If the list is empty or the
> >>> parsing fails, the default affinity is used.
> >>
> >> I can see how this may benefit a specific set of workloads, but I have=
 a
> >> few issues with this.
> >>
> >> - This is exposing a user interface for something that is really
> >> internal to the driver.
> >>
> >> - This is something that can be misleading and could be tricky to get
> >> right, my concern is that this would only benefit a very niche case.
> > Our storage products needs this feature~
> > If the user doesn=E2=80=99t know what this is, they can keep it default=
, so I thinks this is
> > not unacceptable.
>
> It doesn't work like that. A user interface is not something exposed to
> a specific consumer.
>
> >> - If the setting should exist, it should not be global.
> > V2 has fixed it.
> >>
> >> - I prefer not to introduce new modparams.
> >>
> >> - I'd prefer to find a way to support your use-case without introducin=
g
> >> a config knob for it.
> >>
> > I=E2=80=99m looking forward to it.
>
> If you change queue_work_on to queue_work, ignoring the io_cpu, does it
> address your problem?
Sorry for the late response, I just got my machine back.
Replace the queue_work_on to queue_work, looks like it has a little
good performance.
The  busy worker is `kworker/56:1H+nvme_tcp_wq`, and fio binds to
90('cpus_allowed=3D90'),
I don't know why the worker 56 is selected.
The performance of 256k read up from 1.15GB/s to 1.35GB/s.

>
> Not saying that this should be a solution though.
>
> How many queues does your controller support that you happen to use
> queue 0 ?
Our controller only support one io queue currently.
>
> Also, what happens if you don't pin your process to a specific cpu, does
> that change anything?
If I don't pin the cpu, the performance has no effect.

Thanks,
Li

