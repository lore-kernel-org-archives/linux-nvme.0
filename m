Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A25EBC369DC
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 22:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tyFlZw4rIlDv7mRXlmbnpKYKfaVLPKDpm+FWHBjk6WU=; b=r66k8tNlec9I8oUy2Sh+M5Be8t
	KKsfSr0xb6Dbt242FBbBPU7raWhYVBuJRpdSojAuoK+vW5TWexE4q2M/nfDWsd2j7mUbHM+uApEQ4
	VFOfT5R+sHR/C4lViMJmeDz9jue5/MLXxC69l2IOZpyY8mVgWYEOg7h8I/9XecYru5ZWY3i41T8YP
	OQNULL/h3aIDY1eIRYhV1NrNXYo+/nA6KHlxC4K73YnMfv1njC6Mgnty/Rvdv0uDW7f3a6t7Dti1Q
	3fhi4N9p3BB9cQz389LeQiGZ1nSbRQf9UxNkO9gABl7kt+czoOAjaq8Fxtzc30vlQqEHGjP9PeVkk
	ediz89EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9tUH-0000000Az8w-31uh;
	Tue, 29 Apr 2025 22:31:37 +0000
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9tUE-0000000Az8V-3hLo
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 22:31:36 +0000
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-5259327a937so2561757e0c.0
        for <linux-nvme@lists.infradead.org>; Tue, 29 Apr 2025 15:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745965893; x=1746570693; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyFlZw4rIlDv7mRXlmbnpKYKfaVLPKDpm+FWHBjk6WU=;
        b=HPpq9qCHIucbcdcYVegAEKJMfKfE7jG04ncrNh1jHf5TruRRiMalfRLAPb7y5ld/BV
         EduFvgxonSjinnGzTOtz66n87tgp1cNfQF60hAXr0Xew9tcfAPLhe5jZzeFamifX2hQ3
         xwRbnDWSvIbNjCBEa7gC2HrH1AsCjv7yS3DbNh5qVxZ6H/UoHnnLeqhAsywRqdyfySzD
         hK4szdFu3Ni9XAWMlbLk8ndLjIvuuArCOaXG1aF12472d1WpALBMM91OGbIIeCBhJRpo
         ESyopaky+9QPIbzqOHRGJWCWKNfWabTTq55uV1uUPr4s9pwze6P2AA4F7/5mAFni4IZM
         5zqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745965893; x=1746570693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyFlZw4rIlDv7mRXlmbnpKYKfaVLPKDpm+FWHBjk6WU=;
        b=HIMRikcFbi7CeMl5OgK3lf8Ter3iMfbpuI+sLpqsutor0N0EK2HPgtKhmqmO3wOCxZ
         gzvsoamU3ZpkKor2u7OhhGqzHAbX5Bz9FuUIVCp+QfxvBHkSTazFpWpjH2NKCpmz+4Fh
         +W5Mv4PwZWcHq8S1AUVjOkfgRcV/m85l1Qq3ICyBNHl+STxldyWPGsi4IELWb7Q4ig0F
         KWe+6zpwsK6QxZDfxX/rP7mPc+Fgb+mcsZT3fJJzB0tjS1w63Ol73NKZwixuF6WnYRVg
         sXkoAmUfbsBZvvoCzbUgpKpgAWucPIVKX5Im8JPqiwKS70kyl6zqSAJuAEvYkD3CAbe0
         NMtg==
X-Forwarded-Encrypted: i=1; AJvYcCX3aC2evi3oInmEgKwOGXZVxIM6AZtw0dbUJMniye3ds5+D7qko7ZJiCaIPa9fYIWwF+GMQlL9pHYxa@lists.infradead.org
X-Gm-Message-State: AOJu0YxHXNYJqsjtNvswhBuZc13VMiVqPodRlycVsBiK27Pr9Xy+igPG
	tsR0IM1pd4sMIxVmEuGzOfSU66fAOj3PBjc3pGdg/vMDXgB6hapwaplH4j8+hznwe63wnz+ocWQ
	+wPciVBd/uvVgYRWAMCUTZDr77/bQaw==
X-Gm-Gg: ASbGnct8zzEuZE5d8MVprPqN8dmNxDTc2WcAnQ5EHTwcgDTS1aYpyqPkuGhsinb1yK0
	YhzVwuCUiPWgMRLu5XjioQBDxmYZkqwxsL2i8qndCuOpcS0pKV1t2MFW4Poj7sRVgkWINutpV/0
	zu4Ru+wvb7y59+3XouRMuKprEc4NudiULeIv7dLcdk9YTanaUHD7FP
X-Google-Smtp-Source: AGHT+IFx3yw7sAM5yQ6zBnBuCz5GQkXv2WgJTbTYabw5FKr4VXKLZ+lyu7etEqs76IL+yQUoJnThSbvkwf7+0Bkt1No=
X-Received: by 2002:a05:6122:2a0e:b0:529:f50:7904 with SMTP id
 71dfb90a1353d-52acd8907edmr985080e0c.9.1745965893555; Tue, 29 Apr 2025
 15:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250424101333.2908504-1-alistair.francis@wdc.com>
 <f3282cae-ce46-4aa3-8f55-dcc73da93d0e@nvidia.com> <0d46ca2b-3cb2-48c0-8e6d-989e1e5f9325@suse.de>
In-Reply-To: <0d46ca2b-3cb2-48c0-8e6d-989e1e5f9325@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 30 Apr 2025 08:31:07 +1000
X-Gm-Features: ATxdqUHvxR3ZYqDI1PTg7F-zxT-6O74-9yaFVlMQJOiNRwTCZtKm7eYERz377_8
Message-ID: <CAKmqyKMixf=KR6tSZXW=ZxDxHfOOf7Nd00a=T3HKu6sr7-iH8g@mail.gmail.com>
Subject: Re: [PATCH] nvme-tcp: select tls config when tcp tls is enabled
To: Hannes Reinecke <hare@suse.de>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>, "hch@lst.de" <hch@lst.de>, 
	"sagi@grimberg.me" <sagi@grimberg.me>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_153134_923428_AA41710E 
X-CRM114-Status: GOOD (  21.93  )
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

On Wed, Apr 30, 2025 at 3:35=E2=80=AFAM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 4/29/25 18:28, Chaitanya Kulkarni wrote:
> > On 4/24/25 03:13, Alistair Francis wrote:
> >> Ensure that TLS support is enabled in the kernel when
> >> NVME_TARGET_TCP_TLS is enabled. This allows TLS secure channels to be
> >> used out of the box.
> >>
> >> Signed-off-by: Alistair Francis<alistair.francis@wdc.com>
> >
> > Looks good.
> >
> > Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> >
> > -ck
> >
> Alistair, I think the same fix should be applied to the host side, too;
> check the last patch of my patch series to convert the authentication
> code to use the kernel keyring [1].

Yeah, you are right. The host also needs to be fixed.

>
> Should I send out that one as a stand-alone patch to get this issue
> resolved?

I think your patch would need some changes to remove the
`NVME_KEYRING` part if you split it out. So I just sent a v2 of this
patch with a fixes tag and the reviews added. This patch already has
some reviews so hopefully it's close to being merged :)

I will send a seperate host fix as well, but I'm also happy with your
stand-alone patch being applied instead. As long as the issue is
fixed!


Alistair

>
> [1]
> https://lore.kernel.org/linux-nvme/20250425094927.102656-13-hare@kernel.o=
rg/T/#u
>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

