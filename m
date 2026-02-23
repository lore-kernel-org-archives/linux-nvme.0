Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661F0EC1102
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Feb 2026 16:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jb8EY2Daxeiq/LPx1qaHDExDVJMIoxaVnc1OyFiIyi8=; b=giWscGZR4WUPmreTB7iHKdOU8E
	opggNqDXJcvFWeubmrt+miRTivsqWQtj/gyjvCigvwCvYaF5FnXKsbWyKme6IPM2yjXJD6e7OxtJy
	RGnloH59z4ETpPKUd+9ozptoXz5cns3HwlTVLl2ylOM1ROryWw0nD7YYVekBJ13EOB1xfn9TCVNq3
	fOzSfKvEkJQpyJUzfzeC03btzZFDDllLjYgVMv/Qwt5mutZ+NyjTt9oJxq+lfYwkdsp9e71FMWtmX
	R9ImSeWpcYPXKWAzpD5mijApcvdHkzHfc2+g44O3Yv99xCZth2hb+D3F3I/n7Zl6r/DlA66ht5puP
	/JMxO1Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuYMk-00000000dC1-0Vta;
	Mon, 23 Feb 2026 16:00:58 +0000
Received: from mail-ej1-f41.google.com ([209.85.218.41])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuYMh-00000000dBa-1dap
	for linux-nvme@lists.infradead.org;
	Mon, 23 Feb 2026 16:00:56 +0000
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b90bc00578cso62527566b.0
        for <linux-nvme@lists.infradead.org>; Mon, 23 Feb 2026 08:00:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771862453; x=1772467253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jb8EY2Daxeiq/LPx1qaHDExDVJMIoxaVnc1OyFiIyi8=;
        b=Hv0LuzkZ1iZ1YLaOxteYKGE+ZLmvJDfmapFNhy6lEZBxlSnJxQz6T8MtgmneDOgHIs
         eUnaY5tTHWCSUIxEdPYdoJnLSby+tpEXwqHI+CRHMLg1zCPmkKkOiEB9Ana9FGUZr84Y
         nwfo7tlc899ROy4khVsaI1zKrArK/wSXDUwEmNG6bYpxVa6ZopWM6db6zeJ7lTXNjEkV
         whxiVZKNE9rfDaT7mA808TdXZAbL9nqf4fPL/reNJKgje7CzqGoLkxRrvjkSnRGlzA2o
         i545wUcOAmw9w6raSPLXvctEHDpLwX85Ax10Bi95Kb7PCwT8Waa3Pc/qA3UAz20ZLGVM
         B/NA==
X-Forwarded-Encrypted: i=1; AJvYcCU+J+dkFCb0IIOXpJcVa0OWhEn05NPd62+QjU9Q3yCiU2rZ7u9gsFAf1WjDWCsyDjVuBW7xxbo4Ru38@lists.infradead.org
X-Gm-Message-State: AOJu0YxyplsFo9+fjCkdJGkatCdd4GqVvdlFEWdvpzqwsAfzVFUx0T3x
	eIoBTdUXqP80+AEGDpesF3jaKuIaLFOYc0k8o/f64+V/7rn5Ze/TNW05pUJp4HPUE/c=
X-Gm-Gg: AZuq6aJwlCxH5RkjLInBqCrmlvtoXiTJRBpEdhc1kvOBzq84RdhCUQVXIBrZBkNcH3u
	tw1eWI9p7JvHItbMbOUO/pNQDqd9pPn1ZyzcDDHpVZ28CQH/YSxLOnIXY1onL42CjkeB1mEcMXU
	WM/9FDsDTZA4A3O8nYZfBzq0sw41pY6zCsjfLVncTrSm4mV/9dMMzLsfkwd0ueOmDiPXeN5Y1vq
	BmlRkGVvdAm2j9P3MiB6RILDYNSO2NN8h5VK+GbKbp8NyMipcOqtSx9040mEGOXPZegdDMuTz5f
	fylm9UreteCtjo8sU/YlfJDC2h7ilBR1whibeLpKOQ034vYTErr/Jl6TrwE8H+GU5xLQRHrs2zZ
	CgB5SPtx0zpv1e38zH1L1bImlCWKo0zbmAXLFS31VvD7RjubsznUAAYgacB+IsbrRDppuyHa33Y
	L7oIalkmT7FKG/XVbiIXoJmOmzXy+jshebsiG0Nsr79vZdJ49sNHKq3Cw=
