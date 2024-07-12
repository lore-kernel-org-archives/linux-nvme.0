Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B36FC2BD09
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Jul 2024 15:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rt88iW4L24gNZ5mfcSmKf+MLZYXAgtP2FGJ8f0TB3k0=; b=dwvJgXvSxvaRWD4caoCwHZL9fL
	aI2fZxOYpNAZ11I8NrGp5pW/s06UxHAH4OH+jYmo2dnlwOBdExHtOb96+lZDX9sn/YD5M7O9Hey9t
	qUWOslw9vGwtBY57YO03PQZAuDAQvHedW5e/njSSI5eQ4Ecwaer7UTwERz34TlbXg+4Gql+PoEIPr
	TQuCeuCe50L2n7DS5tRjfx519WXCas9OlZOmsku1Goa3QqNMinSotw9yaZquiit15npaydaJQZLFs
	42+jX59qPYEMK5MmxaSN8I7NmGTbu/AMyo4mSGGhZ/3RZ7NIiZyHGcAj45lB/L6nt/Zo2nXKYmgad
	tZ42RjbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSHxQ-00000000Tht-2FFS;
	Fri, 12 Jul 2024 15:13:12 +0000
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSHww-00000000TVi-2JHW
	for linux-nvme@lists.infradead.org;
	Fri, 12 Jul 2024 15:12:45 +0000
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-5c66de0c24bso1127911eaf.1
        for <linux-nvme@lists.infradead.org>; Fri, 12 Jul 2024 08:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720797161; x=1721401961; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rt88iW4L24gNZ5mfcSmKf+MLZYXAgtP2FGJ8f0TB3k0=;
        b=dYm3UwyuCIzHdU+crh46LPgjXzAC7AUCe198nnzvJNRdgTMym1tlMSu6TCrAunnXKP
         bxkH/TbA3e9lfF8JsUxl4MmFaqN+zib1z0mKzoh9Pu9H4VlFI5A+W7fSOvskI14gzbc0
         X8WKUT1fpTtDAxah4yntPcm09/7KA4ZxMpBxwzGfODK/OeX0/9z+RROZzAnnQAmF91mW
         bgl/EJN9G6a1oouESbuV3dR6j+DlqgFTCoBKAReDGKkCwWeMkKw+ZTfv+rD/n1i+F7be
         VTwYfhjeXqCRZwb7+xLlqhckidoMNjAUCQmv4Zvkgh52nx7VeEiRnugvEjoyjuGEVWN7
         0fvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720797161; x=1721401961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rt88iW4L24gNZ5mfcSmKf+MLZYXAgtP2FGJ8f0TB3k0=;
        b=XUSK7cjVR8zjQZP0Cv77AGMHVfelvRaDsCquY+sxr7j9bcG/u+7iJNluXmU0jWJpY2
         bnFDiTTksAw5aHviks27D4Bnltsx0TVUexapdyti4wOOUIaS4pXkNcgvl9Mvgr0LGFOM
         9ibqV7cEjEsqdoHeXmWB4MwvN669gU5r+Wd1HUyV7Z9JYfRe/wDcuX03kJmxFduXPtN0
         b/gDa+VGFXIzTuATopMAwxp9PHGoG25Zw7I3rBBg384TYFyvG2UhWZJgsOCFN4hLn8dR
         mlAfNLhfIAUFtQCRdPA3rab3kLKjWE/fz50w8Ph2/RoEiM6UWkGudHseZR81Tqsq+t7p
         QfBg==
X-Forwarded-Encrypted: i=1; AJvYcCVxIthiqHL/Za3YI2z+v/zd71zB95zcxtBN1FZl50sDuPOLgn8jOIC0zFHOPZ3Hi0SKpyNejlsuLIg6maWKM4moClx1mcbpEuHgSqPg9wU=
X-Gm-Message-State: AOJu0YxbxXIITdI99kD1pUYltvovHqt9PHNukHkWGLSYHjG3lzRs2XSP
	/I/o3juOGhkZohShcEvXIUzIsnYgu/Ar2SqAx2zg27Qwn9SgncZCzn1i1wEkBRk=
X-Google-Smtp-Source: AGHT+IFRujCPbv+JGhve8HXrVori+HKTUQ3sHhSn4FFU8PoDISrKc47mDRc08i0zN5Rtsbb7Vo1b8A==
X-Received: by 2002:a05:6871:552:b0:25e:b6d8:5552 with SMTP id 586e51a60fabf-25eb6d8647amr8957294fac.5.1720797160737;
        Fri, 12 Jul 2024 08:12:40 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::17c0])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70374f78d92sm1605651a34.19.2024.07.12.08.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 08:12:40 -0700 (PDT)
Date: Fri, 12 Jul 2024 10:12:38 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Eric Curtin <ecurtin@redhat.com>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nvme: apple: remove some dead code
Message-ID: <08e9da6d-fb31-4b0e-b0f5-318b0ebbf10e@suswa.mountain>
References: <124bbda3-7ccf-4e6b-b30d-7115e1c2620f@stanley.mountain>
 <CAOgh=Fx6hcJdbQpna2JJhnzp=YG_nyg-gpd=ZH7CewudtgDhAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOgh=Fx6hcJdbQpna2JJhnzp=YG_nyg-gpd=ZH7CewudtgDhAA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240712_081242_908500_901544B1 
X-CRM114-Status: GOOD (  20.13  )
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

On Fri, Jul 12, 2024 at 03:29:21PM +0100, Eric Curtin wrote:
> On Fri, 12 Jul 2024 at 15:13, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > platform_get_irq() never returns zero so we can remove his dead code.
> > Checking for zero is a historical artifact from over ten years ago.
> >
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> There's quite a few return paths in platform_get_irq_optional, are we
> sure it can never be zero?
> 
> Not calling out a specific case here, but it's not so clear to me how
> we can guarantee platform_get_irq() is never zero,
> 

The platform_get_irq() function has a comment which describes how the
error handling should work.

I wrote a blog about this:
https://staticthinking.wordpress.com/2023/08/07/writing-a-check-for-zero-irq-error-codes/

TLDR; platform_get_irq() used to return zero on error but it changed
in 2006.  I believe someone told me the historical situation was
actually worse than I described where the error return wasn't always
zero but depended on the arch so sometimes it was -1...  Then after 2006
zero was success for a while because there was some hardware where zero
was a valid IRQ.  But now zero is not a valid IRQ.  I think Linus has
said that zero is a stupid IRQ number and support for that hardware was
removed.  So now it never returns zero and never will again.

There are still some xxxxxxx_get_irq() which return zero on error, and
those cause quite a bit of mixups.  Last year there was even one which
had a comment similar to platform_get_irq() that said to check for
negatives but it returned zero on failure sometimes.  :P

regards,
dan carpenter


