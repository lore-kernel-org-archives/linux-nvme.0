Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F306CD343F
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 04:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5eO3OesmgPbcWhdQEWPXDOJHLqt5oUyy40z6rI4uuCM=; b=xMYMz2k33kWzNxmbLiD8RSSH7/
	y4G4A/GE60u8QjReBEQ51cCrbR42RCL6KLEk/oBK30/RDHz0aT92yIAbb77GqqGeL4BWnP/h77Ds7
	a+3v3p02RLIU/boPlnxTHh/vzorcA0RoXbeCJW+apRS8Xey/HCLnRlEUucugkPalqkU3jlyKf2gWY
	KFC7j8V4K7JHR1Ro5wwSa8TIKcBPgeQ5I81dOSQ3bkcMcUVzQ8z2mvMADsHVCOLgfFrJoRyOn5P5K
	bdlktmS+sXUcxXjEuDhk6dwXoPeqnR6tXJHAXSEkvdSuLph7CQ87zZ+sSKSF3fF8ulbfzEzkn4ndj
	cIbrM9qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNkaY-00000007LvF-3KNT;
	Fri, 15 May 2026 04:55:54 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNkaW-00000007LuR-1DvV
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 04:55:53 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-67bc8609a9bso15797242a12.0
        for <linux-nvme@lists.infradead.org>; Thu, 14 May 2026 21:55:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778820950; cv=none;
        d=google.com; s=arc-20240605;
        b=JTUemjjCTd21rWVORt+HpjJyJcH9Md8hvSao84Om73ZrEWYQd2koGBCxRAZ6NBnapy
         GruCtggvqTrWqRGPV4W4V00d0iWdAtoExcQjPsqOenSMFKVzwJUVGOSQ6K7YV86MyYkr
         4BUWAVEJw/Yqlpv+gYHAdtNTaK7dA8HjDT7nQqdYXlHGTGQ3U58i0HHm7tgvH+JS7LvO
         WdKkE8ohWEfOVZaP/IQdcEYyF3w59VJhXdJ7R+da67ZIAzsSTIV5OOBk1eQBAYwSwNob
         B5C5pSS2GdQnvrm5SOFhGBmjiZRQx7C2Xhqq5si1ZCpQnq1jN+8CGfpNvZ8uyemLd4Kg
         8UmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5eO3OesmgPbcWhdQEWPXDOJHLqt5oUyy40z6rI4uuCM=;
        fh=39H4EssYoXrkV4pVdxBIOGN1LsK/zHKLk1Wn5Rf71xA=;
        b=WyjHXGVOzzuvGI3Yi5t843lFy0wwM/Zs1fgjt9P7UPWzcZYyzeij4MBNW2aF70LEw1
         OcQ/ZSXP9uyotSXfSYBENAowEiMvJYqtMYOqSAWFlm6E6HDFc2ARqQXAmPleVQcp1l3W
         HvMYKd13TwRc5NPr6BHwNICzQj/F6F6nGRCRjgrQIyjTI8wvBakg4Ou87s442EPSBM0/
         bkLO4wft9FWcXHKjY0WJBsuHBzyzYJvvDrV27O6Xi1LeJ3yGE+HC4PkWTaL6q54gnpdr
         G993uj5/lxPd+8iuFpgH/+ZfX/Thw31ghkoLcRI/s/uPaNZuHBGz3oCYAxdWtvSozMqJ
         JrFQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778820950; x=1779425750; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eO3OesmgPbcWhdQEWPXDOJHLqt5oUyy40z6rI4uuCM=;
        b=D8aog9SyaGTml9fL/a+PObyI6r32BkRMD9tO1K5naO06MngfWKxOXzvUS6SoRzycZs
         EyKQds7KO8x4tGl4M9ZGLNlnbIYIvTY5htKwMtmz+9g77MWn8/SN6GNh6u8aoWpvb2+E
         DfCHZ9X8Cgn18k4D14QW2joNCw8Keda1ZbvI+0O5doAuYwHJNOuivK9/KBDUze0iSX9c
         SwuQ8S+uRfVP1JwOzhbVwWf735KbAWZUyjAP3yr0basAxWozOC+q6WUvH8eHhK8QgRwP
         Z+1MBSNrqwtS1d/TbeTMEaNpNJDTW1J9y12OZDEfFOuq2+PxiVteJXrx7D6FcZDS5OqX
         ewYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778820950; x=1779425750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5eO3OesmgPbcWhdQEWPXDOJHLqt5oUyy40z6rI4uuCM=;
        b=m3fz4MG5PgMzS8VZRWWhPTgJcvrK9ObAEgG4EgcyV52P7SeKFRW4ckzml24imNzRAI
         GxVIiDpcMQ7c9dgRvTakkL3gYWPpJO3g17k4Giz3DmSZUQC+vOLxv/U2tsTujcjDzSSH
         LeJPlbHYYYcjuahHXKPwtXxPeceRgGXNdvD9Pgld78WwiyaE2hXo2dsOo7IHiIoE3Iao
         /T9QByivEZKGhIZ9f3bVcaRalZhw0JxXhYqeT2tMFVDcg6bXp6c6lSUHGjxRwDiPlk//
         4aTdBFRgpVNSWaF5hjhVCGSQIduWPg1PaV4TyoATrtxKb9hp3CgxEFuaKQ1R3IOGm385
         XgOQ==
