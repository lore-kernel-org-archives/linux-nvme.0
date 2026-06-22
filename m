Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DA4CDB46B
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jun 2026 23:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y43m308lCUDYe6SGKx/ogYLuh6nxO1dKPURKI3HejEY=; b=RLmB0FRRz50cRzRgXm1YDN8p71
	DqPS4zvZL5vn9qUYKTWd/byUSIv78FhOOY3T5Y4LtjiLYyuPNfSHzTKfNwgkQieHSPKzS5t/YUKgZ
	h/GZjraLe3ZwXhBmApvh4TTfDG7FzAmHurCclW02Hezuk/12zochQfcsy4onnZq7isRssCwlwDo8j
	dgm61Hz2DtPkAyJkDGxiuA2xi5tU1x7V4g7bzZYymiwfq3ptRfWU66EFFEP46w6aPrxB8Vmn7cyyr
	UsCvoXQnhsBrrffkaDlzVLqkHVJXg7Shms5A16efpwD+ctl+NyJKe/fs2ZA5fPunPqPPg/LXvP176
	xCalW6Vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbnpM-00000005SZV-2Uo4;
	Mon, 22 Jun 2026 23:13:16 +0000
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbnoz-00000005SZ8-042y
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jun 2026 23:13:15 +0000
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-7fd5346b5e2so4154227b3.0
        for <linux-nvme@lists.infradead.org>; Mon, 22 Jun 2026 16:12:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782169971; cv=none;
        d=google.com; s=arc-20260327;
        b=gnAojvG/m/6oKc9puC1M1o0bzyw6c7WZ+eP/ODUSxK9jCj4hIsbfoMvB++GTWrl3u6
         A/73VWBIKizAN7iorOgsbvxcNxRAiL+6YEbc6ewVMUQ1XiEFbLWtfdgfWctUXJcFDHwE
         LwfkH/ztLsmSqF2NneVsOxijpTrjPipE0MTqKXP44oVg6wrTZV+ZXS1RhJiRpC9MC3Wp
         SdtNxXOc44FAcYHEeymoRCx16LqY83jh/30edrFfK2m0cNonp+6oBRqTW2Hk9HkJGsXc
         Dc02KyxlYlWrrMOOdmsNwVId3lxCP6QcI2ZTLhVXXR7SLb6sj71fQ2YpCO8EKZb6jCNr
         yNDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=y43m308lCUDYe6SGKx/ogYLuh6nxO1dKPURKI3HejEY=;
        fh=S41aJCe7WrjM9m9E6rSwDo/aSb4k8q7xalLaReuOFhg=;
        b=kYz5AOwIImxaCek3YwCnpUGJW50ZQSEe4+ItplAKqTF0g0+aY5EwoJGKfHRqWMrpBH
         6APBUgdp7SJUS0aPcS5TaBL8coaQekG29weo5YV+9VGo+9WMjYnkxlvYHtvaso16FY+D
         PuO9imULrTg2c+molieBhvPV77KoK3Uq1JuOV7kbMu8ciAyc6fQkCdBSNC0S3QArJawC
         rfdpw4wdheVW8L3L+Tm9/IvyXkCXBHK4BJ5oiqXZYO4XG3qeUTPtFQSazmMV/e1VD3VW
         Vm2KoyCPTCiD+JekXnMJTwueY5ydSFYIRF63fjaZm99iGPBZdnN51768/41RSWV/6M2y
         eZMg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782169971; x=1782774771; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y43m308lCUDYe6SGKx/ogYLuh6nxO1dKPURKI3HejEY=;
        b=hVVBNdUTjqSz5bijuoeE6slnzlng8SdsF+dF7QZ9/B/pGzahKJaJITd3B0Q0PaunF8
         AFvulNt78j/ZnOf6ogXNSvBJZEtukpby3tBVwJSl5VjQnuFacILwIdIDLs6qEcneLQVL
         h7J204kNPvw/Jt5Q2m1liJvtrGq6+4NHpF3UPFrBNRuV7luEgC4ogehwaYUY4jbu3HZ5
         OB4PWEBtKQH8SnHD16ESATaqi2Vp8sNL5/gL88GUVaWT7p9Hf4gdHzGtiTmtO5lNIbus
         qIQ+dh+YbpDyC9jRcRN8D5Sykjd7hcGKyvFEz8fOD9z1flX4+no7VVkobehZ6IqNhR7F
         ZNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782169971; x=1782774771;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y43m308lCUDYe6SGKx/ogYLuh6nxO1dKPURKI3HejEY=;
        b=B1pDGY8TSt/qF94s1Z4XPiRu+vDvG23IRA1CYVvbS4CycwhSr4l61ocntnpey/kAdD
         9DDLKJyxLwu7cjvLQ/fouUC2x0zqDVW0MtTMynb08KyB/o41JnYTae0ROXSQvwZrHW/y
         cqCk9/FPAKSUml5AhPrplS5WbA3gbK1h1l0w8WHgwPlsxZH8mh363Uwmvv0mMATW3qdZ
         o+Y0WsGK+O1bp/sukteSg/IFf5Lkjb4p+DTAExOkeC3oQsRqwJWLdmUf6iL6HoWLNIEy
         T4sC6yhx6vjR5npfgVAzfdvladRUedKE9+ac6Lf0Vs8j5bvfARTnBh+UG80+KQ6kiUnO
         Mg8g==
