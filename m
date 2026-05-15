Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99452CD4F3C
	for <linux-nvme@archiver.kernel.org>; Fri, 15 May 2026 05:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+RhitBC2IwUsJ94abAqhCkoZ+7x/2b29ADVIbRczElo=; b=uca9YJJg8e2NKtMjlBtl8ptkF4
	u9iYWi90RfkcSke1rEDxDeuyrRZO6ALgf4qNQj7dTSfathFXia1Vdw17jUfhGoodsLQMPedOhUUaW
	O/cmv8URRJjE+chsGSIGLQmbHvxlCTtvYwsd1ADtxY9XHZTJvf78sHwlnNikLUk4NhtWj0hJhy9Fw
	jWXbAtUjyAQgGCQM/VkizLVMa0WRJDflBoDRAPmIb128FXzf6jJ7EDWh+Pg0QGn5z24Dz9G5zeJ3I
	2ZbffFxSPK852LyYqerranb0Ku+sxBAe24tU62RJ/1CkuAtVbffOT/cW3bSwoWkJjkujbJZrjl+fu
	36P3cHJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNkfT-00000007MOQ-1Ty0;
	Fri, 15 May 2026 05:00:59 +0000
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wNkfQ-00000007MNo-2DPU
	for linux-nvme@lists.infradead.org;
	Fri, 15 May 2026 05:00:57 +0000
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-bd0fc4c336eso932468166b.3
        for <linux-nvme@lists.infradead.org>; Thu, 14 May 2026 22:00:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778821254; cv=none;
        d=google.com; s=arc-20240605;
        b=jmtwDmMGQz9AblBuCiIVNSAjkUsI3MAEJyNQRII4s6slJRSvamYVGe86bgmxT43F6F
         X8qWfE7PEyhIu4ZFGn/Tr+rra+stKTlt1jxAbcBsREcSlqmSFmqZoVcXUfLgbLW0QSev
         ydq64F0w3I2fLtb+wN0Pyw0KDbmyveiOU8x476OXMqbb6qbFXwdonKrnvrxGm2ZfamSy
         fO4jNM55s0ZzFK51Zub9zbncwGB5YZiZd/TSqIAldOkxdfGDPTZd5FijLvD6t4bLhGsN
         4nCfuZ8BucLo3aR1YCAd6loetZ6k8NmZI/g0i9MMxiQ6V3HokaM/dtSUV8ap7Acm6r3U
         YApg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+RhitBC2IwUsJ94abAqhCkoZ+7x/2b29ADVIbRczElo=;
        fh=ZES6/Eau9ue20L8KFddA82t1ajW5AEBagMgi69sMtGk=;
        b=MvJsS5QeZeIU8Fs5xhL0olAb1InKC1fIZS47oO8w49mbfjpf0OKklT7ama2FpwFqAb
         oQh5edh394Wqc1h4+sCmpZbEqhLepe85R4s0/soD5eFy8dD3lVnwanGEI2d45sUGZeR8
         9kqrAuMzwhUPn5OT31pIWO5dsO3+T8ad5x/4QqonsuuAbrdyt+I80JJXh/IjnL6cmxy6
         cpf2ank7BuEMz75y8drINrLWsBp/dtZnHRXEBb9ESl6BnYOH8e3gC08GDYWoPdNQvJRl
         yiVfZnbfjz5/ULd6ZlM8Qs3CEX7koNZ3EQn0TtgFtS3CHkCuZ1+hwz5arwaz3rM824ox
         iQSA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778821254; x=1779426054; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RhitBC2IwUsJ94abAqhCkoZ+7x/2b29ADVIbRczElo=;
        b=V0mCFkYHVJLod7Zd/ULAuvBKie5hnTpOs3cx7idaIapf9myrMRaSzYTtS3m9nTSR/N
         2OTJx3LSHnMXIpswczAYs4rhQypZdfqg48SPafJMdv/6JzCdzFOaXPOjzCiLSdc87ZZI
         1v/JTZlkwcZY2KJLlva1NW15MjaRabJLOuZVEeQKQucWPxrmwqnQi27i/BSizKzhzT32
         mMqvRUJytVB6docMsi99iIYX3uD0HOam8ua5s2i53+4dkKPD1SURjaRer7u15Ji9gQt8
         6ghfs3Vxel93+WDcYss/HjR2yzUokG1Tvi77gnJ38W/TyVRCFL430+c+9ezawQy6B98W
         uvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778821254; x=1779426054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+RhitBC2IwUsJ94abAqhCkoZ+7x/2b29ADVIbRczElo=;
        b=FPE+IsPFZrvLah2GsmgUwuhy/peKofl9rXPska2FE+YgNoMVeg7xy+ivvjAN+tyhkI
         8bEf5gt4I3xupGNa0yJ47amRyDSmxrHue+mLVgnIuqOGlyKj2gfKgBB0d1u/P92lZTdm
         966FDpCtpjWmsonhdGF+gqdhCHLfvOiH1pp1u8D8fG+I0woFkOCiAFLQweKV0H1FV8q0
         6Wl5wlLSs8S8RFBnlh0tFWMcO8/baYnwcA8MxHE7r0/icWdBNcv1pr4bVAduCr9pzv+L
         wc4TeXE+9Dz5rXJTBS3yP9MjxhLG9rWpNY+qA61wmHcuVV1fw9Pt1qBdRG2khgmVlq7w
         u9dQ==
