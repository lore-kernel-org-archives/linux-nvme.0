Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEBCE63F08
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Feb 2026 21:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nh5TnaSI7rZPj2uhgnsZBl8QSuJdZuhEOKvh+vqqOKs=; b=emprpKg655gz8ETOYzvmh5egHl
	Cpphoycp7yiGWipt4ldBm+En6DId3Yy8OyM35yy0XUaPOHbJrozh6zY5/27gYG5LOYKdePlUF4BSU
	uxqAH4Zo/ntbxrjge4YdXCPWB+3+29GS0DVbDqeK2Uo3wiHqUSMmz/imrbI5Wp+1XSp5h3V+GUxS/
	IA9saEJzcPkQNRiWleG1nnNzOrE6I3BjWqFdQR78x0rTcCY8bbH4veSw6vJB1E5OQbKUysrGwfqzy
	3WWyMPW1b9vqxMLr4pWUDt87Yo0FePjVyA78S6IgC/PyypMStxoL5+Yqn77VklEkp5jHLOw/z3PSN
	ECouFNVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrjVv-00000005fjF-0AHe;
	Sun, 15 Feb 2026 21:18:47 +0000
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrjVr-00000005fiV-3Fpl
	for linux-nvme@lists.infradead.org;
	Sun, 15 Feb 2026 21:18:45 +0000
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-385c2f88618so19734851fa.2
        for <linux-nvme@lists.infradead.org>; Sun, 15 Feb 2026 13:18:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771190320; cv=none;
        d=google.com; s=arc-20240605;
        b=hwY9Q18bujzehNROE1ujrTNbk696TDP2/awWbnq3Ha4sBlZiS8PmZ4pKW3ae/llgTg
         2Z5XQcqKhxme95HgrPrVH8QXJbo1WFrE8Fv2AzfXy5ppac5RhmfbVnQA753UJYcMtMCO
         APWBnxMy80JqPaNR54+VELmydU56Yhh4TTUgj5qb5fTp10B4Ycki1qUSOE0BXWvtiDBw
         h9xFsW09ZCw76ggtyUfU1uU0ZksGEX5x1FQSPbfmMDOitd4TyFM3ENdwuHkOt62KJUXH
         rvx4pfbrhtPK23zbhyZZEgxdowEoP9nrpz5tbkPH4lzm7c4sGNLr4OXR9FljxkZEyHqZ
         xXmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nh5TnaSI7rZPj2uhgnsZBl8QSuJdZuhEOKvh+vqqOKs=;
        fh=nuymxc5uNT+WEWKF8cqfiz71eNV+5++NI/l2rvQGE9U=;
        b=MrTD/sq7gzdm8La4CjwhyjlMRtER8D94TviB/yKI25FGglkT9DLx8zuHE78OeDPBg6
         9YPkMlyas275CSggpIpy9bsXPf2vKbOrmOMJWG/HbIP63Ugiig0+LjZj4wbkvwqlRixt
         kxYzB/iVu4g+FRkqsekpg4Edepn02/43IHWUbXoQcvztdc6e92FgLEGRfgNEASTlbVH+
         quM2QYDc8rW0qbuhZRoUC5gR8CxXvV7RrRTDeGWiaOads78uKuiq28zswvPbfy/4uP8r
         9HFIkYMKMaD686cj7jYud/+3q76XIjX29pXwRVb6fno39aDLcP9gTd66/QmEduq71iXt
         xSyw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1771190320; x=1771795120; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nh5TnaSI7rZPj2uhgnsZBl8QSuJdZuhEOKvh+vqqOKs=;
        b=c8jVBIajQ3gtAzDjw9AB4UnQPbXUZNV++umh7kOiU5RP4iLUtSgOItdafrZLlNt0cW
         CNbNgiKC4pz2VfRh+U0fzPp1QBYYfkZXGuN20MO+nI7Dck5AK4BeC1QH20goXQgFZ6Ia
         6kc/0gjHA9MEfsNLvxWs5uod4IP445NfLlaHS2qOhfYLx0HD3qD/96EDklfTF18+P8jA
         B8bI5fojBiC4z3+fOBSFT85NH0eVoSAFKUaPOFcayrw2YwvnuBKKATMgfmxgVs5NzyVP
         jXt35UnApH9W8NRl4n2v4Q1EpTihGFTKefckvjLhm+9wZ3hK32q07InvjW7NqNt2nZFa
         mN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771190320; x=1771795120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nh5TnaSI7rZPj2uhgnsZBl8QSuJdZuhEOKvh+vqqOKs=;
        b=gV4xJt7aDt6Y9/ctqwQpHUqfj4oDbLeRODQCFkxaHKmwbvBPpzmOcUBe32qMLy6tUW
         Px3MvPj0wYUO3DeALtFO9VVsJ6hhZmW7QvBODVHAAQe+/4OV+ksjw89jKckbIboACaTJ
         clacsfilzKg8kZAvNHvOaWSyOGiqoSBwwxjoSEMJihHvelpgH+SpM7nChBRR4nRKvNX0
         SExCZyVUcxoSRHvIGqTy1icMS0OEdXpyjpyo5okhdkQ2DqLlazbR5h+IMfNwUB+hD7Fo
         DvbFr+XexBDYYhj6y0eE6ndSy0A8FhAoJXDVLiF3b+8xC8CxQ8DCaVdkKDCoRWOxOjP+
         hCGw==
