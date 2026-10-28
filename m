Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA10606A31D
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=k7uShwbN;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X81vJ/xp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=iReJ63N40uvhp96+KeukleF6Ru8p5xLQflMjZYr/Acw=; b=k7uShwbNzIQjkO
	Y2TIXeIkyvGKKS2DoGqCu6h84K6/DdfhgpcNSszq0s5x0aEZ6V6mzfe+SNaFMIriRl0IfZyxSdX8I
	yrp+A7hcMsH75BZJQGqWf4IjoJ/cg6ek5P3ar4zVVfffrjpSFRvnhFS5/TeLoY95gVjFWBNuXv/5M
	MyZsC/XB9SX6e/m/4oZz4hNluQXsenGsWPshh2Uk4pDBGOKzY9eLIvLFiYROsbtFYd7o+qFkkWVqi
	uPqNAllr7ql0tyVFUc/Y5y/A1Ae2FPMkyoFBOCochzFxBK+6xCWaQAP8nAalYVhBTJqUqggI3/Lw7
	h7b8kSMBY1qOlCFgiEqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5RH-00000007KWi-35fu;
	Wed, 28 Oct 2026 15:19:43 +0000
Received: from mail-yx2-x01.google.com ([2607:f8b0:4864:41::1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5RE-00000007KVL-1q7w
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 15:19:41 +0000
Received: by mail-yx2-x01.google.com with SMTP id 00721157ae682-8b0dbcd4b6aso2630397b3.1
        for <linux-nvme@lists.infradead.org>; Wed, 28 Oct 2026 08:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793200778; x=1793805578; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iReJ63N40uvhp96+KeukleF6Ru8p5xLQflMjZYr/Acw=;
        b=X81vJ/xpUeYJ6rZTNQG/+I9FJ14f3uivStkri7VVpbFipzAuOmkZVj3o+i5gPDFbtv
         RL9rTrrTjF/JfFvVi7DCa6s+NPRSyz6U5jHRStsnTUqzlZCV1OhybHhCWgkhGpOD0b7R
         +k9JYr1vBnVkEQB91E3DzfU/IHGv85JmOUrLXcTynoRJNlzEKaNfsDEjdK8LkvoDqXie
         IgKJVlhu970VsSZ+Ialo8sY0rnezXQMtPyKjEoIOi6XZTMfT+7VPeIsI/SrjhZnHH2hW
         +Xd2dGaO4EwXeO2OfFpxH+2gnYYehmG3FVcB7szMiysQ660BMmwsNxJeRA0JzZH+INQ5
         8Y6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793200778; x=1793805578;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iReJ63N40uvhp96+KeukleF6Ru8p5xLQflMjZYr/Acw=;
        b=I1AlP9WLoxpOlNhWxy9FmLF09qV2InBGyECZ1khA3eslEUc0pnSsoJaV8plkWsXK8X
         Pj+8yhWCP9lRez81Zvk0w4m6PLDFYh+O/YVnKoksx6LhkSmA9kdBqaaqgH49s5C1t+tb
         n4oXJdjLXRLiNCZ6OMYYTsL3ASQ7z5jJ0gW7dDLXgYFaNr0sq/J85M+UZsMgEDllN/tZ
         duqyMV2oqckPx5HeZXoWNTi8Q+NoQ9qZmn/2E28NEJ0mx18ZIW+UUo4OYDoGHuoqrZPc
         ocPjJEdvmyCkNCNVIn8F+hEBTI/1ox+O+RHD1Axg231OTkNA4DKsRkJ/QcoK6ivRGl2F
         QmVg==
X-Forwarded-Encrypted: i=1; AKwUvBwSq+ziNeqZOspQY6sMuZQyalA//fco5TJqNoCHP00C6XRm618uEUSgf4CfmEYg6rvMJwxz2CGezAHe@lists.infradead.org
X-Gm-Message-State: AFq9FYIXnST0hdVxoypKK6nIAainV416Gk3vx0yDGvyM9RziEX2041pf
	eB4QWzzinHBH25sxopwSQGHLF3AjpWI+0lAN4JjQra5ACsiC/pD14dJn
X-Gm-Gg: AYBFou3JGbfbOtoVvA0MzmrZQk9EuEoff4W2kC3SgqmCkZw7V/RgD16LD/9GGTnOYXl
	04F+cZsQedRUU7dMCOKHEy2u/lYAuVsa/Oe9tv3OItz6zjH8VezNmdQSAm6k5wyA8BpWL0VF5A7
	/KIPKWUivqGXQYDVjg63qnCcTEB6L6e9ffVbywN2PWyx6sC87mJ4Gr61stFnKioYakW5LrRG0uG
	y2jL0utZsMXM5prb8xuB6xuQZm2r8/oA6ydUGV+9fVROJoZthbU+RarSAK+bWBf9CvMna5Ovpwx
	w/mEfPl1L7S4cyvN1yoGTJ1RYsNxcSer8VVbQWnZneMjlNxdFQinyTXpztBkw+lX68dTmJflspc
	PQdYfrzWCdCie+mXePKvDyS75F/TI0KS7r/3PGyf+RBuzd18naC0d7a8C5+oe2u0Dxojs81y9IU
	yEubNBSSkN1fXrEvbzAO79kEF4KQHhrsNCGPNZQNRjld1I5BEl2ac2Pgm1/2V9434O+62NWSL6A
	XBI/MaJ4Tmojq/PDroX/I+3ZiOjVmE+tjDPtJsX5/V4H4E6Z4LCIL4hNl4UD+UWa090p9RCJASQ
	lxc49FaCLcvt/NybuCWc8vjFRmCnwHmBa5oN
X-Received: by 2002:a05:690c:c509:b0:8a9:bbb5:6bff with SMTP id 00721157ae682-8b1b5d36bffmr19095177b3.47.1793200778545;
        Wed, 28 Oct 2026 08:19:38 -0700 (PDT)
Received: from [10.0.0.48] ([71.69.222.122])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b19e6365b6sm30497897b3.41.2026.10.28.08.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 08:19:37 -0700 (PDT)
Message-ID: <a0e96bea-b2bd-4c7b-ae94-a13c57c86f3f@gmail.com>
Date: Wed, 28 Oct 2026 11:19:36 -0400
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] nvme-tcp: handle TLS control records at connect
 and on receive errors
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@kernel.org>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Martin Belanger <martin.belanger@dell.com>
References: <20261027-nvme-tcp-ctrlrec-fixes-v2-0-9656395ebcf2@gmail.com>
 <auEreAhSYCdGCWvt@kbusch-mbp>
Content-Language: en-US
From: Martin Belanger <martin.nvme.dev@gmail.com>
In-Reply-To: <auEreAhSYCdGCWvt@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_081940_489738_F08959CB 
X-CRM114-Status: UNSURE (   9.20  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/27/26 18:53, Keith Busch wrote:

> Thanks, applied to nvme-7.4.

Hi Keith,

Could you add these tags to "nvme-tcp: start error recovery when
read_sock fails", if nvme-7.4 can still change?

Fixes: be8e82caa685 ("nvme-tcp: enable TLS handshake upcall")
Cc: stable@vger.kernel.org

Since 6.7, a TLS record that is not application data (for example a
KeyUpdate) makes the queue stall until a command times out. This patch
makes the queue reconnect at once. It applies cleanly to 6.12 and 6.18.

Thanks,
Martin


