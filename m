Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 973E7C44501
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jul 2026 15:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ciDlz/JF2okrWUKZolnPsQiK1AaPriH2d5olMSaW/OM=; b=wSOaj0ECMvN/WlWbuRKG+c3HNK
	vFSQCByUX3kkGjtlOx4IfGwfn8Bdv10ODZeHMaaOfn5sHLNi1OLkP4K9guOjWgtdDaicTODv5wEkv
	k15zmXDHYgG0rHH+YrPLaYJqJqNNs17SVhZteO6KUKgCNi929V9Yji9q4BTqNXO3ODg+BJuNw67YD
	kbwU7hd6oi6qFpmRu4o6zRxYRwn1I1UUO3o7ety8vq9BiN1Kt7GMg41KZ/POlvm/j8BBBSCq2Swt/
	NXo6h4MbTu/zhlWtKC7RkGv2kjo2iFmwT+tJSNNI6LFJIw/TzaDg6bKpCsAJl381GdkOwnXAD4bU/
	QT9wOe3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wk1ZQ-0000000FKCf-34ei;
	Wed, 15 Jul 2026 15:30:48 +0000
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wk1ZN-0000000FKBR-3BC6
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jul 2026 15:30:47 +0000
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-494423343f5so414581b6e.3
        for <linux-nvme@lists.infradead.org>; Wed, 15 Jul 2026 08:30:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784129444; cv=none;
        d=google.com; s=arc-20260327;
        b=A1pGWX8UraUnR28xiIaFoc0eKgS4In9WmlMjNGIwXNly9aR53xy32vt7rZXWMZhyP/
         vkiGvXDti/PYUlwcbzpcDCOUQUcYB370SnMaHe+8N2dHBgZIFf6BGae9hQRiOZhcGMRf
         5eombit4c/AS2SKTFVD6722zAHy7YunMG38w+qFqSeprCJRnWD7+j7dd4ogPivPky5mV
         Vx51eBNkJDzr3bog1b956etdqp9IitNlEjfTUjE/pxBZXlwJ9G3FaTxkBs6uqyUycQmL
         KEdfhHacdOiu82W2V9rybaoZwtgV5HGaIeMdgDYL37tQZuj8zDz8JbZowUUyN/A1k1p+
         x6Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ciDlz/JF2okrWUKZolnPsQiK1AaPriH2d5olMSaW/OM=;
        fh=j1vjb2el3SJvW8YpfXxf610TQ2cn5yVsHilIFaUfbjM=;
        b=JMsSv9ClSrMqW344yvy41HNvWwYnoGPL1EWLLXFjBg/Pi8ceaGBP8kI3i8F2WQDqFf
         lsLlkKJf0dzZ5VL14cWCnyUmvPPiu0FsfATkHvoGkixLm3QT9nYblCONfoFxjFflGxYP
         BUfKK5eHQyphmpbZtEZhmFqwSYnmKr4QQW4D2tkLRR3jzEKhOVMEMn8iMmf3VQV3Rgrr
         NlMwhmjt6qsomO/kexjoS+Ccp8Qa+Sy4LiOE6eHEHZlzk4mtZ267au/qTYHSW20E9D6p
         5JOOSH7jygeJP0dI2QqlNaz/Pw5im8LcUju8s12xwQ0+C1PVlNZFraxka2eQ58XWoh/0
         VgjA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1784129444; x=1784734244; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ciDlz/JF2okrWUKZolnPsQiK1AaPriH2d5olMSaW/OM=;
        b=EGQITHf4YRAnM4DIy1pcEYkOpWOBygZD9ygmvcs08dMsek/CTMBFBoJSF4G99EYdZt
         kHPTRMT0yQO0ShcYszIPuP3AR8J713A8hckMF8sbiBxzRMNXSNGGfF9t+rf7wMVIeUc4
         0gkzs96tZcrj5R/HhQaBHXEMQgjhDfd7wYycmSKyPQGyOl/HKYb6IwVifeXY96H5DzUQ
         o4uWQpI8CHf69fx9o1Z3si4iiuP1OXIDK+oDspV410BeshvilAn9Jouv+7oWiBw+hYMZ
         9G+kmkIvDH1BEPNDjwn8KO0jyBHJq7K6GirJewK1bimUyAkErl1h5Zox25+IoAR5AFJ3
         J+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784129444; x=1784734244;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ciDlz/JF2okrWUKZolnPsQiK1AaPriH2d5olMSaW/OM=;
        b=ZWguiOOyC1sKvBNttG4L/IDxRlK0wxXQiHqh7k8yxI6L7VZUMZ9X4SSQiFhisnoqyx
         /HhyK0DeymYDvvWvMzms2Ywk0Qwa8591kQKTZUyK+bUYjtbmueHjAlHcnsN0doIlnFGx
         KQl0Dwy8j12NNRlwuiyEAC5Dqu6PTYFDLNUl/gWa2c6MDcjH2j+EGsbNblP5TZ1jGJY4
         f3Rd9DktkVoXxDkEXYRcPoW+FKH54JFBjzsGrSsH8FqtVEXKDm+RYjg9P8pLUwbxtu69
         NWqNB+WY1seoBj/B4OZq2m5rlzWHPJudHrjp7tbitn75crT/cspRaHmPeD9mdz+Izjcx
         S4xw==