X-Forwarded-Encrypted: i=1; AFNElJ9aDekwD/xjzUodAbl/OC7Y575TLS/2fLmdbRuGfTMoxmzp/6d4Aw3IRME8cYgcey3nJ2LBDCZHgDlB@lists.infradead.org
X-Gm-Message-State: AOJu0Yx07Y9jYlf+dfy0ipI//jKqQsywaKb0PnmClxTQ2RF7DK6Rhrp+
	tPtomVe7P2Zp9wFoR2n+UNDUavDoIOO3XKn/yxdJy+tKxTyzP23GVY1cy26mOxdL36E+RznKkJm
	QKIrHtG0j8YcXgPo8Bn3Y2UwbFUnIGP1Tk7mSf+0b44mX
X-Gm-Gg: Acq92OFreDQbKsOF6wqVVE8zmVvSpsQLafkonBS/VqB64kALMndcjHhqKq/6ANh1GbB
	rU0a9drzTOiobHQWCvwidpFSDnmI2hwQBsTt+wPPeQVFhLH58FPVWZ0Qm1/6WJOeLIF+9Z5yNc/
	+yhbp/eXnSDBW4wCMWkwIg/pFlpD8hhUp5YT2WkuN/bFZDpxS0On/+dCvHSCFRZzBwLsUDkgryt
	BLKXJvo4R20BkiIVvvyLnqdNzFG9jX3LSoY/nzOQEPqdnXxVek3I5v+XuW25gYBkz/Z6FyZWUN5
	lrqg0pTH
X-Received: by 2002:a17:907:9813:b0:bd3:1a18:cc64 with SMTP id
 a640c23a62f3a-bd5179080d9mr103986666b.31.1778821254019; Thu, 14 May 2026
 22:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260428022911.1288485-1-coshi036@gmail.com> <afBYFfZJjiDDvlLv@kbusch-mbp.client.m3-hotspots.de>
 <DI4LPUI48MRH.3GC5TVZLMICXN@arkamax.eu> <afBgs0f8Et3jqijM@kbusch-mbp.client.m3-hotspots.de>
 <20260508090427.GA20593@lst.de> <af2thHcqZ28pDF2w@kbusch-mbp>
In-Reply-To: <af2thHcqZ28pDF2w@kbusch-mbp>
From: Chao S <coshi036@gmail.com>
Date: Fri, 15 May 2026 01:00:42 -0400
X-Gm-Features: AVHnY4IuxKAWDsF_06UWw6UUaEjO-eCqY-Od7J_MErZI9AJVh0UW_eDgHDE-njU
Message-ID: <CACd_6n27yAJUAR2wTAAHYygksYE4WF2BsM-qtQN60Rn=AeE9qQ@mail.gmail.com>
Subject: Re: [PATCH] nvme: reserve a keep-alive admin tag for all transports
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Maurizio Lombardi <mlombard@arkamax.eu>, linux-nvme@lists.infradead.org, 
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>, 
	Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>, linux-kernel@vger.kernel.org, 
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260514_220056_607828_3ED84F36 
X-CRM114-Status: GOOD (  26.09  )
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

On Fri, May 8, 2026, Keith Busch wrote:
> So the absence of defining a minimum means it's simply optional?  I
> suppose I can see it that way as the intended interpretation, but
> seems counter productive to do on PCIe when you can MMIO the
> controller status register to verify liveness.  If the controller
> responds successfully to the feature, then I have to agree we need
> the host to do its part.

Thanks Keith - I will take that last sentence as the basis for v2.
The v2 commit message will cite the spec reading (NVMe 2.0a 5.27.1.12
plus the transport binding wording) explicitly and conclude that PCIe
MAY support KATO, in which case the host needs the reserved tag.

For data points: I also tested two Micron PCIe SSDs locally and both
report KAS=3D0, so the bug is likely field-rare on mainstream hardware
today.  The patch remains a cheap defensive change for spec-compliant
controllers that declare KAS !=3D 0 or for emulated environments.

Chao

On Fri, May 8, 2026 at 5:31=E2=80=AFAM Keith Busch <kbusch@kernel.org> wrot=
e:
>
> On Fri, May 08, 2026 at 11:04:27AM +0200, Christoph Hellwig wrote:
> > On Tue, Apr 28, 2026 at 08:24:35AM +0100, Keith Busch wrote:
> > > > This field specifies the timeout value for the Keep Alive feature i=
n
> > > > milliseconds.  [...]
> > > > The default value for this field is 0h for NVMe transports that do =
not require use of the Keep Alive
> > > > feature (e.g., NVMe over PCIe). For NVMe transports that require us=
e of the Keep Alive feature
> > > > (e.g., RDMA and TCP), the default value for this field is 1D4C0h "
> > > >
> > > > To me, it sounds like for nvme-pci, keep alive isn't required, but =
could
> > > > be activated.
> > >
> > > The spec says the support is subject to the Transport binding
> > > specification, which does not exist in the PCIe transport spec.
> >
> > My memories from the fabrics working group back in the day is that we
> > explicitly intended to support it in PCIe.  The wording in the spec
> > referring to transport specs I can find is:
> >
> > The NVMe Transport binding specification for the associated NVMe Transp=
ort
> > defines:
> >
> >  o the minimum Keep Alive Timeout value, if any;
> >  o the maximum Keep Alive Timeout value, if any; and
> >  o if the Keep Alive Timer feature is required to be supported and enab=
led.
> >
> > which does not read to me like there is any required language in the
> > transport spec to require keep alive.
>
> So the absence of defining a minimum means it's simply optional? I
> suppose I can see it that way as the intended interpretation, but seems
> counter productive to do on PCIe when you can MMIO the controller status
> register to verify liveness. If the controller responds successfully to
> the feature, then I have to agree we need the host to do its part.

