Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53580C021B8
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 13:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TGWA47ydXjPk/ArJwGLRdTzUR2JDCR2yxtlUSj8iJJU=; b=z8JCNUIqJPcU/JuQWAg6L4sEXF
	WBOu/LfIVTAdFwblojbqAltQsI5gFnce3WK8wIRrUuMjGk6S2gD8UHuJR9vgosEN93uh3GaB7e9mM
	R1DOyG3sxwrTPzRSLCRjnr+WTcBqs+1f3vXmMAOx/kkjfkSXBVHavST+xZG7TeOy04F9mOVlWd2XW
	SxD+fZFdfhbmD73ymUiWzx7AaTOlqw4mSI7ou+Bosy88ViTYXE0tLfu+f28laIvQ8S0MTNQv72dwB
	i4t5RpoeKfpvGAnCxg7Lg31LYccszyq+NiKO76jHfG6EMb/U4zjOnb060ZeTp3xROufNfB3MouNKD
	f9/ylrmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnHPJ-00000003pkN-26dS;
	Wed, 26 Feb 2025 13:25:01 +0000
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnFac-00000003TYl-2zMV
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 11:28:35 +0000
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-30a2f240156so70073071fa.3
        for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2025 03:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740569312; x=1741174112; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TGWA47ydXjPk/ArJwGLRdTzUR2JDCR2yxtlUSj8iJJU=;
        b=ir9w/LmxlAClcwmyAsB7nfoF2bN//raFwvHKS20SvBJU1VkYrIUohCzdZiRRfcESn+
         RRaLTOsPOJFKR9X/8BcAvou6lWUOYQCq3iQ28HoB3vw2Zw/7jUfuuAt0RBSNzRRxtAIt
         kBF8GjsjVB6TLZ1590LbG0NWpaC/yh+R2xDOXR+zR2XSK+j8XdC4gAbFrJ1F5EqvPbhp
         2aGxp/ssiU1341Ijxt31wIS3zvn42kzDx0CUfgLHiLSrEvjUStUOqz4FffOiabpF8oe+
         h7Jtj8W9jHBT0HCqaJN+hY8Vlmlo9tZTkZrfJ9/YY8LYpKAFVai8GdFBRe8iBe5KYo6m
         cg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740569312; x=1741174112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TGWA47ydXjPk/ArJwGLRdTzUR2JDCR2yxtlUSj8iJJU=;
        b=oykZ0ZXI1TOKEhYQuKMt5/8LgtpNzR9dRQ2/z1HlXV4kla296oFwlZMbuZnvURndGc
         I/dYLGntoBO5hG6DFJ8zvl6a5CyjKMscrsU/ZxhuDXOrwtTBWwOZb4XCmuvoD4ft1IcE
         ccyQH8XB/gKeyw9DWpsXpLS8j7d5yOlX53d39C9l1DKd+mrPOEWv6FaSePo7nsk5Nbme
         8U2bpL8vgsjDhhgGvh8/dxaqQ6yI5yJTeWVInHTdi34YMMLq056zZ2UywS1t8ycyoq0A
         nLayd880RW9oRtyMm7sWciqjyAt1ByWlI4dcpMuN2lq4nkA/zHa1fkegUTdf0K0II/On
         Tf6w==
X-Forwarded-Encrypted: i=1; AJvYcCW0o25Rr+pl9kF0Xswhdh00AJ6KSvNSOOw/fwwQzMXgyofWCIqNtHmIfK98rFxwDQozwZ1JvvLzSt7d@lists.infradead.org
X-Gm-Message-State: AOJu0YyhFGqb9zF/6O21QrzZtTP9PJzXXkpQQ09gaaFN0R9gfCvoPeBX
	OePuQUhfW1e4SNB/6uBNujx5r6alor4vstmZ0xcRHuIBd7aPYW7K+6KkBKBnDAo3LOXWHc3o0cY
	KYS9BPnw1OF1Jyn98L/cbNJYt99zdrS0=
X-Gm-Gg: ASbGncuMIuCzbFWv1ujus9kGP4GEGBVLxalzndpht+xsBMf0uVUvO+1MVYRR23E+QzY
	P42wqLEDc+oTzB1CEyovDh61JJKp1uyj6T0xUYD7UIY3htQXQLPYH7P0HeaH2lAaDTwQtYUnQfX
	fs5Z1G9+o=