X-Forwarded-Encrypted: i=1; AJvYcCUgeHVGxizd11nxITqndnOvzlpV2MEFwJGPPBhQNYK52yIcfXu6Qa7NLZWSa9VUgjE1CWCvYCMAvjz2@lists.infradead.org
X-Gm-Message-State: AOJu0Yy4TmuWZ+h4kxOvKon0gT93BA1H6vcfiijJVotMmWc4IaKOdxrs
	VVTSDRtYxuGkRtCZm8RDsUOXpYp9vaP8opKamI/Fz8qkhTaMQ27ijqOdVDZ7FT7p6WS6YwUAWAR
	pGG0h6nbwqko0Bi45iEv0zIMkuGd8VIWfm3bcejG2og==
X-Gm-Gg: AZuq6aJua1995BqAz61SMjXAFi1OvD87fFZwOVhmVGtSAgkVXspr9luinQ1C1nQN2r7
	pZzVL1p83Mhv0Dug76cvoZEPnrrbqy2JyTS3jgB6Nk5et6vvg6n7TC+n3+2R5ETxEDQCJkjJVzy
	LLUYrh29dlbmEZ82QH1VP62OBTJwhgwFlgCdiu/aN7WT8KBPZFlwYgd/44fWlTTEyp7+wAYZ0Ys
	6oO7llupawnMZz4Ftgmq3k5pnAndXJpHzi/YogfzvX8dj3klVALktN0Hm4UTOlX8zSq+ddmxDyp
	pwWTQkcXIveUA3TGNf3yq18FeibRdEbiogNH6oxilXoFSjSmRBVCF85it9dHJpzHDP7jsUoQB7I
	Yf/NKQ3HHVqgEfOwBjp9qAZU=
X-Received: by 2002:a2e:a781:0:b0:383:1d89:8d0c with SMTP id
 38308e7fff4ca-38810525294mr24772281fa.15.1771190319860; Sun, 15 Feb 2026
 13:18:39 -0800 (PST)
MIME-Version: 1.0
References: <31a2a4c2-8c33-429a-a2b1-e1f3a0e90d72@nvidia.com>
 <459953fa-5330-4eb1-a1b4-7683b04e3d45@flourine.local> <aY77ogf5nATlJUg_@shinmob>
In-Reply-To: <aY77ogf5nATlJUg_@shinmob>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Sun, 15 Feb 2026 22:18:28 +0100
X-Gm-Features: AaiRm50UiUfxjs0q7nnu2kE7OqfPsAIU6uDVz4YX8OUdHbhFYRNnEhFTdkEJv9w
Message-ID: <CAJpMwyis1iZB2dQMC4VC8stVhRhOg0mfauCWQd_Nv8Ojb+X-Yw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC] : blktests: status,
 expansion plan for the storage stack test framework
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Daniel Wagner <dwagner@suse.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, Bart Van Assche <bvanassche@acm.org>, 
	Hannes Reinecke <hare@suse.de>, hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	"sagi@grimberg.me" <sagi@grimberg.me>, "tytso@mit.edu" <tytso@mit.edu>, 
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Christian Brauner <brauner@kernel.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
	"willy@infradead.org" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	"amir73il@gmail.com" <amir73il@gmail.com>, "vbabka@suse.cz" <vbabka@suse.cz>, Damien Le Moal <dlemoal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260215_131843_939146_90182F8B 
