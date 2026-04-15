Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041B4F41996
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Apr 2026 12:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NmZn8YaVwP7ozh9+ymcLzBd4heHiFWdC0pHFeYEhGzA=; b=Z1+eYIs6NIxZ1ij0piDb9vmqCR
	FyaTitQn+7kb95z/ZuSTfexe6S0XOfrgvklxaV31mpFey7sHmLiyYQYtcDAAHyENQ0ntsgJXRp7np
	yA+UKJFvrqfw2TbpZUxNr83u+IXnuJVMMp+2WoU8LJiHkWPBTggdAcBWiO16yh448yoLiQqgyFWPx
	f0Fps1MBXjHKXrDjqbS+TwxSNyDdzZCmfpguevAQ/HRiZVSqcrNAMAEDwj1u8t2L5JnK5EruRG/Zs
	1jpw20JoAeS4BKJS9NmuxfZBJBQFAbWVTdYXviblFgPDpRvfWJ0y0jp6uQVSC4RnSKM1n8VnZhDU3
	f/xKw6sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCz4E-000000016Af-3sUm;
	Wed, 15 Apr 2026 12:10:02 +0000
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCw4p-00000000rnO-1O4U
	for linux-nvme@lists.infradead.org;
	Wed, 15 Apr 2026 08:58:28 +0000
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-47952229034so2001742b6e.3
        for <linux-nvme@lists.infradead.org>; Wed, 15 Apr 2026 01:58:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776243506; cv=none;
        d=google.com; s=arc-20240605;
        b=hMg9dJoMh/bWhuqbb+no2xISC0hBNt7O/ZQ+JCX+SIWjzi1ecUhTyX0KsDAPhD1AQF
         kYU1Mdz58kYyEsT0O7Ty7we2CLs9MDbljXODJ1IeJSbg/1d8gF0ys+w1mT2WiteYGZG7
         13e8brvjh4W2xlIWtHA3F4jf+HkJNPVnjoEwHEFEDIDsg8yDaPiWVV7NJN0kXuDx3+m7
         LOF4k0vxpexRdqdmMI3MKP4WehLGysevLtVglLx+jEYM0QSAKG6UgfouDD3u75dio4xo
         p2QnWOVLAKgnfs70CFWBnTH07Sf+UdT2NGp2IGmK5POyWqiZJ8thLVXsR9/C/tjZwtVL
         CTVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NmZn8YaVwP7ozh9+ymcLzBd4heHiFWdC0pHFeYEhGzA=;
        fh=T5zw/K+sDdyEVZNx/lG5JdXdjAP89GggOKnJyiteISQ=;
        b=EbD12Z9Rq8ARJUFhFfzgnY+mMS4T6nbIEyPRb0e/JQNjRLE0fblNmhijbZPrOHIdje
         iWI8jvzY6bVf5H9LCFxCjdcc22zivxv70C5pzZOJKvrycdG8s/rjwDbqA+2kgR+rXt8H
         ESLniOxarVwLmHdf4vBPXAgo+nxk/W01W9P3AWdfHpPk6ebQbf2McLHB8cAZHsbqArxt
         22B06DeZulgUgF3XRuXSnphOB14a5KSLY5rbYLy4e/gaEU+NTe6+SJaxLJGiBM26ygrn
         ncysYYs3ii35Z0ragZ+mBgA6McpN9rWSkUwIJf5wbfQlLmZoN5P51GA9jHZ4X9ZohWjq
         32oA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776243506; x=1776848306; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmZn8YaVwP7ozh9+ymcLzBd4heHiFWdC0pHFeYEhGzA=;
        b=LUSLdbvjHzepGjJGC0TqVDUCLf20JdIXctOIOClBHVrvEwFdjvCD249sByFaEk+Sd6
         1g7uElx2nWHrgSfLrE+IE8CJm4n1/PxL7utetwBi7I0nMV17IccU1TEgQswKKqIbAXiT
         6OXG5rGw6ADSsEQ0gyC3SQpvB3/LKue2pUr+zjDvEC/sFqcnqKWoaiVy31kezgilr83D
         1X+RIQF8NxOjz4rwZ7S9NVQMyP8pAoDYkj1yr23KjIRAjC80XOqQwixZ7lTwmnvgtCj2
         ppxtMMC3nXR6PIbTfnS1b1AK7qJ9GoLimEevYNpj9FKKTO+SVBway09LT/TCGmGml4OS
         pBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776243506; x=1776848306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NmZn8YaVwP7ozh9+ymcLzBd4heHiFWdC0pHFeYEhGzA=;
        b=TgclWe1u3p1H8hNx3lik5maHC1/AA+7U/hGGmp4amyvxDE2WIR27vHeEQi202nJjAz
         kFjWjnYV8kIwtZQyRllmOVzw3qUAKf3U2E7YpZv6v3730rQaxl/RmTEY7dvF3S1dyvcn
         /FN/GENQSe6K2yho/ezvnWQ9uR2fkSnGv5MmPDo1Jiuz/ZIpPE4gsQ0ZrvJXIZFjE9oh
         nJ5vhzecB4SX81y6hmHhfxYZVpWiBUuDSSuZLVrqV7FcNjMVVk6lUWJnmiobHIiFaPDB
         xs4gZmTP5MNBRCd/1P0BFz2eW8M7+ZzWtPqGcIvp4jOAIIkWcig35guitiYJSFHw3KY+
         8dmQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ySTj1+WjEs+rJ+mRIyTYlEp9whgvsgslTq+gYZSqjrqi0+w+T8vZgQjkimy2f5Y3uYhOXi0p+Woih@lists.infradead.org
