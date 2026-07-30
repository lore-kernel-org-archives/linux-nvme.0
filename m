Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDA6C5516E
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 19:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ixWJgT8hMudFvQmf9xO+ue0lQJczsuaDtkS4pNl60os=; b=byBClzczAFZ8h642cXHeC8mf11
	gvJpTGdTRADeMvBLvUbesN2AcdPqPe5jWypCSjC/CeYQs5H4VRN+razmQrn0mMVaedIFcMA28tQrf
	uUFPFgM2dYDiSN16CHyz+Va3RWCKOZWF5Ly7xVJS9t69x048FAIVe5dm1kIpqguqh7lSJ+KuLP4eC
	csbJo6d7QerMxpSZPi2enqgSaBawYe3EMV9iB6Dzkf2kgjtBOHg6reC8AwQrCRJjaq/YAec9k2pdS
	CkFfB6bubg+5aWQTAyOknnZSS1C2kElAeyyYpOdaMV9Lhy5kgRRswR+6zcBDySuARHITnSarB1yqp
	yk/V8Gng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpWkc-0000000BGcG-2dYa;
	Thu, 30 Jul 2026 19:49:06 +0000
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpWka-0000000BGap-00uy
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 19:49:05 +0000
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-697bd21fdc2so376934a12.1
        for <linux-nvme@lists.infradead.org>; Thu, 30 Jul 2026 12:49:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785440942; cv=none;
        d=google.com; s=arc-20260327;
        b=hnSFbDhOaK693YUUarZJYnjds261+41O7yj+ZSgc5rlMv2sU+pB1fW+dCm2vKpYRt2
         7DHMND2VvhqWqbzob9aesPRq+uVk0+7f3haxcABiJsrATExtUbLUeCklQbFuc0BHd9fB
         LYT7LpwDvJUP2JfVPs9VC3AcOwAOiqsKSJmXVzN5A5n6lgDOxjwiEl4hIrvHTwL6bWxM
         tb7hDhotgRsK5dauwn48pTW284nninK0QHp2+xmdozKYapi+LsmQGXPCvJgoQUA9oPYs
         I9JG7zi9SvGSI5RjosGxwEmfqWQQj+AKYrVW6E5l9Z0i4iwFwlfYZrlO7ATzSvYi3Hog
         m8oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ixWJgT8hMudFvQmf9xO+ue0lQJczsuaDtkS4pNl60os=;
        fh=5G3hZ3/Prqn6s8858SjEeFc2FTqdcLqW/7wd6SxFNY0=;
        b=F46eO/a6fe45gm7IigwqsgWv3pZ4b8BqHbdQuSbvt0ghFqTplk5EnEwE+3Ovvf7OGJ
         Xgmt7GninL0ZyAERml0EfiYM32WcMCSrLDs/xClO1yebRKN7a6tP2hXEbbVxF3eczj1u
         BPRXL6sQnN7KCFhnLpaAHqJ7E8riE5+OYmBM84KQTfQEwFMdZIeWxK0a9hYVh84l0nRf
         FRXQ4PXJR2fV9s5J6gUdMjdsXBGA9OE8PzHfcRo2K3iitz/mqUM/O12KlXm792CW1J4c
         5pUW2Js+Jc69VPJB1GvGIqOPeDukDm5qiurOLMAN7BQaLpL2fuyE+Lf/pPi9eYFKcjt8
         r+VA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785440942; x=1786045742; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ixWJgT8hMudFvQmf9xO+ue0lQJczsuaDtkS4pNl60os=;
        b=irRZkonlYRbSqb4fWnfCJQqkVy6HTgNFdrDecJMjP+pqBwRQ5OjLFoQBXi4IxCWAlX
         EZnVUAOpnjK0hpOCt6XCUg2sMlfS00GhZDVSiLYLjOduP61UW31RMxB/shsAIfjDVDTK
         MCQcRj0/dWBQAL4yS1hqXcwcYZbM1g3cFNtrwLTzVuXcPWmPgMQAUAESQJF0vE7tK41Y
         xCN51OFmfXQwsP73jI/9yh1YKZRocVrWN9EggOpJ6FiI3CS7/8+eolYKHIj+jvT7sLBp
         DYzhvX0i8iXUUAkcvF7HSVun5pKjhukkpdff+D6gwgtned7PI7j+UoP5EM/bYLhNfpi6
         g1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785440942; x=1786045742;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ixWJgT8hMudFvQmf9xO+ue0lQJczsuaDtkS4pNl60os=;
        b=kOlt7bzxLkvldpR08Igg7fFXoIDnKxO27p+c8F13TT1WZDh3Jtup3Str4m+wh4gK8o
         ekTC5jZfHQ4VBOn7xd0t0NqhL9c8dOdYpimSvOVq6e/g4mLmwpXjEXngsWZzPXc68QPD
         Ly613el1UVsAFoAGRIfeEwd+UZIVHWwVeh8xefJzNc/uiahWQpqvd5rlwHetKFYNmeob
         mwJs/yGe5udIJMJkoNd3tr2nMMRfopQm50P9aLj4s1WQlC0rufm0ftbBvrwu8TS3AHX4
         Z0QRu/PnV5W9nbcnbm7qVg7AiEja+hUA1pQ3h9DtZB4e3g9+/mJyBRbpD8k0uuHCutwU
         321g==