X-Google-Smtp-Source: AGHT+IH+Zjc+bSh26ZsVjU3bqp76TTCLT0O7VaVEWFGY3H7jTf7GiuF0ZJl8GQK9eeazQ/KZTqZRV1mtBf3J32sedzA=
X-Received: by 2002:a05:6402:254f:b0:5e0:b542:fb32 with SMTP id
 4fb4d7f45d1cf-5e4a0d88ac4mr3401857a12.19.1740569301171; Wed, 26 Feb 2025
 03:28:21 -0800 (PST)
MIME-Version: 1.0
References: <20250225044653.6867-1-anuj20.g@samsung.com> <CGME20250225045514epcas5p10d06ab361a4125a94933fa8235fe3fa8@epcas5p1.samsung.com>
 <20250225044653.6867-2-anuj20.g@samsung.com> <20250225150626.GA6099@lst.de>
In-Reply-To: <20250225150626.GA6099@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Wed, 26 Feb 2025 16:57:42 +0530
X-Gm-Features: AQ5f1JrVzXdezh5PQ5o_BGjgjz3qnhupiyvcy-dL-1mUwfQLc2HYvilNGs8wJSU
Message-ID: <CACzX3AupuX0NYqBxq-7hBxU5E1v3BhHeYoeuWxYuyXqu++iMcg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] block: Fix incorrect integrity sysfs reporting for
 DM devices
To: Christoph Hellwig <hch@lst.de>
Cc: Anuj Gupta <anuj20.g@samsung.com>, axboe@kernel.dk, kbusch@kernel.org, 
	martin.petersen@oracle.com, nikh1092@linux.ibm.com, 
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-scsi@vger.kernel.org, dm-devel@lists.linux.dev, 
	M Nikhil <nikhilm@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_032834_751854_968E599B 
X-CRM114-Status: GOOD (  19.42  )
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

> > diff --git a/block/blk-settings.c b/block/blk-settings.c
> > index c44dadc35e1e..c32517c8bc2e 100644
> > --- a/block/blk-settings.c
> > +++ b/block/blk-settings.c
> > @@ -861,7 +861,8 @@ bool queue_limits_stack_integrity(struct queue_limits *t,
> >
> >       if (!ti->tuple_size) {
> >               /* inherit the settings from the first underlying device */
> > -             if (!(ti->flags & BLK_INTEGRITY_STACKED)) {
> > +             if (!(ti->flags & BLK_INTEGRITY_STACKED) &&
> > +                 (bi->flags & BLK_INTEGRITY_DEVICE_CAPABLE)) {
> >                       ti->flags = BLK_INTEGRITY_DEVICE_CAPABLE |
> >                               (bi->flags & BLK_INTEGRITY_REF_TAG);
> >                       ti->csum_type = bi->csum_type;
>
> Hmm.  I wonder if this is the correct logic.  Basically we do not want to
> allow mixing integrity capable and not integrity devices, do we?

It is about a situation where a non-integrity-capable device incorrectly
reports integrity capability due to improper flag propagation. The issue
is that BLK_INTEGRITY_DEVICE_CAPABLE is set incorrectly even when the
first underlying device does not support integrity. This part of the patch
tries to fix that.
For example, when I create a dm-linear device using an integrity-incapable
device, the resulting DM device wrongly reports integrity capability [1]

Rest of the handling in this patch would not be required once we correctly
initialize in blk_validate_integrity_limits as you suggested in the other
reply [2]

[1]
# cat /sys/block/nvme0n1/integrity/device_is_integrity_capable
0
# echo 0 409600 linear /dev/nvme0n1 0 > /tmp/table
# echo 409600 409600 linear /dev/nvme0n1 0 >> /tmp/table
# dmsetup create two /tmp/table
# cat /sys/block/dm-0/integrity/device_is_integrity_capable
1

[2]
https://lore.kernel.org/linux-block/20250225150753.GB6099@lst.de/

> So maybe the logic should be more something like:
>
>         if (!IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY))
>                 return true;
>
>         if (ti->flags & BLK_INTEGRITY_STACKED) {
>                 /* check blk_integrity compatibility */
>         } else {
>                 ti->flags = BLK_INTEGRITY_STACKED;
>                 /* inherit blk_integrity, including the empty one  */
>         }
>

