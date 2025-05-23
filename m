Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AD0C54ED1
	for <linux-nvme@archiver.kernel.org>; Fri, 23 May 2025 20:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:To:References:Message-Id:
	Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
	Content-Type:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XnlnCZLLUIoyCLkd3CctK2QifmBa8hyTumaKQvXBaqw=; b=uyhCs2tYGjXOHVlJf4NeNMGYTa
	xEbrQNV4Vk9rhihbPEMdPjp6mwb2r0CUursejz/aEYdred4+ve+Ply0M4vO8wQ8K7fkxFm+m4ESNa
	hp7AbiKVBaJB9874nU+JyJipY67o56rPV0rnlPLpFHmvdlYsmywE/ozAzPSQDjmHJWSZznO7t1fvx
	3HIKXIH/3bP8obOwNeUaBQHFaSTjyL3okP/oox8M4csaf90HpUee83SMEhHwsI1PUcGPlIyJSF45a
	3YFaRqGGW2b4nY0jn1SJO8egNhPJUOcAac9H0KAfmNur6O38NfkryqRtgCN7YWER1+cOp7Jqwy5GS
	hMqHUJTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIZTx-00000004vI3-1LGO;
	Fri, 23 May 2025 20:59:09 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIZTv-00000004vHd-1wyr
	for linux-nvme@lists.infradead.org;
	Fri, 23 May 2025 20:59:08 +0000
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-601aa0cb92eso398932a12.0
        for <linux-nvme@lists.infradead.org>; Fri, 23 May 2025 13:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748033946; x=1748638746; darn=lists.infradead.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnlnCZLLUIoyCLkd3CctK2QifmBa8hyTumaKQvXBaqw=;
        b=ZRxRz7dQ9PGopY7GgZlLjobY6ym14bfjJdjq/w5cz2oAlSBoOGTTe4YGtbrwDmaItZ
         UIxk4zfbtyCxex5+zCvGBNDyIVMoXDhgr4eTOT04bTTRre4vVwJJXxqko/Gj1S3PqLrA
         QSdOwDXjpEuRfxbFz/ixvE60swNFyJXXSbwkRGbK3dWgzfT3kmDB1ViicliseN/155lP
         TbJF64q/kaGq3C/nsjgmK1bieZ3HPsWeZJchXUnSy4+OneEHCASHHBzA1llNiRh7Spfh
         ux5JTcO0ZcLp4wp9mr9pwt2/m+w5bZxIbbbb9/d2j6+xglnD9m1Cje+Vq7QtH0NLcJmh
         B8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748033946; x=1748638746;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnlnCZLLUIoyCLkd3CctK2QifmBa8hyTumaKQvXBaqw=;
        b=WlHHoe0ShKRCP3H86SS1VcSSTVeBo7JkOU12Ou6bLLtqdQhUP464HL9caJpHEMX07N
         Ou1rkpqSEsWLwM+kWuiQGAlO558nKc1MNkqMNFdphKv+1EFdJqvgA+Vp9T2G8ksNyryO
         SNgNEJSEeHKVdXTvMwPUdDwmR5g2KxjJZODVlP8jVeawrBT0HuEh1bhGsjIgdZyX91vA
         YSnkfG1SbJOoAoNcGr6of1p+XkKF8lVpRsmmJtc55treUjUqpVmzETmt+/g9XvhKSnBu
         304E2G3mFcBYecQWapr7ulJof2rGTrM9hnITthZKCi/87oitGxQ59Z7OEBKCf2HW7lHW
         H6AQ==
X-Gm-Message-State: AOJu0YydEfj0eBf7hZz6fSqeTOH2zveEN5mhU3J9TQs4rZrdbdEBCG1l
	dYMU7eq9BoND2OxreRAAE+GhOaFxlRJzx5CZ/Rz00NghRMwvP1x4iow72fS64Q==
X-Gm-Gg: ASbGnctFlZ/bTjfXzqwBMaLnOmuY15ha8gBthCHwEpRtig+f8TZ+JzZEGVc+cdZeqn1
	DmQ2LedVpIlVcmuWzJ/dcE8H63dnyiQd3I8Os8BnQsS+j598RQOEZzzADERVvro2MJuqjuEPleQ
	ULJ3Z1gnXHluvIcZCiYHvcOV2reFKF8FfgZH4vFmR8/G3v9HBmVnLyHW1ac17CRTXoxzKZV0wZx
	B7ZziONx3dtykF+I81LtWD4UmQ1yMcdopPUSzD0ARDg5Jk9XBFsK7WT+aeki2Y2s0RLDIWDQH4B
	2UXI51/ZPkKSStF/0b7PrS7gHFeUEQ6/2ajGQO5K7mhVkrJly6j9xEw9CC04Ak3oI5lSoDFa/Qc
	H2znywS5dH+siSdgtbT0AntZILYA=
X-Google-Smtp-Source: AGHT+IG7pBgXAui7jOGsOBlkyu8AVgt23YRHPO8vMpBBOlerArFNaRIlwvgjDYTwz5zNeu/cqlpLDQ==
X-Received: by 2002:a05:6402:3582:b0:601:f92e:71e with SMTP id 4fb4d7f45d1cf-602da304191mr479008a12.25.1748033945577;
        Fri, 23 May 2025 13:59:05 -0700 (PDT)
Received: from smtpclient.apple (mob-5-90-50-33.net.vodafone.it. [5.90.50.33])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6005ae3aed4sm12371800a12.75.2025.05.23.13.59.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 May 2025 13:59:05 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: APST not working on Intel p1600x
From: Andrea Mencarelli <andrea3000@gmail.com>
In-Reply-To: <aC-iW4puI1V1g_-6@kbusch-mbp>
Date: Fri, 23 May 2025 22:58:53 +0200
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DF7A219B-C53E-437A-AC24-0E1687726813@gmail.com>
References: <0DCCBCB0-EBDE-402C-94BF-50A3CA6D58B7@gmail.com>
 <aC-gEw88-Wk0DT08@kbusch-mbp> <aC-iW4puI1V1g_-6@kbusch-mbp>
To: Keith Busch <kbusch@kernel.org>
X-Mailer: Apple Mail (2.3776.700.51)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250523_135907_502146_4340B513 
X-CRM114-Status: GOOD (  15.25  )
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


> Il giorno 23 mag 2025, alle ore 00:16, Keith Busch <kbusch@kernel.org> =
ha scritto:
>=20
> On Thu, May 22, 2025 at 04:07:15PM -0600, Keith Busch wrote:
>> As to why the driver does this, spec section 8.1.17.2 "Autonomous =
Power
>> State Transitions" has the answer:
>>=20
>> 	The power state to transition to shall be a non-operational
>> 	power state
>>=20
>> I'm not sure why the spec decided on that behavior.
>=20
> Well, it's that you need more info to capture when to autonomously
> transition to a higher power state when you're already in a degraded
> operational one. Does the device switch to a higher power after one
> command, or should it handle it in its lower operational power state?
> There's no spec guidance here, so the requirement makes sense, but I
> think this could have been sorted out.

Thank you for the clarification.=