X-Received: by 2002:a17:906:f247:b0:b8a:f9d7:1afe with SMTP id a640c23a62f3a-b9081bd17d5mr470880066b.57.1771862452910;
        Mon, 23 Feb 2026 08:00:52 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084ec6deesm346431866b.59.2026.02.23.08.00.52
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 08:00:52 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4833115090dso43101385e9.3
        for <linux-nvme@lists.infradead.org>; Mon, 23 Feb 2026 08:00:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUvXUsQJG4pwbQ7TAD34A2V0p8z9gTNmDY+4/96ulABjFhZ2LgR75Mv+OelW+qrcs+PlrcRWRNJqEXI@lists.infradead.org
X-Received: by 2002:a05:600c:548e:b0:47a:935f:61a0 with SMTP id
 5b1f17b1804b1-483a95643b3mr157300905e9.0.1771862451875; Mon, 23 Feb 2026
 08:00:51 -0800 (PST)
MIME-Version: 1.0
References: <20260216003541.161806-2-iam@sung-woo.kim> <20260223134104.GA15458@lst.de>
In-Reply-To: <20260223134104.GA15458@lst.de>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Mon, 23 Feb 2026 11:00:35 -0500
X-Gmail-Original-Message-ID: <CAJNyHpK79p07b3aBXNzWvcSRCSC6Ri5MEXAwYbAr2uXXt6T8Pw@mail.gmail.com>
X-Gm-Features: AaiRm52vX_DkyHsYNp5wBmQPa1eeew3ZE66_o6hljPC2vt3zGEgIoN244brpKy8
Message-ID: <CAJNyHpK79p07b3aBXNzWvcSRCSC6Ri5MEXAwYbAr2uXXt6T8Pw@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix memory allocator in nvme_pr_read_keys()
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Chao Shi <cshi008@fiu.edu>, Weidong Zhu <weizhu@fiu.edu>, Dave Tian <daveti@purdue.edu>, 
	Mike Christie <michael.christie@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260223_080055_431590_9ABEAF03 
X-CRM114-Status: GOOD (  17.51  )
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

On Mon, Feb 23, 2026 at 8:41=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> s/allocator/allocation/ in the subject.
>
> > -     rse =3D kzalloc(rse_len, GFP_KERNEL);
> > +     rse =3D kvzalloc(rse_len, GFP_KERNEL);
>
> You'll also need it to free it using kvfree if you you use kvzalloc.

Will do in V2. Thanks for your review.

> We might also want to add some upper bound to the number of keys
> to not allow the user to allocate 4GB of pinned kernel memory.

Could this be a typo for 4MB? Users cannot request 4GB, since it already
has an upper bound, PR_KEYS_MAX (64K). The maximum requested memory
size is 4MB + 64 bytes as follows:

// struct_size(rse, regctl_eds, num_keys)
64K * 64 + 64 =3D 4M + 64 bytes.

We might still want to know that 4MB is okay. I think it is fine, but
we can shrink it as
the current upper bound is more than sufficient, according to the
relevant conversation:

>How about limiting num_keys to 64K (1u << 16)? In practice, PR keys
>are used for shared storage coordination and typical deployments have
>only a handful of hosts, so this should be more than enough for any
>realistic use case.
https://lore.kernel.org/linux-block/CADhLXY57aFmNB1v4TG2YxhOQL1+_02KkWpB3fE=
sn8t1GiFqdrg@mail.gmail.com/

On Mon, Feb 23, 2026 at 8:41=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> s/allocator/allocation/ in the subject.
>
> > -     rse =3D kzalloc(rse_len, GFP_KERNEL);
> > +     rse =3D kvzalloc(rse_len, GFP_KERNEL);
>
> You'll also need it to free it using kvfree if you you use kvzalloc.
>
> We might also want to add some upper bound to the number of keys
> to not allow the user to allocate 4GB of pinned kernel memory.
>
>

