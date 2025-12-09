Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51CFBD3B996
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Dec 2025 21:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5JtO+/e6kTnIf7NZZ+Q5LHQ9Py7x/v7ASju/lUvZ3DY=; b=Fej1yClKrzPvHxgJRMpWMLcYI7
	rXCltgjC3ZqmjQ+lssEk3hhAch0qPWvWaZ6o+OBRiUp9eItby2KUNDCDp7KmHskiAdXoCs+1+XFfF
	sZaVDj3PzxCDbxh31mXJ1uj3TA4KmpbmmIkaDvIQHS7wTm+hgVljby5nvtpv61/gaNL+LADhZbyTY
	FV8ZqL+nMldwYTTfBvM5aFMdEyHf8IfY320yMlQqRFDwYvGWcqTf+2wMLnHWbf8w1azvafRjuQtDZ
	AioFMegujdBsFiT1ZPld4iC698oUQbb1kb86FileKxwVgCtDMeAnjWc2nVHAUjKjOU5kpZzOl0PFH
	PD08yttQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vT4tr-0000000EnmY-3NO0;
	Tue, 09 Dec 2025 21:05:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vT4to-0000000Enlm-3YoC
	for linux-nvme@lists.infradead.org;
	Tue, 09 Dec 2025 21:05:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765314331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5JtO+/e6kTnIf7NZZ+Q5LHQ9Py7x/v7ASju/lUvZ3DY=;
	b=WL/IlKEiQ0DMdqIyhy/LxN/Ib5m9XJVxQwAwxUco4Aj4S/eITCX1SnE7cURy0bxufh+4Pr
	sbcpwjLduAsb0o5toGFCIa2RWkRktdb+3qMx6ngPR3YCrOsD365lbWRmyePIn2fVi6gSnx
	fx8apOa0jwSbXA4HrOxEXsRVzEcFsvw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-n9jZxmbPNpiseTzR1SlDuQ-1; Tue, 09 Dec 2025 16:05:29 -0500
X-MC-Unique: n9jZxmbPNpiseTzR1SlDuQ-1
X-Mimecast-MFC-AGG-ID: n9jZxmbPNpiseTzR1SlDuQ_1765314328
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4779ecc3cc8so37544685e9.3
        for <linux-nvme@lists.infradead.org>; Tue, 09 Dec 2025 13:05:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765314328; x=1765919128;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JtO+/e6kTnIf7NZZ+Q5LHQ9Py7x/v7ASju/lUvZ3DY=;
        b=cp0fxuReJ1xNshG8fkk5Ai4MZw1Tbf5UmmJbIfdzh55efdw6VHY+HUI2ZPn8NPJfyU
         IMwNpCQK8iJYWMue2dUXJTVCcnWQ6ZtYi2AYMLkAjUxjIZBrwRJAXhpL9kknfZyCo6+M
         eL3q9Q/luSdUiLIViQbJk0YG8eW61epgWTKj9H8xhp8zBNGRdzm01EzBKRGtBsDKhNn8
         aB025VgxjL6Erw8uvwaD5dGPxNHBNbmiBcYpV2d0OxrOIUKMta7hjJqxeUXaocdvwBKc
         FlgFQoJageTDkRvl8HTyP1pCgWDQJi/JKNrd7Szv5lW68PLceXuywAdDZ3TpuYNWer9T
         Q4yw==
X-Gm-Message-State: AOJu0YwxWrMMM8xl75Xcu9dZ47dyHUQict5XoaQyTRL+Sv84n8e9GnpW
	0R2XfUEbUJPhJgTqIzTpdJbHt2c1ZjIDmg3KNJV7tB5c1pdObAaNlg11pbbWzh1QUYK3vh+/Fsz
	xAHpc5E2WoU6sP9NzOcWuixMhRTdUyd3IMVwRf7BzeMIzDPjFgPgv6LvxuntnQiAiPI5S