X-CRM114-Status: GOOD (  43.27  )
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

On Fri, Feb 13, 2026 at 12:25=E2=80=AFPM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Feb 12, 2026 / 08:52, Daniel Wagner wrote:
> > On Wed, Feb 11, 2026 at 08:35:30PM +0000, Chaitanya Kulkarni wrote:
> > >    For the storage track at LSFMMBPF2026, I propose a session dedicat=
ed to
> > >    blktests to discuss expansion plan and CI integration progress.
> >
> > Thanks for proposing this topic.
>
> Chaitanya, my thank also goes to you.
>
> > Just a few random topics which come to mind we could discuss:
> >
> > - blktests has gain a bit of traction and some folks run on regular
> >   basis these tests. Can we gather feedback from them, what is working
> >   good, what is not? Are there feature wishes?
>
> Good topic, I also would like to hear about it.
>
> FYI, from the past LSFMM sessions and hallway talks, major feedbacks I ha=
d
> received are these two:
>
>  1. blktests CI infra looks missing (other than CKI by Redhat)
>     -> Some activities are ongoing to start blktests CI service.
>        I hope the status are shared at the session.
>
>  2. blktests are rather difficult to start using for some new users
>     -> I think config example is demanded, so that new users can
>        just copy it to start the first run, and understand the
>        config options easily.
>
> > - Do we need some sort of configuration tool which allows to setup a
> >   config? I'd still have a TODO to provide a config example with all
> >   knobs which influence blktests, but I wonder if we should go a step
> >   further here, e.g. something like kdevops has?
>
> Do you mean the "make menuconfig" style? Most of the blktests users are
> familiar with menuconfig, so that would be an idea. If users really want
> it, we can think of it. IMO, blktests still do not have so many options,
> then config.example would be simpler and more appropriate, probably.
>
> > - Which area do we lack tests? Should we just add an initial simple
> >   tests for the missing areas, so the basic infra is there and thus
> >   lowering the bar for adding new tests?
>
> To identify the uncovered area, I think code coverage will be useful. A f=
ew
> years ago, I measured it and shared in LSFMM, but that measurement was do=
ne for
> each source tree directory. The coverage ratio by source file will be mor=
e
> helpful to identify the missing area. I don't have time slot to measure i=
t,
> so if anyone can do it and share the result, it will be appreciated. Once=
 we
> know the missing areas, it sounds a good idea to add initial samples for =
each
> of the areas.
>
> > - The recent addition of kmemleak shows it's a great idea to enable mor=
e
> >   of the kernel test infrastructure when running the tests.
>
> Completely agreed.
>
> >   Are there more such things we could/should enable?
>
> I'm also interested in this question :)
>
> > - I would like to hear from Shin'ichiro if he is happy how things
> >   are going? :)
>
> More importantly, I would like to listen to voices from storage sub-syste=
m
> developers to see if they are happy or not, especially the maintainers.
>
> From my view, blktests keep on finding kernel bugs. I think it demonstrat=
es the
> value of this community effort, and I'm happy about it. Said that, I find=
 what
> blktests can improve more, of course. Here I share the list of improvemen=
t
> opportunities from my view point (I already mentioned the first three ite=
ms).

A possible feature for blktest could be integration with something
like virtme-ng.
Running on VM can be versatile and fast. The run can be made parallel
too, by spawning multiple VMs simultaneously.

>
>  1. We can have more CI infra to make the most of blktests
>  2. We can add config examples to help new users
>  3. We can measure code coverage to identify missing test areas
>  4. Long standing failures make test result reports dirty
>     - I feel lockdep WARNs are tend to be left unfixed rather long period=
.
>       How can we gather effort to fix them?
>  5. We can refactor and clean up blktests framework for ease of maintaina=
nce
>       (e.g. trap handling)
>  6. Some users run blktests with built-in kernel modules, which makes a n=
umber
>     of test cases skipped. We can add more built-in kernel modules suppor=
t to
>     expand test coverage for such use case.

