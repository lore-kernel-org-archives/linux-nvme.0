Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5449EB64DA
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jun 2023 15:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kfOVdHgYJ1E6F9PfNyEObZ4qWmQU8ebGaDanILDhjPU=; b=SGBjT9fGJA7dq7d4Cu/hY5MFCJ
	U0SKTVYYUxBrtIuUvJJNp5P+HFNfpmS/CbvpHcCFOrCCOxM+dmO38Y34Mg1grOVePCGnWSZt406vN
	BmY+EoUeb+cw91O7t5h+xz5D/1Io9lgbq3mN3NZ5fqYQv9LH32w4CLWkF9jQg0yO+F+QiA6yNGQJv
	EtxG4nMKL/ID70n+HOQ1zehwWhlJy23z6VCNytCasukIO9r5Y2ojfZIgRmBQAQgAin1KD43jx4mz/
	2euhrBWwEpMvtPvbSLFRgO30LR4qRuXt09fLFaMu9qoBHn+hMEylgwoUTjxnNchSGzdosac3rzu0J
	+BjOJ4EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qFFtQ-003vxl-0e;
	Fri, 30 Jun 2023 15:18:40 +0000
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qFFtO-003vx3-04
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jun 2023 15:18:39 +0000
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-5634db21a58so1320308eaf.0
        for <linux-nvme@lists.infradead.org>; Fri, 30 Jun 2023 08:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688138317; x=1690730317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kfOVdHgYJ1E6F9PfNyEObZ4qWmQU8ebGaDanILDhjPU=;
        b=P0IuK3hQpNVumn4PqzXdGpFy72R5KBK62N0w2JbvXroB3MbE0Nu4r8yGEAQ/aSLaMu
         pNDgbb5pHwQ/uaoc1NYgK1x5YcpGYhCS2eiZiIW3bCZkIfcrnEmpfzx7PNF9EShG9mgW
         VnRPqUPqOInB1e4tzK2Vrd6IpZuUqw0Z3v8zRPX+nrI4YsinvYMXsKgoDrrJYXnCOhep
         4ts6QRpsifcAmr4U1YJI5g9D4bCEDLasIpZ/iAjT6r5ilMmFglUOeax0iiv1o+oG2+BJ
         LWgK2KwS/bNBGXBLvfOJK1/tzPqDLAT5D7/aZG23DR9GyCh58jaUMlXukVer960D9zUB
         3/Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688138317; x=1690730317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kfOVdHgYJ1E6F9PfNyEObZ4qWmQU8ebGaDanILDhjPU=;
        b=EfZwZyaXM2NmuXWskAi/TwEOjA4lOA2ht/Bkd/chBlgXFPh62Eyz0H6TQIyIPajOnB
         Laj6C2dpQdZEr9JUO+zwJMGf+dq2Qqd2HFTyj/3fKwznBsczUzS9WKE5DpcMX+dUCNdO
         8k/S7zOY4KuI24PnBs1KBPzU0620uupS3Gg+xF0zmlNbXp9LC9TpXrw5xI66WosAWnpu
         i5nkFOemi+Z/ygO8Whlo8CkCbnnn3t3R8GAWG61yFwtx52N7eW2zSyRWkKGS7T+nAZHS
         46Olv5Qe+n79iY3+nJKQ/G/g25YGJuG+AfhFMeFRYEda7feqhHmC70JTke5yDyiI80rb
         5Uvg==
X-Gm-Message-State: AC+VfDwsGUnBlbQ0tOriR+CrM25WVdC8J2ExB0ovzmHpCdCFVA1jdsAQ
	xfcXDNBPjvXVTn1Q7bW5mPEsBb9bTjjTkrBSUQo=
X-Google-Smtp-Source: ACHHUZ6cTe4piYpQSfx2HLnXKCP0BNrb+SjDlKLlHFK7a95mz2TGtuUpknPXkTj31zKplY+magfaLhJ7/hJB+0waUi4=
X-Received: by 2002:a4a:97ab:0:b0:563:5069:2323 with SMTP id
 w40-20020a4a97ab000000b0056350692323mr2345485ooi.5.1688138316821; Fri, 30 Jun
 2023 08:18:36 -0700 (PDT)
MIME-Version: 1.0
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
 <CGME20230627161055eucas1p18d097cbcc2215b292c65a5b3a0f0e6b5@eucas1p1.samsung.com>
 <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com> <9b778d59-c8d5-b037-0eb7-34cee5f273cc@samsung.com>
In-Reply-To: <9b778d59-c8d5-b037-0eb7-34cee5f273cc@samsung.com>
From: Clemens Springsguth <cspringsguth@gmail.com>
Date: Fri, 30 Jun 2023 17:18:00 +0200
Message-ID: <CABfnBFoZ=gh2rkY_oYWzjkGcu8HPQ2FqnrnushH0DZFSi8cwOg@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20230630_081838_062885_0C1A3094 
X-CRM114-Status: GOOD (  19.63  )
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

Hi Pankaj,

i would be very very grateful if you would create and submit the quirk
as a proper patch.

kind regards
Clemens


On Fri, Jun 30, 2023 at 10:40=E2=80=AFAM Pankaj Raghav <p.raghav@samsung.co=
m> wrote:
>
> On 2023-06-27 18:10, Keith Busch wrote:
> > On Mon, Jun 26, 2023 at 08:15:49AM +0700, Bagas Sanjaya wrote:
> >> See Bugzilla for the full thread.
> >>
> >> The reporter had a quirk (see above) that fixed this regression,
> >> nevertheless I'm adding it to regzbot to make sure it doesn't fall
> >> through cracks unnoticed:
> >>
> >> #regzbot introduced: 86c2457a8e8112f https://bugzilla.kernel.org/show_=
bug.cgi?id=3D217593
> >> #regzbot title: NVME_QUIRK_BOGUS_NID is needed for SAMSUNG MZ1WV480HCG=
L-000MV
> >
> > These bug reports really should go to the vendors that created the
> > broken device with non-unique "unique" fields. It's easy enough for me
> > to write the quirk patch, but it's not the ideal solution and may harm
> > devices/firmwares with the same VID:DID that don't have this problem.
> > Not being the vendor, I'm not in a postition to know that, so CC'ing
> > some Samsung folks.
>
> I got a reply from our team internally. There is no plan on releasing
> a new firmware for this model and the related models with the same VID:DI=
D
> pair. We can add a quirk.
>
> @Clemens: Let me know if you want me to send the quirk as a proper patch.

