Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24B0CCFA1A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Nov 2025 23:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=reW2+QwMotnq4rhXvXOoTeWOCmK4BzSaoNoYEKFE2Nw=; b=KiMX8AL2BSwAYYmikjpWRqM7o6
	xIvX0nx2SUqlAumJWN/WzyBaSs80kHLwV4WHnMXA6z0lAdLoBqPbkg2qNYBN0l5F78ct1CmOqs7jZ
	Pn9fecJtjTnn3iSOptx6bFhXU9lGj4TDcrvvYi96LPAa4bQQIQd57t4knTw5qDKakrtq2I1MDl+vT
	7b7vjVDElzCchzLjYGJOSWmnBjoMsctqChnFDHFRE7r0rlh4yR5d9MM8vzNRYWyji9NnzgSM7QATC
	G7+PjNTkt4Uw0W6KNGQbiHCts56k8XMY3zPGzIyYmDyFoOhQBCT2weY0THeEGg2UllYHss0FzySyh
	jFOkaK4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIxqi-00000007smy-03TN;
	Tue, 11 Nov 2025 23:32:32 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIxqf-00000007sm5-3vtD
	for linux-nvme@lists.infradead.org;
	Tue, 11 Nov 2025 23:32:31 +0000
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-b731b176b5eso53284266b.1
        for <linux-nvme@lists.infradead.org>; Tue, 11 Nov 2025 15:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762903948; x=1763508748; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reW2+QwMotnq4rhXvXOoTeWOCmK4BzSaoNoYEKFE2Nw=;
        b=ln4UwASY3OvmN53Dj6kXs7DJLUn6a+oJLQ6RPkoi5L6y78UIncJjzj9j4FszaA1KJf
         q27dnnqYOt1rf+NwytqGoiBYUfcwpRufmrTJp2wZOdojuor6elmjKRzMfOWS4Yyi9fqa
         tgX5+HBUaQpQf/EZFsJyN+y08HWIE+nmSp96Azo0PoIVo5JaYp1hCuyKx7qTRd/hvh7D
         3VX3ydiIf2/LmP+8ifzS7hBfQC6/jwFb8ZNRmBhrbSAMBh1GAzpul5dMGF+pBZ2m3j5F
         b1Cs5TZ9HfTFRc2Cwx9bAukHBVx+n2UYkDYMnwmFZ2gKqozPN8rbJUDsl3/8ANtCN04c
         3d1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762903948; x=1763508748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=reW2+QwMotnq4rhXvXOoTeWOCmK4BzSaoNoYEKFE2Nw=;
        b=sdg3l0ITtuHlVMxrnn/Wcm8siisXXz6Rzet7As/d89PaYVzyF8oyK/vRtudS/vvZjh
         7+GONByWOykqwacPpLsGfZ/fKP2y1uZHuQsCGhCR+LUYoJC8wP0PoFibPrKOg+IK70cv
         Q4ecxS7Hjzb43SjywSz2xBH0OqbwbbRJ2llEz1kzcI88BK8Bl0mQbSOj6fHoP/9ObPdl
         tHhTaiYfPwcnXIGD/LTziOpOi8b9lHpx3i5YdXmAKuvd/wezTqQyxlFPlNNXEv1LBPiS
         P45Hn9QYnTDmqzEAdvAD3I6/d6HSydz6DjWwYhVakxk8mfxTHDJQHh1Esk8TMst7vOdF
         2l7g==
X-Forwarded-Encrypted: i=1; AJvYcCVSI3UHbXsPiPJ0bLFZxQD5xdY7v8Gq0NY+Hg1WJt4HEhBawyhDxiuSyRn5TrWc2pDvA8zJJ58OJoyD@lists.infradead.org
X-Gm-Message-State: AOJu0YwyjPRxiPc6BB5OvLr2AkMA6Lk3bgoe4WQiE7Q1KENDGQOpxnFs
	/+8lTpUm/oErN67ankXHHZtb6Py1EHqW/OzAPLiUpGeoeaql9j4JebwcEN9WbC7XrITqxFyTeMz
	7xz0tp8lnQ4D6vx983uKfRJoTc9AmXls=
X-Gm-Gg: ASbGnctv1Ais412u6I5vEy1AcP8B3+e6Tu5Aav0GmbjQBpLIhXpL2u0ZasMVnrT2dwB
	JXV1q49zMGkSyl7cAMlv3dVHsJwrtapMDDtWQFE4CvIIVCv7bmjJoaspNp27sj/H1CHgll6Cb8J
	DuzOVzJnm63EKz/I0YhstloYulclHqhhsSr+KTc3p4cItSGTyTk1S3ezqQJNGlBmBmhBcTkmBRT
	iMqjjXSIUf1K+4+iv5Rjb/M/5B0f110gm1c1CbOMvJx2rM4SdS2FRvjw0GI6eHiHziG3cODGoX8
	teYi2jMbzu42+Fk=
X-Google-Smtp-Source: AGHT+IG3uw/6uvxht4oOdjOmi2F/0iIWJjYLpHYKQRgvzBx8kPjRQz3Jwr7IzYxm9dctoyz/qQl92E43O8w/1V+hTsE=
X-Received: by 2002:a17:907:a0b:b0:b73:21ab:7d52 with SMTP id
 a640c23a62f3a-b7331aec3a6mr86591466b.60.1762903947511; Tue, 11 Nov 2025
 15:32:27 -0800 (PST)
MIME-Version: 1.0
References: <20251030035114.16840-1-alistair.francis@wdc.com>
 <20251030035114.16840-4-alistair.francis@wdc.com> <8a236ca6-3675-461a-9166-4d4df3b5de08@suse.de>
In-Reply-To: <8a236ca6-3675-461a-9166-4d4df3b5de08@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 12 Nov 2025 09:32:00 +1000
X-Gm-Features: AWmQ_bnjMYteWvIi4UzpsvFmh0JZtTtuo3DyWXAbIQxcyV3jCUaeqoz-YrmZSTE
Message-ID: <CAKmqyKO=W2+5ZBudWhN_L1choupte9vzJBEoxVeZ-vNHykeR0Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] nvme: Allow reauth from sysfs
To: Hannes Reinecke <hare@suse.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_153230_023000_F5561177 
X-CRM114-Status: GOOD (  19.36  )
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

On Mon, Nov 3, 2025 at 10:08=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 10/30/25 04:51, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Allow userspace to trigger a reauth (REPLACETLSPSK) from sysfs.
> > This can be done by writing the queue ID to te sysfs file.
> >
> > echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/replace_psk
> >
> > Note that only QID 0 (admin queue) is supported.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >   drivers/nvme/host/sysfs.c | 31 +++++++++++++++++++++++++++++++
> >   1 file changed, 31 insertions(+)
> >
> Please, don't. Currently we are using the same key for all queues,
> and we really should keep it that way as we don't have a way of
> specifying the key based on the queue ID (the TLS identification
> is identical for all queues).
> So we really need to trigger a replacepsk operation for all queues.
>
> I would suggest just allow writes to the 'tls_key' attribute; any
> writes to that would trigger a replacepsk operation.

I think the `tls_configured_key` is actually the better attribute to
write to as that is the one that updates after a REPLACETLSPSK
operation, see v2 patches which I'm sending now.

Alistair

>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

