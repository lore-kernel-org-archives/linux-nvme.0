Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF6A606A320
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2026 11:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jm7tjxvI;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ky/JB9+/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zlJH4+t0mXQ/RY9w29YgUuQUml1Z0NJ3e214jG9j+bE=; b=jm7tjxvIdiRQgC5QXL8c31lMYr
	T1gqMuASJl30GgzFBvRfmSl/21zrkhZRTulqWfA+jNe32JzCFEeEJKnHNZK1DtjlpQr1dK3pzcwIk
	b1WYVb/1Q7/9kpOh2ywxJ9538CkFNR9zm9APsTQB5hMr3cMPLu3yAiOkNed+cGqmTKAGEF1n94wFW
	idg0DIrV7WWjQ7d3EuqDbbXjdQfc9mIiQEI0UmGqcX11nQ7EaSlKgphjST3b4VJv/eSXPFDKrBP+/
	td+hpUkE0D+5+Rg4k8EWdo3PsFrmwRezLvYSjHTcclKLY9YMCBQrrBpHLSM+2K+n8B0MzWjHo2Oaf
	aLgtELGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU0lO-0000000BlFy-3CgU;
	Thu, 19 Nov 2026 11:57:14 +0000
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xU0lL-0000000BlEd-1E3q
	for linux-nvme@lists.infradead.org;
	Thu, 19 Nov 2026 11:57:13 +0000
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-6b6f42095bcso3306273a12.3
        for <linux-nvme@lists.infradead.org>; Thu, 19 Nov 2026 03:57:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795089429; cv=none;
        d=google.com; s=arc-20260327;
        b=BmL7VzvMxliulGYnwPbCcmcE6w2ixznbIOlBgpOZw+Z/nMCc4IZqIGFN+PciC9u1Iz
         5A6xi46zDmymTg/e2n3nUpFkHpY9d0xXm35AwsJt3/HBbFXkavXOiNkUIxbJHvKWXJCE
         NIj2pe3GPbKTtbnl1vpuRk4V8efZvrbBNYn5a06vbGMWvCrTnSe3T3Mrgr98k+twMKBi
         +3LiglhmhBoVA2QufLFntKxmkK3RHInubnNYYuOhVPgBh8G+ejtGzlYAyCGQsVfKk4xo
         ZI0JVvc/Dz8VkuD17hboYOHb45mM12/6pfuH2NlzdDz38m9AIK4rslBh8QNTwn/W6ulx
         nOgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zlJH4+t0mXQ/RY9w29YgUuQUml1Z0NJ3e214jG9j+bE=;
        fh=AAkfMCwhF6Hq92eLIEPgHSt502SP3mkpMFzTfysAyyM=;
        b=YruSRnGR3ydzBUN8LOrJOpwOOntQmkVGuCNYBdz+4QkMj/DkdaktY2UH5HpmSO7bxP
         5r3tuLrykiZQJRTrlFEWjwA69h6o3lLOnInc23ztPaUruWv41eSh8xOS9+Pima7ModUn
         YZ+CCgYc0imMf0fAFoMabnIx72F2UPPuiKpRcRiq1JiUZd6y0dJGVKKJgpNFd/5thr3c
         lauwjTdeGRjZxXVXnaVNvRYWBKH7Jq6KxY663nalqm3Hp2Y/9ZGeKMnexBtyjrEm/0np
         nX7CWzGjxZ36l8zWm4lPXpYOWwRKczXdXYok9gZm832l+5F9b4E05LgvLcyMZxAAT8XW
         J1lA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795089429; x=1795694229; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zlJH4+t0mXQ/RY9w29YgUuQUml1Z0NJ3e214jG9j+bE=;
        b=Ky/JB9+/bfZqlu+mS+5x8jATNu2b2N/FZR+v3IlbpArq+JkNFugL+mBIwrUlW+b21O
         WfxeqfjLsn+73Xby12KZB1i/qJmJlW6mPcBuS5r2kbple4ThipgqaUKUTKe5slLV0ZLz
         2+SGshpTfZOe8CzNxJCs+VQFK+eBov0Dz1yZV4fXsKhvyVf5TKEb9Z0vjBkTMxB8GpZT
         Y2mNkbZCjd65bx/NRoX+A5rPfvE8+veZKRkPECuOFbzcu0Ma4bh0nP3Xk+meK+BkJiYh
         IDzReBPxZLqwEbkEM3ozRqmhjX6AE5rFZ+c5/C1H4oRCcVf6oQK0Y1wD3OflargNEs6d
         jndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795089429; x=1795694229;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zlJH4+t0mXQ/RY9w29YgUuQUml1Z0NJ3e214jG9j+bE=;
        b=LFywaRrJNrD2bOxmK9OW6TFFBg1BlErcRs9Is3hi2//P1bTRk+Iwm7O2ySkXngkZEv
         YTiDPS5QHeScYqHQjVDDlkTtUYkN9IUOXNdGC3vh5vpKsPpkuYAHxVcsu1FcWIa3Jr5l
         KfAYjuJCNRjhNYF3mGwbEmIbYfUyrxfJz/X0+Dx8jNzZERGuY9sNIGCR0rWqxhGCxY8X
         pe6/T+5fB2mbC+GLRpvTJd89BDkcYi057KvGZNY4COOvcRheNOMYchcAxk2uV2NuzrNh
         9d59EgAdPImBcKO0Cc6ZsVpTpF8XI/AwyhU8dYMfBEjD/Q+gUN4a12SWfBOyhOisHYM5
         xYAw==
