Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3387C35FFA
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Mar 2025 21:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7ZZnr8Peg4sgkDN5O2NmMXhC1AaZb9dF39U9SKehLEg=; b=UFaljCxC93FT2kSMX9wMQAaxuE
	78WVIrJ+EHBBpH8sBY8AkXV0FAlDCMG9o4u9F3NMDgCgZ5t7mSKOVRSVGCf7SrdCVFOoq/0IgLT/l
	d8RIXcjnAJr5YXQu1/5IsKlyHWOq5D7GwCUhZuvZtVe+MOtjMaxUeBc3H7740lZqULlMbOZ/k2d7W
	ERW0fXJEB6YBLtzSClfuKo0uwchV9xIJoptRIfSd26AmT0KzIlZ5T6kbAoWkGS3pCHH2+45RjxQQF
	7paeRORnvE7Ri1ZSu3ql7UT6FCeSSZ2MMNQaiC89PMrql0luFGsscrhZixlZhf7Rlt6qSDTlhFL9f
	TbRzuCSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tv12b-0000000A9qr-2Tql;
	Wed, 19 Mar 2025 21:33:33 +0000
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tv12Z-0000000A9q0-1bl2
	for linux-nvme@lists.infradead.org;
	Wed, 19 Mar 2025 21:33:32 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so500015e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 19 Mar 2025 14:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742420009; x=1743024809; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZZnr8Peg4sgkDN5O2NmMXhC1AaZb9dF39U9SKehLEg=;
        b=KrdHO3++kjoXW4RvTqApuWrp3BxpvNT2n0M/zFVpgIatbDd5r2Md39s8R+gSyOpFgC
         n+a/5DwTax4BSsbCmWBKMIhrH35MINs/rtiUvJtRG0tmYv0Pf9hUK40tNyvYpeTDgBTs
         xvsdbUPnLYbnIDLDSgHPr2VL/2YcqcuEDFHfKf1gDshSN6jV1WSDivE5fC8+59JeDgx3
         TsYaJw6T6lfN/Z9QXLz9I8Hz4cnH0P7NB8fn9xqY7mowwu84M85uWeXWTWRrrGC08r5q
         9Z7nIkXR6SOAES/YGbFOskQmOvvSpzXjQTLiUGQ+ncZOwEdpNALDIZhvEp/u5DfO9gy+
         G28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742420009; x=1743024809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZZnr8Peg4sgkDN5O2NmMXhC1AaZb9dF39U9SKehLEg=;
        b=I4Qqca1z8P2H25HXZ7/z7B+sauk549UHe5GocfPtDqVoZ39bHvWUJwWyXTwLGPNyqm
         0JP0zlBt50gvYkcpwY9vOK07qRY1+nV99Xv/MMZ66rzmOfw/F7fVFvyRR0lQ/JseQ1cv
         0wEB9OcVl4OwM9ll9AA8fTGM4QtmhVyYr8PdXuPB56GOiQAkCwvwf1ocbMhQ8Lbs6KAT
         bVLNoqI5Ftiooy2P8bEfJXaFFFKY6QmXu7PXVEbb91+KkLIcYwGO21GdhJLH8UmYyGXB
         q9Xm11go16uwWXt31nFCL2DG2tTBf2DcQWnOxUgc7p71EzgVj45K1iQzoJIfIqDhNLD6
         YXDA==
X-Forwarded-Encrypted: i=1; AJvYcCVQjgvfBV6S62anmXNxMhj39a6beY70PHAbZ5E1baJpLLbAvD3cr19wp/xdD9EGXx868PQGurXQmdNf@lists.infradead.org
X-Gm-Message-State: AOJu0Yxt7Wyumn2hffdEqm6175Zl7lmZ0qWYHTe7PVPHXuaTVrsjcBez
	XALOVbnVyTdXFZrDn71myXSw32Vl6/g4zA9rklaoff9NhJefJDZP
