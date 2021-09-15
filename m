Return-Path: <SRS0=dHSS=OF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1527C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 13:22:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8B6160EE5
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 13:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A8B6160EE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SelxYZ8ndd64KFhRoFu1qhTGGxc+c9y7rXukhFLDhrw=; b=uUuF7j92n8t4s0
	fpqWJKxXm/sy8MvdwDbOlS5mAqvQbWAYLhsjEabuesu8GRNbKzSbaN43w9xTLP2VErE3y2PY9pkq3
	j2DhahSC3iE7dpaNo7uMiLOSMcLthjR+iR6EY6PFIRtCNoucGP1CQozKA2v7uxnPOLEakjfMAknnr
	u/jMCuCNEsnmPzTZ7C0RCEi4vl64eC/lqd59M+Vspf2hpRYllJLBKO7cX2mlMSay/M8KIj7f/4f9V
	qUOdSY6yVzRbobg9z0K3xg3+BCBS3vNyjI5FJv6xGqmKdn7Sctl2T+0Tz11U1gJtCJekOGcHG+sSO
	LX8ZBh0U95oioimDmykA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQUrz-009A6G-4X; Wed, 15 Sep 2021 13:22:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQUru-009A3E-Vv
 for linux-nvme@lists.infradead.org; Wed, 15 Sep 2021 13:22:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631712150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N8XVIae35tL1jV2ZqP53lL8GffjmSTNBE3TsFycIEN4=;
 b=TeNbNl/vxcrv9cc1rilYyu0mNzRiWEl+qV0MwCNkNEyUT4c4tlqJwd/MXhvHmkQg5dgXSw
 29pbb553ESI8WhaDspGuw+6mSGvv/LjiIXCy5nxSpI0mYYKLUxqYuNR1NMCxk76bKI14kW
 zU+SAYxIdrd2gm44BLS364E1RgQ0x2M=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-601-At6x_aZJPjOITnoBsJtrhg-1; Wed, 15 Sep 2021 09:22:29 -0400
X-MC-Unique: At6x_aZJPjOITnoBsJtrhg-1
Received: by mail-yb1-f199.google.com with SMTP id
 p200-20020a25d8d1000000b005a3a281bc11so3553308ybg.0
 for <linux-nvme@lists.infradead.org>; Wed, 15 Sep 2021 06:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=N8XVIae35tL1jV2ZqP53lL8GffjmSTNBE3TsFycIEN4=;
 b=AKQdR+b8JfUAp77BwVvYPPmCh8C+RSVCBWSr+KJ8syVTwBWqWfQnljMY2npG6nnKco
 VkluO4nHRZHvjA7CcofgS2DAeHxdFAoBuQHVw1BtZ0VSuZi6gR0XQ7RKyc4/mnr1wXFn
 5KbHWKh1BGINsxbzoEgn9rOZ2Q1mIZfO7/HEs5EYVmRayXmH+E01kdqVIH7ZXazjcen6
 eedWzwwBOGQd6MAdU1Jvjp62yeWbvpARAMQWX3NeUOqs0TziQsZkwEwcfkKUs/vPnhbU
 y+vKM9djEdPK1P3UFUoVRlLtyX/hZLM4kqlJrT/5PqUUtVgau6bK0p7wuGZWYjMeAs/d
 q9FQ==
X-Gm-Message-State: AOAM530UvDFuEVreeWSvRcbI4JCr7sOGpkmMqQyzN/NIC/UHNLy/+SU9
 mGVRyDGs9YWKs/i19sPouQPXIDcT28ObeKn1784Cziyduop4z9E0YPS1mufbrfao6DVWmIf8Uo7
 2FreTzplgnk1yfvDFGyuZhK8tYBhhXooaVZuRzKHSc+c=
