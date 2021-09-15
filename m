Return-Path: <SRS0=dHSS=OF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C61FC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 12:42:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 520F160F21
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 12:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 520F160F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CLIDsAri8sa/QiP/c+ElauyyZDQJw0opQXe4oqay5Dk=; b=VK/eeOq3Ud3nvQ
	IIPyEmph7WfxYFCwb8ZDqKk4/TwWF/fQGY7dzGHsOFaREp+7yDavDgBOT8CojLP8upT500CC8supr
	1qsUsVDMoPW98CKWDrFg7C8yEGGHT5zeABlIGd/Je52mpNCmk0uyLl4nVQvnn2iYUwfIO0PkDRUap
	/1dtDti+uB8l1D4ZdEsPX/3TOekCOr+TIvrV0joZh4rtewmefO3JFiZpATOYlk05a2KeKygHdqLD7
	8U27pjYCDjhy20jWIguZgYAP9h4ew9BnzZ6CF5G9iGfnqgqLC+5aC+OL0wgE1EM4LEOqlxoKjDLLF
	rbd+RH40fSnaiE03ZFiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQUEP-00941u-2w; Wed, 15 Sep 2021 12:41:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQUEL-00941P-R3
 for linux-nvme@lists.infradead.org; Wed, 15 Sep 2021 12:41:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631709695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tEfV1/DYZkGpxw3ayA2oBkkT4tRl5bPyLJkShMw/OD8=;
 b=LevlbvVeFGfsubDMLiSE747tdMHSMQUH3ZXQplr2dpJ0oJixjsjh+1cRiyjxdaJcdelaTY
 IqAtydXQTn8102t+KrePrUEPvbUWSQkd3LyQ9I1a48nxBt5pxb6i6PrzKKjTVrcvxHsdEo
 oCpeAMTdnzTkRHD+cja//DKcnzm9MMI=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-Den8qqk_NkCHBR6fwh8LPg-1; Wed, 15 Sep 2021 08:41:34 -0400
X-MC-Unique: Den8qqk_NkCHBR6fwh8LPg-1
Received: by mail-yb1-f197.google.com with SMTP id
 b84-20020a253457000000b0059e6b730d45so3308284yba.6
 for <linux-nvme@lists.infradead.org>; Wed, 15 Sep 2021 05:41:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tEfV1/DYZkGpxw3ayA2oBkkT4tRl5bPyLJkShMw/OD8=;
 b=HIhDZ/6JQiNZN96a4Axe8huUiDfXZIFjKwf4XeEKKpgIrYqt6dyFBaHXhxF43jlAC5
 vlOAyTcSaGxEVOcKKyFCR7izgTTIQ0y/CCa9mlwFkocynFuAEwVHzAECUnmUtEDdigI2
 /57/m4rzQucFNACmPSd0Vj/yMeMY7HdugRm2OjW05HSEK+hjzVDlh3YXSJMYc05wRnsB
 2iXBWAa3Xx/LYxMG6DwkIq84Vir/z0knkDZ6nV/++L/EXVh5zXLyoQSxqGF9ZqcG8lF5
 FF31p5bEXhxQgHHoaiDD+PUfqAfmz5FP0CWwTPlbWxjC+uU9rQYnJzVbRDXtnE2xDPr7
 nACg==
X-Gm-Message-State: AOAM533T8/ZkkJQq/c9dz5iJvwjLq9qTF+aoHhfkK+s45prt4Qa5GmZB
 TaY0mv5zOVj0vQPRDy4dAdPDXtoNorOqo3ANJHdtvDXauRFhqMAXx7vW/mLWAql3NgQ6BlLjHjl
 nSdheIZAoX88aHUsxel6xOa6m35lev1tppGTfPPy6woY=
X-Received: by 2002:a25:6e05:: with SMTP id j5mr6060593ybc.86.1631709693597;
 Wed, 15 Sep 2021 05:41:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYXfmKAL8J/kdJ6tVlq03ShaucMeQ1AyAxuj3HLKQJr7h2PEgsEt4QwRhS8cM1Vk81Nswx3FwdUgYPdMTmyWc=
X-Received: by 2002:a25:6e05:: with SMTP id j5mr6060566ybc.86.1631709693413;
 Wed, 15 Sep 2021 05:41:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj4cs94pDUfSSfij=ENQxL-2PaGrHJSnhn_mHTC+hqSvPzBTQ@mail.gmail.com>
 <ca405578-5462-0ab9-91ab-de9d42ee0570@grimberg.me>
In-Reply-To: <ca405578-5462-0ab9-91ab-de9d42ee0570@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 15 Sep 2021 20:41:21 +0800
Message-ID: <CAHj4cs8_382bLtbcR4F8RBJSmwMAdW22EiRycDjdLa0QtY2vnw@mail.gmail.com>
Subject: Re: [bug report] nvme0n1 node still exists after blktests
 nvme-tcp/014 on 5.13.16-rc1
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 stable@vger.kernel.org
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yizhan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210915_054137_996196_8C091C66 
X-CRM114-Status: GOOD (  13.43  )
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

On Tue, Sep 14, 2021 at 10:28 PM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> > Hello
> > I found this failure on stable 5.13.16-rc1[1] and cannot reproduce it
> > on 5.14, seems we are missing commit[2] on 5.13.y, could anyone help
> > check it?
>
> Was it picked up and didn't apply correctly?
>

Hi Sagi
I tried apply that patch to stable branch, but failed to do that,
would you or Hannes mind help backport it, thanks.

[linux-stable-rc ((daeb634aa75f...))]$ git am
0001-nvme-fix-refcounting-imbalance-when-all-paths-are-do.patch
Applying: nvme: fix refcounting imbalance when all paths are down
error: patch failed: drivers/nvme/host/nvme.h:716
error: drivers/nvme/host/nvme.h: patch does not apply
Patch failed at 0001 nvme: fix refcounting imbalance when all paths are down
hint: Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

[linux-stable-rc ((daeb634aa75f...))]$ patch -p1 <
0001-nvme-fix-refcounting-imbalance-when-all-paths-are-do.patch
patching file drivers/nvme/host/core.c
Hunk #1 succeeded at 3761 (offset -46 lines).
Hunk #2 succeeded at 3771 (offset -46 lines).
Hunk #3 succeeded at 3790 (offset -46 lines).
patching file drivers/nvme/host/multipath.c
Hunk #1 succeeded at 757 (offset -3 lines).
patching file drivers/nvme/host/nvme.h
Hunk #1 FAILED at 716.
Hunk #2 succeeded at 775 (offset 3 lines).
1 out of 2 hunks FAILED -- saving rejects to file drivers/nvme/host/nvme.h.rej

-- 
Best Regards,
  Yi Zhang


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