X-Forwarded-Encrypted: i=1; AL+hErH2ktUJ18zvbb4waGvgkkIkwJZ4NRpJ6JmG6V4uEM5ACvHNanAJjfYAmEbCf6yxwO7rp0rq+WN8c0rd@lists.infradead.org
X-Gm-Message-State: APuU4Z8H9I2FfsXcjPkDnHWQ23D1SFsQf2ZC0S/mtK+hmEekIqsYSUne
	pYUXjoFbwPmhCL8NV4nielB3EkVEIZq+elTkVoE40tjqI0rzT3vYzrCpdO5c/b3LHQGwLSWPvtK
	ypPVMfQJiOB0thdlsuBrEqh1+0K9wKw==
X-Gm-Gg: AYBFou3eFLkyYiT65b2xD6jfrtZLQ66kPt02/QlIOSAPfNF3yzBcRQQCfKa+6sEYGxu
	nBqxFVbv6iASzXjr5NwdhowhBiPiw8yAaVRqchd2aXMheWs9uYAgqpCi6FsG6mw/bO8fF7XToYn
	d5/TBBuZfjMjjHS0s7vSAIFm7jpBl6O3EiAdkOo36eOWDhdtaY9ypvqGaksb+Kyn46NbZqQ6Plg
	7opqrHDRaDZ0/JuRI7FYMzwe+XJ4aa3/A2t6YUdQ5XSDU8OAGcssCB/hnT5ImZ98Zl1+PCDyGIE
	SEJOda8hsD3yEcDhRfUTr1Kz2VARJw6tsnHz8VmZkahavYd5SHuyJUHfdgtjNKtSCarRyeZYeY9
	Ww+dvY6b9CcoJi4N0ytD7xaDGUNCWyG1B7HxFFnqIqZ/CB3LBCQ30jUMmxK9e4iY+e0pqu1NIUq
	ijuQALqthEv6F87KeUR4mB3V7c4E400sJAZICNsSypXB18aWsq8hK/DK60LO7vl2q76yE=
X-Received: by 2002:a05:6402:2341:b0:6b8:50e:3bb0 with SMTP id
 4fb4d7f45d1cf-6b887f051b5mr5100854a12.43.1795089428496; Thu, 19 Nov 2026
 03:57:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030014540.3065403-1-anuj1072538@gmail.com>
In-Reply-To: <20261030014540.3065403-1-anuj1072538@gmail.com>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Thu, 19 Nov 2026 17:26:31 +0530
X-Gm-Features: AclHuK_SZqZJTPjuQjOc7cIWYhN7F4D2sFh9VtkHTF5WSy6wsq_qeWgrWRBsOwc
Message-ID: <CACzX3At2GfpQB7eE1S2njJONChr8DmDC5poBw4pX+pAg21cscg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] dma-buf backed NVMe passthrough I/O
To: axboe@kernel.dk, asml.silence@gmail.com, kbusch@kernel.org, hch@lst.de, 
	sagi@grimberg.me, James.Bottomley@hansenpartnership.com, mkp@kernel.org, 
	bernd@bsbernd.com, joannelkoong@gmail.com, miklos@szeredi.hu
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, 
	fuse-devel@lists.linux.dev, joshi.k@samsung.com, anuj20.g@samsung.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_035711_351714_5105B358 
X-CRM114-Status: UNSURE (   6.71  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jens,
All patches in this series carry Reviewed-by tags from Pavel or
Christoph. The series no longer cleanly applies to current for-next, so
I have rebased it and posted a v4:
https://lore.kernel.org/linux-block/20261119095615.1840522-1-anuj20.g@samsung.com/
Please LMK if you have any other comments?

