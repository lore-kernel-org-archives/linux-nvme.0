Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E4AC00140
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Aug 2022 18:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JF+jvzJ9J7rN+bZsHfjsFFUjwlN+h+ky1MttPYSMiNY=; b=00ZG5L4BnLXjR7gMfrkICHP9r5
	J9p5o217y7ygh6SKOcbVizi4ZfHwIYiYt3UBg0AxgC6SbAGtDO8//e4PBEU2Ugac5MNj45hDRNW5j
	an6au/9u3ya2IuB88+2vTYz82l9JU42FRh3PXxTn5d85c55ukQUnf+HwdED5dALfV7VkoaW4zMmKT
	VqsDQeZK361bfdlRBgwkTJ7wT6zEss1j6l7n/LQIU6dp3aQZJgL1pfj5SlRITf355CIR8N4dmQBhS
	T3z+TA2U5yhUGy0G3sbeN0UTWTY0M+NQhOexBFDZLcLu0QGQRcyQH9yIAidha+I4tyYAq28jFih4O
	/yh+Pr2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLqcu-00DoPt-LY; Wed, 10 Aug 2022 18:40:20 +0000
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLqci-00DoGm-3V
	for linux-nvme@lists.infradead.org; Wed, 10 Aug 2022 18:40:10 +0000
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-10ec41637b3so18812760fac.4
        for <linux-nvme@lists.infradead.org>; Wed, 10 Aug 2022 11:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=JF+jvzJ9J7rN+bZsHfjsFFUjwlN+h+ky1MttPYSMiNY=;
        b=CW4o+Cd+JnxBhfMY1lKxIDc2nY2q+nXtdmdaeccqBavPXcwjyi4IkmmEfb2dKhZVk/
         8HIC5+vmay3B833cSqxul6tLEgXlRIGj0inW3RSpVBEOW5syEHxCGVdvVmZD+cQp4DjC
         DYjWXwb8DLnhFq8nlLW8PrzanHvoZL/xfLoKOaQ+XWoKeJqHCZMnPY9ifxMKGCTmJz7b
         aQjKlPAfPIfG4KYmPtrT7Koz9vmi/zpK1L6YejMHb0FukqMNU0ebs0H2oZsk12kXXel7
         GKLHDdd3HnsKTM24KrVDiMP1WnPuAJOGdU72PZ+qskXfKzirp+aOb1toE/D4RdHwi8uR
         WbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JF+jvzJ9J7rN+bZsHfjsFFUjwlN+h+ky1MttPYSMiNY=;
        b=CY6afqwkl1Fm1XldZ9910i3Jg6gBz21Y3Arm9BLlg5GU7dPRVLPrz3xDe8fMy8eccw
         ITKqg3DJVGP6ZYXF6zduwCC/QeaT1TkkDeGC5cOsNP1/XgMchtDJftM0Hx7gnQX8jn0M
         sLGXyIiONzBQN6v1noq07tgixz2ZGIqjwWuBHsfLAnGj9aixkiEMiia4EkKX6LfMbih5
         /aZS9ml/pAoOosPriSgtzJjGqGkrRu9IDH4pfUj76QzRdlG1x9DDo6F5YP8XOa3Vs3i+
         hNHqnM5JnzlPYrk/XIXVV5nCKTC+9vvQ93HDev1knN3A74EZ0I6HN/ImzNu5QWgI9bF6
         CcXA==
X-Gm-Message-State: ACgBeo3e//KK5DlKLp7olb1sbD93ffhZO0Z2xG7Uqgnn4hjc/ytv6O1Q
	4+iFx4DaOtLy0NTstL1BojlSGbr6q8w9nH2qo2a9VSYGBw==
X-Google-Smtp-Source: AA6agR5nexQyG2ReJ5r0YsSyA4myGB59sSKhWcXiNCmQ8ihtGjorAgqpca5Vp8MQI3H4OAIlFeVnHNxRuDf/8S1bUmg=
X-Received: by 2002:a05:6870:9588:b0:101:c003:bfe6 with SMTP id
 k8-20020a056870958800b00101c003bfe6mr2044914oao.41.1660156805547; Wed, 10 Aug
 2022 11:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220715191622.2310436-1-mcgrof@kernel.org> <a56d191e-a3a3-76b9-6ca3-782803d2600c@kernel.dk>
 <YvP1jK/J4m8TE8BZ@bombadil.infradead.org>
In-Reply-To: <YvP1jK/J4m8TE8BZ@bombadil.infradead.org>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 10 Aug 2022 14:39:54 -0400
Message-ID: <CAHC9VhQnQqP1ww7fvCzKp_o1n7iMyYb564HSZy1Ed7k1-nD=jQ@mail.gmail.com>
Subject: Re: [PATCH v2] lsm,io_uring: add LSM hooks for the new uring_cmd file op
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, casey@schaufler-ca.com, 
	joshi.k@samsung.com, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-security-module@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	a.manzanares@samsung.com, javier@javigon.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220810_114008_412650_F0CDDAF1 
X-CRM114-Status: GOOD (  22.53  )
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

On Wed, Aug 10, 2022 at 2:14 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Fri, Jul 15, 2022 at 01:28:35PM -0600, Jens Axboe wrote:
> > On 7/15/22 1:16 PM, Luis Chamberlain wrote:
> > > io-uring cmd support was added through ee692a21e9bf ("fs,io_uring:
> > > add infrastructure for uring-cmd"), this extended the struct
> > > file_operations to allow a new command which each subsystem can use
> > > to enable command passthrough. Add an LSM specific for the command
> > > passthrough which enables LSMs to inspect the command details.
> > >
> > > This was discussed long ago without no clear pointer for something
> > > conclusive, so this enables LSMs to at least reject this new file
> > > operation.
> >
> > From an io_uring perspective, this looks fine to me. It may be easier if
> > I take this through my tree due to the moving of the files, or the
> > security side can do it but it'd have to then wait for merge window (and
> > post io_uring branch merge) to do so. Just let me know. If done outside
> > of my tree, feel free to add:
> >
> > Acked-by: Jens Axboe <axboe@kernel.dk>
>
> Paul, Casey, Jens,
>
> should this be picked up now that we're one week into the merge window?

Your timing is spot on!  I wrapped up a SELinux/SCTP issue by posting
the patches yesterday and started on the io_uring/CMD patches this
morning :)

Give me a few days to get this finished, tested, etc. and I'll post a
patchset with your main patch, the Smack patch from Casey, the SELinux
patch, and the /dev/null patch so we can all give it a quick sanity
check before I merge it into the LSM/stable branch and send it to
Linus.  Does that sound okay?

-- 
paul-moore.com

