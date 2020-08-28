Return-Path: <SRS0=SY4p=CG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172E5C433E6
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 12:43:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3A502078A
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 12:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GUD1b7qT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIe1wGvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A502078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=i3SimJUENH3SyD5teyPReAnQyj3oklPK/8/wKPhyCJM=; b=GUD1b7qTs0fqyjZ77T055ZfPD
	sTtM+YYFJr7/YcswO6bn6QicWy8fJ1xEdBct1sXsmNZzQfNQMD7kXGqmLRfQA9Y2+9l7m71Dbs70l
	9O8r59O6aQ3asLwXQQsGNq/gg6R7EvpJjANihDGgulgAUPApWXDjhlEyMZHb8Qfi5FUQgi0MJlakE
	0XbfgJ11T39vWgON4UrFTnYp6nRovg8c3yTTI9rkbKs9J7V/bm0cQDcilZ6RoIXdN7vGX/0YwFye4
	iOeMK6Q64uidMc2ZIgpm7X8L6Qx+c+NmAlUOOxK4rtR7aHR0GVSsdslxc/f2jyp4V3z8JTUgpI170
	RVGsdotfA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBdjS-0005eM-0R; Fri, 28 Aug 2020 12:43:50 +0000
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBdjP-0005dM-AE
 for linux-nvme@lists.infradead.org; Fri, 28 Aug 2020 12:43:48 +0000
Received: by mail-il1-x141.google.com with SMTP id o16so723462ilq.0
 for <linux-nvme@lists.infradead.org>; Fri, 28 Aug 2020 05:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BlGqee6LUFbQlE8A/CJ72Y5d50MDkiMD4t/Odvf7ASU=;
 b=qIe1wGvJCvxhcj68y8/oHRAx47yLHDKofI0vmuim9NR/PWCdH/7RQAHSP2eYFPv8ud
 Pcd0+JHmQwLRL3v3DHWMk9aoLJ2L9XkRfpAAB98r4m47hhcHGSAhi5Xtdyygs/7Ex6uJ
 uR1oLx/IPJ2Wi/Ib3wn9kwhsfwSjY1yrkje290OFqlmLjJjvu7YHbyzk5+rYb1zpzr5k
 8GnLrYnRD7BWOeolsxG6ocrEx7LA0/7TJQSORnWeXYULUyRM8q64gUSKNr9d+co9BLxT
 V3MX1ea7ggCGlvgB26UT2UEvKRY2jDzMwtprUynN19kCIJA/+gdC7PYSp+zf/90IJYPV
 L5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BlGqee6LUFbQlE8A/CJ72Y5d50MDkiMD4t/Odvf7ASU=;
 b=HZSTLXin8/sVuml1z+uZOQWDNwIN7EPZKK+2IdIqXixgBc2GDACQ5PL+XF/SkdvncC
 4+zol6Afo6HimLX2piPOk7vBYQrme30S1Yl2kwMTJrJPOpXmSHv4yrfTgW4lJqdhvMvH
 I2bYO+EsLB13UdUwsP0ZSX+tXkkeLCM2CiBe5+FJazJRyK/uD0J6MSdSmE8X9E7oVnvU
 owr4DGDZukRArOaZlhd06vIbZ3o98y0geyz4A8E2nmbTbFmrzTo6XGi1bmTkm6i7YCa1
 vra8YbbUtnorfv6cMBKH2ZR68WmtTyLbtIjq8vRaANuz26m87XK1rU1YG520qEWQUEYM
 eBSQ==
X-Gm-Message-State: AOAM5339Xe2X4oycKiMhfOGLy71AXhqAh7EVoG15Irp8EnjX4fX9Dlaf
 rusPkfxabDOJO0xdOCIzKSM9ycK4bURYqXEyVdY=
