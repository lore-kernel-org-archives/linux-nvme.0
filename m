Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FC7C00140
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Aug 2022 22:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P25ltMRtJD/usTExdwvaP0sN/6HovIdZJUsoLXN0Pw8=; b=VxM5YbO5YHaZp1yn2iSarFm0Ph
	6afalZzuQ2kaxsHg5aaioH57bKhtrPJ/wy1s1kKJUZOPgg/+yPWbyWl7MNf2hP74y5NVbhDeQ9w07
	ZylectxWYTPHVIyB2rB5RPo3RalQdUbHRN6xNKg/Ey9QHA0hN1APH+ocAzJX/Z0cXzSp+wIJFFuKO
	IjPdDN+jHMNgcHiQlRnwp6w6yFz8DEAndXlV4Rp+OoCvs73umn82abujEbTZgLmR0D4qjSEe//mXc
	WM1OHvwb5yUPdD02162juKO6A/xEqxSWUy9O6BlQvR7PWL3TUqilY3TlFbLi8TK5NOxowWc5mPuef
	Vao+LnnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLtym-00Fkzv-2x; Wed, 10 Aug 2022 22:15:08 +0000
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLtye-00Fks4-Er
	for linux-nvme@lists.infradead.org; Wed, 10 Aug 2022 22:15:06 +0000
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-10ea30a098bso19500709fac.8
        for <linux-nvme@lists.infradead.org>; Wed, 10 Aug 2022 15:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=P25ltMRtJD/usTExdwvaP0sN/6HovIdZJUsoLXN0Pw8=;
        b=u8XLY8KfuDWm4X0an7AhBB3+RHpm1zr9rrmHSl8QQfXvDFxZSrKbT4yJe1jNtNxbdj
         icQnvzJNFel5LW4hi/hFIyTLptiBXldFpSPrpdSyrASCP9U71k8q2MAp1ERYsExXbQCD
         /t9hI7fmuP3oah70A7aeAinrP+Oo25aUL7OsU6K/qKOe4QJqW/kEaLR82yDnIrHT7LG7
         rqUBVczB4CxY+FIRT6LIqclNIVwb3IdZ2mr3JIjsnH6qLhA5KyM96rBRLx9H/zUQCTQh
         1MCTqCA1xvBMDJx/JWNC/mc4giWEp+xcGcuqQw/qk5UYOoWpiwEazDmFKkTGepMFbCrb
         20+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=P25ltMRtJD/usTExdwvaP0sN/6HovIdZJUsoLXN0Pw8=;
        b=vKwnekFdPQ/qrVBFjq/gg0Lu9oUI4PiHh9yWMG7TiwSh3J3UM+sgWqky84EkLBAndV
         Q7+g5D3MNJzfilcLeKISrgxnTRx3HuGKG2X99aNZmwSNurlnSFMksJ5ObNPg3AjQzdhe
         qHF8XqLtV0kT3Wv7N1ZPc8AOd27oY4NhScpof0xUiL9Frow4V/MINWW+HL+hpNFNUSB5
         VLWUEz7/l8kHNo/VFlZKOxNkAi0cty9IDr3p1x1LYnJvlvdV9inFlV6ctJ/M/ngxyLWp
         RTMCYlis7WLt3Z2S1+X0Y9sNkPwhi7eMvKFcFcALndz1UA+GGTjvNEZGHttKXdjaNcq8
         6vUA==
X-Gm-Message-State: ACgBeo0iQbmxL1jUEP96aKAATNOXJHK4lcVsFFtOUg5dxHztuEnxRJup
	Ds1RDtv6hU6t4I3UFuFN2hnD3WJEb5mjMwRSl2rd
X-Google-Smtp-Source: AA6agR7lpEDOex8Xn/nwOzvRwkqdwihfKzZXcNXKibctA4d/DBBgX+tHbeIJEnc8xR8utAk/bU+7O6/2CM/jJn7Pe3U=
X-Received: by 2002:a05:6870:b41e:b0:116:5dc7:192a with SMTP id
 x30-20020a056870b41e00b001165dc7192amr2465315oap.136.1660169698931; Wed, 10
 Aug 2022 15:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220715191622.2310436-1-mcgrof@kernel.org> <a56d191e-a3a3-76b9-6ca3-782803d2600c@kernel.dk>
 <YvP1jK/J4m8TE8BZ@bombadil.infradead.org> <CAHC9VhQnQqP1ww7fvCzKp_o1n7iMyYb564HSZy1Ed7k1-nD=jQ@mail.gmail.com>
 <YvP+aiGcBsik+v3y@bombadil.infradead.org>
In-Reply-To: <YvP+aiGcBsik+v3y@bombadil.infradead.org>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 10 Aug 2022 18:14:48 -0400
Message-ID: <CAHC9VhS-8DCw3oG+VySo-bWsN=Kgz9o0T+47pL9jWdAZ3=+REA@mail.gmail.com>
Subject: Re: [PATCH v2] lsm,io_uring: add LSM hooks for the new uring_cmd file op
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, casey@schaufler-ca.com, 
	joshi.k@samsung.com, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-security-module@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	a.manzanares@samsung.com, javier@javigon.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220810_151501_192670_3E97B1EA 
X-CRM114-Status: GOOD (  32.06  )
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

On Wed, Aug 10, 2022 at 2:52 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> On Wed, Aug 10, 2022 at 02:39:54PM -0400, Paul Moore wrote:
> > On Wed, Aug 10, 2022 at 2:14 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > On Fri, Jul 15, 2022 at 01:28:35PM -0600, Jens Axboe wrote:
> > > > On 7/15/22 1:16 PM, Luis Chamberlain wrote:
> > > > > io-uring cmd support was added through ee692a21e9bf ("fs,io_uring:
> > > > > add infrastructure for uring-cmd"), this extended the struct
> > > > > file_operations to allow a new command which each subsystem can use
> > > > > to enable command passthrough. Add an LSM specific for the command
> > > > > passthrough which enables LSMs to inspect the command details.
> > > > >
> > > > > This was discussed long ago without no clear pointer for something
> > > > > conclusive, so this enables LSMs to at least reject this new file
> > > > > operation.
> > > >
> > > > From an io_uring perspective, this looks fine to me. It may be easier if
> > > > I take this through my tree due to the moving of the files, or the
> > > > security side can do it but it'd have to then wait for merge window (and
> > > > post io_uring branch merge) to do so. Just let me know. If done outside
> > > > of my tree, feel free to add:
> > > >
> > > > Acked-by: Jens Axboe <axboe@kernel.dk>
> > >
> > > Paul, Casey, Jens,
> > >
> > > should this be picked up now that we're one week into the merge window?
> >
> > Your timing is spot on!  I wrapped up a SELinux/SCTP issue by posting
> > the patches yesterday and started on the io_uring/CMD patches this
> > morning :)
> >
> > Give me a few days to get this finished, tested, etc. and I'll post a
> > patchset with your main patch, the Smack patch from Casey, the SELinux
> > patch, and the /dev/null patch so we can all give it a quick sanity
> > check before I merge it into the LSM/stable branch and send it to
> > Linus.  Does that sound okay?
>
> Works with me! But just note I'll be away on vacation starting tomorrow
> in the woods looking for Bigfoot with my dog, so I won't be around. And
> I suspect Linus plans to release 6.0 on Sunday, if the phb-crystall-ball [0]
> is still as accurate.

No worries, hopefully we'll have something working its way towards
Linus by the time you return.  Enjoy your time away.

-- 
paul-moore.com

