Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1CED59D63
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2024 19:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J18SmnFQeamdNEYCZNavvZbO2fNT+YnPrW1SuN+Oklo=; b=j+1K1983jaIjbHAN1FGPKSA3dT
	JoKTQUffR3pgASxclGStmUQk5QSy61NkkucK8nNkcpA2r3wbZfxyq2o7V8GF+I7o8E1Bgib1QSeIj
	8MWq9F4Z62geU2rEu8y58YY4kB0ImZtJm4YlJgeIQQ1RE4rOCUXwn6vV5SfkR6gRujU1IrQPZglC6
	P4zDshHwC6TLaKzc4p7BJFdLRq5PyJi0Gz1wPirGDS22eKEhkmbXErOnWcZgdwKSqCJXzY7ILJHM0
	/ygRX6mrUIpQggE2YrdmlNfmLVAWGhovfm6oV85wrXhC6UybME69PDYuXAIabPnUt7H/QEyEC99gz
	CCFr4I+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFesr-00000008yVY-0dO0;
	Mon, 25 Nov 2024 19:36:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFeso-00000008yUy-1Ksg
	for linux-nvme@lists.infradead.org;
	Mon, 25 Nov 2024 19:36:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732563389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J18SmnFQeamdNEYCZNavvZbO2fNT+YnPrW1SuN+Oklo=;
	b=AIgs/kV3EsqeehmAlPPlpxEJlQBNbTbWmkpUS1Ldc5d5ZyzyCZL8vdQuz2UdGclztns+OP
	2kkCIGtUyhkNs3c1fgQfCAPR78j3NN+l1Nt82hxiYt0rVLCT1E31RrmIga2PKSUXsGgAXh
	N+xDUMT5/qD0LQDAFjJN09CC2NtWcvE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-EMis5Zp6NyqcRnYjPUYDvA-1; Mon, 25 Nov 2024 14:36:27 -0500
X-MC-Unique: EMis5Zp6NyqcRnYjPUYDvA-1
X-Mimecast-MFC-AGG-ID: EMis5Zp6NyqcRnYjPUYDvA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434996c1aa7so15408405e9.2
        for <linux-nvme@lists.infradead.org>; Mon, 25 Nov 2024 11:36:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732563386; x=1733168186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J18SmnFQeamdNEYCZNavvZbO2fNT+YnPrW1SuN+Oklo=;
        b=l5YCvKDZ3m3cjkXKEpwgooVUUNAXsZMtHreRAZg3AHHWwphxfWzv1ftDaydvGePcbn
         +JhwXHAkbJyVlSLWVIWx6TIshL5upjwsuyXhza1VQueCabkN4PcVwCrjpuCojys1Z7tO
         emIuCTUy7E9uDxBggT3ujARmocwWCu2KRI+sgznvVhGiRbkYyJ0A1dxNtJrFh7W5uTqH
         Yx3n1ZYmXSwWGtiUgo6BLDl1JwKc12QDdwv3rsnLSQAv/Cat70m+o0JOuSVa00xPA2nM
         R0QVkasPyfybOXP7OgCHmdY5xsN1liaVckX3iH9/xMkTqgsDSc7hCt2ZnXaBCyYCUbCa
         HsZg==
X-Forwarded-Encrypted: i=1; AJvYcCVhhwUmAlWSvpq2xmMM+H77rWM6NxoMvQe14PbHvAPEvfE9QE5B2+wQARDIOZ3KtlPpsivuE+CbPtw/@lists.infradead.org
X-Gm-Message-State: AOJu0YzsVChFpFn56o9j+1Ic5rraMq8j7lzlZnBTzSEMO9SFh8m9o5Lo
	vlYfVpEUSUBhIQh9kJX2M50JMwAnmgVMZGkqB1x+KOCufmdD3dD8p7Kt71Jh36nUDjWszsq2pzC
	uzg4LdtbYT5lJ2j7m8Zvrb4lggx/2htym220aR8IvjGbiLTCcomJCGgZvPwqjVtACF4LVvbr7K5
	tHcjs9O74fAa2dzjzH2WYDKRU+wcPTQkpteMdHIUI=
X-Gm-Gg: ASbGncvAbK38gnPjx0vp/3e+bFmZOrZVmu4AnE8gzyfUaDuAW8aP4NB2LT0COCqOX5C
	jcQUL9BBPuS+40nSaLxB+4u1zx2+sC34D
X-Received: by 2002:a5d:5f8f:0:b0:37d:5173:7a54 with SMTP id ffacd0b85a97d-38260bdfa48mr13890434f8f.52.1732563386450;
        Mon, 25 Nov 2024 11:36:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+jZ/waN7tbH2hztjQQrTx6SsRw9sDWTjtxopfhtZsxswPOGXKdXVZv2vwFIZR8bLMftrPbjHzq6wOyJLyF+U=
X-Received: by 2002:a5d:5f8f:0:b0:37d:5173:7a54 with SMTP id
 ffacd0b85a97d-38260bdfa48mr13890419f8f.52.1732563386136; Mon, 25 Nov 2024
 11:36:26 -0800 (PST)
MIME-Version: 1.0
References: <20241125162904.7326-1-bgurney@redhat.com> <7a220428-59fb-4b2a-8d67-ecbe40cba037@acm.org>
 <CAHhmqcSwxbvySBdb_mWhOXZBfiXZOv-frD_5bkvhJhs8rnO=7g@mail.gmail.com> <a6d7f0e0-76e3-424d-8e28-93214a6dce6e@acm.org>
In-Reply-To: <a6d7f0e0-76e3-424d-8e28-93214a6dce6e@acm.org>
From: Bryan Gurney <bgurney@redhat.com>
Date: Mon, 25 Nov 2024 14:36:15 -0500
Message-ID: <CAHhmqcSEiLXe+15UnEQT2mNUuvw3Ykq_PRDtCFUA1iCs=q-RUw@mail.gmail.com>
Subject: Re: [PATCH blktests] nvme/039: check for sector size of test device
To: Bart Van Assche <bvanassche@acm.org>
Cc: shinichiro.kawasaki@wdc.com, linux-nvme@lists.infradead.org, 
	alan.adamson@oracle.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yScW7uWdZ6lxfsI4NpTn9Rqnny6Ink_bRTqragd2YmU_1732563386
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241125_113630_424670_9BB59BCD 
X-CRM114-Status: GOOD (  10.64  )
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

On Mon, Nov 25, 2024 at 2:17=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 11/25/24 10:27 AM, Bryan Gurney wrote:
> > Yes, I can do that.  Does "LB_SZ" work?
>
> That sounds good to me :-)
>
> Thanks,
>
> Bart.
>

OK; I'll send a v2 patch with an updated description.


Thanks,

Bryan


