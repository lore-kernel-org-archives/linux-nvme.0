Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC382C77B61
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Apr 2023 14:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P+bc7ZuC8G9X6V5Pyx75I64zhOn5ekB770BG95AHrN0=; b=0rtRoq+EYNeHX/txp6w5K5gWnu
	BTmgkc1Sf9A4rN8d8mOIc2pbRuIR/KAd5Fa7TfSZjfXI67bG+JD3bBFs4sHlFrtpoO5pW6kCXVi0e
	n2vIxJ9MB0sLaSI04lrLBsusP09694XQZVAgETCbvWgsyU8yK/roIEUMXRRoKGKs9e2Q+JmV6Ca2c
	B5vh31wlaZ6IPQIwpHkbRu7pwIRZtZKO2AY86zcS0QG/2KximSZV62dyfRlHjaejnqJEehyHsLUGs
	VlUw6kiXE36zv5KjDldoRRtq42R4kIjLg2e7HnIcqwZlp58NWDnlQ+NHK0JEwD2irMA/qi1g0l889
	Ow+Vb4aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ps2lI-006nHn-1L;
	Thu, 27 Apr 2023 14:38:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ps2lF-006nDh-37
	for linux-nvme@lists.infradead.org;
	Thu, 27 Apr 2023 14:38:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1682606290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+bc7ZuC8G9X6V5Pyx75I64zhOn5ekB770BG95AHrN0=;
	b=UHuCf6J+hmCk8dk3RRR8PZuQDHHvUKRvZL5S66qBQN5jskBYejnKXMNb7qVXEWrdneeuYs
	A9gldipmjaIZQKLb6QaMdEJqDj5UaPO78qJ/dfIT60nMm7bDdnvqYkwsplWJNYFsVqOZ/H
	bsYIvAJh9Cnjru2zS3Oc+is3NDkuZAE=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-RuxnyNZ4OAqpFLJqqoCyIg-1; Thu, 27 Apr 2023 10:37:06 -0400
X-MC-Unique: RuxnyNZ4OAqpFLJqqoCyIg-1
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-42ff5f5c5daso143216137.1
        for <linux-nvme@lists.infradead.org>; Thu, 27 Apr 2023 07:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682606208; x=1685198208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+bc7ZuC8G9X6V5Pyx75I64zhOn5ekB770BG95AHrN0=;
        b=k2BXcZTm99CKSBRoPrvgzf0scyB4/gGTm5kBZbnDXr7i0HbIJ4uZaohP3waCRjdPsD
         Ia2sIwD/joEiZQi420qKLaZIR1RIrmHowNVzL0iDMKRELUF6Hy9cAWdxTW+BZnz2VUi2
         iAsur+rMuADI4+NT1t0lvx687YAZ+tgipZnqeMZwhGKuAbHeVzdaDENxmjIJzHg1EN6/
         Gel9PXEmpjyE9oK8hUHRnh3sddJejVcx7cPT8kKZnz9RwxS98KdqSU/VaT189FeYbO2/
         X72KXBdSf1P7EDjnETW5qc+ZD7poO/Jsb1JN4Qj12ahGejnY/tamgGT361BQdntHXAi8
         Wc2A==
X-Gm-Message-State: AC+VfDz9/LrA8TTdzrpAoPhgoXxQfEztSL7LAI2cPQ91v3YdTC8UcrX2
	pY+x1rUVUqDjmbI3xBbbyDGsUo5U5kG77SoPyF7W0W9PV4yeE9pPEOLN9/PZNFf07Xgk+vtwknO
	UjVjfZyvy2kla1d9nBTbBaUE6tKRQfeur+SzldwjyBrc=
X-Received: by 2002:a67:cd16:0:b0:42c:599d:f96a with SMTP id u22-20020a67cd16000000b0042c599df96amr919444vsl.0.1682606207808;
        Thu, 27 Apr 2023 07:36:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ58HGmVOdnmzREy9nBdtSIoSod5J7jyQssPmFiLqufzftlIDgM4+jwwoaJI/AuCnje4qJMYnlgc9cLWHGPGCAQ=