X-Forwarded-Encrypted: i=1; AFNElJ/gZOG2413IsIPbJbyEFbSfr0zOIRYwmAs9Jb6sJGMcM4OxOwyWrHYU26pxoBvbsc7iBAGKpGFziVAu@lists.infradead.org
X-Gm-Message-State: AOJu0Yy1xnuyI5u9vRQRr0LZZBVHb/GlPBVhxrsH75bVAaXCSKqnvl+N
	t2RbPtEUJNkgyWta7I9TkAzMCNpGEFFfdNUtXp2TxjavtD3HgH5RfNPqELXiePq6nXbTOt7pveo
	TAZy70tiqet54jaYaDKr2ubGfwlYSgtw=
X-Gm-Gg: Acq92OHrvzDOUEL207wji+h+wpGPzI8vGpyFIxAx9iNLBqqAx9L3HMOC6VrHFF4XCIr
	06Is9lg509uJwfO8saqYzG09FvsOoObOtgYMeFKgZCkPVeRVz9faSFYX5o89VbNqi74MfWH2mOY
	0D//8z+eJph0Sb96na87abrgcbiyU2yupqyg+gTcvjGP3pr3vQWWtQyXZULooiVBJJgKxhXFoEI
	McvpLWTlSBVnSE8/95eEvakBoXRLtHN/MAmk6NQQttcBNbIpxaoZmuzBzeJ1Ej5XJ/e34kS/ad+
	wSlEcawO
X-Received: by 2002:a17:907:3e8a:b0:bd0:20ae:a9a2 with SMTP id
 a640c23a62f3a-bd51780c63dmr113738266b.4.1778820949412; Thu, 14 May 2026
 21:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260428022911.1288485-1-coshi036@gmail.com> <afBYFfZJjiDDvlLv@kbusch-mbp.client.m3-hotspots.de>
 <DI4LPUI48MRH.3GC5TVZLMICXN@arkamax.eu> <afBgs0f8Et3jqijM@kbusch-mbp.client.m3-hotspots.de>
 <20260508090427.GA20593@lst.de> <af2thHcqZ28pDF2w@kbusch-mbp> <ec1d5711-7541-400e-9527-7d1428548e1b@grimberg.me>
