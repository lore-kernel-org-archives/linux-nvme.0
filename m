Return-Path: <SRS0=t83a=6I=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3587CC2BA1A
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Apr 2020 04:25:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 078F92076C
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Apr 2020 04:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AvLLpas7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5Fd7M/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078F92076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BqTEuJHalM15rkoRL7tEzSI9uRGGngHJ7mMOzdLgARw=; b=AvLLpas76/daWl
	RXd7XLBJzbzZjodOomMgU4x66r+sDA3iHd/b4Vts05TCOtludwHlo0U3NwEvoRSg+r6cOADKcG3RH
	KU8MQBwGcfCESSBhS8cylFOvMrZZ2b9yW/XTlvQEdx0jdHX03mN43dbty7fEbd+BpL/vfPieTCwhV
	gv6Bbj1DW+kfgKpkGVPrXGAlhws6qipOtP6yTSb8ZdMLIRI9Ng9R120UeeWsXAoflq8QCDRPfpEMu
	B2Wj/8oArobxqCq9W4pkBXrrnsph09dW4QhThF4+DitbOAAuzMY0j8lPoVNU3fC6OhfRayu6OTAP5
	UqjHLhrQDv2cD5vZ3zXw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jRpuC-0000oC-44; Fri, 24 Apr 2020 04:25:36 +0000
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRpu8-0000n1-NK
 for linux-nvme@lists.infradead.org; Fri, 24 Apr 2020 04:25:34 +0000
Received: by mail-qk1-x743.google.com with SMTP id l78so8973842qke.7
 for <linux-nvme@lists.infradead.org>; Thu, 23 Apr 2020 21:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SzDMX1vGV+H1HNqu9t2ozN0RBVpZO4r+hHsPSKSvqHQ=;
 b=n5Fd7M/YMHJ1uNgAqoU+tCCidUJJB/dySswnCY/iTi+BcfUNebnyxaQA2c0cWZc1hv
 gGBXJkBTgP/B6qRyGta8JivmEoIbiXwmcIjg/ZnE/ILzVKljZcZazngGoufw2UYE3gEF
 dhfTRAQNvVTbDmU/biZmNTjFEofqwPkEznA77hNihfdyzNE3D0aUrWAEakLZsztt9NbX
 ohz97E0WImaenizdcsnYGuHKuGrViejg0NkmlwbWNpo/i9fZdo8qA9Bj8Jup0mCAsfRY
 vm1CpTfQR3Tpv6iSB6Fewt/6rm+f7kYQjgWZw1QcNU+PjwwGfgldOcuvLHB4iaNvTV9r
 ChRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SzDMX1vGV+H1HNqu9t2ozN0RBVpZO4r+hHsPSKSvqHQ=;
 b=NN1ZB3hPJxiaTnWvVmXJHKHxdFM+rF/R2/t0OfKybdBrgq3PLr8KuIie75Pb08qLeV
 //mzdsNRnpwJ0omKu5OOw67KOtC/qwJOIYUqmDG5gLno59C7UPu18OEZaNI1B99DAgr2
 rJf9bkJ3CLONhYwp3ctR8HmrIuW2lLzKNLvXmhoBCXC21kXRau7ilLTEbbVlTW/mzzh/
 rHMiGpKefymcRPyIy4nE/Gd7/dc82U3LwsQzLGAi+tD48iPueaxd/tU8ip+v+cFiauyg
 FvcYdhxNGmYWh/Lx6GjKk7bPj56ee6jeVkRL8Dvw1psUbT/Zc44vI13FVGBBQ8TGDOiF
 Mn6A==
X-Gm-Message-State: AGi0PubiJiw6Y2jRL0YxvXKPnr/a6h6stZ4t7+frqihPDnOgQ6W0uAue
 J/M5P2eVju4iwHiDYEuGW+QkJ2X9uTgHSEXoP4Y=
X-Google-Smtp-Source: APiQypJ80si3r23rIID+Muhr073kzItC3A2eiQPbs/60tKUyB7VKuiwM45eLq6cTPfoTRgZemPuzS5gKoibjJQmDjRA=
X-Received: by 2002:a37:8c05:: with SMTP id o5mr7212096qkd.498.1587702330366; 
 Thu, 23 Apr 2020 21:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200423075938.GA11215@192.168.3.9>
 <de3cdc57-a97a-f800-26dd-f9439f97bba5@mellanox.com>
In-Reply-To: <de3cdc57-a97a-f800-26dd-f9439f97bba5@mellanox.com>
From: Weiping Zhang <zwp10758@gmail.com>
Date: Fri, 24 Apr 2020 12:25:19 +0800
Message-ID: <CAA70yB6iHXRjr-dYWQKh7UP2-vmA8rk-7=h3DprvQENFqn3YFA@mail.gmail.com>
Subject: Re: [PATCH v2] nvme: align io queue count with allocted nvme_queue in
 nvme_probe
