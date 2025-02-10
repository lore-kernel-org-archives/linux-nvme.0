Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F260C0219B
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Feb 2025 06:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TDrreukPOYO7oq2sreS0k7npIsPrcaogPlyj/E66n8M=; b=Nf2B6ycFY+zt47XI6juuGq9zG6
	QvkzUUqQtIlME+mZJN3OP+XHGusNXwYHmcPjvKjwhNwX0JYQNQQtUOje7kid2lu8lcWI3TcCwxpr9
	s67LYgBcGiXx/00o5M9U8h+yLy7jDnNvrhi7VkqVD/9K73yQ7nc8NSL+YEUq/SE8wn+M9wuA79yPh
	F1LA7yXqbUKyHoP6IYjxqYb8AJDQlAIF/Wu9Jl+nr+vuFyAuBm4JCH7dZO4VZLLZs26fe4bXyTPBA
	yTFY+lIorE6LRyXrpYbzJKasz1jLt5x4Wjioyo7TNj8E/T0JFTbGl3QUGE+n9l0x+EYnzsIj6tgeW
	MAazmQsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1thNOx-0000000GO2S-273Q;
	Mon, 10 Feb 2025 06:36:15 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1thNOu-0000000GO1p-1Fjr
	for linux-nvme@lists.infradead.org;
	Mon, 10 Feb 2025 06:36:14 +0000
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2f83a8afcbbso6184044a91.1
        for <linux-nvme@lists.infradead.org>; Sun, 09 Feb 2025 22:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739169370; x=1739774170; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TDrreukPOYO7oq2sreS0k7npIsPrcaogPlyj/E66n8M=;
        b=rpIyqZbnrlgoSLnrRSI6cshxkXPZ9JDe4CsKQ82PTr1SuB2a1XDAANa6eBisAk69Tl
         EaQmPXAWDTdFszPhCcdX68kGFXWmeh0Geqy1gUrl4vWgq0798/LTD9NGvOm6xrAnmDeS
         EucTTMtxsZN9OakGL8yNYa98MWC7Y8Rl6rPymaImRY+NK9nRS/3frsYOoNmkAHOg9iVR
         hS6khKmhvY+SJREp0NMZA4TCdBfcR6o0P74cMrppLceA2Ir2eeUhSVVU6jghOV9aAx7z
         k6Opn5LAaKvUUb/u48n0ztOHrfCb26PXGlo1IUfIn3E+NAVD1khWKsXDZpgSJhPfDfMt
         78YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739169370; x=1739774170;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TDrreukPOYO7oq2sreS0k7npIsPrcaogPlyj/E66n8M=;
        b=XHxsEeWW2YvCVs7ooQviDlNxscVcC78lCmB1Uj38WEHyyAJNn7IlDBco42SMBG5d03
         qRvtyET3pvg+nh5XNai2celZX2N8WlBHslTGfSZ9OqD9mnAlWm1Qrmy1qDkunBOGZ3sP
         9iFzcvs17tlnRTfWIFTdUqnlpVB4osORb363LE0GJ4wCfpAs78MKvv2Cx44ab5JvuENS
         9i/0P7ysUnqrXxZ+GL9CHpGRVz7rEBIXjs80IKdhIW2k7noBBA4dzJAIoZSvtBJLHrWU
         Z+ic51afcCa/CDykpmp3Y8Neid03jI6Jvvp5GAKrdwgiZ84XlY2GXRYyt9F1hJSF3BJV
         JNLQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3d8CR6sy0RgVGq7ITJGhwLzvc+np/FsqrPfBaZiaJYEzZb/U5LqiCeAurUOHaKFHkeLfXIHkrhkEn@lists.infradead.org
X-Gm-Message-State: AOJu0YyMTCJ7P6JYqO2THxxiIr/KE8o/ZuWm+ILjIy6PVTdxN8PBr+qu
	LvbBs1QF/lh/KZw099xUZZqye1fsH6bQ8PVxWvUEX97vm95tjxhM512MjDOaTQ==
