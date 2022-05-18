Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50899C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 13:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cyJx2Ikk3M6UREufrh2Jxx8zfYV2z4VljnQeZDclXoY=; b=tfz/3lXd03aRyjLc/8KBf7A2E9
	nS9xrveF3lDgQXi1rqDXBWFpYCiRa51Dp3LZnZfVsQXDH5Eh/yDfexkGJtHSkFcS693OWKRKGMcur
	bxhbLG03UMUtqOWHL267EeTsmRD9gh3SRPKmf8hT0NzuGNPEkijDkDkFJOpweezvSeVSWrNEvSIvQ
	fMQ/3KgcxBdZIs1Y50OVoWEGYUL5pmZXho9crePND9zgdvconc6UtPkmucGNJu777yc8/lni0yM4g
	o/ZI3XT3pYAF671OcKTOcknLTROWaCypG06YdqDUyQMpQumAl6YVUZHjb4s3ytNLMfocoE7aiU8G8
	QSkdlsYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrJii-002JAY-Q8; Wed, 18 May 2022 13:28:08 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrJif-002J91-E3
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 13:28:06 +0000
Received: by mail-pj1-x1032.google.com with SMTP id
 fw21-20020a17090b129500b001df9f62edd6so2383069pjb.0
 for <linux-nvme@lists.infradead.org>; Wed, 18 May 2022 06:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=cyJx2Ikk3M6UREufrh2Jxx8zfYV2z4VljnQeZDclXoY=;
 b=nAIZWcCQB0vEb9Hi5ushwVJZSD3o0Tc6//fRfTNV7FBk5tCIzKAoqjzGPrE1mdIWXY
 DQTe3O40KH/Ja4N36vW17qmplhql2M75ZNPepdcNiNnN4Pauuhu0I+p704bP+5jPtY7G
 kI3kj70JEr2G6C4P2Z5epOLsdSSX4B6UKyn+f2o6EYBIE/F//87hCW6GRqSjlqGd2mSN
 RuzZDH/hurmV0y++ddqDJ4eGDDVbtqhplvDFcFS3wTLLz9GFyT3YT2/OD7FdRaKbRLbD
 TVTerhPsWMEDIKL42XkFCDljIQ84D1h96PsHD19F6YTrxNsarsxVo577uAsEnTTVYOQu
 M0sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=cyJx2Ikk3M6UREufrh2Jxx8zfYV2z4VljnQeZDclXoY=;
 b=Pvoz1Bxdipys1DKZCAWqrMwlMtuNRIh7HCyOchKqdwUZvEcnu8yPwFqnzucI3MZEtP
 BTvIUmsktmGL2NN8/s1dthu4VgvblPjfUKjJaycRb9BnsDLvS41MK6PwQcXGEDhJjOZm
 2Gwz0uOLmBIZCBxEF6FR3KOD9Q+Hq54V087MYsH4p1IpJ+jJbDD09Ixqake5Y/mhn64o
 i8EnJE1HyRcgt8P8LlDbEDO5iXsKf4hyMVK4bEBkmLE9gOzO94K6JprowcTO3nm5nygL
 iknli6GPP4YmWufud9+YCTFDutqKawuW6Tjg0+yAk+Lsa3+b1AAK6Ky/AmX+noohllqw
 kYxg==
X-Gm-Message-State: AOAM533WUAy5T+9hA6TCL/xZABwr5SaiLaRKM1Ul+bGBRa8GXrI/46wb
 3kts6lEJPHAfGSvkzY/Nn3Jh
X-Google-Smtp-Source: ABdhPJzB+pOxRPGTV08iwOjpsuVMYv3p58e06J814Q36NWj7SUgbEYF+KcxLnJLZX577FAOHqLDTdQ==
X-Received: by 2002:a17:90b:50b:b0:1dc:a0b1:c783 with SMTP id
 r11-20020a17090b050b00b001dca0b1c783mr42309190pjz.49.1652880484629; 
 Wed, 18 May 2022 06:28:04 -0700 (PDT)
Received: from thinkpad ([117.217.181.192]) by smtp.gmail.com with ESMTPSA id
 bf7-20020a170902b90700b0015f2e3e495asm1653407plb.239.2022.05.18.06.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 May 2022 06:28:04 -0700 (PDT)
Date: Wed, 18 May 2022 18:57:57 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Christoph Hellwig <hch@lst.de>
Cc: bhelgaas@google.com, lorenzo.pieralisi@arm.com, kbusch@kernel.org,
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 svarbanov@mm-sol.com, bjorn.andersson@linaro.org, axboe@fb.com,
 quic_vbadigan@quicinc.com, quic_krichai@quicinc.com,
 quic_nitirawa@quicinc.com, vidyas@nvidia.com, sagi@grimberg.me,
 linux-pm@vger.kernel.org, rafael@kernel.org,
 Prasad Malisetty <quic_pmaliset@quicinc.com>
Subject: Re: [PATCH v2 3/3] PCI: qcom: Add system PM support
Message-ID: <20220518132757.GC4791@thinkpad>
References: <20220518131913.26974-1-manivannan.sadhasivam@linaro.org>
 <20220518131913.26974-4-manivannan.sadhasivam@linaro.org>
 <20220518132358.GA26902@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220518132358.GA26902@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_062805_586614_848B074B 
X-CRM114-Status: GOOD (  17.16  )
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

On Wed, May 18, 2022 at 03:23:58PM +0200, Christoph Hellwig wrote:
> On Wed, May 18, 2022 at 06:49:13PM +0530, Manivannan Sadhasivam wrote:
> > From: Prasad Malisetty <quic_pmaliset@quicinc.com>
> > 
> > Add suspend and resume callbacks to handle system suspend and resume in
> > the Qcom PCIe controller driver. When the system suspends, PME turnoff
> > message will be sent to the device and the RC driver will wait for the
> > device to enter L23 Ready state. After that, the PHY will be powered down
> > and clocks/regulators will be disabled.
> 
> So what about just not doing this stupid power disabling to start
> with?  Unlike x86 where we do not have choice due to the BIOS, we
> apparently do here.  And disabling power is the wrong thing to do at
> least for SSDs as it massively increases the wear on the NAND.

That's the requirement the Chromebook based on SC7280 has. I will check
internally and get back.

Thanks,
Mani

-- 
மணிவண்ணன் சதாசிவம்