X-Google-Smtp-Source: ABdhPJyXoRYFnAomBCPJy+w+LO23nUTbQyGzwjW5zkTcAeUckUO9HFTvnby7Y0dUx8ShDp0e1k2OiKDKjosctjzgPds=
X-Received: by 2002:a92:8550:: with SMTP id f77mr1215513ilh.129.1598618623906; 
 Fri, 28 Aug 2020 05:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200814071431.201400-1-ztong0001@gmail.com>
 <20200814150433.GA3498391@dhcp-10-100-145-180.wdl.wdc.com>
 <CAA5qM4CctYiBe766-OnxAPHJWByyOo1rE7FzW-75ZcOib6niCA@mail.gmail.com>
 <20200814154233.GA3772144@dhcp-10-100-145-180.wdl.wdc.com>
 <CAA5qM4CtnNgZDpT-8Wiwvs18-h4fmxv3jPmW4AqWXgT-BqNLYw@mail.gmail.com>
 <20200827150103.GA2613662@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20200827150103.GA2613662@dhcp-10-100-145-180.wdl.wdc.com>
From: Tong Zhang <ztong0001@gmail.com>
Date: Fri, 28 Aug 2020 08:43:32 -0400
Message-ID: <CAA5qM4ARCf-28eH6dME6pDc8WBNpMh2jGUfcj-Wp7vfwvVRz8Q@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: cancel nvme device request before disabling
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200828_084347_368578_8C05A8DB 
X-CRM114-Status: GOOD (  22.78  )
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
Cc: axboe@fb.com, sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Keith,
Thanks for the confirmation. I will send another revision according to
your comments.
Best,
- Tong

On Thu, Aug 27, 2020 at 11:01 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Fri, Aug 14, 2020 at 12:11:56PM -0400, Tong Zhang wrote:
> > On Fri, Aug 14, 2020 at 11:42 AM Keith Busch <kbusch@kernel.org> wrote:
> > > > > On Fri, Aug 14, 2020 at 03:14:31AM -0400, Tong Zhang wrote:
> > > > > > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > > > > > index ba725ae47305..c4f1ce0ee1e3 100644
> > > > > > --- a/drivers/nvme/host/pci.c
> > > > > > +++ b/drivers/nvme/host/pci.c
> > > > > > @@ -1249,8 +1249,8 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
> > > > > >               dev_warn_ratelimited(dev->ctrl.device,
> > > > > >                        "I/O %d QID %d timeout, disable controller\n",
> > > > > >                        req->tag, nvmeq->qid);
> > > > > > -             nvme_dev_disable(dev, true);
> > > > > >               nvme_req(req)->flags |= NVME_REQ_CANCELLED;
> > > > > > +             nvme_dev_disable(dev, true);
> > > > > >               return BLK_EH_DONE;
> >
> > > anymore. The driver is not reporting   non-response back for all
> > > cancelled requests, and that is probably not what we should be doing.
> >
> > OK, thanks for the explanation. I think the bottom line here is to let the
> > probe function know and stop proceeding when there's an error.
> > I also don't see an obvious reason to set NVME_REQ_CANCELLED
> > after nvme_dev_disable(dev, true).
>
> The flag was set after disabling when it didn't happen to matter: the
> block layer had a complicated timeout scheme that didn't actually
> complete the request until the timeout handler returned, so the flag set
> where it is was 'ok'. That's clearly not the case anymore, so yes, I
> think we do need your patch.
>
> There is one case you are missing, though:
>
> ---
> @@ -1267,10 +1267,10 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>                 dev_warn(dev->ctrl.device,
>                          "I/O %d QID %d timeout, reset controller\n",
>                          req->tag, nvmeq->qid);
> +               nvme_req(req)->flags |= NVME_REQ_CANCELLED;
>                 nvme_dev_disable(dev, false);
>                 nvme_reset_ctrl(&dev->ctrl);
>
> -               nvme_req(req)->flags |= NVME_REQ_CANCELLED;
>                 return BLK_EH_DONE;
>         }
> --

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
