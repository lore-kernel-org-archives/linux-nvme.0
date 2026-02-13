Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACAFDEDF165
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Feb 2026 14:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PPZ5UjJXZiG/dIIj7T0/FHqJccKNEyOB/oHBxQ8dlL8=; b=Ixb2UU5QHQ39rrXaFOf/cOH6DX
	88HECh/AF4fjZyT8y9Vt6pClYnGc/gTnC/woTDajBVY3gKXCAklyVjTsNINyvUZIhnngMDnDa8e6F
	vgL/Lc087EFBB9tqMF+RzJfYTxOrcnq/9u6Tu1rNI3JcNY+H4iN1GbkHwl0fAMyrsd+RgkRhCQtHy
	9cr+eHYGNwVRHSIoNIWMX+/RQDGTSeFpAtlooYMlN26CMQVXFPIxmmQlquYDV6BNqvt0kg/VqBNc5
	Jnyg0GvvCe9XqbFx1rVoIDAmJM7gr/qYM24p7OG1G4jMsdeSH1mTOqg2okplC9n4a7RYM7Ywz/bV8
	nBTM2GXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqu0X-00000003Wv1-0vr7;
	Fri, 13 Feb 2026 14:18:57 +0000
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqu0U-00000003Wuf-3kxW
	for linux-nvme@lists.infradead.org;
	Fri, 13 Feb 2026 14:18:56 +0000
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-386714da2a2so7356291fa.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Feb 2026 06:18:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770992331; cv=none;
        d=google.com; s=arc-20240605;
        b=YPZSgUBBGdarBg4oIVt2DZP/j9lySVCooqmwK4cUpl+JTVRdd9xSF21f0zi8nzLW3e
         FdtsaaUOrIDfbsO+qBsaSGdBpzDlHQLxu9fBxFpybvd9zRZrswnIxkd0urbdU93RAvxi
         /0mV5bS1fwdm0pG6mhcR9ZVltxdE1dPxb9yKDm02tRhXSojzVolpltTdpHT7mO0RwIBi
         b1yp7gVfxVMdPh28kVEcBfpChmt0s2o8wYUXo887PbJyLHYm8vjBe5C1Mhjf5DU3C318
         ljCwPiOyOjpTMyzgitqpA59NhWkfMBmN8uYHxSA6sFBCoZnEY+xp7v+KbxPff+4MzRxj
         FwDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PPZ5UjJXZiG/dIIj7T0/FHqJccKNEyOB/oHBxQ8dlL8=;
        fh=YpRCPV1eNV8MO0XFnuiNAuT9utAO4CfvTJDC8LRtTCk=;
        b=lG08CWgyVz9hqY8affP+COXbgT2LOCMyi/DfxNIlnkiqPKDhcg7prfWEComWOhYAte
         mH1rALm5D0adODMNfMwK0sObN121oMRab1KWXcgw36ceAxtZegrMWbcpikCbCB4S0+8/
         9qKoRKfp2zEw1Z76DF+TV6GESom/vLHhKYVIbPKMYBUydjD1Lnl4yfcxJIGS0g6/Y1/O
         UIR7bLCc/ZKQJK6WGa4KYGT6EBgiaGKQC4M/0SkQp1y1h0KG0d1ErtOu9hpqemByockG
         lXa+h7WcXjfWuOu/nEAbdSCkMGBMEsQ++bGmp1Sn7PkClqhW94tw/T0ZEab8P39elpl9
         kwFg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1770992331; x=1771597131; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PPZ5UjJXZiG/dIIj7T0/FHqJccKNEyOB/oHBxQ8dlL8=;
        b=IzXZGDpsnf4jdUjRhpWdlTgHfwSL2bogOR2e6T8mWEKVBkr4sm8CUPlaEhh4LGJXgD
         25U5xNs59ga707mgffYPXER/GDm7NSAv2M3Qy05WTC5LrUXhw5fkla7nYt25w6C/rCAz
         D+bjZxxAmeDTW4+bKzNbq05pEUSAnwiFjZNfhZy6jkAm9FRsoBZiKERePA2dmxhKUNOY
         eV8f7kS2CpHeFFHbXpGqqERjZoCErN3MJvcMxmfnB3U9ljCIsFApZJQ6wCXRJqCV/HM7
         4t7YhMUH5fe6I56xOEZjYV+EBwSeh9eI+v/Q4gbIjUpRlggEPHWGRCf48xjOD83XrJ2s
         s6GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770992331; x=1771597131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PPZ5UjJXZiG/dIIj7T0/FHqJccKNEyOB/oHBxQ8dlL8=;
        b=awDbW+oBL2GXM63hxKLNTua9j9ETRTxmiWcEcZ7syxqVOcfJEEwwhmlJb0q8NS15Zy
         uDA1w2ZWkOoVwxgGY0RK0Qs1HD+pzzLUPLHqoIROjwfLDKGMUSO/LeXDbU7GeGnTl+PF
         sMY7I+gK34aR1LYaPIiHZWs86cJ4yYPgqjfJHEdcDs3uHC6BjlyxsZ9dpSj3yHmwuXex
         zqp0HJe5LMKn4Ot7v4gowPRftgKEuwi+pMG37CWE/Fm52scZuSNVH7CsruV5/5TD0HxS
         ZjVyDxNGOOdinqaYEd2a2in1nWEz2IsFbTZ3Pg2gu/3Hfp39JtSP5jC6ZmfdCTHQtYEf
         q6pQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj0SmJNFRemwWZrsyvyOo1dT/w78ALQ2a68BbNkunyBeobxQiXV+oov3hU/MmtapcsY4k5ymM/rVGl@lists.infradead.org
