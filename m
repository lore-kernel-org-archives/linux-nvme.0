Return-Path: <SRS0=eVk/=55=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5895C352B6
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Apr 2020 12:00:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA20F2073E
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Apr 2020 12:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YYHN5HTS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeT3tRyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA20F2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8ruUhw4slkYYP2HjDBibHY70NIkaSnLcbBXZtvjxR/g=; b=YYHN5HTSM06zCq
	jcRO6iH1+wA47HSPJdZzYkeE4OvbwAQVztXaKQS+BFB29t8neqNwyaArpuUztMnev2BjvTxwzilpI
	C4mehs+JPcYAEFIiYC3VE+i77zOcuOFDtLdG0QfdPA8NZDUaR5ojU/tXb/f/aNJaAOmhsSnLeVGu/
	p4ANbHssmxJE/U00T6pTkkshaINru2Pp9uz9tGlTOPjS8mp68ap1tqPb8Aiqj2ZpFhTSnuvqQ3R5R
	0VZxKxSXXkeeNIaaaljmotpVyTsWayLTCT3sIxbC015a50IW43qtxmSU66Blh2q0j8cO+OxvL9wlA
	/p5r9tsiCkU95t+TQTdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jNxlg-0007VD-Jr; Mon, 13 Apr 2020 12:00:48 +0000
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jNxld-0007Ur-Hz
 for linux-nvme@lists.infradead.org; Mon, 13 Apr 2020 12:00:47 +0000
Received: by mail-qt1-x842.google.com with SMTP id i19so3943776qtp.13
 for <linux-nvme@lists.infradead.org>; Mon, 13 Apr 2020 05:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3y+EECPx7Rv3jNEFbHiCz39qxzc00CLHxDSwLPLNJFY=;
 b=MeT3tRyVRtWUC0U/7KPtJhGtFoFnLOyGPdyJu2LYdUWLQlD7yJCTL8c7kRpdU7MOTx
 H0+vSdJJdVLm8F3jeakdCa1cmFFhvrviW6CA21RMySqd0CnF9yLCZgAv4vxZZ0/lSWoY
 +I6bt1sKYAZESAq+pwWpY+XwDKIy904PAvlS0uBzxPUP6HG8itstAAs+RJoMA7K+5BLT
 /zL7bA7LjhXCXjlNA8+D6VlYg/D1wLQfeH8MCHhbp8EZQ9jB01Hlq4sbAB9U3zwbyYZU
 dvQSXsZgaYcvFW+u22YtxqffhuqtyOovHF5GumlPPFzVNTmEFD+t+l7TPWZRrNknB+qi
 dJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3y+EECPx7Rv3jNEFbHiCz39qxzc00CLHxDSwLPLNJFY=;
 b=QfcIKYJ20qBah+DRpRqE7hjVxJTbY9oPyJucfapCwCdm7OopnWszWkyCjdRUXhqxC1
 b8SGNX1qPa3X0YYWwOVwe2zZUUMvMKkHVuSxeFoT6E4D1fk+LyZt26RpNnU4MYD6w49d
 99CJ8SIW7haIvQvKnJJb9RttNX05EbEjLiT6og2uoyH2U4FFAj3DlH8LG3AYTytvjH3o
 0KaCwrGZAkAzJ5/8Vs85leqlO19pkbgYXQGGxCNBOa7pPdVA9bJPMOj9qeEpZUymofdw
 p4XxPf0AC24Y1X1IiGTNVo4e4EKAbbGWfjPbsoVn6mdatJO995KenovrqD518qpM+IFH
 Pegw==
X-Gm-Message-State: AGi0PuZXVGUwxX4JjlkUbZyFirtZvu1D0yB69CyvoKHOlr3XFEV6aMn+
 OiVuCXWwyMINRq/8ubiMiBzwhg3YMamqoLuSBgM=
X-Google-Smtp-Source: APiQypK2JTWmtbYGe6kcgk39t3T+ArtXOoKhjwxQy0dkKXKHjLGG5aMs0V7q2U2NAsZoVCWE9pYo3J44AgCPZXum4Bw=
X-Received: by 2002:ac8:36e9:: with SMTP id b38mr6038972qtc.234.1586779244149; 
 Mon, 13 Apr 2020 05:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200410095719.GA4393@192.168.3.9>
 <188ad279-9211-9dca-3e6c-b5718ae6fc80@mellanox.com>
 <CAA70yB63bHGcFOzKPrLz+-bjHoEMQWiZEpFyoZ72rzDy9ZaO3Q@mail.gmail.com>
 <66add5c2-62b9-5c2d-977b-0499834b2b7a@mellanox.com>
