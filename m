Return-Path: <SRS0=1Q2H=NB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECE4C4320A
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Aug 2021 13:38:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C20860F41
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Aug 2021 13:38:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9C20860F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DSaroI3H5qWTSv3tDoDTWOk3lTYX0CmMkJhtflTo6C0=; b=aLPFXwVwHjskL8
	fmc0JtZb963NIR+wP/0UrymBDPKgH/Sa9s4+4f8WbYozGDtGAg7YB1e8iqpszW36c8CkddecsVINN
	9jvmgBPQeGHw01My/TUiqgANbRG/xsJXbWj499c+fY3J6deNyubhf3/YNzp8jOfUlwwi0S0XD6EbG
	zT6VZXFk48oqWsWzM0qNybOKAFf+Jy6tfpcbbXnvapleCXHz2qWWXAqYRTjE/wqXxaSWwSmYcZ3bM
	vdWnpcBYmSgZak5r1cU2MPP24fF9mcJcvVbkQb27rlY69hPUw5W/M9jULhF9QfUdyeXiLQ29KO5sS
	HCmu9v71Nump3w73YqTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mDRwv-0041Bq-6I; Tue, 10 Aug 2021 13:37:45 +0000
Received: from mail-il1-x135.google.com ([2607:f8b0:4864:20::135])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDRws-0041A2-4y
 for linux-nvme@lists.infradead.org; Tue, 10 Aug 2021 13:37:43 +0000
Received: by mail-il1-x135.google.com with SMTP id f8so15389673ilr.4
 for <linux-nvme@lists.infradead.org>; Tue, 10 Aug 2021 06:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=csVOACPDP1qngSSliCngUR28zuz3Rq1l/jFifM6PtPQ=;
 b=EhpG0sOIYIWFhM988LReWhSQhb7bUwOYYlzL8o7Mdvyp8kYIHZQwBRqSi6h6OlsLlR
 GH2vIj15e0Ulp4TesTUrRlStpA5gdFGXMN+GbHT5rRVY3S2Yi5aUIgDC4fLjS8LlGYeK
 3AwGJ+eLgC3SVyA2xUHxoHVIdPUM92/ocAtlc8XVJQLZXhXxsnSwEKAbK1BnQZ7sn7ar
 uNz0OFJKRJ4J30agewhvzs1z4n9QqySI31Yogxdmxu1+eN+NOpHmwIMdZURR3s2xvxto
 ufpXRFJ0jgXAmhvvKmNgglC8xX6YREpuhIZBq6fZHZaHM5pGefixWRhBnsVVmMItU/QK
 mGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=csVOACPDP1qngSSliCngUR28zuz3Rq1l/jFifM6PtPQ=;
 b=jH6D1ljZ3wYXbcQdTKP+NukOnIW7GE6aEcKSJ/E9vuLGsFvXpjWdzXwF2TSK5MC/9E
 LD4pcp+DdkBB0ODX9xgbSfx4/0LnyaWg6l14iROd0CpqSN9SyRUSjv7bxg1+2RWUhx+8
 kiuaBaVQ+9PiWVv9r4//9M5zbyw6UKRjG78IYVemLxy4424pMOvrV2PJIrFqOH6alr4j
 kuIg5RIG+kHQlmpWoA3GydRR123F5ze7mKrTI52PNco/CUaPqejEyx6MUTG4DwFoVcdF
 hKl96t19vRsFnBHV0rSEiSRE9mZ6nfP/oIkpCALdOUyvOjnhv9ewwGDtbBVkjxn2E0RO
 ou9w==
X-Gm-Message-State: AOAM532GkguwlG+bm7jnpM+BLKc5QS0woCmEz3e8wE9JyRmz1CRjslsa
 vPlaQ2A11EL+LJw0pMiT1O0vQFdsd+TJe+5fUUA=
