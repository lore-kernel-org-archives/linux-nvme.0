Return-Path: <SRS0=EEJI=JD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DEBC433B4
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Apr 2021 14:13:59 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E58D613A7
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Apr 2021 14:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E58D613A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kh305fpuAwXTw3nE6HQ2iIKy9dOzaVCmWAj6jSKVM8E=; b=aCay0yr449hkljNNM1hd6Gukc
	EIphC9NKt+l2kBUUiHQQKttqjPWT2Q/IfRbbf1O2mWYwPHuQ9xnKli+Ua+Yj6TODZIeaRUqSM2p5h
	Zn2tnM00Z/PKvN/RZ5qyowqgk5qrxRjHNxug8BNHFDAqGwVD8CeTyGlGhqEVMsW4b9bKHV+mWmkXv
	kEs9O5QPtpKfAOnIgBZ/VJBDHG255lX5PMFAvBhq5fKQGCcKgmCmhiFtglIH5qQE65w5QYwkLzpQJ
	5DDg66U41HrajGOpYljodnYU63MDf074eUKs23VFMShnlx3uryh3OzWAuCieE7fFuia6A5GiQasIs
	UjVcMP6cA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lTmSb-002oIP-Mh; Tue, 06 Apr 2021 14:13:41 +0000
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lTmSX-002oGi-CE
 for linux-nvme@lists.infradead.org; Tue, 06 Apr 2021 14:13:39 +0000
Received: by mail-wm1-x330.google.com with SMTP id p19so7456156wmq.1
 for <linux-nvme@lists.infradead.org>; Tue, 06 Apr 2021 07:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2M1WuRWvs9tYtuON4UtGBD30PwfP3ImCqZ+1yEDE0es=;
 b=ZrB1YA5bI11C6RYqd9m5BKclwTk5nFBvvpnbxrQ+jVyck5OauczcZ0fCPPSktsXebP
 9tUFb2gmfgqOglcOnOTVHnFI9HzOmc4j9JCKnhONVAIzIm6677eJDmyeMHLob2mjDrmy
 E/cmRqOkNA2iJQabmCwgxUptOTVngU/EVKF0LN4/UNRtIqTb/Zq07MaGTimeKix/ZTVi
 kCGbZakmdinwGbek7COoF3PAqWGdx22GTfgJiSMnD5sisn2fjB3sAsKwS8ug1VQp/BQ1
 LmrxBAdwJPJOZ06HrrBEKYpGrwuZ1w4akvy1tBk5LADRYXXa0tTCUO2RMpO0yipKkiLG
 LHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2M1WuRWvs9tYtuON4UtGBD30PwfP3ImCqZ+1yEDE0es=;
 b=PHy7gDhQFMbJ9EX8hl3qZte5S0MrWCEKn+PsmvkJeDYyGIevbB3RHBUSxI/IgL2J+L
 VaXPsOHPS45BmAvE3YGpsNuQDxIn6XP1k0gBc944Oh2fp2hxG6RDQRI9UaqD7irTXc2K
 MRoExJEsgyuxG5zD7quFS76+lR1eq3d7qK3ycpIqUQ7xnb1w3KXxQQ0tsFTxUZGVqtnz
 m5c+/Gke/0hEy7fHa0X0tTRwJUxN4PHSh9+YnRfZwL2Pm2GJQ6nFRLyK9stmKujtWaM3
 X/etO2S8RS6YUDQvXmOq26eJhnHsz4WOf2aAJVSGP2rNo5DzDFhD7EMM2KR6V/rNc3hh
 cBUQ==
X-Gm-Message-State: AOAM533qzgRbnbmXH5w46ZL+id4WTBUeOkntbLR9VJWQcRMyEKwLUrhb
 QonSuuPhNtDRnXVY7bOmf0qB/bS1e/PtsEwA/HM=
X-Google-Smtp-Source: ABdhPJwXKPW1fiH/ljW5vj0gnSeySghBn2IquRhOEiXBuYQejTk69YjBMscPH817Ag0oo9emEU9fxXJN3OD+DolSwCA=
X-Received: by 2002:a05:600c:4fc2:: with SMTP id
 o2mr4258568wmq.25.1617718409764; 
 Tue, 06 Apr 2021 07:13:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210406064841.103393-1-minwoo.im.dev@gmail.com>
 <YGwjc8rliXhvccPp@x1-carbon.lan>
In-Reply-To: <YGwjc8rliXhvccPp@x1-carbon.lan>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Tue, 6 Apr 2021 19:43:03 +0530
Message-ID: <CA+1E3rKVS4dXNSPKojchqA4vbxmLhs=EBBk7=zAsbYFcR-TeBw@mail.gmail.com>
Subject: Re: [PATCH V2 0/1] nvme: introduce generic per-namespace chardev
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, 
 =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210406_151337_708456_FDB2E4D2 
X-CRM114-Status: GOOD (  34.85  )
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

On Tue, Apr 6, 2021 at 2:33 PM Niklas Cassel <Niklas.Cassel@wdc.com> wrote:
>
> On Tue, Apr 06, 2021 at 03:48:40PM +0900, Minwoo Im wrote:
> > Hello,
> >
> > This is the second patch series to support generic ns character device
> > to expose per-namespace instance to the userspace.  This version fixed
> > code mis-ordered reported by Kanchan.
> >
> > This patch introduces per-namespace character device to I/O in case that
> > blkdev is not initialized properly.  Userspace applications are able to
> > I/O to the generic namespace chardev even there's no blkdev properly
> > initialized.  Because we don't allow nvme controller device to I/O with
> > a specified nsid, this generic device will provide a way to I/O.
> >
> > This patch is derived from Javier's patch series [1].  Javier and I have
> > re-coded this series again and it starts with new version tag.  Changes
> > from the previous series are:
> >
> >   - Update naming convention for the chardev exactly the same with the
> >     blkdev:
> >         /dev/nvme-generic-XcYnZ  to  /dev/nvme-generic-XnY
>
> Hello Minwoo,
>
> The current proposal puts these new per-ns char devs in directly in
> /dev/ (I assume since Christoph didn't like the /dev/nvme/ subdir idea.
> Keith seemed to like the subdir idea, since he had suggested the same.)
>
> For the absolute majority of cases, the namespace will not be rejected,
> so the user will be able to use the per-ns block dev to perform IOCTLs.
>
> For the small minority of cases, Linux might reject the ns, so no block
> dev will be created.
>
> I'm slightly worried that adding all these new per-ns char devs, in the
> same directory as the regular per-ns block devs, will lead to confusion
> from regular Linux users.
>
> Imagine the potential confusion about what device the user should use
> with e.g. fdisk, mkfs, mount, in fstab, what to specify in fstab, etc.
>
> I think that there is value in reducing the confusion for regular users.
>
>
>
> I don't know the best way of reducing this potential confusion, but here
> are some suggestions (suggestions are mutually exclusive):
>
> 1) Put the new per-ns char devs in a directory different from where
> the regular per-ns block devs are located.
>
> 2) Only create the new per-ns char dev for namespaces that were rejected.
>
> 3) There is already a new module parameter for this, default it to false.
>
> 4) Introduce a sysfs /sys/class/nvme/nvme0/export_unsupported_namespace
> that you can echo the nsid to, if you want to create the new per-ns char
> dev for a certain ns.
>
>
> I'm certain that someone can come up with an even better suggestion.

While 1 sounds good, the problem with 2, 3 and 4 is that it will make
things difficult for applications which want to use the new interface
(i.e. char device).
When char-device is always available/visible, it is more
automatic......applications can use it all the time without resorting
to any extra administrative tunable.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
