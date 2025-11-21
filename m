Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE00CFC271
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Nov 2025 13:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qQG4w/4j8cgCrLBTRPU2/d9Bsk4842ntkRe0AXOKvEg=; b=UH+VTr5s90vIMAfcpcgJCgqOva
	GJTSnHGEn95TkxLeEAfV0YsxTzCJ8Z+ptN0Z5dKrG9qcrxGu4co39OB5h6IvgYMtxf9KmUTF+QJa4
	KQejz47+mYqlfGrmCnQx4/EHbLe7T6I7f/VNE33+uCJ5Uz1LPa7Ry6y46hO7kjcMVs18xDV8Bfzy8
	2yFGVNqVX2WuyobCKDDPoWIPy5SGBEeyaaMUxJU+F5gSWtmRlkSZSVkVRfAp7uZEUctFPZhvAO3hT
	Cx5HoqxulXNbSuB5AfI/nYULSVhDTp0s8ys3mpDp7Q1gKntRULvxDEEk/O1TMxymg9c4oBRBRatst
	vvDwgwPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMQql-00000008OTo-2B47;
	Fri, 21 Nov 2025 13:06:55 +0000
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMQqi-00000008OTL-2S40
	for linux-nvme@lists.infradead.org;
	Fri, 21 Nov 2025 13:06:53 +0000
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-640a503fbe8so3397255a12.1
        for <linux-nvme@lists.infradead.org>; Fri, 21 Nov 2025 05:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763730410; x=1764335210; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQG4w/4j8cgCrLBTRPU2/d9Bsk4842ntkRe0AXOKvEg=;
        b=ejAP0UNIVsCecl4xkem7KCCvx23FnjtQlGb2NQZxtpjunJp+n1uwiNm/Ty0jJt/AvY
         ux9uH+MuUnrpL4kv0DJ2wK2XeksxwcROhnBj29rkHVLk0f5UH+uVzclZMqsQMB2aHoDL
         2m8PmsbUWhptEITFauLw+dUjCilDNye+ZSZg2HTAPArQU/6oBqrwqYmS150SET/1lvQc
         Vicea6i2q7dqD/99Pt/ism9v6hrK1BvkwHqt27MWW5xZ433wv+2FIUenH7XICtQzS78U
         KRMwcXHvJUH5MSdGiVV0jKjrhffkpokjG3/E8qZsgbp3LH/ri+o6puw25Hj6539ZlbbV
         ja0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763730410; x=1764335210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qQG4w/4j8cgCrLBTRPU2/d9Bsk4842ntkRe0AXOKvEg=;
        b=VNaI3JNcAd1KTBADmlGkAx6JkJByuDWjL6gKr0r7G05LG+MtbjjSqxiqAITGnk483o
         5VSSwj4gKG+HXG+lXtmEZ1RbEeBVHRqiXGFKOqHCWdEkOQUdhDNxMGPZ8qrSY1xK/Xge
         mfkbsMA1nn0sPxNzfOGLbgorYME1TjjjCIhonBrQv1tnWdP04AD4lBhQIIhjb8YS5W4I
         fGmG+a2JpZz5AbnSVIeHKBfZcfVjK9lPfBBsCidPIa2yX7H9fXSo5FQo1yMlIrl3z7wE
         +TfHLSaYIvQ9Tq1KOLLDqIDdX9qMLwuJ33rp+uS2ib6nRbb1F2gezyeGqy7P9mSDz8XD
         Iq9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2uV4frQXW0nm35RbaCbyDrzEaaoFXqn1mdrdRddhEvnzOJXa4Bp7JubIXwjcgH4b0H31ZhCOo7kk/@lists.infradead.org
X-Gm-Message-State: AOJu0Yx9j3QrpRUIJ8d0tddZzNecReoJGqn8EYCeGMPyOF9ZVSeMq4Am
	5aiuoarDVVzEQ2Ob5uKUHJQsF/5v9JiMaZKSKRNxOQVdC4todW/osdACQRoj37j9Kwb+BCSC0KJ
	+waODtTm8YAi8cO6fiy5Gl1x5HXlO9vCEjg==
