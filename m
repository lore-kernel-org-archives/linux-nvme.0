Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCF1C0219E
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Feb 2025 18:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XkglN50gfuQ6erp2z8Ofp6pXI2FMc5IUlP0T/eiB6Ig=; b=0bS4ween079RYiHxB70VNDdPTp
	yjEWZfVs6qSouf2YM/I2tzju085T3L+CytT9592NkJ1N2O9krEu4itra7mdeecaL94qNUxgHStCKI
	rrlcmlBr6VNm294ABkWup/opTyOFwihOs1uD3+yTi6qm0/d4GTnoZAJrc/xiVEyb0D9P8JnbzKT1f
	rB8zOAJDYIZ9wqNxB10qGndkZQ4qR7j8gsOmBYZzJ3G2fFDilFPmt9IKe4dMH3kI0BY3TmTIFK4Mh
	y+fOa2u9mTTc8eswIhRS+jSnvEQG9yNRtnq/ElEB6SguFexTyw1stD6R1kXwSQ21xQA1BuDzUPaA1
	+bB95QgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tgSmU-0000000AcmT-3wLK;
	Fri, 07 Feb 2025 18:08:46 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tgSkG-0000000AcLX-2vcD
	for linux-nvme@lists.infradead.org;
	Fri, 07 Feb 2025 18:06:29 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-21f50895565so15606915ad.2
        for <linux-nvme@lists.infradead.org>; Fri, 07 Feb 2025 10:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738951588; x=1739556388; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XkglN50gfuQ6erp2z8Ofp6pXI2FMc5IUlP0T/eiB6Ig=;
        b=TRE1gpdD2LPSRlr77QFM8M6C9zd2dEgp23gGtcDowDu1PfDTUesmCxZUhLqCQD8fzx
         Ir3sAsZ2a/KP1OGKcJ8jnV2mLjcPFSuCeihHWEQZpRBAWh4c9yFfjpgWJEvKkjOSLQVh
         CV7/5A5d9gQKiM1XF9pzkstK85zGQnvpIJEgHCh3ypNnxgUcRuhr4Quop9u/LV+/xnD3
         Jhmjaw0yM0VFskdHh+tkMgIzmVJK+TaAlRBPC+FyrXzTbw8K+E5H0o3pdHIeMfJmKvgK
         D6LN/UVSv4WnTRVgKWAduE18OmSRfvh2978w4hFgCFVHb2G9Pdlt/HuE+EgDAEAp4xww
         Hi6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738951588; x=1739556388;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XkglN50gfuQ6erp2z8Ofp6pXI2FMc5IUlP0T/eiB6Ig=;
        b=VdaniA/r2Vsby7jgy/Htv0t2d7aw2CbC8lMIrlvMARq1YlawditUBe7eaDQrxsztdC
         uamo1xOlhYR2b5ugbNe0+pP15YzRZbOhUVNeJSsYbd7lfrSmBzJFnrpU8Ra6+CrssqWI
         2eJa1SFRf0bpN4shkS1ykE7+fK2nzXEbqkaY3q6+uYDFeA7b8tI9mU8H0Wbd/jKvfaoj
         AgwZEsN9529hFrUgp1ZmGl5g5jgtAihaT2UG+BJPY/jthkx7Us6NiBTqjxQt0J5zo3nJ
         LfX6TeqcjgBr6DyfCUaO/PTO6urOJnjFNYFbrCeqRNvMKna/XJP4nhuZfoTEJUlbCO1j
         BTpA==
X-Forwarded-Encrypted: i=1; AJvYcCWmgS/7XJmKhEHBaxSiLRqp4baL4M6vAjSEsX+jERcXDI2J+pDmsz0fiSiFzxg+A9ubKJ5APEWpMaIf@lists.infradead.org
X-Gm-Message-State: AOJu0YxMHkxh8df6kBnfg1nwG9PMBrq1+IHBxbogn6RbMRq6/1udkVEt
	WdVHyyqnpIBXOWDzFsvCmezkCPTTv0iAkxw3XdKV/0u3FAlIBPQJFJxjxt4rRw==
