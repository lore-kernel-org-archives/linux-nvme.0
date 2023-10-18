Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625B9CDB47E
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Oct 2023 19:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0lcjfcAxdk5Wm/hZPKJ7a4MTu0A8XP8H21xpAEIkZ74=; b=rz3sLymJqyvvLohVyWi3LpEA3+
	u6TR4b50VWhbLRN3RT7hRCZSxsbNpM0BWC0FKHu1pObcBoUBDwSXJgdLntLJ082E2//KbyPmKIBjX
	bqTZcuZBaXeTR7poJsJXE9AOC8dT0C5jvxSNZEU7FxScDM7PLDYUrRIXik63G2nBDqYa1qz/qeCUg
	QMRjdSo+wtb/gRkzDAB6+v6lsPpqM+RybfMY7oZCPfS+jZfJQ6InkO51hr6Czfi0XBl7VZBqLRIT4
	pa3zHpcuU+4OaH6heNeJ2vvDE7tYlvdFgzOT5fZeuYnlwrgeoQ2oX3/FibRIMmslWVIEQvgEdCtAb
	t8oDVFRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtBsR-00FW1Q-2D;
	Wed, 18 Oct 2023 19:06:43 +0000
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtBsN-00FW10-3D
	for linux-nvme@lists.infradead.org;
	Wed, 18 Oct 2023 19:06:42 +0000
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-407c3adef8eso17163415e9.2
        for <linux-nvme@lists.infradead.org>; Wed, 18 Oct 2023 12:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697655996; x=1698260796; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lcjfcAxdk5Wm/hZPKJ7a4MTu0A8XP8H21xpAEIkZ74=;
        b=dz8RAJ6NfgVxu8rRBj2gcf7aln/lK8pVOjjurRSbhwmMhKD5X920B3j0POpTDLDo6F
         O8BJy5iCPRnYLCdJJVE70v1DTBZLxy+pmjabzIx+xPD/CE1VTAx5shrphCRgKdi3Dqda
         PPCgKqAKsTFG/PCHwM7TbiwzNyGaEjEwkkaZmtGfrMpxcskQn/1P/J5s2ZRlkdcRw+VT
         IgXFboorMbb/9PSM+S258A1PX5dheyQK0M+NnpuqTt7U9lHEHUrdEZKA7y22LBdW9T7b
         HPVJVd58YURdkq1HiYn9f/rQaJ06OmN0Ori6S2UYOT+0OmQXTYVJAOeOm4ih+bCwqk+n
         XPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697655996; x=1698260796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lcjfcAxdk5Wm/hZPKJ7a4MTu0A8XP8H21xpAEIkZ74=;
        b=cVbmsN8hWYDJPZhukWueGZH9a2QTHouO0SU2Laagj7I2rZWS9MbWrMC6hyAOCbIxDs
         lL+qTrMs3UFpwrI/TdLmpVJJFYBllEmDvq83VBTKtIZLMTWfY8dJBXTZpQ5eMbexBKtn
         5B7g1FzGUz4/B37HZ2zhJOraeZimBfGlUh3h3OEZwYf4xSi+HFXVVarZIfjKlYWadH4G
         DW1L08hu9ekPnPHmI5uX+GaO5yck0hVP+8tUukoqRSwQcEy4VQDpZQhU+CpcRcdstL7g
         ItkLIY+Yq3dXuXgJzklg8tSDrjNn6BszqebYv1cVqXvSMuDmEZy39y2qMEEK+yK139is
         MX3w==
X-Gm-Message-State: AOJu0YwD2FxMAx4OXVWluXzQDhf46Vs0wNkdeAVpomqtC6uFYfklRKOv
	vZN38WJdTsL3syrpyibPGve3hSaQg+1QSsYpjyA=
X-Google-Smtp-Source: AGHT+IHAHP8my+4eNHIBftoXGIG+6Ht58IJ87C0Q6uOyN9bIdqXEUFMVsmzfQb/N8hnWvtquw1ShebqzN5SyI6u5ukI=
X-Received: by 2002:adf:ea45:0:b0:32d:9701:90e5 with SMTP id
 j5-20020adfea45000000b0032d970190e5mr4854482wrn.34.1697655995630; Wed, 18 Oct
 2023 12:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20231018183620epcas5p26ab74bdd1f2739ef3ec1ee2431329dc4@epcas5p2.samsung.com>
 <20231018183003.41174-1-joshi.k@samsung.com> <2f6cdecc-d51b-4cbf-a0dd-ccd22fac8a98@kernel.dk>
In-Reply-To: <2f6cdecc-d51b-4cbf-a0dd-ccd22fac8a98@kernel.dk>
From: Kanchan Joshi <joshiiitr@gmail.com>
Date: Thu, 19 Oct 2023 00:36:09 +0530
Message-ID: <CA+1E3rJks2GVqNJ_YrUv4g78oNTHc9zkHc7-myPLOGp1U2mJJA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Unprivileged sgl-only passthrough
To: Jens Axboe <axboe@kernel.dk>
Cc: Kanchan Joshi <joshi.k@samsung.com>, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_120640_055420_45AB193B 
X-CRM114-Status: GOOD (  16.50  )
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

On Thu, Oct 19, 2023 at 12:10=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> On 10/18/23 12:30 PM, Kanchan Joshi wrote:
> > Patch 1: Prep. Adds the meta-transfer ability in nvme-pci
> > Patch 2: Enables fine-granular passthrough with the change that i/o
> > commands can transfer the data only via SGL.
> >
> > Requirement:
> > - Prepared against block 6.6 tree.
> > - The patch in uring-passthrough failure handling is required to see th=
e
> >   submission failure (if any)
> >   https://lore.kernel.org/linux-nvme/20231018135718.28820-1-joshi.k@sam=
sung.com/
>
> I didn't have time to follow the previous discussion, but what's the
> reasoning behind allowing it for SGL only?

This was a solution that emerged while discussing how best to fill the
DMA corruption hole for passthrough.
With SGL, the buffer length (data/buffer) sanity checks are done by
the SSD and it fails the IO rather than doing extra transfer.

> IIRC, we do have an inline
> vec for a small number of vecs, so presumably this would not hit
> alloc+free for each IO?

16b dma_pool_alloc/free for each IO that involves metadata. This is to
keep the nvme-sgl that points to the metadata buffer.
Hopefully some ideas can emerge (during the review) to see if we can
do away with it.

>But even so, I would imagine that SGL is slower
> than PRP? Do we know how much?

I do not know at the moment. Plan is to evaluate this soon.

BTW, SGL-only mode is for unprivileged users only. For root, it
remains the same as before (prp or sgl depending on the data-transfer
length).

