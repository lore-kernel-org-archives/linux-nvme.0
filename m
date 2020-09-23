Return-Path: <SRS0=afDi=DA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DFAC2D0A8
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2020 16:41:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C4B020791
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2020 16:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="3SFzdeDp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OC6bVAwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C4B020791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=XWDouIMCwduF4k51K2m8M/G6eUpFX3be31ybj99tRMw=; b=3SFzdeDpSL5f39SzVxk1It6ut
	v1rh7ka0G3wUY3BBD7x1LCgMFISSULOEC3U8/sb4zl5xMdYN0N0JJgmaojzVAtQuTjn3sNSSfJN9p
	TqRlA2LYEOnyudYRGPMfCjgGtTySiZMNGKymCYhQfIYloebPc0y0gFzWPZRBkt8/6FJXFobWzwC+W
	nKZCr6Rlsg22klyDde9zOLuqL2t37aa9mj4NI1VQaR+S1dED/BCrTcsN7VPccIODMryK+jtOve5DE
	Q+Eu6ibj4vrpJVUV2MQtfuoa7PFPGbj3W4bWAJwhaT3LEDaqLE6a5u0IgTpgsXJC+wO8N9SaPez02
	+t4gE3Mfw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kL7pQ-0007fH-6O; Wed, 23 Sep 2020 16:41:12 +0000
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kL7pL-0007ds-PQ
 for linux-nvme@lists.infradead.org; Wed, 23 Sep 2020 16:41:09 +0000
Received: by mail-io1-xd43.google.com with SMTP id z25so98157iol.10
 for <linux-nvme@lists.infradead.org>; Wed, 23 Sep 2020 09:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Dsh5kVcL0Zz/uaeUu7RBOwQv289afFMLyYlaCd/5qzg=;
 b=OC6bVAwXdTVVp2Ujo5E2D27IUKBduif4l7gS+lm8rNKZ23HhFjma0l3k6LTHvc05LD
 wu4wlocPR8bXhJbP5kcs/5Jb0861sIHTD1zzrHmwyVMGkJTg5xdlP1JHoyAluRqMwDSq
 PMZqHfzEdnP6ZYcLzcmeL6S5MBW983kb7H7Dqf/HxAgrDXYF3Xc+9WM/iOkl/mpRa2ii
 4W9hAL2LGD/O5XOSRybSP7auxmHuZT9MX6UrWyKzOK/gJhF3S2zcD6dcKS8NXbvzYhlu
 UABwVR4RQD/hWU5OCt/AbiNEjwCr5pmhM0QHVprhJtXa8A1Mtmf2cvcURrDCVzDu21yT
 XIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Dsh5kVcL0Zz/uaeUu7RBOwQv289afFMLyYlaCd/5qzg=;
 b=H6jNHhPSFcZs4O9BID9idQnfooZdzsFgXGRU+nQVa0v+2u5Z9uRftfhgUyOyLi2Q2h
 ooi3gs15SzkL9z8fZq6TLxa6I2JVSgY/6JADG2wwrVon0fGBv8MqV0m4rM1VMmpLxi+X
 +D9LNBN6oOpYIAlzRGumM+dbH1Q9p9h20JUF3Ogb7AaTh/8KozR70jDdnMLpVNpxZ4s8
 DaRDnmOf1SnpxMxlCRHthtcpkb9QU50cbuy6KG0nPnvSU+Sp5T7UlvsthvbO8Wb2TkRx
 /pjajLTvcAaVCFrr7On4bEnGYF0hHK4Y4sdcy3ROWCR6y4THr/rWBDAqHma+SMl2Lv85
 DmUw==
X-Gm-Message-State: AOAM531HeLZ3TlvpA7eTixQX+iITLPsdD29PLmRQppUtaKjjeEZ0wtB9
 tXqMYOaUwmJDZIb+6/v5BXpevqHaJbq3ak8smxxsuU9BhR7cgw==
X-Google-Smtp-Source: ABdhPJwDDwo+YLGCIxjT3ydOvfjQ8egO8Z64SUNEUKOYFAs4VOAUXFLtQ2WDzgWOnzI1D+2yl7GUoWKyTWEisdb9NY0=
X-Received: by 2002:a6b:908:: with SMTP id t8mr320427ioi.124.1600879265871;
 Wed, 23 Sep 2020 09:41:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200916153605.5253-1-ztong0001@gmail.com>
 <20200922135956.GA23437@lst.de>
 <CAA5qM4BPKZaqH0SHS3zCO7oz=f3Ow_zB2fqtJYUrbbFBNbWsNQ@mail.gmail.com>
 <20200922164154.GA1894@lst.de>
 <61E8905E-E3FE-46EB-8283-9B35B4F069E1@gmail.com>
 <20200923050641.GA14878@lst.de>
In-Reply-To: <20200923050641.GA14878@lst.de>
From: Tong Zhang <ztong0001@gmail.com>
Date: Wed, 23 Sep 2020 12:40:55 -0400
Message-ID: <CAA5qM4AuYn4XEHWv5TcHpr77-4yd5os3ykC0FY-JGE-i1McR8Q@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix use-after-free during booting
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200923_124107_829981_16FD3AF6 
X-CRM114-Status: GOOD (  15.33  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

IMHO, WARN_ON_ONCE() looks ok to me. as long as it won't crash the
system or lead to any memory corruption issue.
We can talk about the reproducer offline if you are interested.
- Tong

On Wed, Sep 23, 2020 at 1:06 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Sep 22, 2020 at 04:34:45PM -0400, Tong Zhang wrote:
> > Hi Christoph,
> > I modified the patch a bit and now it works.
>
> So you're still hitting the WARN_ON_ONCE?  I think we need to fix that
> as well, but all the ideas I have will turn into a bigger project,
> so I think I'll submit this one to Jens, and then do things
> incrementally.
>
> Can you share your reproducer?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
