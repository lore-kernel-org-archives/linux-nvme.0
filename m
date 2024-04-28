Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF541C4345F
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Apr 2024 10:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oAUDl2EQOQQL16rvtcMFG+TGjH0r2wEnOekpaWH5GNc=; b=KNsYmV9aWvQE2hjkaU0CABCe6u
	FFGyeUR8rdqAFkvSsCRFL2j9tPhphQqzX9OO2DxAf2loXU+PuY6egILIu1MWMwORoo1ihvUVASox0
	e5+omkB96adYWIhFNMVZrIGjG80qOO6ONii7/uzv/nQXS4ToPXMKrVmyJRgIkT1K8CUPtXHnLyO0m
	ckNESkMj9p+ltSqZaDGjbge3S+Ha1ktwYFkBb899H47IWY0v9YASaN2KNEeK/XNEsr7ksAI5X29Rw
	dHlrXpQNoR8+CArdeHMAK2QkQMVGXQ2y5WekQZSuSSyou6LXHKd4PQhZSxXDYkYbCJiNfHaGDzniV
	0WsyTiyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s11j1-0000000HL6g-0VqW;
	Sun, 28 Apr 2024 10:25:39 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s11iy-0000000HL67-1ACn
	for linux-nvme@lists.infradead.org;
	Sun, 28 Apr 2024 10:25:38 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6f30f69a958so3100185b3a.1
        for <linux-nvme@lists.infradead.org>; Sun, 28 Apr 2024 03:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1714299933; x=1714904733; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAUDl2EQOQQL16rvtcMFG+TGjH0r2wEnOekpaWH5GNc=;
        b=AoBdcfMxtFfsvgBetWp3edNs6Q8oJfKqZmFB1swYnpGGtcoZd1Rk/K2xTLuUjrxZzv
         uNUgm6VGXmH87YZxVQxp1L9oJueikyp6OFp1M0oWxzMw0/8rV5Zo/hWy6n/MXIfB8yfV
         Ur0JIJ3HowlMZl5oyqgMXDc7XwwJtH5E4tYGg94jbSa5TuY6l/cASN1jpxr3X3Que66s
         gZ8xS8Hdk/DdVMIPVHHdBEPLuYZL9QTIR83OphGpoMeW7lu8nBXerOCLl1pWcMIcV/Ei
         36ki2c7Aj5FTLklnCrV2GnDNZIGDTkMK9JvBYhAS/DZw9YkLdTybMPptcVUQPkDAAQ7P
         0CSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714299933; x=1714904733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAUDl2EQOQQL16rvtcMFG+TGjH0r2wEnOekpaWH5GNc=;
        b=w9371d00YHMQarp3IjkewrajB00TJ20NofN0fPBZjBd6itIMNRn5p0HbvAQ4M+WWOS
         UNM1cS5urWwRFaMzgJHDa2vD2j7f0PVwp2Ks8jZZc4i6gjalaebeWscWpMMeDh0sr5MN
         U2pbW32d8O6/FvUTi25foIu0HmLZB16AvyE5rnQrur5QH1hZPOwRA1cJYXggkJYnE71E
         ocrV1H7FD/q7mXfwGOwS+fP2iXA4bNEH6ggJFxvchfHVN5gxzeuoDZUT2bx3Y81s4nkE
         SE2KoT/9/Jtk93nDwtjULiNa5LrLzly07KStHL1U+pl9HyF7mtOPSIqmMOEMRLJ5zQ75
         2LYw==
X-Forwarded-Encrypted: i=1; AJvYcCWB7cyXIJK4efpPA3XVExGwfUKHOISetLwSVAWQR56Bcq+Og3WSN2YoUkhgWxuqMF6m1/B8xI2aSXx4EuQffqfn023le+y0xi/9HZoMCSo=
X-Gm-Message-State: AOJu0Yws7U6ueXpDJJh8MXhtL1AZNz4JqBxn3vV0bS4iwyoJMOaqiAQX
	0EKWgiKE1TKX3sH+n3+UMFSlwu2RD7nch1NEBQlPDKc7h684epsJ1Ywufa8Lk8g=
X-Google-Smtp-Source: AGHT+IE2lardqMKGHkiv5DcqtQwvACm2Pn82KmgG+STCOsw2geLTwrgTrRGeg90NVB5ebwqXxmJ46A==
X-Received: by 2002:a05:6a00:22c1:b0:6ec:fc71:3be2 with SMTP id f1-20020a056a0022c100b006ecfc713be2mr9863100pfj.21.1714299933641;
        Sun, 28 Apr 2024 03:25:33 -0700 (PDT)
Received: from C02FRH0UMD6M.cn.corp.seagroup.com ([143.92.118.30])
        by smtp.gmail.com with ESMTPSA id f19-20020a056a00229300b006ecf00ecfe2sm18028894pfe.12.2024.04.28.03.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 03:25:33 -0700 (PDT)
From: kwb <wangbing.kuang@shopee.com>
To: sagi@grimberg.me
Cc: axboe@fb.com,
	chunguang.xu@shopee.com,
	hch@lst.de,
	james.smart@broadcom.com,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	wangbing.kuang@shopee.com
Subject: Re: [Bug Report] nvme connect deadlock in allocating tag
Date: Sun, 28 Apr 2024 18:25:27 +0800
Message-Id: <20240428102527.37462-1-wangbing.kuang@shopee.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <d200fc7c-c781-49f1-8277-bdb5d537b1f4@grimberg.me>
References: <d200fc7c-c781-49f1-8277-bdb5d537b1f4@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240428_032536_410805_64CCA524 
X-CRM114-Status: GOOD (  13.26  )
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

>On 28/04/2024 12:16, Wangbing Kuang wrote:
>> "The error_recovery work should unquiesce the admin_q, which should fail
>> fast all pending admin commands,
>> so it is unclear to me how the connect process gets stuck."
>> I think the reason is: the command can be unquiesce but the tag cannot be
>> return until command success.
>
>The error recovery also cancels all pending requests. See 
>nvme_cancel_admin_tagset

nvme_cancel_admin_tagset can cancel requests before stop admin queue, but 
cannot cancel requests before next reconnect time.
The time line is:
recover failed(we can reproduce by hang io for more time) 
-> reconnect delay 
-> multi nvme list issue(used up tagset) 
-> reconnect start(wait for tag when call nvme_enabel_ctrl and nvme_wait_ready)


>>
>> "What is step (2) - make nvme io timeout to recover the connection?"
>> I use spdk-nvmf-target for backend.  It is easy to set read/write
>> nvmf-target io  hang and unhang.  So I just set the io hang for over 30
>> seconds, then trigger linux-nvmf-host trigger io timeout event. then io
>> timeout will trigger connection recover.
>> by the way, I use multipath=0
>
>Interesting, does this happen with multipath=Y ?
>I didn't expect people to be using multipath=0 for fabrics in the past few
>years.

No certain, I did not test on multipath=Y.We choose multipath=0 cos less code and we need only one path

>>
>> "Is this reproducing with upstream nvme? or is this some distro kernel
>> where this happens?"
>> it is reproduced in a kernel based from v5.15, but I think this is common
>> error.
>
>It would be beneficial to verify this.

ok, test need more time, but we can first verify it only in v5.15.

>Do you have the below patch applied?
>de105068fead ("nvme: fix reconnection fail due to reserved tag allocation")

yes, my modification is inspired from the commit. Chungguang.xu is my coleague

