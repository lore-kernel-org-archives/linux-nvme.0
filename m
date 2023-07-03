Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DF0EB64DC
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jul 2023 13:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vqn7IKTdo14CySBv00ohACcAfgAIiWSh1E9RKmDPgr4=; b=39lajirqE6KiUnliyYk0exTeoS
	MgCvawaT4sa8sk0seoAhTNS32uzdcgdF8jG2/rRB4XjnRE+kvruNdC43vOY/7pRY8b6IDlLNe4KIz
	C9BUWzUojCeIL5aKIMkw3j+nyR2EHITnQNe8Zn7x7hIE7jergK9S4yJZK8j96MhAKD1c+GeqbKf4r
	XwZq0c9/X1ofn20cl+kJ3AMDH+jMTPs8OhvMzwAkKUOOX9ifseqqumtFjzmYlyW/B5xBJFdUpzWXf
	1brYEyHRgL2NYDP3m96iCYPFsR3c16dgvG59b/N/KG0SFVSpQ5DgZ/1xwqLI2VsP4SSsouzDnUwcb
	fUkCJk+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGJZh-00Ad92-03;
	Mon, 03 Jul 2023 13:26:41 +0000
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGJZe-00Ad7O-0x
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jul 2023 13:26:39 +0000
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a3b7f992e7so238283b6e.2
        for <linux-nvme@lists.infradead.org>; Mon, 03 Jul 2023 06:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688390796; x=1690982796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqn7IKTdo14CySBv00ohACcAfgAIiWSh1E9RKmDPgr4=;
        b=Ek1UGhRgVlcOvIL06WHpGzgjgyHpvklDmtxMOactMDjhcaI4gwwV65eiGbrFnTuYMp
         sx+StujcB87IZnmVr0obLNhPZ3QtF3Hnn6KRTiSfoUNG34iq6GMQjbrGeO8blA+j2tvf
         h/kwO/mSVsgqvnw7MmKImnD9Pydwuvvhl5dLCVmInI1GKbEVxBZ0/2klnE3A77D9x7bU
         WI8PiUsuUjVZhuHi476SolDhvelKrfeWzquDbo/oNuoRyDoPM28I7yNszphIDppKjqcD
         nIvToQ+4GW88bXvZB5zKvNYfZ/SizZVOiU893uOtzX5iYcLUjFStPOA9WE2E32m0Xk2o
         XXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688390796; x=1690982796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vqn7IKTdo14CySBv00ohACcAfgAIiWSh1E9RKmDPgr4=;
        b=DU2rkoKeXY5Sc4BbtB1sQSq5nRdc75nd+6wUPXGZODjMY4Q+2GjCGVwoOFFh16ssd6
         lF0JfAhCwHpwFSijW8LQ0L0yO2KgnKZgsA9Hi4T1zQ9ga8/i335FoSXqqjtQ6/3VX06j
         p0rdKZKfeCsGIFJkycD8cg6vkKFrSTcGxo5LT5OPuGbHWQOY6PJ7e6WI6qQN9b9CW3Gq
         LEqxw/JYeM0dHjxGhgToWZL2O6TaAHFZDEUpCJwjQM0AhLlncHBcKk30+OGxDovWqoEK
         M48NJxLlh3UHScZtsVWDFeKAZU2ZZvOXodU4SAlhXJlsp51Jy7Mmfm3Xk2u6Nn5Cc+0V
         FtTw==
X-Gm-Message-State: AC+VfDzrrLe/lYL2ysQc4qSiZYZhkZ+UKXwxGSXRgtzKTC8YQrnxc3zu
	Qb1aXKDnOs46mU6qs8iDOKtnvXj2SXLn3+0sjXA=
X-Google-Smtp-Source: ACHHUZ6uqGeljNO+21cjgetYX14NexS83zR1TTJuyVJ+ZqhjCxOYbav6ccfXjzVMlVGI0t01i24YsOMut9poxjZGFYM=
X-Received: by 2002:a05:6808:199f:b0:3a1:e7ad:11a2 with SMTP id
 bj31-20020a056808199f00b003a1e7ad11a2mr9346884oib.18.1688390795816; Mon, 03
 Jul 2023 06:26:35 -0700 (PDT)
MIME-Version: 1.0
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
 <CGME20230627161055eucas1p18d097cbcc2215b292c65a5b3a0f0e6b5@eucas1p1.samsung.com>
 <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com> <9b778d59-c8d5-b037-0eb7-34cee5f273cc@samsung.com>
 <CABfnBFoZ=gh2rkY_oYWzjkGcu8HPQ2FqnrnushH0DZFSi8cwOg@mail.gmail.com> <50723e0c-370b-7e4f-338c-401998739fba@samsung.com>
In-Reply-To: <50723e0c-370b-7e4f-338c-401998739fba@samsung.com>
From: Clemens Springsguth <cspringsguth@gmail.com>
Date: Mon, 3 Jul 2023 15:25:58 +0200
Message-ID: <CABfnBFpZJ=kToimneFgs87i=yL37Z8_MJ5nL6NUpW9w6mFSyjw@mail.gmail.com>
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Martin Belanger <martin.belanger@dell.com>, 
	Chaitanya Kulkarni <kch@nvidia.com>, John Meneghini <jmeneghi@redhat.com>, Hannes Reinecke <hare@suse.de>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Regressions <regressions@lists.linux.dev>, Linux NVMe <linux-nvme@lists.infradead.org>, 
	Kanchan Joshi <joshi.k@samsung.com>, Jinhwan Park <jh.i.park@samsung.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Javier Gonzalez <javier.gonz@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_062638_339758_A8CB4D11 
X-CRM114-Status: GOOD (  14.18  )
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

On Fri, Jun 30, 2023 at 6:21=E2=80=AFPM Pankaj Raghav <p.raghav@samsung.com=
> wrote:
>
> On 2023-06-30 17:18, Clemens Springsguth wrote:
> > Hi Pankaj,
> >
> > i would be very very grateful if you would create and submit the quirk
> > as a proper patch.
> >
>
> No problem. I will send something soon, but could you test it and
> give me a tested-by tag when I send the patch? I don't have that
> model at my disposal.
>

Hi Pankaj,

I am available for testing with pleasure.

kind regards
Clemens