X-Gm-Gg: ASbGncsf9dJpK4uiOy5gX0MzlYUU1OU/XGQYUiVfw7rnX3Ykubn/G81B38EsE4Y/xUz
	4wZo8YGpI7XMsLeP4TjSzHPimv9qhjO+foQimdwnVhDcz605bDRyaAZOs4BUsbb1YjD/cFidZV2
	KAFoawAeq1MY5fQir6v+7LuFYmyIq5C7nCTIVwqgnUJ+6DO8zu1eFLmqjKwiunr8iwVEN/5flAj
	E48SdCViIqyAyOjPkdjaJKlkqOghxAvJo6+aRnLDKtMgQNfK3f00gDrb7Nr1Y6GKFjEgcs1vu5O
	55CpSGWj1WuKJ5FwlPqSAjXeyNwSTeY0RaXpyEuywz0XvlUjArYHLVrvnexi6ZKREjgp9VMPeyr
	+k07XET1cns3q5WFQdpYkqd7+dCwCFLGtS1ooBO0LZmCotB5rP8c/zMFocZ0=
X-Received: by 2002:a05:600c:34d1:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-47a83744a33mr2306475e9.2.1765314327658;
        Tue, 09 Dec 2025 13:05:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtCAFhErGwzqpGWe7IpcJT0+41Hr+cUdeizf5PIDHvpAkbhAflBzeSLnGEysOKGluXPZLr/A==
X-Received: by 2002:a05:600c:34d1:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-47a83744a33mr2306225e9.2.1765314327245;
        Tue, 09 Dec 2025 13:05:27 -0800 (PST)
Received: from rh (p200300f6af498100e5be2e2bdb5254b6.dip0.t-ipconnect.de. [2003:f6:af49:8100:e5be:2e2b:db52:54b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a82cb12fbsm10202915e9.0.2025.12.09.13.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 13:05:26 -0800 (PST)
Date: Tue, 9 Dec 2025 22:05:25 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: linux-nvme@lists.infradead.org, iommu@lists.linux.dev, 
    linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-xfs@vger.kernel.org, Jens Axboe <axboe@fb.com>, 
    Christoph Hellwig <hch@lst.de>, Will Deacon <will@kernel.org>, 
    Carlos Maiolino <cem@kernel.org>
Subject: Re: WARNING: drivers/iommu/io-pgtable-arm.c:639
In-Reply-To: <4386e0f7-9e45-41d2-8236-7133d6d00610@arm.com>
Message-ID: <99e12a04-d23f-f9e7-b02e-770e0012a794@redhat.com>
References: <170120f7-dd2c-4d2a-d6fc-ac4c82afefd7@redhat.com> <4386e0f7-9e45-41d2-8236-7133d6d00610@arm.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s5kuhpi7KsrJnLtq362mskybA57PLWrLB9-nkEPnk4o_1765314328
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251209_130532_962736_78AB537E 
X-CRM114-Status: GOOD (  12.99  )
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

On Tue, 9 Dec 2025, Robin Murphy wrote:
> On 2025-12-09 11:43 am, Sebastian Ott wrote:
>>  Hi,
>>
>>  got the following warning after a kernel update on Thurstday, leading to a
>>  panic and fs corruption. I didn't capture the first warning but I'm pretty
>>  sure it was the same. It's reproducible but I didn't bisect since it
>>  borked my fs. The only hint I can give is that v6.18 worked. Is this a
>>  known issue? Anything I should try?
>
> nvme_unmap_data() is attempting to unmap an IOVA that was never mapped, or 
> has already been unmapped by someone else. That's a usage bug.

OK, that's what I suspected - thanks for the confirmation!

I did another repro and tried:

good: 44fc84337b6e Merge tag 'arm64-upstream' of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
bad:  cc25df3e2e22 Merge tag 'for-6.19/block-20251201' of git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux

I'll start bisecting between these 2 - hoping it doesn't fork up my root
fs again...

Thanks,
Sebastian


