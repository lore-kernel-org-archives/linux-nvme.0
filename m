Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2954C32796
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Aug 2022 11:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Na1NAllN7g9WsTtgis0LWpixD7V6CN7QvtBsKELlHgs=; b=zSQJl7OCdCEnUe9w3bi63Wkbs0
	hDGIvGSWQzMqb6ypcuHujYf+ts09FziwC4LFyudPCt6+zWNvu/X/QUQGqgVtwbdALlfYl2WHPczSL
	1T3y1zUA5PJ/uL0NJxOnKGKOkfD2ZC2Iq+xfXpCqH3SqVXTjIXHhbgKiWHHxQ438uwFHTpv8iC8vD
	2G4yjKeR6qgdefm0sOhYCAd49cHadsceI0mbTvaU8wlg25MGG8NDbszNuTzb2HQR8OyiFw/Udv3H0
	63YXvfjRc00Q+MHL4OhXWr4km4R1EKswo1mSiL1rR4pHsfjio8GDxvaw1R22rvXQoATxWNCIiz5PM
	oSx9elfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQp1F-00CdSJ-4S; Wed, 24 Aug 2022 11:58:01 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQp1B-00CdP6-Og
	for linux-nvme@lists.infradead.org; Wed, 24 Aug 2022 11:57:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1661342274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Na1NAllN7g9WsTtgis0LWpixD7V6CN7QvtBsKELlHgs=;
	b=fAnY4ixRd5kI5+lKlrW3h3WhYXHENrEaXTMWusg8TY6KzkuasX19ZwYYppOjCDeDR0Bds5
	F6JNFBypeBq7zvV6QFzRkJXwSZ6EsVrgo0TV037imjB/C3KVDmPGqaQfMtKXETBslB0q37
	OoyEfVe1aXdRDBxDz3yfGH1nTzx9bn8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-210-V_A8IhFmNC6A-3n--IxSSQ-1; Wed, 24 Aug 2022 07:57:53 -0400
X-MC-Unique: V_A8IhFmNC6A-3n--IxSSQ-1
Received: by mail-ej1-f70.google.com with SMTP id qw34-20020a1709066a2200b00730ca5a94bfso5062223ejc.3
        for <linux-nvme@lists.infradead.org>; Wed, 24 Aug 2022 04:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Na1NAllN7g9WsTtgis0LWpixD7V6CN7QvtBsKELlHgs=;
        b=bGcEMhFKBtCm4NSLHcx0HMMcyhzY4k+SNlDOeu+q14brm0nWktzdTHtH416ZKv94b6
         CpnuXSrApMOhNi/JYqOU2rOrNt9AAzkzVhz/bLUSg0fX26eRmLYR2Gketo5AenAb1Hh3
         ORJ2f86FfcXwMz6GF/0kNED/chu0MBZ2GJj3XeLIFwdQjo5QThmg9TkhakiIyQ15qiGx
         6nDgJIBUSxwBKe8zZPwUkGnSqclzxjYLW/wZGCSaAN2hljSoVgEYDIZExRihnEMyKUyT
         LTKWQrFv6TCzf/TifTZxqsnf62r06DiWhHyHAX4Et0+x1031ff8Z/g147yBLQITKhvJM
         CKPg==
X-Gm-Message-State: ACgBeo2tb6hrYnnvIcywTDtlzN725QNUkvOEiq7f4ZfpPkVG7B2yCU6S
	5q2lwstSPq918RA5ev8qa0no+RJGcLM/hI7rRbSLUenQc4aMRJ/ohuucLSbZ+ZqyhDSwE0kZwuW
	fxtw4juyPnVZD15psMhrCanRNc8Lwle/Y5xqLWenlSQs=
X-Received: by 2002:a05:6402:28c8:b0:43e:8622:1c21 with SMTP id ef8-20020a05640228c800b0043e86221c21mr7396614edb.135.1661342272019;
        Wed, 24 Aug 2022 04:57:52 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4jPvEye4m2lUB4dQSqFWgK+Xuq1w8dPOJ5ifZNJzsI5smKvGkJ7f1djOG8M8PVbW1GusH/8rLaArFOZHcYOGk=
X-Received: by 2002:a05:6402:28c8:b0:43e:8622:1c21 with SMTP id
 ef8-20020a05640228c800b0043e86221c21mr7396600edb.135.1661342271824; Wed, 24
 Aug 2022 04:57:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220821084754.340585-1-ming.lei@redhat.com>
In-Reply-To: <20220821084754.340585-1-ming.lei@redhat.com>
From: Yi Zhang <yi.zhang@redhat.com>
Date: Wed, 24 Aug 2022 19:57:40 +0800
Message-ID: <CAHj4cs_qurGP0W+3b27BFg0BPfE9bR_VtyEAvn60WNd8vUfh8A@mail.gmail.com>
Subject: Re: [PATCH 0/2] nvme: make NVMe freeze API reliably
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, 
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>, 
	Keith Busch <kbusch@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220824_045757_923227_9D916CE7 
X-CRM114-Status: GOOD (  14.24  )
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

On Sun, Aug 21, 2022 at 4:48 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> Hello,
>
> The 1st patch is from Keith, which makes NVMe freeze APIs more reliably.
>
> The 2nd patch removes nvme_wait_freeze() from nvme-pci's nvme_reset_work().
>
> Yi, please test and see if the issue you reported in [1] can be fixed.

Hi Ming
The issue cannot be reproduced now after applying the two patch, feel
free to add
Tested-by: Yi Zhang <yi.zhang@redhat.com>


>
> [1] https://lore.kernel.org/linux-block/CAHj4cs--KPTAGP=jj+7KMe=arDv=HeGeOgs1T8vbusyk=EjXow@mail.gmail.com/#r
>
> Keith Busch (1):
>   nvme: make NVMe freeze API reliably
>
> Ming Lei (1):
>   nvme-pci: don't wait freeze during resetting
>
>  drivers/nvme/host/core.c | 16 +++++++++++++---
>  drivers/nvme/host/nvme.h |  1 +
>  drivers/nvme/host/pci.c  |  1 -
>  3 files changed, 14 insertions(+), 4 deletions(-)
>
> --
> 2.31.1
>


-- 
Best Regards,
  Yi Zhang