X-Forwarded-Encrypted: i=1; AHgh+RplyD3lMmq9XKsuZklId3FZNAiTgiQi6/sjjeLVcYX+SUVho7Ndpl90VJlYn3ZBj71qSsHycGF0bOx5@lists.infradead.org
X-Gm-Message-State: AOJu0YyMNwvEUkof6B5eMtK0JjO/bXooOqNcqtNaBVK7QrhM5JYPaEk7
	Bd+76/5jvje35svBUk2TDfbmoRYiKOohEndM0UPOoys0EoLxptjQlZtgqrRDIDmD+jZmoBxAfB9
	FP5wWYhUf/uROqif30kEUlejEz18KW6s=
X-Gm-Gg: AfdE7ckQvyAVZB7tGwKjXAT7xGpr1I9vR0tfNnckzvmyCLqCGVSGgIU9nQFRcUMkhAH
	wLfMiU8bfNEWa2XyftJT0C3kpeIHOzataFSLia0Vcf0ZXFQEPbMNHg06zhHWR1CHdCT3WKqHvS8
	AaQJssMB5s3I8Y+64KD+TM/i38svDdey1eVzYbmLCvTInNv0vE3W3eW1YKwvlwKA1vR1DvjFvCk
	kGi8QQegIqrjbsmfVn5kp/lJVaGkTr3Nj2SInf7Bpy4/JrlYAmGFEdYatfmYb6xSXuZgDbXCtbv
	YZKH8fSAZA==
X-Received: by 2002:a05:690c:ec2:b0:7b6:7df9:33f6 with SMTP id
 00721157ae682-80670e47f1dmr19414487b3.2.1782169971169; Mon, 22 Jun 2026
 16:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260621135939.2658295-1-zzzccc427@gmail.com> <3ba6ae70-9541-455b-932f-3a44f7a576a3@linux.ibm.com>
In-Reply-To: <3ba6ae70-9541-455b-932f-3a44f7a576a3@linux.ibm.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Tue, 23 Jun 2026 07:12:39 +0800
X-Gm-Features: AVVi8CdhhU1RXgyggcbZkFMM_fVFLzOFxHlhAKIKi9mgYrUeNF3g2S2A3XOYB_s
Message-ID: <CAFRLqsVWp3r5kzNvC9oz5J+EAAQmL6LO+kDcWYos8HOs6Tha=A@mail.gmail.com>
Subject: Re: [PATCH] nvme-rdma: avoid stale device wrapper in remove_one
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Steve Wise <larrystevenwise@gmail.com>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_161253_113306_88E185DA 
X-CRM114-Status: UNSURE (   9.32  )
X-CRM114-Notice: Please train this message.
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

Hi Nilay,

> Then, loop through the ctrl list and compare ctrl->device directly against that
> matching ndev. That would avoid dereferencing ctrl->device->dev while reusing
> the existing kref-based lifetime management for nvme_rdma_device, rather than
> introducing a separate cached ib_device pointer. At the end, we can drop the
> reference to ndev.

Thanks for your review and suggestion, that make sense to me.

I will rework this to avoid adding a cached ib_device field.

Best regards,
Cen Zhang