X-Gm-Gg: ASbGncvJ0b/WiJFLmdl7ckZXrgKBhOmN2OOluVelGcjwoJ3mTA5QHwniBglBcAhmlL7
	1g5fY1wmDJXAgzE8TsqQ1Acpzq8EzGHnwJ0dPeQK5rG7RVAVLAd84Ty9u5XmfsDxh/oGkbVqimb
	NqzX1q3g3H2xouTBcXP2skWALw8gqGjhiClDAxEpf2VC3hZZNMNa+krx927Hee7EgdcmEtt93K1
	ENqdipJ4rZFRbaQJ3c7ZN3QfXBkp+YB3seQO2DXJS1vZ3HT1NWJ5yGesYWA5OpVO5fUgliDA4d+
	SEZpj4/c1l0vy5QzQBd7znnbawnRqCnxRS9oQG948z71bQHfi7W9GZM764jOVCDWoHZEkS34p9s
	Q6eZyCQWWk9BGcvnnCfGn1gI=
X-Google-Smtp-Source: AGHT+IEv1fnmCBYJ0lqxFncXGcTVYaGmR8vxxcXXSz3bTlZAYbpBZUU6MZvkz4NpbOibHzfMa47OC3ytxLmZImIarKA=
X-Received: by 2002:a05:6402:34c7:b0:640:edb3:90b5 with SMTP id
 4fb4d7f45d1cf-645543493b7mr2079518a12.7.1763730410186; Fri, 21 Nov 2025
 05:06:50 -0800 (PST)
MIME-Version: 1.0
References: <CACbz5yFi8hiPD0Avg=KVTpdEeJC=3MMSkGtYOBQ=OmB_O0khyQ@mail.gmail.com>
 <aRzb6U1se40SrQRM@kbusch-mbp> <CACbz5yE1RNmJkg-RSBe2u60Y5yd1zxkEZ=pVy_gTa2JLh9d5xQ@mail.gmail.com>
 <aR-CUUzWzQKIAfqx@kbusch-mbp>
In-Reply-To: <aR-CUUzWzQKIAfqx@kbusch-mbp>
From: Thomas ten Cate <ttencate@gmail.com>
Date: Fri, 21 Nov 2025 14:06:23 +0100
X-Gm-Features: AWmQ_bl8X6mhJEpIQfsjfeU1r17Y4IhSzZuCVaC6xwMtMnbkfDAQD7RXNpSJDCg
Message-ID: <CACbz5yE52zBkN_mhMhY_bA62z0Fajt3K+K65Fyf8bWBd13yC-Q@mail.gmail.com>
Subject: Re: "controller is down; will reset" on SK Hynix NVMe drive in Lenovo
 IdeaPad Pro 5
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251121_050652_650008_C6E724E7 
X-CRM114-Status: GOOD (  11.29  )
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

On Thu, Nov 20, 2025 at 10:04=E2=80=AFPM Keith Busch <kbusch@kernel.org> wr=
ote:
>
> I assume vendor 0x1c5c for SK Hynix,

Correct.

> but we also need the device id to
> make a quirk. You can get that info from sysfs, for example if your
> device is enumerated as "nvme0":
>
>   # cat /sys/class/nvme/nvme0/device/device

0x1d59

> There's two quirks we can try: NVME_QUIRK_NO_DEEPEST_PS first, then
> NVME_QUIRK_NO_APST if the first one wasn't successful.

I tried adding the following to linux/drivers/nvme/host/core.c, in the
core_quirks[] array. It takes a model name, not a device id, which I
took from /sys/class/nvme/nvme0/model.

{
  .vid =3D 0x1c5c,
  .mn =3D "SKHynix_HFS001TEJ4X112N",
  .quirks =3D NVME_QUIRK_NO_APST,
}

With NVME_QUIRK_NO_DEEPEST_PS, it still hung almost immediately. With
NVME_QUIRK_NO_APST, it appears to be stable.

Would you like me to send a patch?

