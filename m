Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC24C0015E
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jul 2023 20:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WVgpZ8lQKOwdGxh2onlmjRJMoFI1HaOmtUktQySa1w4=; b=tSA3FvZ+NjKxR46/2B90vJKt7p
	Eowaa1yPSyw1hy6giheoliUZJi9mAThWmhn5QOZyI57lVxe1ChPypQBIQziYzsP2MrwnCy4dPVgb1
	8J/EIYxuW8DJvQA4FYJH+acxy/y+ByJO0tnHY0ojrIxLEKlYWmNH4WNd7SjdQlQ/YPb/05oEYA86B
	HIxLa0WNRu3tEesJKic75i7NJW2glbbN7lHWT7s3qcmUdRfPQpW4fSoSO5QU+IdZ+LeC0JdNsCMKM
	1H1CVbO6myIeYaIdcBOWztBvx8gyrL5zFtuN33X9lltCBZi6UF/IVWxsbIeOgCJZv2ElDlLPbQWZP
	oHasrdMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qK32a-004JtY-1J;
	Thu, 13 Jul 2023 20:35:56 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qK32X-004Jss-0V
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jul 2023 20:35:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689280547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WVgpZ8lQKOwdGxh2onlmjRJMoFI1HaOmtUktQySa1w4=;
	b=brAghUeEi5zm7m+NPYv9vZQ0dwGQRnDouoQDfN1E1wZMIVXlIukP9Yd0R21SknFIXiKQ8x
	qo+6Eq08ZpXY+06e6x8L1P1YZAmgUhlu4+6hNtsKNCQU4yBVy3HVlfhwWW5Q/2dacI/zp5
	ldab4W6esPZp9rYpMImkaKKmz7E41Bw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-enLu2P8rOP-7hSZd2tV-AA-1; Thu, 13 Jul 2023 16:35:46 -0400
X-MC-Unique: enLu2P8rOP-7hSZd2tV-AA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30e6153f0eeso736149f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 13 Jul 2023 13:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689280544; x=1691872544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVgpZ8lQKOwdGxh2onlmjRJMoFI1HaOmtUktQySa1w4=;
        b=JSzeiCq1NR3YdkkiEKyBt/zdBMZ4r2P8fOC37TbpwI0gRsAnO251x78qtgylQzWqA1
         VyjjvorrPd4blRBLn/cj3RmzkkoKgJj8+CBnydfRPy3Gx/tnPBetht6oT7a52rNBXjM9
         0DnaD6LKG2b9MlLl8dvK3vcGqU2Scuz464vbymlqiQvvSYOcVVMRVfw+6LRIYkqd1nLI
         2rldEEe3AwX3mBwzS7tiud/XUJ2MD0JeSn0QBpApB1WY55mVBuNKWDPSg3V5qijlR22l
         I5PdN8KbHL6WPkmqXwbiaKrKu8Bfsc1ogwmsymHLkLto1CtAQrcLIIavTl/3qqqXXXgJ
         RWuQ==
X-Gm-Message-State: ABy/qLYJ649Hjf9ESYL1mdj2054AdTAl1mtXrx0Zsbbp7BolDzcIZk84
	KJ+CiOd9jnFSRUt6Ncmr46VRXuNDkNR1HvQ9icE4d579f1KUiBO8ZP26Z+JUgIoFhSLIVDDhk27
	YgtuUxvlFLBNbt+hbn6q1SAZQfGgUdVGsj003polrGB8MjTdwmnk=
X-Received: by 2002:adf:e60f:0:b0:314:1ad7:2ea8 with SMTP id p15-20020adfe60f000000b003141ad72ea8mr2264240wrm.54.1689280544728;
        Thu, 13 Jul 2023 13:35:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHOrNFSNqO2ibgNG8U5/2UOpb0BAv2NtxVH0GEXiTL3/xlDsfILHX94fg3ANCKRsk4V/3fsHjacWFA3C9imx4A=
