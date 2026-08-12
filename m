Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28A0C5CFDB
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 10:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v1giYEEFDAdDWhpqNCDj5Oim4DUh+IAW8TxGs1lj9Po=; b=BwLg3G753p1GV79zdcX9i2Ip2t
	uVl1znOtJy0bN5UYnxuz0Hjf0eXfbKafXhry0OVVeb+Ul4E/FHN2MvLNVFvrgTNTNBp1w9ZHkPq90
	ak6tfrb8AZeZCZh1COL4fGmGFSQD1eqR7/6CWNZHIV4X6IL6tSYARjFxsfSMoILA7God1oLebLrRr
	lbuEKtXk85g/3ccfuTapZYUHx/2tNr4T8DYOy7OYZxAliGBkOCGeZNSNyK0UzcYFU2Tlg+iNmgRxr
	cMpyP5bOHvfBmUQqbAgHoppMv6exCJB2YFegLDFQoIhlamXKdCzztnPBQpmJ0PR3Vu8PaDrj2PncG
	PGXgqfOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu6c7-0000000FyVT-2Dnq;
	Wed, 12 Aug 2026 10:55:15 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu6c3-0000000FyUs-40Gp
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 10:55:13 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso1191095a91.2
        for <linux-nvme@lists.infradead.org>; Wed, 12 Aug 2026 03:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786532111; x=1787136911; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v1giYEEFDAdDWhpqNCDj5Oim4DUh+IAW8TxGs1lj9Po=;
        b=rD4dfUjaoSc4bYsVFTfyE/bOv9/0Y+ibngBvs/B+HMlj58YxupLs3BEnEW+3NOerrD
         RxP0N+8g24gb+/kTH559BuoqZAtn1npCCQY1VLaYK82dafwRbd84QqVQ/06Tlxwa98xL
         ifofesUNYGyOD2oZzAAmdj3lg3lhGFQ961NN0ZdAKK+CRCUsecO3WYyUf7grRtWTF5HM
         6PitEqRI9dzcUK8yqpx/oTWhxuVq6R6N1NCgrbGkVDaOvF1qz4YFsOIANTXXx6RZVhYu
         q0g6bEqz1QN1rcAkJJcBpQ920atcc8WVTYQjgB/IGkNxq4C1i8+ikoxjbo9cILm1h2c5
         SJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786532111; x=1787136911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v1giYEEFDAdDWhpqNCDj5Oim4DUh+IAW8TxGs1lj9Po=;
        b=pQUx1p1EHvJf8NsQ2mnDsUVQO/BBEMREuRIziq1xEBSWHFaO6m+Lbhl806LJGsZAwp
         mx9H+kxZRacpQ/4iPLwtrQWpsOT1o6tr9hNH4qygrTX56YsevfNiXmVdqaRgGm3JA+ka
         fu+JBPbYPrgIPIIDP0++P0FIy6GHU1o0qZUSsH4a6G8FN6tU3HDF6aDfABudm+3wYMbg
         F5QJv4E1MXuyFGZerfSvfu6RfcMwgghMiz8gJ1Ihqm6I9pywJT1GY435cLUI4sYKOXaZ
         ogePU3N7dVh4FsnvbXloE95OJAWFhDlOGu2mvk4ufDNTapBTVVrmOHa+JWrb1NSBY/rQ
         S/4A==
X-Forwarded-Encrypted: i=1; AHgh+RpdsWBWEONNMYmeLs7H0Jl1X2WwEiJL4T1TjXLgj3qRE/b5SqWMw7Jm38ZIRCargTS2VB20qwZLNl3E@lists.infradead.org
X-Gm-Message-State: AOJu0Yx7fPjVUcDvVRBFY9jN/ycnNGW475Fuz2no+iAhGLAaAqzI/fnR
	dBk4A1AWffdbb4W3qBfbvhplj0ooKu/BDhPOk6hvFBqSaIYm7gvLAs8X
X-Gm-Gg: AR+sD13CwOgv5sPAonTvLexY7Wc5Q5ERH79dYxlYsBl2cWlNqaaNPGMkYE9Hxt7/nhV
	z+Fb4pSoSnvJ7eUB6pqzrWa3FlHgHNQyvvn7Wi/bgJvpuAY3QLsW1lZV92L6/e6CwT4Ehy7Od+c
	mv+dAM59/vxHhh8L/8r/l2XXmxTtldN0Ozaw3RxpI8lc/Hovj52O+/lrX3juiexL8kMc/nBiNb1
	GBYZy8rgzhAEAsuFuIzAltIhR2DU2OmLvZVJjoXSqFTwan2Wv74vciKKGhWzZZAzBFsRSswjdux
	IidgRdx1uIQlUZz8sxA1bxx/H/iItHzdrBIZO5/D0wdlqjDI1JfJmx5zirJuc9LhFZeXn6kgU3z
	KMSnMGsLf/Ggf7ONDFu0HLZS40AGT3sVEIV6bRu6ktDeLoV6/rD8yUObQ9Gjx2wXD4MdeiF8ODP
	oT9i/eJbXKdSUQeaqYgdmI5m4eX25khB73CkbWNTRx1K8Z6xd6CD6/uV4gytGP
X-Received: by 2002:a17:90b:1c91:b0:38e:49c0:75a7 with SMTP id 98e67ed59e1d1-3930125aa9dmr4302769a91.8.1786532110400;
        Wed, 12 Aug 2026 03:55:10 -0700 (PDT)
Received: from ubuntu.. ([219.241.133.184])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f8cffe2csm3215244a91.10.2026.08.12.03.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 03:55:09 -0700 (PDT)
From: Rihyeon Kim <rihyeon8648@gmail.com>
To: kbusch@kernel.org
Cc: hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-fc: fix double free of fabrics options when nvme_add_ctrl() fails
Date: Wed, 12 Aug 2026 19:55:04 +0900
Message-ID: <20260812105504.53711-1-rihyeon8648@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ans_4i0GcU2YAkKl@kbusch-mbp>
References: <ans_4i0GcU2YAkKl@kbusch-mbp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_035511_993135_2C383618 
X-CRM114-Status: GOOD (  11.57  )
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

Hello,

Thanks for the review.

> Can't you move the setting from the "fail_ctrl:" label to the
> "out_put_ctrl:" one instead of duplicating it for both?

Yes.  I had kept both because I was not sure the put inside
nvme_uninit_ctrl() could not be the last one, which would run
nvme_fc_ctrl_free() before out_put_ctrl: cleared the pointer.  As far as
I could tell nvme-tcp and nvme-rdma use the same uninit-then-put ladder,
and testing does not show it either.

I swept fail-nth 1..200 over the connect write with fcloop and failslab:
unpatched hits the report at 17, and with the clear moved all 200 pass,
21 of the injections landing in nvme_alloc_admin_tag_set(), so fail_ctrl:
is covered as well.

It also looks like moving it drops the window where opts is already NULL
while the fabrics sysfs attributes, which do not check it, are still
there.

v2 on the way.

Thanks,
Rihyeon