X-Gm-Gg: ASbGnctHJpKdZPe5VMVRFTnn/U9sNddSCwwPoM/fazl6vXpXQl8zzSekFUlk8Q6JmPw
	OIc1pMkvTs0nwRhxobsgZdS0fCOmCVSxq+uPDn4zH5/f49ZQoAWl7hnmMC0kYNh8GcwTmiypVBE
	m86OG9yWzCq+WGue3GmbYwSYdArAbpwjcSCrA0bPtZpu6smINl78arkwAhrQrBpifDMikFXSFht
	Ijpa47Gdym4+a6a115e4RBs9hsdv1v4pNgwpgLurarToJdAvQoq90lWXmWbEzblJPP75ZFqyRYH
	jGvifSwfLoyDt4SSO8jmi3Pm4v+g
X-Google-Smtp-Source: AGHT+IGXtB2aMLUfrCG09NakGmZSrATPGVKEEt1AiSNhJunaG6YGYbdOydOoySS4xsS3muPtGftcOA==
X-Received: by 2002:a17:90b:3e8a:b0:2fa:2268:1af4 with SMTP id 98e67ed59e1d1-2fa22681b43mr19550522a91.7.1739169370161;
        Sun, 09 Feb 2025 22:36:10 -0800 (PST)
Received: from thinkpad ([220.158.156.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa2a201b9dsm5759427a91.22.2025.02.09.22.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 22:36:09 -0800 (PST)
Date: Mon, 10 Feb 2025 12:06:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, axboe@kernel.dk,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, rafael@kernel.org, ulf.hansson@linaro.org
Subject: Re: [PATCH] nvme-pci: Use NVME_QUIRK_SIMPLE_SUSPEND for Qualcomm
 Snapdragon 8cx Gen 3 platforms
Message-ID: <20250210063605.yp5rkraain5oqxka@thinkpad>
References: <20250126050309.7243-1-manivannan.sadhasivam@linaro.org>
 <20250208185124.GA1120888@bhelgaas>
 <20250210040446.GA2823@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250210040446.GA2823@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250209_223612_340097_7EFB4DAE 
X-CRM114-Status: GOOD (  19.09  )
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

On Mon, Feb 10, 2025 at 05:04:46AM +0100, Christoph Hellwig wrote:
> On Sat, Feb 08, 2025 at 12:51:24PM -0600, Bjorn Helgaas wrote:
> > > +	/*
> > > +	 * Qualcomm Snapdragon 8cx Gen 3 (SC8280XP) platforms doesn't retain
> > > +	 * power to the PCIe bus after entering low power CX power collapse
> > > +	 * state during system suspend. So shutdown the NVMe devices to have a
> > > +	 * working system suspend on these platforms.
> > > +	 */
> > > +	if (dmi_match(DMI_PRODUCT_FAMILY, "SCP_MAKENA") ||
> > > +	    dmi_match(DMI_PRODUCT_FAMILY, "ThinkPad X13s Gen 1"))
> > > +		return NVME_QUIRK_SIMPLE_SUSPEND;
> > 
> > I certainly acknowledge that this is a big problem for users.  At the
> > same time, this seems like a maintenance nightmare of
> > platform-specific hacks scattered through endpoint drivers.
> 
> Yes.  And it's what we stated that we won't do multiple times.

Multiple times? As I stated in the commit message, this quirk is *not* going to
be extended for any Qcom platforms as the rest of them can retain the PCIe power
state during CX Power Collapse.

And we don't need this quirk in any other endpoint drivers as this chipset is
mostly used in Laptop form factors and only the NVMe driver is found to be
causing the issues. Rest of the endpoint drivers (WLAN, Modem) are all coping
with PCIe power going down during system suspend.

> This needs to be taken on in the firmware or at least core PCI/PM
> code.

That would be the end goal. Once that happens, we can revert this patch.
Unfortunately, we need an interim solution to satisfy users.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