X-Gm-Message-State: AOJu0YwQLULB2d/BSYT9TXNHkHGJHo3KpyF6vcC3CbHCjqMdBpZolsyj
	IWYHI1naRZj7pD/Q13I4kvD/5S44xGFh+o5hFY0GYHvVPQn/jkC4giQFNBrCw1ERjhW5YR7yI/x
	F2D3Rkbpvp6nntBV7lpFIXO0wwcRdcUg=
X-Gm-Gg: AeBDiessXYgLlcwx4MSVHONIYXz70F4npkPvyiA51486UzInBMvNgBnV4OyVnZMRlt3
	1ozUUAbCHSzZ9+bNJLlFJLvalszpPKEqgjpYjxzYqZM7df/SQMPs3mypoaPH4jMYn5KQmbbAONN
	3m1lk1Aqd/ooOHTN3fdue2Fs07Rw9JxmMA23eEznA9w0H/5pQanNGSKd1OWgi/ld0G20Qi8uTWD
	hbeDimP6Wd2XpZS0REirgDGw6y/qs+bGgfjroqTO4tjOUs7bihHBh+ulJ20pjP8ABvgTkdi3w6L
	C5pUII4M+9rzD+DE3ZVdwZ8Q8TKPZhb7DNJDeBxQ7w==
X-Received: by 2002:a05:6808:c162:b0:467:91:fb26 with SMTP id
 5614622812f47-4789f111a6dmr9948231b6e.37.1776243505664; Wed, 15 Apr 2026
 01:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <nxe24ixebb4lm2d5w4aubhtwr23df6mumqd663axj35oswdiyv@amtqhtsidyr4>
 <adMoon3Zf6gO-UbA@fedora> <zawhqvn53mcp4wf7axsmuq4cg73upxs5h2zgrfta5dpat3sfy4@zctfbz2ttz5m>
 <CAFj5m9JE5e4DRGbzQFxDdZWU76ZPQ3G+C9JpLu0mhTB6aesZ9g@mail.gmail.com>
 <a566smu6morqeefqal23eek4ibezfuiwhs774xtxhyyclpbtsx@uzzwgbzmwdjd>
 <adhj_w11cpMfeEgN@fedora> <dzpxscrhibmi5okkozf5jfull4dcajgpctldvdyfcjgmpeetk5@tkeyqouyabzy>
 <adpD8M8cNu3IZzEL@fedora> <6glgsbk2djsz4cqtbp2ht4274dw4rveq6fojlnpnuvx6zmpjxw@i43jo2l4qlz4>
 <ad0Hk48y5JEeMlFk@fedora> <20260415083458.UD3cF5IQ@linutronix.de>
