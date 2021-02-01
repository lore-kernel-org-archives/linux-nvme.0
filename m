Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2965C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 19:36:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 876C464DB2
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 19:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 876C464DB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ot6/thJ9tkzXIriTK4hbITQ4dlEPFO/0KP/afvVhJJE=; b=IDQv6P/KbCUCmZgtozrTzL8nQ
	RzGjjK52pgsZLWE0zkAXyp0mIvN+l7Ou30scCxwyLIenb2w+M6QIuIJgBLa0u5B0lnnLH8w4H9REz
	D1kj1gxsxmjYDmY4altZPprUsEF3Osxz6LsLmnWjUYfXAnOcaC/+w66v0vekULLvikAr8M+21GJCZ
	iybPURv3shP345iwVtGYX0dV5/yNS9pngWyM1WSAn3tw0TR5SVg4f1+XceHQz2XkATb0UZdB6gZd9
	9y/MyNCFlAo4rcdut8t8tLQV/cfjQZ2IE33cUgw/4xj86lzAsWpoPR4ngpR/NKQcyFvWvxUYXnsUD
	Q4oE8Rf3A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6ezb-0000Aa-3C; Mon, 01 Feb 2021 19:36:11 +0000
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6ezY-00009i-Ms
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 19:36:09 +0000
Received: by mail-ot1-x335.google.com with SMTP id i30so17495314ota.6
 for <linux-nvme@lists.infradead.org>; Mon, 01 Feb 2021 11:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JWBkNAaNFyDailoNLvfd01F/RWQlC5hp7A6f+h/cyqY=;
 b=TZxvbVNiXKihvb482TRxj/6WLckWUH8R84HUFz+GyZcJj4bDdqokogc8XZdjFuz66J
 B5QIJRO4vCDoGUNuyOgOqgmW4qpUurcYdQlvQjwMAo1AQsqhPVzf3x57z1YVHxjLLjMw
 BBPPaSfpe8ATUSfRZboIsbLfkbp2hi++WS0OCvjShV6qCf3THh8G2i3/vW4NTkCUBy83
 qtF4MRc/5EkX8POcuGFwClV2jvLeIQ/dCU/onWhEa3tZJ/1pr/lwn/AauK+RlpCaSDdu
 vD0tFxi8yEzu4n2K4AQ2p2GH3p6j7qrx3lQADHKCizJNfZatHNzTyRm4avKI55+xUqZn
 kkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JWBkNAaNFyDailoNLvfd01F/RWQlC5hp7A6f+h/cyqY=;
 b=YjiCSHWCQqDfg4Fsb8DVAKRp+jXKEeObQaDW1TNvrpBWmTzWA7cUsSbFx9OJSV7UYl
 UeqVgkOa+/Z7GEwJBsOraDjpTwfICYqFoWTdOaMVY7MMQEG6jY1UqJ0Z5SE7EtXCJfPG
 GYL7bVc/6Nkn3ICduRW18UFGp9k/w3/0cwOQe2+hPIGCbeb2GtfRD2wEXTALdNEZDRLp
 oiOPM0JrOnVTWVJJMp4CYE1os9ZaczMqYOrMbSj8U6bLU1uEhcYK2QRhwOvRoXtPxl1L
 nPw+cVw2LJQBpIrRdueMmdNm34fKMIqCOTbRoQnGwTySsnGJWZHbtrZq07dz+5RMpws2
 q3jw==
X-Gm-Message-State: AOAM531qCdeNMt7W87kfFZwUfptFVpROZYMu9FQWuwGEZCAniOSXJfHb
 Qyina3/4WIUEzc+XplXtyHJ0Yp5ChUdfbskPOJ2uzw==
X-Google-Smtp-Source: ABdhPJzyuAUli/LaOAe8RusYWEo21XH5hUPI02qphfk+PAI/Wvf6MAfQb2fhO5ryBBYE9EV4k+dZ9B02fM5dWCkJKOo=
X-Received: by 2002:a9d:7d12:: with SMTP id v18mr12655165otn.205.1612208164558; 
 Mon, 01 Feb 2021 11:36:04 -0800 (PST)
MIME-Version: 1.0
References: <20210201183017.3339130-1-jxgao@google.com>
 <20210201183017.3339130-4-jxgao@google.com>
 <YBhOrK+kea7PNmXn@smile.fi.intel.com>
In-Reply-To: <YBhOrK+kea7PNmXn@smile.fi.intel.com>
From: Jianxiong Gao <jxgao@google.com>
Date: Mon, 1 Feb 2021 11:35:52 -0800
Message-ID: <CAMGD6P0qc0FZagmimTCuYsbJXo-WBHjtgoWSRzs63EULybTzNg@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] Adding device_dma_parameters->offset_preserve_mask
 to NVMe driver.
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_143608_787677_AE51655D 
X-CRM114-Status: GOOD (  19.80  )
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
Cc: axboe@fb.com, heikki.krogerus@linux.intel.com, sagi@grimberg.me,
 Saravana Kannan <saravanak@google.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marc Orr <marcorr@google.com>,
 gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, bgolaszewski@baylibre.com,
 iommu@lists.linux-foundation.org, jroedel@suse.de,
 Erdem Aktas <erdemaktas@google.com>, dan.j.williams@intel.com,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Feb 1, 2021 at 10:56 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Feb 01, 2021 at 10:30:17AM -0800, Jianxiong Gao wrote:
> > NVMe driver relies on the address offset to function properly.
> > This patch adds the offset preserve mask to NVMe driver when mapping
> > via dma_map_sg_attrs and unmapping via nvme_unmap_sg. The mask
> > depends on the page size defined by CC.MPS register of NVMe
> > controller.
>
> ...
>
> >       if (is_pci_p2pdma_page(sg_page(iod->sg)))
> >               nr_mapped = pci_p2pdma_map_sg_attrs(dev->dev, iod->sg,
> >                               iod->nents, rq_dma_dir(req), DMA_ATTR_NO_WARN);
> >       else
> >               nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
> >                                            rq_dma_dir(req), DMA_ATTR_NO_WARN);
> > +
> > +     offset_ret = dma_set_min_align_mask(dev->dev, 0);
> > +     if (offset_ret) {
> > +             dev_warn(dev->dev, "dma_set_min_align_mask failed to reset offset\n");
> > +             goto out_free_sg;
> > +     }
>
> Seems like rebasing effect which makes empty line goes in the middle of some
> other group of code lines.
>
> >       if (!nr_mapped)
> >               goto out_free_sg;
>
> Perhaps it should be here?
Yes you are correct, it should be

     else
              nr_mapped = dma_map_sg_attrs(dev->dev, iod->sg, iod->nents,
                                           rq_dma_dir(req), DMA_ATTR_NO_WARN);
      if (!nr_mapped)
              goto out_free_sg;
+
+     offset_ret = dma_set_min_align_mask(dev->dev, 0);
+     if (offset_ret) {
+             dev_warn(dev->dev, "dma_set_min_align_mask failed to
reset offset\n");
+             goto out_free_sg;
+     }

Thanks for pointing it out.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>


-- 
Jianxiong Gao

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