X-Google-Smtp-Source: ABdhPJy7Z7khDppO8U5qMy4HqGlCkNlq4zE7AxkKB0pxCO2cWIaPtpMskTv3U1cGMcHq8nCKRtMZjvSq7wQolcVEE3s=
X-Received: by 2002:a05:6e02:1bcb:: with SMTP id
 x11mr763516ilv.168.1628602661048; 
 Tue, 10 Aug 2021 06:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210722110325.371-1-borisp@nvidia.com>
 <20210723055626.GA32126@lst.de>
 <02c4e0af-0ae9-f4d9-d2ad-65802bdf036a@grimberg.me>
 <CAJ3xEMjzRqrj-EN7gbqKmD5txAV-gZn828V+6QAf5wfwYsqySQ@mail.gmail.com>
 <1d461a0d-cda5-2086-ec17-c5bb3a80846f@grimberg.me>
In-Reply-To: <1d461a0d-cda5-2086-ec17-c5bb3a80846f@grimberg.me>
From: Or Gerlitz <gerlitz.or@gmail.com>
Date: Tue, 10 Aug 2021 16:37:29 +0300
Message-ID: <CAJ3xEMj=nLp4-GUSMYH0tgK69bfhuUYDjtE8fHFy=n2x2-cL_Q@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 00/36] nvme-tcp receive and tarnsmit offloads
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Boris Pismenny <borisp@nvidia.com>,
 David Ahern <dsahern@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>, 
 Saeed Mahameed <saeedm@nvidia.com>, axboe@fb.com,
 Keith Busch <kbusch@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Eric Dumazet <edumazet@google.com>, 
 Shai Malin <smalin@marvell.com>, boris.pismenny@gmail.com, 
 linux-nvme@lists.infradead.org, Linux Netdev List <netdev@vger.kernel.org>, 
 benishay@nvidia.com, Or Gerlitz <ogerlitz@nvidia.com>,
 Yoray Zack <yorayz@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210810_063742_286117_3E08942C 
X-CRM114-Status: GOOD (  26.97  )
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

On Fri, Aug 6, 2021 at 10:46 PM Sagi Grimberg <sagi@grimberg.me> wrote:
> On 8/4/21 6:51 AM, Or Gerlitz wrote:
> > On Fri, Jul 23, 2021 at 10:59 PM Sagi Grimberg <sagi@grimberg.me> wrote:

> >> [.. ] It is difficult to review.
> >> The order should be:
> >> 1. ulp_ddp interface
> >> 2. nvme-tcp changes
> >> 3. mlx5e changes
> >
> > .. and this is exactly how the series is organized, for v6 we will drop the
> > TX offload part and stick to completing the review on the RX offload part.
> >
> >> Also even beyond grouping patches together I have 2 requests:
> >> 1. Please consolidate ddp routines under a single ifdef (also minimize
> >> the ifdef in call-sites).
> >
> > ok, will make an effort to be better in that respect
> >
> >> 2. When consolidating functions, try to do this as prep patches
> >> documenting in the change log that it is preparing to add ddp. Its
> >> difficult digesting both at times.
> >
> > to clarify, you would like patch #5 "nvme-tcp: Add DDP offload control path"
> > to only add the call sites and if-not-deffed implementation for the added knobs:
> >
> > nvme_tcp_offload_socket
> > nvme_tcp_unoffload_socket
> > nvme_tcp_offload_limits
> > nvme_tcp_resync_response
> >
> > and a 2nd patch to add the if-yes-deffed implementation?
> >
> > This makes sense, however IMHO repeating this prep exercise for
> > the data-path patch (#6 "nvme-tcp: Add DDP data-path") doesn't
> > seem to provide notable value  b/c you will only see two call sites
> > for the two added empty knobs:
> >
> > nvme_tcp_setup_ddp
> > nvme_tcp_teardown_ddp
> >
> > but whatever you prefer, so.. let us know

> I was more referring to routines that now grew the ddp path
> and changed in the same time like:

> nvme_tcp_complete_request

not sure to follow on this one.. It's added on patch #6 "nvme-tcp: Add
DDP data-path"
and then used twice in the same patch replacing calls to nvme_try_complete_req
and then to nvme_complete_rq -- so how want this  be broken to prep/usage?

> nvme_tcp_consume_skb

this routine was born due to the ddp_ prefix addition to the iov copy
iter functions, which we are now removing due to feedback from Al

> etc..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