X-Forwarded-Encrypted: i=1; AHgh+RpFeCTEhoAbDUVodmug/vDVwQMwOy+wtE/6Pa+3mdL1BEVVTiIE7fAr+t0R1LiwFCu+BGPLa9YGPQoI@lists.infradead.org
X-Gm-Message-State: AOJu0YwEVKq9Jky7UCIT7/Tfrtg14PKLl2TgW5qFcLJwsinTcKR/nkKc
	WahU+/wBFtSXnDqIQvhbV7xj42ZF05OfFQjGJQcMQmxX8sjOi/ih34wDbaP4bTHm7Ar9FaIIklY
	RQUtnhY9vQiFbAyR4xkQNoZu4tp/dlJKg9heFZYuqXQ==
X-Gm-Gg: AfdE7ckVEo9ujX7JDnF5aFx+eTn0mJiEerwFUr1baWMKlwpWsJL2lhjIQdAKXbb/b4K
	86CatCmRIdGNWSbscgBFX1nJhCFuAzsOmZ6RqWC7Nki2RIYiDEPq0bozS9LHpznsw5go686uwV4
	0wB3E7t5W2x5Fa4a20mY0CXJVlARC2uoxpKI1A6mGwr6Kj3Qm11dY0qsop8RPm9AI6LnjlxXOh7
	1enaFbNUp0YDa9xOsRHmZWdW+JRY6iNA7Kzn1O+vdwxG3GaqzPXwAPLFqWsdpUtNd7j1M6P
X-Received: by 2002:a05:6808:191b:b0:485:7c46:b870 with SMTP id
 5614622812f47-4a42ac4c1d1mr7855454b6e.2.1784129444114; Wed, 15 Jul 2026
 08:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260627061933.2187447-1-csander@purestorage.com>
 <20260627061933.2187447-3-csander@purestorage.com> <20260714135310.GB714@lst.de>
In-Reply-To: <20260714135310.GB714@lst.de>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 15 Jul 2026 08:30:33 -0700
X-Gm-Features: AUfX_mxo7lB146q5JXEsmTmctGA9iKJ24a4jDXPS2pCRNBa9UNhJ5U7jlOaJJJA
Message-ID: <CADUfDZoGheGP6JCwwV=BCBnqxAspJ1n9Aes=UsjtS-DxAMxeEA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] nvme/core: advertise BLK_EXPECTED_REF_TAG_CAPABLE
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260715_083045_959128_E3981178 
X-CRM114-Status: GOOD (  23.01  )
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

On Tue, Jul 14, 2026 at 6:53=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Sat, Jun 27, 2026 at 12:19:33AM -0600, Caleb Sander Mateos wrote:
> > NVMe Read, Write, and Write Zeroes commands include an (E)ILBRT field t=
o
> > specify the expected initial reference tag for the controller to check
> > against the ref tags in the protection information buffer. However, the
> > NVMe driver currently always sets (E)ILBRT to the lower bits of the LBA=
.
> > The block integrity layer generates/verifies the PI ref tags according
> > to the bio's ref tag seed, so it must "remap" the ref tags, adjusting
> > for the difference between the ref tag seed and the absolute integrity
> > interval number (=3D LBA).
> >
> > If a request has an integrity payload, set (E)ILBRT to its ref tag seed
> > so no ref tag remapping is required. Set BLK_EXPECTED_REF_TAG_CAPABLE i=
n
> > NVMe devices' enum blk_integrity_flags to skip the block integrity laye=
r
> > ref tag remapping.
>
> I don't really understand how this is supposed to work.  For type 1 PI,
> NVMe requires (E)ILBRT to match the lower bits of the start LBA:

Good point. I suppose we could only set BLK_EXPECTED_REF_TAG_CAPABLE
for namespaces that report Type 2 PI.

>
>   If the namespace is formatted for Type 1 protection, the value of the
>   computed reference tag for the first logical block of the command is
>   the value contained in the Initial Logical Block Reference Tag (ILBRT)
>   or Expected Initial Logical Block Reference Tag (EILBRT) field in the
>   command, and the computed reference tag is incremented for each
>   subsequent logical block. The controller shall complete the command
>   with a status of Invalid Protection Information if the ILBRT field or
>   the EILBRT field does not match the value of the least significant bits
>   of the SLBA field sized to the number of bits in the Logical Block
>   Reference Tag"
>
> For Type 2 this remapping could work, but doing it unconditionally
> will make all data written using and earlier kernel in a partition
> unreadable once this changes has been applied.

I mentioned this in the cover letter (and that's why I marked these
patches "RFC"). Unless you have a clever idea, it does seem like an
insurmountable obstacle here.

Thanks,
Caleb

