Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0984CC00140
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Aug 2022 22:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VTnegZyaFPfsdagJD4WUfYTIKxb9z6L0a/lV9cT5wlc=; b=ddm7Y+8mbKG43zaVtO5z3/JBXT
	zCajyQcbxXDeqJ9tQrQWX6xEnHRI46MiA5+76oDus3sgKh0H+/MEbBPVmXsXgrsQaHdyt6084sJy4
	P1MxadNr5o0vGcYXjgmNzKWkX+vOzZgaukQ7a1cmXAux6bYusKpS+LfRLSOIBih4JqFZzM+B6lanw
	NYmD966FCti4JpPckX/wg4lDelN67fkcbXmiiWOlUmBAB3zeXpBsfO/IHSPN/265PRLxEPLhB8lIq
	hB7+krKht77Vp5yfPVN5Pm6N0Caj03VXKyoBIMV0fApYVWyMp4KMOOFPE5ZgdwlSlsub1uF5dBaCe
	wrENpm4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLtzc-00FlaB-Nw; Wed, 10 Aug 2022 22:16:00 +0000
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLtzX-00FlUk-K3
	for linux-nvme@lists.infradead.org; Wed, 10 Aug 2022 22:15:58 +0000
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-116c7286aaaso3604758fac.11
        for <linux-nvme@lists.infradead.org>; Wed, 10 Aug 2022 15:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=VTnegZyaFPfsdagJD4WUfYTIKxb9z6L0a/lV9cT5wlc=;
        b=fCsVIBxPniDLvxqtDGZSjF46mVcKedAftX2L73cEkTAx7IlLUM5jGmJxbu7jg3oVUm
         PbE3e7UJGoyb/3wK2E3b7/lzBeQzqXR4NNvc/oE0HNWKH5El//h4RakIyYADugvj594P
         2++DYpW7LurZAI+6C9YhmyC5VXdeeHxdQlhnZADWfJE93TlNPufMlojbU5MoxDp5UrbA
         J89cdVSijLKERJb8xzpX/4xBX1ZGtK5Tfrg26Ul4Lh6XK02HJmjXYJPZiJbS4I8XWlIf
         lP+ev3pbTqFoLBAtxuItTC3HqeYNggIg/mDxeaP6XII/BlE6t5YwAXQ3LaOpKs6+6R9W
         a05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=VTnegZyaFPfsdagJD4WUfYTIKxb9z6L0a/lV9cT5wlc=;
        b=IBR6db3iDrTh6h1wFecktA4a7Q9Q+exslsbwH0sAdzUtpY57TdJ48vFitqlwe0jLjr
         C8J0F7XrsCdij6tpLnrAsHJ5840uJ1Lkxad05TUK09Jd3DWynllMHDF/AIVwurHr1dlp
         sYwmzFfDVoOJkANylo6jhMao+GULp40Uo7USyaTmEutBR2H7vyvYxCx8CKPy3BJaGqUx
         nSOi8vAVlSiDOLAgd6yYAz4xkSTGJD9IIjYO566fPPzsoNLRP9B4lBjHpxuweT9Lhuft
         R+so4H1Os5EWX4d98YjSksxY0rbXxiGsoKHRx73PSYgvtNsiQ2khbJM0yBe1tWWb3uNp
         STTA==
X-Gm-Message-State: ACgBeo0kg9I8xM2KjyH/VfuQkAyglIxP+sbObLu5BbbvQwzpB4URWIDT
	ynybqzosP4baIEsSHOBk8l/JPK13Ncg/DlEOcEnl
X-Google-Smtp-Source: AA6agR6eBmWxqg3XkoHYvhLYsvVWU6yf+tw0M88bpPbBWRisbp5T7RjnuwgCsPx/X+xpdOR/81Hp+D9ZDFCuRAuYP5M=
X-Received: by 2002:a05:6870:b41e:b0:116:5dc7:192a with SMTP id
 x30-20020a056870b41e00b001165dc7192amr2466807oap.136.1660169753648; Wed, 10
 Aug 2022 15:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220715191622.2310436-1-mcgrof@kernel.org> <a56d191e-a3a3-76b9-6ca3-782803d2600c@kernel.dk>
 <YvP1jK/J4m8TE8BZ@bombadil.infradead.org> <CAHC9VhQnQqP1ww7fvCzKp_o1n7iMyYb564HSZy1Ed7k1-nD=jQ@mail.gmail.com>
 <YvP+aiGcBsik+v3y@bombadil.infradead.org> <d634ce85-f69b-5441-a72b-ca161cc1f00d@schaufler-ca.com>
In-Reply-To: <d634ce85-f69b-5441-a72b-ca161cc1f00d@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 10 Aug 2022 18:15:42 -0400
Message-ID: <CAHC9VhSkTV21tY_mLDxYr4YQ4LneNiLReRJ1Tgt4XxM=Jb1gow@mail.gmail.com>
Subject: Re: [PATCH v2] lsm,io_uring: add LSM hooks for the new uring_cmd file op
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, 
	joshi.k@samsung.com, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-security-module@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	a.manzanares@samsung.com, javier@javigon.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220810_151555_742454_5D29A1A2 
X-CRM114-Status: GOOD (  26.13  )
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

On Wed, Aug 10, 2022 at 3:26 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 8/10/2022 11:52 AM, Luis Chamberlain wrote:
> > On Wed, Aug 10, 2022 at 02:39:54PM -0400, Paul Moore wrote:
> >> On Wed, Aug 10, 2022 at 2:14 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >>> On Fri, Jul 15, 2022 at 01:28:35PM -0600, Jens Axboe wrote:
> >>>> On 7/15/22 1:16 PM, Luis Chamberlain wrote:
> >>>>> io-uring cmd support was added through ee692a21e9bf ("fs,io_uring:
> >>>>> add infrastructure for uring-cmd"), this extended the struct
> >>>>> file_operations to allow a new command which each subsystem can use
> >>>>> to enable command passthrough. Add an LSM specific for the command
> >>>>> passthrough which enables LSMs to inspect the command details.
> >>>>>
> >>>>> This was discussed long ago without no clear pointer for something
> >>>>> conclusive, so this enables LSMs to at least reject this new file
> >>>>> operation.
> >>>> From an io_uring perspective, this looks fine to me. It may be easier if
> >>>> I take this through my tree due to the moving of the files, or the
> >>>> security side can do it but it'd have to then wait for merge window (and
> >>>> post io_uring branch merge) to do so. Just let me know. If done outside
> >>>> of my tree, feel free to add:
> >>>>
> >>>> Acked-by: Jens Axboe <axboe@kernel.dk>
> >>> Paul, Casey, Jens,
> >>>
> >>> should this be picked up now that we're one week into the merge window?
> >> Your timing is spot on!  I wrapped up a SELinux/SCTP issue by posting
> >> the patches yesterday and started on the io_uring/CMD patches this
> >> morning :)
> >>
> >> Give me a few days to get this finished, tested, etc. and I'll post a
> >> patchset with your main patch, the Smack patch from Casey, the SELinux
> >> patch, and the /dev/null patch so we can all give it a quick sanity
> >> check before I merge it into the LSM/stable branch and send it to
> >> Linus.  Does that sound okay?
>
> It's taking a while to get a satisfactory test going for Smack,
> but I should have something in a few days.

Thanks Casey.  When I get a test working for SELinux I'll be sure to
send it your way just in case.

-- 
paul-moore.com