X-Gm-Gg: ASbGncsp4ArmIC72iBLDqGzdBs4P/fC/+2IPNWYWDdpW8I+/hREypWfwuNoAbBwAOaf
	S1Iybg7Lxo7voUTSRuS2cImfIqY8LUbyi3hWf9SAZU9TzC0xU2shSTUBgWL9+YGHdaZx9Fbwm77
	VMgmeoKSkPCvASfULApJxjpPPM75zz9hJYnz0LJxJUlWVcW9eQy0VsVNwBcgCcudjDWh3v7rbSy
	KiSDH9Q6aWLwz9kdFgvanwDG8LSgj0e1igMIhtVpiUm1GtQmTX2ngkh3Ha5lSx7Trx+X5Jv3J6D
	6MZze2LRkWl7qThKfRqjaKMsDQ==
X-Google-Smtp-Source: AGHT+IEGQbMoB6GFj06Ak8dhhWj5Td9SePkG/cyThscF6f8JtfnvZUjmhrcJv2M2U3gusWXIG8uxLg==
X-Received: by 2002:a17:902:d4cd:b0:21f:14e8:e87 with SMTP id d9443c01a7336-21f4e6e87admr72467985ad.26.1738951587987;
        Fri, 07 Feb 2025 10:06:27 -0800 (PST)
Received: from thinkpad ([120.60.76.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51af7b744sm3400169a12.77.2025.02.07.10.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 10:06:27 -0800 (PST)
Date: Fri, 7 Feb 2025 23:36:22 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org, rafael@kernel.org,
	helgaas@kernel.org
Subject: Re: [PATCH] nvme-pci: Use NVME_QUIRK_SIMPLE_SUSPEND for Qualcomm
 Snapdragon 8cx Gen 3 platforms
Message-ID: <20250207180622.dugcctzfbef7sshw@thinkpad>
References: <20250126050309.7243-1-manivannan.sadhasivam@linaro.org>
 <CAPDyKFqfJmpFvNgjj3P3+vmiSooiU4sr=dnVuBfXOijPdcbt-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFqfJmpFvNgjj3P3+vmiSooiU4sr=dnVuBfXOijPdcbt-A@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250207_100628_734995_A78AABF5 
X-CRM114-Status: GOOD (  31.14  )
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

On Tue, Feb 04, 2025 at 05:03:33PM +0100, Ulf Hansson wrote:
> On Sun, 26 Jan 2025 at 06:03, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On these platforms, power to the PCIe bus is not retained if the SoC enters
> > its own deep low power state called, CX power collapse state during system
> > suspend. Once the SoC resumes after going through CX power collapse, all
> > the PCIe bus state will be lost. So the NVMe devices on these platforms
> > won't resume properly, rendering the machines useless until forcefully
> > restarted by the users.
> >
> > To workaround this issue, the PCIe controller driver is keeping a minimal
> > vote on the PCIe-MEM interconnect path in its system suspend callback
> > current currently. While this gives a working system suspend, it also
> > results in increased power consumption during suspend as the SoC never
> > enters its low power state. So with this change, the workaround can finally
> > be removed.
> >
> > Also it should be noted that the actual fix to this issue lies in the
> > PCI/PM core. But currently there is no such fix exist as of now and the
> > consensus to reach it is also taking a lot of time.
> >
> > So use this quirk to allow users to save battery life on these platforms
> > until the PCI/PM core comes up with an API that tells the PCI client
> > drivers when to turn off the devices.
> >
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> FWIW, feel free to add:
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks!

> 
> > ---
> >
> > Hi,
> >
> > I'm sending this patch as there seems to be no consensus so far (as been
> > discussed in this thread [1]) in coming up with a PCI/PM API that tells the
> > client drivers when to safely turn off the devices. Since coming up with these
> > kind of generic APIs are bound to take time (I do intend to pursue), it makes
> > sense to allow these platforms to make use of the existing
> 
> In whatever form you intend to continue to try to move this forward,
> feel free to keep me in the loop. I am interested and will try to
> provide as much feedback as I possibly can.
> 

Sure, will keep you in the loop.

> I can also keep an eye for a conference where we can bring this up
> again, last time we discussed this was in LPC in Richmond 2023, I
> think. It looks like we have some more data for discussion now, but
> let's see how far we can get on LKML.
> 

Ack.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

