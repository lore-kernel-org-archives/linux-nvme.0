Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B033C53200
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 18:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=49lFXvTq+sDchsjaqszQLQWrDbstBqsIDQjrotBwPC0=; b=bhj1zat6ZgUlSPa9SvK6QD5ltl
	7pKeHzDlFOxcMOsnf0Rz1ZWDIcVLeLX6sMGD7p9zHSK8aBUzHMCMrIiWC97/BYBMSp79Y/ZEDzXer
	yOYrj/kMOiU/ogAau1wTaIddTdCEK6+8PYEtB8a5/wm+N2DmDWSjqU7+cqkhovFPH9+8AgK1bihy/
	fMm8kNlhZZOtQjn+ww/QXrYehuTz3Tze0MZTam4Z8V+RRHykJ4ZRd0GBWf4PI3y6BkS3dUl/C9qqv
	s61YTu2jAmCNL08uU6hzEgTkyOotKDXtrXS7N4bNbJkRauoTT9p7frbuxttUv2y22iJdQkCOgalSm
	ZG99Ebtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp8fI-00000008mBr-2i5y;
	Wed, 29 Jul 2026 18:06:00 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp8fC-00000008mBS-2sEs
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 18:05:55 +0000
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-69fdcb13fdbso337930a12.0
        for <linux-nvme@lists.infradead.org>; Wed, 29 Jul 2026 11:05:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785348353; cv=none;
        d=google.com; s=arc-20260327;
        b=nq93xwqWFsQcDlq4ElJqETbxLzq5VBrGuG26Ha04oFTmjnI4gWbthOeJBa7Vla9Q7G
         4scteFzfhfZEUY12yGwAKsNwCK17PhvvlEDpGsjNxJM1E7t2JNWY7YI6gwj0ui39L5w7
         oH4tT/uAuQm8LZnFiYLwnnSUFzi9dW+5oJ5EyI3qxLCqT0H5Cup/mi8yBCs5HxdTjndV
         uCwDyiCZn5GP00gPs+GLgB3aurtJBzJJTO3ibX+q0nBj1F/CGvqJJu+Ivsvap/zwjBKn
         TB3xuehKL5QaqcHfziHA37M8WpB+lvv55ZoIAw/Iqz3AHkIzir5l5SG/3pkFTdKzFQv+
         HQMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=49lFXvTq+sDchsjaqszQLQWrDbstBqsIDQjrotBwPC0=;
        fh=Tjep1ZVjdjoPYieo8l4ykUimI/KZ9+ooW7SbqCP5+WM=;
        b=cYHaPp/VJVQuT9PonUh1JCvDpvT4d0+hWXgKxOUugUw7SwK01VVFsI5xmN3naaZeXr
         BsPv2iOejvEU68I4E52mhnO+qSvn1G9wbplw0BDSW/K6TJxR2++T46zzFLjG+GhriXwM
         99/YqsgbEHJgNdd5reIY39z9wwLQFbmLU0Y4Dvv7vyYBj+Y3sDKozJpXbgMy2C99TJX4
         gsi58YCJr0WWBt0npOsBt687AsAmAVm3otJGJNUnxJKHnBmkP5mEoMfBwZufOetslbZ9
         g9AJ4hidjTypuf60urOkaK75wjBkancMFT/rci88cudm39bIBqyDLyUaGlSKrVZzDCxt
         1C5g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785348353; x=1785953153; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=49lFXvTq+sDchsjaqszQLQWrDbstBqsIDQjrotBwPC0=;
        b=lYW0ui2wmxU+QlXTstaJB6MKcGeDXfmniXrHE5YtYL7d/0+nh0Kkf+z9sK8KKQ6sBo
         D8xBKb0SBQI27KQI698G+XbaJREL7Ll2IGCCGkk4GRZwH51NyHjhN9IT7dqPcGwhNXRr
         a4ND4k366r7K4/GwX08Pzwh30FiYMnz4BQMruKusVfkvBnZCAK+5k8OfN2dPnWtCqUG1
         No9HVgfMSCVTc2+/lC2B6NfRVFh/AtZIDHhCmCS7hN/YhKJwSQx9EsY9Xg837r3JP3Q1
         2PEkewBq5WEUmuGaczjH+DWFWZH8ykRbn8ns8+MzodX91MwzM/lqajC93rrXZasLk3bw
         0KAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785348353; x=1785953153;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=49lFXvTq+sDchsjaqszQLQWrDbstBqsIDQjrotBwPC0=;
        b=IeVUcMg8QITQZ+UXgVHGxYzTL5+W2hKJC+omuGhwZtODCIXuWQP34SkG1sj3YlHO76
         D/3azj15dVBF9v4TdBpZ4rM+YcB3dSAKVmX+A4h55NvZYvA+4HCFM/cQc2pLGXmbDsXr
         3X6KSykcpJ+SH0aAlBS7Kfszha6dom0N+KWJwDrSh11FFdrKxaWKTRGVAWFxdcN86H+n
         yPpC2XH9ew9q7H0lWI1R1CT/m7/I03aGDDgEYXmCg0lOc0dHklw2kia7JAEcnNlWzBXT
         WlFrhUWf4gCPiKUqy2yii4i6FhXnRkCCRTLdVBsjz7cYJHZlV9S30unbQX4cpcOJna7b
         n2Ag==