X-Received: by 2002:adf:e60f:0:b0:314:1ad7:2ea8 with SMTP id
 p15-20020adfe60f000000b003141ad72ea8mr2264232wrm.54.1689280544417; Thu, 13
 Jul 2023 13:35:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230620133711.22840-1-dwagner@suse.de> <20230620133711.22840-5-dwagner@suse.de>
 <594f73f2-59b0-bbcb-d7a0-6d89e2446830@gmail.com> <7kcc75btp5bo5oqjnpqlwwo37l2f4atwfemknbmvqagrqicl2i@njn4tai7e4m7>
In-Reply-To: <7kcc75btp5bo5oqjnpqlwwo37l2f4atwfemknbmvqagrqicl2i@njn4tai7e4m7>
From: Ewan Milne <emilne@redhat.com>
Date: Thu, 13 Jul 2023 16:35:33 -0400
Message-ID: <CAGtn9rmDDqXKH2XfqKXww7aOKmNG6vwuPEsy6bXmABaWvHvd7Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] nvme-fc: Make initial connect attempt synchronous
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <jsmart2021@gmail.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Shin'ichiro Kawasaki" <shinichiro@fastmail.com>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230713_133553_283438_DAED6F01 
X-CRM114-Status: GOOD (  30.62  )
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

The basic issue I am trying to solve with NVMe/FC is that we cannot get sys=
tems
to boot reliably from NVMe/FC (boot from SAN) because we don't know how lon=
g
the connect is going to take, and we have seen spurious failures in our tes=
ting.

In general, I think the whole business of a userspace syscall() -> asynchro=
nous
work in the kernel is problematic because the syscall can return a good sta=
tus
even if the connect is never going to work due to a condition that is
not going to
clear.  It is difficult and cumbersome to script around this reliably.

So what I am saying is the current mechanism doesn't work completely
right anyway.

We also encounter the problem Daniel is addressing trying to get
blktests and other
internal tests to work, for similar reasons.

-Ewan

On Thu, Jul 6, 2023 at 8:07=E2=80=AFAM Daniel Wagner <dwagner@suse.de> wrot=
e:
>
> Hi James,
>
> On Sat, Jul 01, 2023 at 05:11:11AM -0700, James Smart wrote:
> > As much as you want to make this change to make transports "similar", I=
 am
> > dead set against it unless you are completing a long qualification of t=
he
> > change on real FC hardware and FC-NVME devices. There is probably 1.5 y=
rs of
> > testing of different race conditions that drove this change. You cannot
> > declare success from a simplistic toy tool such as fcloop for validatio=
n.
> >
> > The original issues exist, probably have even morphed given the time fr=
om
> > the original change, and this will seriously disrupt the transport and =
any
> > downstream releases.  So I have a very strong NACK on this change.
> >
> > Yes - things such as the connect failure results are difficult to retur=
n
> > back to nvme-cli. I have had many gripes about the nvme-cli's behavior =
over
> > the years, especially on negative cases due to race conditions which
> > required retries. It still fails this miserably.  The async reconnect p=
ath
> > solved many of these issues for fc.
> >
> > For the auth failure, how do we deal with things if auth fails over tim=
e as
> > reconnects fail due to a credential changes ?  I would think commonalit=
y of
> > this behavior drives part of the choice.
>
> Alright, what do you think about the idea to introduce a new '--sync' opt=
ion to
> nvme-cli which forwards this info to the kernel that we want to wait for =
the
> initial connect to succeed or fail? Obviously, this needs to handle signa=
ls too.
>
> From what I understood this is also what Ewan would like to have.
>
> Hannes thought it would make sense to use the same initial connect logic =
in
> tcp/rdma, because there could also be transient erros (e.g. spanning tree
> protocol). In short making the tcp/rdma do the same thing as fc?
>
> So let's drop the final patch from this series for the time. Could you gi=
ve some
> feedback on the rest of the patches?
>
> Thanks,
> Daniel
>