X-Forwarded-Encrypted: i=1; AHgh+RqgCd28hFxeadUyoqGglmd1uRag9PzVHRVVeSwLwFZAOJsdpN4e6WLR6Pkcp7gYdsSROEkwyXwDezig@lists.infradead.org
X-Gm-Message-State: AOJu0YwtGGGS8wo6ybUmd3JAlB0kfqblZfi5VngoCMqFBZXB/MfF+oVV
	PqpovWrU1gDvKIQT4IxndBZNq7dWbahMIxAafaKX656oJ3JP50gbIRARE4rWmeGZgteMtqmqsDa
	QOeAEN3/Snqk308jEbov86+F8+c7570x00CegHW8=
X-Gm-Gg: AR+sD11MIAnROXHj/hLRQ0/tDj2U5V/iCbRF1eJorXEMwkrJCgaRtL3aT6mxaaAw+ov
	ikWRnOqFL40guPgahsA9Nfh+pBENhdZeWQGbKlcuzlF5C0qQSYzFEND18pppQWX5IQJFlprlxR3
	aq6xNVZuQbcyliIUEWTUWYxuMDUD+4ZYM3pBrARZDAyoEa4w857jhliOLvs1abY71Uj6qPThx3J
	0fF6ACu/PD/pZgH7WG/fbzzRoQ5M2UjJuvHu9tCdBEHJ9AOJwaT3H9lYW7cO1cjuy1vMNu1QTsA
	BpBJODXBWGC6Qb9snzFD80e42u3syiy082VB4JzlnJe7
X-Received: by 2002:a05:6402:3784:b0:69f:e3cd:5ae0 with SMTP id
 4fb4d7f45d1cf-6a07b7e2a4amr2228183a12.18.1785440942100; Thu, 30 Jul 2026
 12:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260727201257.211635-1-coshi036@gmail.com> <178532422849.2568853.3142469605707392497.b4-ty@b4>
In-Reply-To: <178532422849.2568853.3142469605707392497.b4-ty@b4>
From: Chris S <coshi036@gmail.com>
Date: Thu, 30 Jul 2026 15:48:50 -0400
X-Gm-Features: AUfX_mzw_brm-7pVnzrWVTk1rf99jQRwch2Ue0uN3fj_yO5c3bAG7uT9FU3XI0Q
Message-ID: <CACd_6n372enkmZuXJnxXaDe-PA8o-t3Nmj86s_zCgGkdYTcanw@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20260730_124904_062877_69A90891 
X-CRM114-Status: GOOD (  14.55  )
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

Sorry for the mistake, I think I replied to the wrong emails.

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