In-Reply-To: <66add5c2-62b9-5c2d-977b-0499834b2b7a@mellanox.com>
From: Weiping Zhang <zwp10758@gmail.com>
Date: Mon, 13 Apr 2020 20:00:33 +0800
Message-ID: <CAA70yB7bkeSwQVjJ5rjGS3HxZtkraUY1FX9ZMHXH8FO6a-8omw@mail.gmail.com>
Subject: Re: [PATCH] nvme: align io queue count with allocted nvme_queue in
 nvme_probe
To: Max Gurtovoy <maxg@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200413_050045_594936_09CEF0FB 
X-CRM114-Status: GOOD (  22.91  )
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
Cc: Jens Axboe <axboe@kernel.dk>, sagi@grimberg.me,
 Weiping Zhang <zhangweiping@didiglobal.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Apr 13, 2020 at 5:37 PM Max Gurtovoy <maxg@mellanox.com> wrote:
>
>
> On 4/13/2020 4:01 AM, Weiping Zhang wrote:
> > On Sun, Apr 12, 2020 at 8:38 PM Max Gurtovoy <maxg@mellanox.com> wrote:
> > Hi Max,
> >
> >> hi,
> >>
> >> how about the following minor update:
> >>
> >> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> >> index 4e79e41..46ab28b 100644
> >> --- a/drivers/nvme/host/pci.c
> >> +++ b/drivers/nvme/host/pci.c
> >> @@ -89,6 +89,7 @@
> >>     */
> >>    struct nvme_dev {
> >>           struct nvme_queue *queues;
> >> +       int nr_allocated_queue;
> >>           struct blk_mq_tag_set tagset;
> >>           struct blk_mq_tag_set admin_tagset;
> >>           u32 __iomem *dbs;
> >> @@ -209,15 +210,15 @@ struct nvme_iod {
> >>           struct scatterlist *sg;
> >>    };
> >>
> >> -static unsigned int max_io_queues(void)
> >> +static unsigned int nr_dev_io_queues(struct nvme_dev *dev)
> >>    {
> >> -       return num_possible_cpus() + write_queues + poll_queues;
> >> +       return dev->nr_allocated_queue - 1;
> >>    }
> >>
> >>    static unsigned int max_queue_count(void)
> >>    {
> >>           /* IO queues + admin queue */
> >> -       return 1 + max_io_queues();
> >> +       return 1 + num_possible_cpus() + write_queues + poll_queues;
> >>    }
> >>
> >>    static inline unsigned int nvme_dbbuf_size(u32 stride)
> >> @@ -2073,7 +2074,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
> >>           int result, nr_io_queues;
> >>           unsigned long size;
> >>
> >> -       nr_io_queues = max_io_queues();
> >> +       nr_io_queues = nr_dev_io_queues(dev);
> >>
> > It may have some problem when user decrease queue count for multiple tagset map.
> > For example, there are total 128 IO and 96 cpus(system),
> > insmod nvme write_queues=32
> > nvme_probe will allocate 129(128io + 1 admin), nr_allocated_queue=129;
> > and then user decrease queue count
> > echo 2 > /sys/module/nvme/parameters/write_queues
> > echo 1 > /sys/block/nvme0n1/device/reset_controller.
> > nvme_setup_io_queues should use
> > 96(num_possible_cpus) + 2(write_queues) instead of 129(nr_allocated_queue).
>
> Any change that you will try to do (increase/decrease) will not effect.
>
> If you want it to effect, you need to make nvme_probe to run.
>
> I don't see a value only for making the code not to crash but not really
> effect the queue count.
>
> write_queues and poll queues shouldn't be writable IMO.
>
I think we can keep it writeable, the user case is that setup as many io
queues as possible when load nvme module, then change queue count
for each tag set map dynamically.

> Since nvme_dbbuf_dma_alloc/nvme_dbbuf_dma_free also call
> max_queue_count() that uses writable module params.
>
> we can save this values locally or make it read-only param.

It's not safe to use max_queue_count() for these two function,
and there is also a problem in nvme_dbbuf_dma_alloc,
static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
{
        unsigned int mem_size = nvme_dbbuf_size(dev->db_stride);

        if (dev->dbbuf_dbs)
                return 0;
it does not aware queue count was changed or not.

But it can be fixed by
unsigned int mem_size = nvme_dev->nr_allocated_queue * 8 * dev->db_stride;

Thanks

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