In-Reply-To: <20260415083458.UD3cF5IQ@linutronix.de>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 15 Apr 2026 16:58:14 +0800
X-Gm-Features: AQROBzBesZ1I4COKhVLm4yVWD97BVXXbWvhA1t-bSTLWqOPST2qVCo792OkUIh8
Message-ID: <CACVXFVMPO_JZMSbELnsKzUpXZ7M1sF7cHETUtdqEFT73gn9shA@mail.gmail.com>
Subject: Re: [PATCH v10 13/13] docs: add io_queue flag to isolcpus
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Aaron Tomlin <atomlin@atomlin.com>, Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk, 
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, mst@redhat.com, 
	aacraid@microsemi.com, James.Bottomley@hansenpartnership.com, 
	martin.petersen@oracle.com, liyihang9@h-partners.com, 
	kashyap.desai@broadcom.com, sumit.saxena@broadcom.com, 
	shivasharan.srikanteshwara@broadcom.com, chandrakanth.patil@broadcom.com, 
	sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com, 
	suganath-prabu.subramani@broadcom.com, ranjan.kumar@broadcom.com, 
	jinpu.wang@cloud.ionos.com, tglx@kernel.org, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	akpm@linux-foundation.org, maz@kernel.org, ruanjinjie@huawei.com, 
	yphbchou0911@gmail.com, wagi@kernel.org, frederic@kernel.org, 
	longman@redhat.com, chenridong@huawei.com, hare@suse.de, kch@nvidia.com, 
	steve@abita.co, sean@ashe.io, chjohnst@gmail.com, neelx@suse.com, 
	mproche@gmail.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
	mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_015827_382104_9E9E36B9 
X-CRM114-Status: GOOD (  20.87  )
X-Mailman-Approved-At: Wed, 15 Apr 2026 05:10:01 -0700
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

On Wed, Apr 15, 2026 at 4:35=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2026-04-13 23:11:15 [+0800], Ming Lei wrote:
> > > > What matters is that IO won't interrupt isolated CPU.
> > >
> > > The isolcpus=3Dmanaged_irq acts as a "best effort" avoidance algorith=
m rather
> > > than a strict, unbreakable constraint. This is indicated in the propo=
sed
> > > changes to Documentation/core-api/irq/managed_irq.rst [1].
> >
> > Yes, it is "best effort", but isolated cpu is only take as effective CP=
U
> > for the hw queue's irq iff all others are offline. Which is just fine f=
or typical
> > use cases, in which IO isn't submitted from isolated CPU.
>
> Couldn't we tackle this by limiting the number of managed interrupts the
> device asks for and then limiting the CPUs it could be bound to?
>
> So if have house keeping CPUs 0/1 and isolated 2-63 then managed_irq=3D i=
s
> futile since it use 64 interrupts and map each to one CPU. Even if the
> device supports less it would map them evenly across available CPUs.
>
> If the user wishes to initiate I/O from all CPUs but not be bother by
> interrupts we could limit the device to ask for 2 interrupts instead of
> 64 (with the consequence of more queue sharing) and then limit those two
> interrupts to CPU 0 and 1 instead to CPU 0-31 and 32-63 like it would be
> now the case.
>
> Wouldn't that be what the io_queue flag tries to do?

Yes, that is why I call it one optimization, however it does introduce
cost of CPU offline failure, please see patch 11.

Thanks,
Ming Lei

