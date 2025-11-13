Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127C3CD6E42
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Nov 2025 12:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=96n00582KRfAzbP9HmUAwW0SECp6ktvz1svZCc5/Luw=; b=sk1ZS8ETfKCcKnaXDa/zsoLzmD
	uHbmQoTIbRhb4IQJTAHBlhicHLx1YDCLfQhGwdpz0xEZMunCjFp4+J2pRyU3d7r7aQBSGyxzclCeq
	9fYcoCKg+x0iLGiMiiXkS5RGO/3QwMVbxLW5UCBtiz/fB5Vb/wcSgRzpgjpux4Z9CdnaOGf3Kt33E
	SbejELTdfQSUXBnxDry79teI7B8US90+rIynitGSBC/O4ZQe+MWQFqFhrWiRS/rUfA9/S/QXeiJUN
	27uWd6K4Bpvex6Z6ZveLxJCkmOz8ez+6mPUHOy/Bn3WxSPJhyVkWGR64HyoXH7kWP82PbJ5mxzNUU
	i9EvjTng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJWMv-0000000ASdA-28RH;
	Thu, 13 Nov 2025 12:24:05 +0000
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJWMp-0000000ASal-3hqh
	for linux-nvme@lists.infradead.org;
	Thu, 13 Nov 2025 12:24:04 +0000
Received: by mail-yx1-xb12f.google.com with SMTP id 956f58d0204a3-63f97c4eccaso665837d50.2
        for <linux-nvme@lists.infradead.org>; Thu, 13 Nov 2025 04:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763036639; x=1763641439; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96n00582KRfAzbP9HmUAwW0SECp6ktvz1svZCc5/Luw=;
        b=VurIqHCM+3Ie2NVenoZxyv6fiwfZTs7cHeWBp9nEa9RBwePfS03F80KWdT4mZoAFPh
         eevsq9VwebVPS9/iZwVLWs2Sb5jEPGkd5UgDHoYTBfby0UWpjGWttPbc3Fu/icAwsXJZ
         k3WKZM2Z+8+pqUEpR2tdIf98nScaR7wQixDpQ9i1cU8chdWQukXOjtyctLV5shACVLIy
         55v5uskB9TQ//bHmbl5Bojpvd8Ks2xNseSaFAoJQ9RIrVfIOpbKxNKzAyrmJZT5PDeZl
         GU0gRSjYuapwAmWu5g5kU7cYY5FfAjODMDQmpxq/ipl9EftNlH55QS+Z+zWKsFHYo9/2
         fXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763036639; x=1763641439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=96n00582KRfAzbP9HmUAwW0SECp6ktvz1svZCc5/Luw=;
        b=EqtQP8wd0GvS9aXUO+/G+w4weTAURVMiNeVYT7Ew0rGDJfM5cyk0iN+vzpUMlxcHKf
         eSx5WZLVHcX5xYWua9iBq0HOeyKW7hHcCLsvW9pi/9P4+itP3S/8Z/8XRu2olrQxoRZ9
         6iYKMz46yrGzsKszOwGrLgm3viNDa72J+5lHrbaX035HaKjktgQwYO5YL8CgTok/MBIm
         qngX222ysCVAyYnIm1RlcTvyugRIECQ2h2O+pDIGncnIJIDyaFw2cMgOx7aPHnvNNX4g
         jue4OXiw+h/nVzWqlsVzQzPW2KwbaknRzshAXwkXbebwxiYaKC4LyGVzD9J8uMOgJXX5
         6s3g==
X-Forwarded-Encrypted: i=1; AJvYcCX2WFymsLRQbALrErVOBa+5Ef/whTyH40KhI9xkSIsjMjSITToZ0XT6fBgmkkkhg2pPJZzZtsUtUEms@lists.infradead.org
X-Gm-Message-State: AOJu0Yxdc1Kcx2HG9FRCquodLGs+avwUMhV/y1HW60rCaABkMDmNRIi5
	rtMdLRyQOgR8xHoXU0B3/PKPuVJh5hgP6oEYnyqmU8eW4dz3FnBAoznNagSLHkrMkh6nPJCaa5L
	RSslE14m81n5xQbzrU0HW7M05VlgTMGA=
X-Gm-Gg: ASbGnctZ1UykshkCrpmBnCgsTXw2PwXxG3Pf7oX8lL3BBP5RPFBagS3HECckBe7zIMm
	G/XnMUl6kgMW0hCS6VBoLh98mNoh8DFao1EdwoZeiaHIgTCQ8yyGnG5RbgUabP/kcRz8lKIS/0j
	hFwDa4wkKwf/suKQHSlX0C0a2MYCjh7s5xNmHxEfjuBVBUL3XDVpRwZUJlQFHXkhdTIKyDTdRsf
	Poou0uaDrWpMjHbngU5XSBquzx8SRBmaMCguQiQcqy6FXbyZLof5xRm/AcHPh0OGHLNJrPqmzXK
	4MqmkH8d7TR5p7c=
X-Google-Smtp-Source: AGHT+IGyWmfE8lnNSETzpsam1FziO25e2MZBJM9bAC2smHtK+EvCnDtF+WCQIw4wVIWrdLrFAFWemlz3Bj1M+g7hA3Y=
X-Received: by 2002:a53:d047:0:10b0:640:d009:e998 with SMTP id
 956f58d0204a3-64101a0b2bdmr5030018d50.12.1763036638749; Thu, 13 Nov 2025
 04:23:58 -0800 (PST)
MIME-Version: 1.0
References: <20251111234519.3467440-1-alistair.francis@wdc.com>
 <20251111234519.3467440-5-alistair.francis@wdc.com> <20251112065653.GE4873@lst.de>
In-Reply-To: <20251112065653.GE4873@lst.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 13 Nov 2025 22:23:30 +1000
X-Gm-Features: AWmQ_bm2ZdiPzFPd48NGdHsGyOt4QuKhzjv2Kb9fjvNcUPYkKnuCpretzVc_oKI
Message-ID: <CAKmqyKN8nv+D1BzDTAm4AayM0NgWWUY8Z7-o2Ru6CSq7nU9ECA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] nvme: Allow reauth from sysfs
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me, hare@suse.de, 
	kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_042402_127645_C2127DD1 
X-CRM114-Status: GOOD (  13.90  )
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

On Wed, Nov 12, 2025 at 4:56=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Wed, Nov 12, 2025 at 09:45:18AM +1000, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Allow userspace to trigger a reauth (REPLACETLSPSK) from sysfs.
> > This can be done by writing to the sysfs file.
> >
> > echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/tls_configured_key
>
> This now takes absolutely any write, right?  I think we should at least
> be strict to force some value, and document it.

Yes, it now takes any value. I can change it to a bool-ish (so write 1
to trigger)

>
> Which reminds me that Documentation/ABI/testing/sysfs-* is missing a
> lot of nvme attributes it seems :(

Yeah, that's why I didn't add this one. I'll have a look at updating this

Alistair

>