In-Reply-To: <ec1d5711-7541-400e-9527-7d1428548e1b@grimberg.me>
From: Chao S <coshi036@gmail.com>
Date: Fri, 15 May 2026 00:55:38 -0400
X-Gm-Features: AVHnY4LCI7Zut4tnFvBZ7m4ghX2H_TFf-zLykUF4iL0SogkUSwyRgRbFd2_YSO4
Message-ID: <CACd_6n2Q+_9nY9DEfWu+E-wA3M7FksZ_yjvwdO7Auy_1D44Awg@mail.gmail.com>
Subject: Re: [PATCH] nvme: reserve a keep-alive admin tag for all transports
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Maurizio Lombardi <mlombard@arkamax.eu>, linux-nvme@lists.infradead.org, 
	Jens Axboe <axboe@kernel.dk>, Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>, 
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>, 
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_215552_359118_B9EA1A0D 
X-CRM114-Status: GOOD (  27.23  )
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

On Fri, May 8, 2026, Sagi Grimberg wrote:
> Perhaps under a quirk? Would be interesting to understand which
> pci devices support this...

Thanks for the comments. I thought
always reserving an admin tag for keep-alive is simpler.

I queried the Identify Controller KAS field on the two PCIe NVMe
drives I have locally (Micron 7450 MTFDKBA960TFR and
MTFDLAL3T8THG-1BP1DFCYY), both report KAS=3D0.  I could not find
publicly documented PCIe NVMe controller that declares KAS !=3D 0
either.
The spec (NVMe 2.0a 5.27.1.12 plus the transport binding wording
quoted upthread by Christoph) allows PCIe to support KATO; the host
should be defensive against that legal case.

The cost is a single admin tag - NVME_AQ_MQ_TAG_DEPTH stays at 30,
the regular pool goes from 30 to 29 on non-fabrics.  Fabrics has been
running with 28 regular tags without issue.

If a real PCIe controller is later found to advertise KAS !=3D 0 and
misbehave with keep-alive, narrowing the activation with a quirk on
top of this change is straightforward.  I would prefer to land the
defensive default first.

I will send v2 shortly with this rationale in
the commit message.

Chao

On Sun, May 10, 2026 at 4:53=E2=80=AFPM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
>
>
> On 08/05/2026 12:31, Keith Busch wrote:
> > On Fri, May 08, 2026 at 11:04:27AM +0200, Christoph Hellwig wrote:
> >> On Tue, Apr 28, 2026 at 08:24:35AM +0100, Keith Busch wrote:
> >>>> This field specifies the timeout value for the Keep Alive feature in
> >>>> milliseconds.  [...]
> >>>> The default value for this field is 0h for NVMe transports that do n=
ot require use of the Keep Alive
> >>>> feature (e.g., NVMe over PCIe). For NVMe transports that require use=
 of the Keep Alive feature
> >>>> (e.g., RDMA and TCP), the default value for this field is 1D4C0h "
> >>>>
> >>>> To me, it sounds like for nvme-pci, keep alive isn't required, but c=
ould
> >>>> be activated.
> >>> The spec says the support is subject to the Transport binding
> >>> specification, which does not exist in the PCIe transport spec.
> >> My memories from the fabrics working group back in the day is that we
> >> explicitly intended to support it in PCIe.  The wording in the spec
> >> referring to transport specs I can find is:
> >>
> >> The NVMe Transport binding specification for the associated NVMe Trans=
port
> >> defines:
> >>
> >>   o the minimum Keep Alive Timeout value, if any;
> >>   o the maximum Keep Alive Timeout value, if any; and
> >>   o if the Keep Alive Timer feature is required to be supported and en=
abled.
> >>
> >> which does not read to me like there is any required language in the
> >> transport spec to require keep alive.
> > So the absence of defining a minimum means it's simply optional? I
> > suppose I can see it that way as the intended interpretation, but seems
> > counter productive to do on PCIe when you can MMIO the controller statu=
s
> > register to verify liveness. If the controller responds successfully to
> > the feature, then I have to agree we need the host to do its part.
>
> Perhaps under a quirk? Would be interesting to understand which
> pci devices support this...