X-Received: by 2002:a25:6e05:: with SMTP id j5mr17475ybc.86.1631712148368;
 Wed, 15 Sep 2021 06:22:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlFFW+PIYA/L9A4+NI1cWzq0l7OXoGX84sFvfGDI7OOVW5F2GclVm0ysvg4GFh2FICrY4eHPWAOssysD8Rdh0=
X-Received: by 2002:a25:6e05:: with SMTP id j5mr17454ybc.86.1631712148163;
 Wed, 15 Sep 2021 06:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs94pDUfSSfij=ENQxL-2PaGrHJSnhn_mHTC+hqSvPzBTQ@mail.gmail.com>
 <ca405578-5462-0ab9-91ab-de9d42ee0570@grimberg.me>
 <CAHj4cs8_382bLtbcR4F8RBJSmwMAdW22EiRycDjdLa0QtY2vnw@mail.gmail.com>
 <YUHueINHsFDRwHPa@kroah.com>
In-Reply-To: <YUHueINHsFDRwHPa@kroah.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 15 Sep 2021 21:22:16 +0800
Message-ID: <CAHj4cs_c2a9CBfFhGDC8ciid1ShZhp9rEdTy_hxa87uAnG-QZg@mail.gmail.com>
Subject: Re: [bug report] nvme0n1 node still exists after blktests
 nvme-tcp/014 on 5.13.16-rc1
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, stable@vger.kernel.org
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210915_062231_155713_6E8620E4 
X-CRM114-Status: GOOD (  24.51  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 15, 2021 at 9:00 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Sep 15, 2021 at 08:41:21PM +0800, Yi Zhang wrote:
> > On Tue, Sep 14, 2021 at 10:28 PM Sagi Grimberg <sagi@grimberg.me> wrote:
> > >
> > >
> > > > Hello
> > > > I found this failure on stable 5.13.16-rc1[1] and cannot reproduce it
> > > > on 5.14, seems we are missing commit[2] on 5.13.y, could anyone help
> > > > check it?
> > >
> > > Was it picked up and didn't apply correctly?
> > >
> >
> > Hi Sagi
> > I tried apply that patch to stable branch, but failed to do that,
> > would you or Hannes mind help backport it, thanks.
> >
> > [linux-stable-rc ((daeb634aa75f...))]$ git am
> > 0001-nvme-fix-refcounting-imbalance-when-all-paths-are-do.patch
> > Applying: nvme: fix refcounting imbalance when all paths are down
> > error: patch failed: drivers/nvme/host/nvme.h:716
> > error: drivers/nvme/host/nvme.h: patch does not apply
> > Patch failed at 0001 nvme: fix refcounting imbalance when all paths are down
> > hint: Use 'git am --show-current-patch' to see the failed patch
> > When you have resolved this problem, run "git am --continue".
> > If you prefer to skip this patch, run "git am --skip" instead.
> > To restore the original branch and stop patching, run "git am --abort".
> >
> > [linux-stable-rc ((daeb634aa75f...))]$ patch -p1 <
> > 0001-nvme-fix-refcounting-imbalance-when-all-paths-are-do.patch
> > patching file drivers/nvme/host/core.c
> > Hunk #1 succeeded at 3761 (offset -46 lines).
> > Hunk #2 succeeded at 3771 (offset -46 lines).
> > Hunk #3 succeeded at 3790 (offset -46 lines).
> > patching file drivers/nvme/host/multipath.c
> > Hunk #1 succeeded at 757 (offset -3 lines).
> > patching file drivers/nvme/host/nvme.h
> > Hunk #1 FAILED at 716.
> > Hunk #2 succeeded at 775 (offset 3 lines).
> > 1 out of 2 hunks FAILED -- saving rejects to file drivers/nvme/host/nvme.h.rej
>
> 5.13 is only going to be around for a 2-3 more days, please move to
> 5.14.y at this point in time.  No need to do any extra work for 5.13.y
> at this point in time as it is about to be end-of-life.

Got it, thanks for the update.

>
> thanks,
>
> greg k-h
>


-- 
Best Regards,
  Yi Zhang


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