X-Gm-Message-State: AOJu0YzN7hussaLmF716n26npjZipCEthWv349VO4QpWBJqKwDOakgyr
	tYALq5/uelhl3n5CzKmFLJJ9gUxY/0zX9bn4MCnkJFFsT7OqY83KyoiHx+V5aoCXyT4k6dX/4X5
	jhNtPhHe54vVgpM0/H0PktRGY4AVsLlJr3LTFekhxYw==
X-Gm-Gg: AZuq6aKduNEYdwc1BWQ87onmwxctsYEGbgKB5DiXq1jUkzh1kDIcUWgRAEGPPIpM+eC
	9QKqT1L2RIx44/OosXP2am9ooJQ69imWEdtu+7LgmzQO6Wezi9ffzqbRg0ODq3K9+hPOI9aOOPV
	xClohkXlusKg9LDN1KKExVMbm2mmo8hzBoVQsUydxgDu8pBN355++miqJNDUPWtar6Mm9JRX824
	yX2MdHdaxfB7kroKFbKOswAsXaHE5TqoJ3AwN3K7hvR714HGeE2VJvcHKrXFKVH4lSVR3XltI8h
	Au4F2m0DpxTfV79R56MCBzajJt5+gNt378qQvAMGIcN3CJ1s/WYRIz9aqzN9j6IfnxbHxRUqFZ5
	AjDQ=
X-Received: by 2002:a05:651c:f17:b0:387:1c06:f744 with SMTP id
 38308e7fff4ca-3881054c449mr6460791fa.23.1770992330706; Fri, 13 Feb 2026
 06:18:50 -0800 (PST)
MIME-Version: 1.0
References: <31a2a4c2-8c33-429a-a2b1-e1f3a0e90d72@nvidia.com>
 <459953fa-5330-4eb1-a1b4-7683b04e3d45@flourine.local> <aY77ogf5nATlJUg_@shinmob>
In-Reply-To: <aY77ogf5nATlJUg_@shinmob>
From: Haris Iqbal <haris.iqbal@ionos.com>
Date: Fri, 13 Feb 2026 15:18:39 +0100
X-Gm-Features: AZwV_QiMQawRDF7MErqQBuWp-MuhZWG8Dupe7ZsjeFBjsuqumHNHXRrm7OHAk1I
Message-ID: <CAJpMwyi7-g0Oh2aJHQcrbf4zQN-2Z9oGBCDRdQbt4drQKqUN7Q@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20260213_061855_009147_8BCB9139 
X-CRM114-Status: GOOD (  43.74  )
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

I am interested in this topic.

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

+1 to this.

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

I like the idea of blktests.
We have internal tests which we run for RNBD (and RTRS).
And I plan to port the RNBD ones to blktests.

>
> From my view, blktests keep on finding kernel bugs. I think it demonstrat=
es the
> value of this community effort, and I'm happy about it. Said that, I find=
 what
> blktests can improve more, of course. Here I share the list of improvemen=
t
> opportunities from my view point (I already mentioned the first three ite=
ms).
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