X-Gm-Gg: ASbGncvwwLqUUmqhyDoTT+bulGtNZ4+L+v/geE+YSH4qFkUlewcCTsaK3DuTbfVUtON
	FrzvrZ2Z1ESfDDkl+Kiqrl9FTrycp3Ldb665mM8lb+iHjKR+ImP1sqgnAOzEYwQ1oZBfKJDju5Y
	bJb/khr6Hd54FDoJbCzMIk5dNczQTBE91UKddZR2nq3WJ++TRgZlKem00y17uQx7X6m5pY+dvSp
	/nnYldHWa0/sXbeElNYoX5wfsSymI/MUi0lyYcFxw3+fPMZ7mOrw/EclIliI9RVykpALQSl6jx1
	Uh3LXQeLEUyXmSVISRw0QHp+0lKdHkFuDSSih5KUxc8EKdkdJ3bmvPaA6W+k91BvGNOtAOjET5U
	i62m/CkA=
X-Google-Smtp-Source: AGHT+IFOk6grmlPeOiStRfVkidnxaMQXz4SpvB5TFBLqf7uN6Kx1t4fNnlWxPwuptc0lhMR2/6CPfw==
X-Received: by 2002:a05:600c:ac1:b0:43d:49eb:963f with SMTP id 5b1f17b1804b1-43d49eb982cmr2544855e9.24.1742420009217;
        Wed, 19 Mar 2025 14:33:29 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f47ba7sm29093165e9.16.2025.03.19.14.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:33:28 -0700 (PDT)
Date: Wed, 19 Mar 2025 21:33:27 +0000
From: David Laight <david.laight.linux@gmail.com>
To: <shao.mingyin@zte.com.cn>
Cc: <hch@lst.de>, <sagi@grimberg.me>, <kch@nvidia.com>,
 <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <yang.tao172@zte.com.cn>, <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>
Subject: Re: [PATCH] nvme: replace max(a, min(b, c)) by clamp(b, a, c)
Message-ID: <20250319213327.2bf94bc1@pumpkin>
In-Reply-To: <20250319210032.5d442b0c@pumpkin>
References: <20250317153909901uOL4saBkASEN9kOmQXDoP@zte.com.cn>
	<20250319210032.5d442b0c@pumpkin>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_143331_425113_B1EB5776 
X-CRM114-Status: GOOD (  19.02  )
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

On Wed, 19 Mar 2025 21:00:32 +0000
David Laight <david.laight.linux@gmail.com> wrote:

> On Mon, 17 Mar 2025 15:39:09 +0800 (CST)
> <shao.mingyin@zte.com.cn> wrote:
> 
> > From: LiHaoran <li.haoran7@zte.com.cn>
> > 
> > This patch replaces max(a, min(b, c)) by clamp(b, a, c) in the nvme
> > driver. This improves the readability.
> > 
> > Signed-off-by: LiHaoran <li.haoran7@zte.com.cn>
> > Cc: ShaoMingyin <shao.mingyin@zte.com.cn>
> > ---
> >  drivers/nvme/target/nvmet.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> > index fcf4f460dc9a..30804b0ca66e 100644
> > --- a/drivers/nvme/target/nvmet.h
> > +++ b/drivers/nvme/target/nvmet.h
> > @@ -819,7 +819,7 @@ static inline u8 nvmet_cc_iocqes(u32 cc)
> >  /* Convert a 32-bit number to a 16-bit 0's based number */
> >  static inline __le16 to0based(u32 a)
> >  {
> > -	return cpu_to_le16(max(1U, min(1U << 16, a)) - 1);
> > +	return cpu_to_le16(clamp(1U << 16, 1U, a) - 1);  
> 
> Swap the arguments into a sane order - clamp(a, 1, 1 << 16)

To clarify further it is clamp(val, lo, hi) and is only well defined if 'lo <= hi'.
In particular the order of the comparisons is not defined.
It might be val > hi ? hi : val < lo ? lo : val.
Which won't give the value you expect when 'a' is zero.

> 
> 	David
> 
> >  }
> > 
> >  static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)  
> 