X-Forwarded-Encrypted: i=1; AHgh+RqAJghG7FzjSWAUs85CzsaKQagLV3Dujtt79r7PTg/WWd53BxWFT2TZmNWtkJGLif7MNyVWBJpro5GR@lists.infradead.org
X-Gm-Message-State: AOJu0YyvxzU8DTi9NrC+bsEUnc9rLBhRfSQ2cCQoYWdF4AS5nezbHGO3
	KHK4xulmYhoeieXx2YIQvy3qwGZtobUnNkUMKiBZ/sKhk6evO/6FDquDwyqehCNYqe7KEw/F0wN
	Bi9rWHirEqFKj4VgEIWpcCqN40RFsJ0Q=
X-Gm-Gg: AR+sD12E//DGvu/PoQ2v5uOTNi37WrJipJLIqoESoEOurWDce7TjkmjR3ZsF63qcoxJ
	oIqmfWfPZFBzL1PfHVaFhUYvulg2knoU8UVkYwzKKtV/zNKDkY/ppbEUn1n0B8xaofN6WRKRaX9
	vckvVaElq2UcOmrH1/zAkXNr0rUpRa+dSGmjnYCkV/9Q8sTyF75F8o7xcvRfKwE18gyLOpOaWXi
	eJc2kECF41xyq2jGngaphac/93ifbjfB1yCTolXhJZzTgw5DhEWaX7NJpNq8usbTogFhL3aqHh6
	kKaS2T1nJOo7Z3dRmn88iw2RqIg9j0A4+CVZ5n4eFy2B
X-Received: by 2002:aa7:d045:0:b0:6a0:4bdb:2232 with SMTP id
 4fb4d7f45d1cf-6a052fd7b7emr1486891a12.12.1785348352453; Wed, 29 Jul 2026
 11:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260727201257.211635-1-coshi036@gmail.com> <178532422849.2568853.3142469605707392497.b4-ty@b4>
In-Reply-To: <178532422849.2568853.3142469605707392497.b4-ty@b4>
From: Chris S <coshi036@gmail.com>
Date: Wed, 29 Jul 2026 14:05:41 -0400
X-Gm-Features: AUfX_myCfEqTt2vnp1u4w8aDpspSL6ueI6W81g7qGqLPZryGhb4Ech1gv1U8ZKE
Message-ID: <CACd_6n1Jy69wew4AdF+J5=kpYus9VZgOpv9OVsA+uASrBObuYg@mail.gmail.com>
Subject: Re: [PATCH] block: stop the timeout timer when releasing a never
 added disk
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>, 
	Keith Busch <kbusch@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Weidong Zhu <weizhu@fiu.edu>, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_110554_747245_2BD0BE9A 
X-CRM114-Status: GOOD (  14.76  )
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

Thank you so much!

Best,
Chao

On Wed, Jul 29, 2026 at 7:23=E2=80=AFAM Jens Axboe <axboe@kernel.dk> wrote:
>
>
> On Mon, 27 Jul 2026 16:12:57 -0400, Chao Shi wrote:
> > disk_release() undoes blk_mq_init_allocated_queue() for a disk whose
> > probe failed before add_disk(), but it only calls blk_mq_exit_queue().
> > Nothing there stops q->timeout, and that timer rolls forward: it stays
> > pending until it next expires, not until the last request completes.
> > So if the driver issued any I/O before adding the disk, the
> > request_queue is freed while still linked into a timer wheel bucket.
> >
> > [...]
>
> Applied, thanks!
>
> [1/1] block: stop the timeout timer when releasing a never added disk
>       commit: 26cb8ebbfaf713c82e142d08828d4d765057633b
>
> Best regards,
> --
> Jens Axboe
>
>
>

