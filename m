Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB35C25B67
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Oct 2023 14:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mdJyWHkR+YOUTBjltFWZKQC5z087EIsa7mjZmUcpTIM=; b=YSsJbPVkcI8gctTbaq/GElbOkd
	gbyKZ/KLWxSo8W5tvpQcql5Rrg9ON+ykOTLk1xowrYgUxdOwNi3yrFHez9lbwKlr12wAzoCx0G8WA
	MhTSv9S22YWkti/suO6N/klAUHAnVhPCUpEEJWkR85k90fKhsOMnxeOXSa4N8oyT0g6Mj1wU88Fk4
	0qzQovj84t628hdY2+SjKOutjck1Bu4Ln+sLVOYtoMb/jTJzdYqmgTH46+XCE3RzT5auPKhsXcEws
	nlBRrURqRMt2uF3dqYATU2WxLCUYRqkmgcEiAR6v/7aM5DwDoRThatqWtQ0sexcfYg/0HRIjns1Oz
	8/lJ4p3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qw1Qt-00Ehcd-1f;
	Thu, 26 Oct 2023 14:33:59 +0000
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qw1Qr-00Ehbi-1O
	for linux-nvme@lists.infradead.org;
	Thu, 26 Oct 2023 14:33:58 +0000
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31f71b25a99so633922f8f.2
        for <linux-nvme@lists.infradead.org>; Thu, 26 Oct 2023 07:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698330835; x=1698935635; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdJyWHkR+YOUTBjltFWZKQC5z087EIsa7mjZmUcpTIM=;
        b=htCgLePUQgG/mAgYeWn4CoH9PZIYaqfEZJ8qsAPYOcvj6UDZa3yrfwf0BGwUSYbzeS
         573e9u57bIZ7/dWqvOJW3U/DDGkd1zIwqXMdR2Tlq+UU5Tf8MvqV0/vhiG7chrCxv/Gt
         dqEGzZlvUTzIve93ncXBpxqPOj9NHwjJ/2fFOSRAvLjEi8Bs7yLWNYFclDmboUUcEsrk
         +xPgn7PBXZeTlLAnfdPHF1ROrx4bJxupANbxwj+Ro6StwxAZxRiX1OQiBLSLbhgrKXki
         s9YvGIXELTMPp4YvkcyUrGOL2wlGmIxn95JCr8wzuguN5Nlx8Mo81NrzqXb9sbw1mJf/
         KeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698330835; x=1698935635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdJyWHkR+YOUTBjltFWZKQC5z087EIsa7mjZmUcpTIM=;
        b=D9xny/wtB815SKbiKuTPPm8bvwlVk03slAp+xQKY1nu/H+K0RKrA6PVsNGliEgT9/k
         CYZKzYfY7FbisCGPYRN3KD7JX7P2k+1JYJRHWgLBjfk06r3YSJYiJ+g/0fD++ZcPps6O
         agRbnOyhCwcRTHB+DqlAaRbOha5JdX50zxPFXlh4hmgPkGfSe3mnunBAtAzBczJp46T0
         zk1b6wQqzdIo3OElsuKZJGF843XormrZGfgQEd6vFnJ/oSrMrWRfmuEq3He7h6pJ4O0L
         FbgE8q1NOZ+BVSPdQumBJtQz9Q3x+JRWkfY4Zh38jwUDcby/gVVCNLJOF+67/C5rOChu
         7Eow==
X-Gm-Message-State: AOJu0YxIepqNOM5d7/aTLHnJcapER3ebimpn4lvnUQYV48mNO2hdQ85s
	lqqavtsv2u07TsGUHts/g7sxpu+/vWQMz0xnPt4=
X-Google-Smtp-Source: AGHT+IFE8MZGeVASEplQBzpAVayuF8bdX3w4Zb4uluFPxLUIJ37qxiDiq5EIA3ylFQSbI2qlpnJtIE2dP/zbDp+gRtk=
X-Received: by 2002:a5d:4483:0:b0:319:8a66:f695 with SMTP id
 j3-20020a5d4483000000b003198a66f695mr14810308wrq.55.1698330835333; Thu, 26
 Oct 2023 07:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20231013052157epcas5p3dc0698c56f9846191d315fa8d33ccb5c@epcas5p3.samsung.com>
 <20231013051458.39987-1-joshi.k@samsung.com> <20231013052612.GA6423@lst.de>
 <8c755915-2366-28ff-ffd4-be17d797557c@samsung.com> <ZSlL-6Oa5J9duahR@kbusch-mbp>
 <3438f3b8-f7d4-f0bd-44ef-7efb09ed6151@samsung.com> <20231013154708.GA17455@lst.de>
 <CA+1E3rKaUW0YN+bphe9n26ZRTX1rq6M0z7Hpc=zLOJE1AER9hw@mail.gmail.com> <20231016054647.GA26170@lst.de>
In-Reply-To: <20231016054647.GA26170@lst.de>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 26 Oct 2023 20:03:30 +0530
Message-ID: <CA+1E3rKcN=bOw3613XWKm_NqPS=dGOz43g4zwwQG_pRQSWkH_w@mail.gmail.com>
Subject: Re: [PATCH v4] nvme: fix corruption for passthrough meta/data
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>, axboe@kernel.dk, 
	sagi@grimberg.me, linux-nvme@lists.infradead.org, vincentfu@gmail.com, 
	ankit.kumar@samsung.com, stable@vger.kernel.org, 
	Vincent Fu <vincent.fu@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231026_073357_468742_6ADEBAD2 
X-CRM114-Status: GOOD (  13.92  )
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

On Mon, Oct 16, 2023 at 11:16=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
>
> On Mon, Oct 16, 2023 at 12:49:45AM +0530, Kanchan Joshi wrote:
> > OTOH, this patch implemented a software-only way out. There are some
> > checks, but someone (either SW or HW) has to do those to keep things
> > right.
>
> It only verifies it to the read/write family of commands by
> interpreting these commands.  It still leaves a wide hole for any
> other command.

Can you please explain for what command do you see the hole? I am
trying to see if it is really impossible to fix this hole for good.

We only need to check for specific io commands of the NVM/ZNS command
set that can do extra DMA.
Along the same lines, disallowing KV does not seem necessary either.
For admin commands, we allow only very few, and for those this hole
does not exist.