X-Received: by 2002:a67:cd16:0:b0:42c:599d:f96a with SMTP id
 u22-20020a67cd16000000b0042c599df96amr919432vsl.0.1682606207540; Thu, 27 Apr
 2023 07:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230413062339.2454616-1-fengli@smartx.com> <20230413063317.2455680-1-fengli@smartx.com>
 <7f553d34-9ada-426c-4847-c7cd1aba64a8@grimberg.me> <E23A9D5C-35CF-412C-AE35-37389242BC71@smartx.com>
 <03a47920-9165-1d49-1380-fb4c5061df67@grimberg.me> <CAHckoCzBBmn8kCuD+ssRKApvFYNxedj_RkqsvgDis+iwV8g-oA@mail.gmail.com>
 <c15d89c5-4cc2-68b9-d8fa-6c3a8590cfdf@suse.de>
In-Reply-To: <c15d89c5-4cc2-68b9-d8fa-6c3a8590cfdf@suse.de>
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 27 Apr 2023 22:36:36 +0800
Message-ID: <CAFj5m9+1VBuDV5HFM3-BiS9T5cxvdB5BuaZOTCYs8uTMxuTzqw@mail.gmail.com>
Subject: Re: [PATCH] nvme/tcp: Add support to set the tcp worker cpu affinity
To: Hannes Reinecke <hare@suse.de>
Cc: Li Feng <fengli@smartx.com>, Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Ming Lei <ming.lei@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_073818_074513_E8333625 
X-CRM114-Status: GOOD (  36.66  )
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

On Wed, Apr 26, 2023 at 7:34=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 4/25/23 10:32, Li Feng wrote:
> > Hi Sagi,
> >
> > On Wed, Apr 19, 2023 at 5:32=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me=
> wrote:
> >>
> >>
> >>>> Hey Li,
> >>>>
> >>>>> The default worker affinity policy is using all online cpus, e.g. f=
rom 0
> >>>>> to N-1. However, some cpus are busy for other jobs, then the nvme-t=
cp will
> >>>>> have a bad performance.
> >>>>> This patch adds a module parameter to set the cpu affinity for the =
nvme-tcp
> >>>>> socket worker threads.  The parameter is a comma separated list of =
CPU
> >>>>> numbers.  The list is parsed and the resulting cpumask is used to s=
et the
> >>>>> affinity of the socket worker threads.  If the list is empty or the
> >>>>> parsing fails, the default affinity is used.
> >>>>
> >>>> I can see how this may benefit a specific set of workloads, but I ha=
ve a
> >>>> few issues with this.
> >>>>
> >>>> - This is exposing a user interface for something that is really
> >>>> internal to the driver.
> >>>>
> >>>> - This is something that can be misleading and could be tricky to ge=
t
> >>>> right, my concern is that this would only benefit a very niche case.
> >>> Our storage products needs this feature~
> >>> If the user doesn=E2=80=99t know what this is, they can keep it defau=
lt, so I thinks this is
> >>> not unacceptable.
> >>
> >> It doesn't work like that. A user interface is not something exposed t=
o
> >> a specific consumer.
> >>
> >>>> - If the setting should exist, it should not be global.
> >>> V2 has fixed it.
> >>>>
> >>>> - I prefer not to introduce new modparams.
> >>>>
> >>>> - I'd prefer to find a way to support your use-case without introduc=
ing
> >>>> a config knob for it.
> >>>>
> >>> I=E2=80=99m looking forward to it.
> >>
> >> If you change queue_work_on to queue_work, ignoring the io_cpu, does i=
t
> >> address your problem?
> > Sorry for the late response, I just got my machine back.
> > Replace the queue_work_on to queue_work, looks like it has a little
> > good performance.
> > The  busy worker is `kworker/56:1H+nvme_tcp_wq`, and fio binds to
> > 90('cpus_allowed=3D90'),
> > I don't know why the worker 56 is selected.
> > The performance of 256k read up from 1.15GB/s to 1.35GB/s.
> >
> >>
> >> Not saying that this should be a solution though.
> >>
> >> How many queues does your controller support that you happen to use
> >> queue 0 ?
> > Our controller only support one io queue currently.
>
> Ouch.
> Remember, NVMe gets most of the performance improvements by using
> several queues, and be able to bind the queues to cpu sets.
> Exposing just one queue will be invalidating any assumptions we do,
> and trying to improve interrupt steering won't work anyway.
>
> I sincerely doubt we should try to 'optimize' for this rather peculiar
> setup.

Queue isn't free, and it does consume both host and device resources,
especially blk-mq takes static mapping.

Also it may depend on how application uses the nvme/tcp, such as,
io_uring may saturate one device easily in very limited tasks/queues
(one or two or a little more, depends on the device and driver implementati=
on)

Thanks,
Ming