To: Max Gurtovoy <maxg@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200423_212532_759890_8B2B16A5 
X-CRM114-Status: GOOD (  26.93  )
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

On Thu, Apr 23, 2020 at 6:25 PM Max Gurtovoy <maxg@mellanox.com> wrote:
>
>
> On 4/23/2020 10:59 AM, Weiping Zhang wrote:
> > Since the commit 147b27e4bd0 "nvme-pci: allocate device queues storage space at probe"
> > nvme_alloc_queue will not alloc struct nvme_queue any more.
> > If user change write/poll_queues to larger than the number of
> > allocated queue in nvme_probe, nvme_alloc_queue will touch
> > the memory out of boundary.
> >
> > This patch add nr_allocated_queues for struct nvme_dev to record how
> > many queues alloctaed in nvme_probe, then nvme driver will not use
> > more queues than nr_allocated_queues when user update queue count
> > and do a controller reset.
> >
> > Since global module parameter can be changed at rumtime, so it's not
> > safe to use these two parameter directly in the following functions:
> > nvme_dbbuf_dma_alloc
> > nvme_dbbuf_dma_free
> > nvme_calc_irq_sets
> > nvme_setup_io_queues
> >
> > This patch also add nr_write_queues, nr_poll_queues for
> > struct nvme_dev and io_queues_reload for struct nvme_ctrl, that allow
> > per-controller reload module parmater when reset controller. The nvme
> > driver will not reload module parameter(write/poll_queues) by default
> > when reset controller. If user want to reload them, they should enable
> > it by echo 1 > /sys/block/<nvme_disk>/device/io_queues_reload.
> >
> > By now, nvme pci driver allow user change io queue count for each
> > type(write, read, poll) within nr_allocated_queue, that's to say, if
> > user want to change queue dynamically by reset controller, they should
> > setup io queues as many as possiable when laod nvme module, and then
> > tune io queue count for each type.
>
> typo: laod --> load
>
OK, fix it in V3.
>
> > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> > ---
> > Changes since V1:
> >   * don't use module parameter nvme_dbbuf_dma_free, nvme_dbbuf_dma_alloc
> >       and nvme_calc_irq_sets.
> >   * add per-controller sysfs file io_queues_reload to enable/disable
> >       reload global module parameter.
> >
> >   drivers/nvme/host/core.c | 29 +++++++++++++++++++++
> >   drivers/nvme/host/nvme.h |  1 +
> >   drivers/nvme/host/pci.c  | 55 +++++++++++++++++++++++-----------------
> >   3 files changed, 62 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index dfb064b4334f..80172192a9d8 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -3357,6 +3357,34 @@ static ssize_t nvme_sysfs_show_address(struct device *dev,
> >   }
> >   static DEVICE_ATTR(address, S_IRUGO, nvme_sysfs_show_address, NULL);
> >
> > +static ssize_t nvme_sysfs_io_queues_reload_show(struct device *dev,
> > +                                      struct device_attribute *attr,
> > +                                      char *buf)
> > +{
> > +     struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> > +
> > +     return snprintf(buf, PAGE_SIZE, "%d\n",
> > +             ctrl->io_queues_reload ? 1 : 0);
> > +}
> > +
> > +static ssize_t nvme_sysfs_io_queues_reload_store(struct device *dev,
> > +                             struct device_attribute *attr, const char *buf,
> > +                             size_t count)
> > +{
> > +     struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> > +     bool val;
> > +
> > +     if (kstrtobool(buf, &val))
> > +             return -EINVAL;
> > +     ctrl->io_queues_reload = val;
> > +
> > +     return count;
> > +}
> > +
> > +static DEVICE_ATTR(io_queues_reload, S_IRUGO | S_IWUSR,
> > +             nvme_sysfs_io_queues_reload_show,
> > +             nvme_sysfs_io_queues_reload_store);
> > +
> >   static struct attribute *nvme_dev_attrs[] = {
> >       &dev_attr_reset_controller.attr,
> >       &dev_attr_rescan_controller.attr,
> > @@ -3374,6 +3402,7 @@ static struct attribute *nvme_dev_attrs[] = {
> >       &dev_attr_sqsize.attr,
> >       &dev_attr_hostnqn.attr,
> >       &dev_attr_hostid.attr,
> > +     &dev_attr_io_queues_reload.attr,
> >       NULL
> >   };
>
> Well for fabrics controllers it doesn't mean anything.
>
> maybe we can do it non-visible for fabrics ?
>

Make sense, fix in v3.

Thanks

> _______________________________________________
> linux-nvme mailing list
> linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
