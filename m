Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E78D4922E
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Nov 2024 14:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5Kj40amW5IpporSjQ73hgk+ubBMNelSpX7cTHNX0nDY=; b=j+47L/v9QfuqXJEzgv/eTXIJs7
	ObuyUOX5OlMWZurqXvqoDgPY2c2in6FsKmw5K/lSANMaMWPiSLxbGr/F5sbMfN/Nv5uSbKWw9N+dw
	vfUvQlhJttn4mc9VijkYzbFqlufJC/ZQIFNUWNeJ0gaWSNffl1FGTd3LI6Tca5DtgncZiJJGPs0Bb
	Ma2u1uAICInRSI5s+ia3S2s1KXnjVmaEflIol9NW7LpXYGkntLAriE26fxGAEuTbjkUD5g0frG2In
	OaazwFuYyS+/cuRbUM6gMXWCertjQuU1vabaY20wH6EZgWZ0qhS5WqyBylm4uxR8bLcXWHDCRiT4t
	MzzgFl8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tD3Cx-00000009q4u-1D8u;
	Mon, 18 Nov 2024 14:58:31 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tD3Cu-00000009q3D-1zpF
	for linux-nvme@lists.infradead.org;
	Mon, 18 Nov 2024 14:58:29 +0000
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-7e6cbf6cd1dso2861621a12.3
        for <linux-nvme@lists.infradead.org>; Mon, 18 Nov 2024 06:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731941906; x=1732546706; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5Kj40amW5IpporSjQ73hgk+ubBMNelSpX7cTHNX0nDY=;
        b=tH5Wx1b/4bIgAiCtYPXvWCVHrmB1Q1QqgKegQKXHvezVczLCuf4uoqIyFmnX+natig
         ecXD/PpxOfFyxYDqR3wgIM6TL1JnwjYUIO3gsJHLos9tMGaabsXDtMSOsHhlyxD2/7Oz
         PXS+pIGAYRxTLgCUFCKXgSaKUmpJDGbnOxQKqOlmKDHcvnUCHCubZjl6iMzhzw/aVJpk
         jujnpfLSbqWD+6+8tte84u6kCA6gJw8ka6gHYtESg7FRii/+rvw04BuKvgtnd66Pf8mz
         gJBTRAwsPDRvJMaQ8iWbhn2ZD19ybut1qTDclQo7hTiNDpr/kwajXnuTT0xlA7suGYsu
         tNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731941906; x=1732546706;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Kj40amW5IpporSjQ73hgk+ubBMNelSpX7cTHNX0nDY=;
        b=C7Xp3SGOaal753nxtq9ZzA1FKHSBTZBvsA5hgXznzV/Q6ZDg5vlt5UYcj5sEAxS8LD
         mSOegjcdiL4n8zMu+YuLx6AqVh8rJLykmlwn17bYvLidVuixlKxxHzwSr5dQr/v6VSja
         PGNL6GorEXvjb+acaEzNYZIlLLvDHnx2rJ2t9+99SDLj+QmQQ91ePWvcw7NA0kJpyoW1
         nqn1lBTELsGjRAE8KJ1TemJExdhREJsjjmk3a4waKOafb/4OeDpO2k96+vX/Nkqb+pEe
         jfIdTsUBsaUy3PlT3sXqve9N3yqb+uq/sUDOUU5WxePEXSus5zE4IybKV/645Z5A/MCo
         fDqw==
X-Forwarded-Encrypted: i=1; AJvYcCV3ojiOej/5NAd1YMuQcDoZWKR1Bgr+3xAm2ZfY7IeEILAEsa7aEr+phVoOxwa2g0i1lLPfCB/Dt9+u@lists.infradead.org
X-Gm-Message-State: AOJu0Yyrpa7GIDVYXLY38fwQsjK1V9/Pir9sZu4+vxad5bto1Rmxpmoc
	OTGz1VqZbklotpjGJ4ZK0ZBIv0Sy1QlKwzXf9xruPF0pXstPCstsm6khOd5h0w==
X-Google-Smtp-Source: AGHT+IFXhxjuxnpcBK6VkRM8ka4xfCsVzl6RCq9DZi8mELcnE7vPbPlemi6MxwH3EwSL+aB5tXXoZQ==
X-Received: by 2002:a05:6a21:7881:b0:1db:dbad:ce3b with SMTP id adf61e73a8af0-1dc90b60450mr18251249637.23.1731941906610;
        Mon, 18 Nov 2024 06:58:26 -0800 (PST)
Received: from thinkpad ([36.255.17.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771e5c0csm6291226b3a.164.2024.11.18.06.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 06:58:26 -0800 (PST)
Date: Mon, 18 Nov 2024 20:28:20 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241118145820.2ecu5hzb2r5ygjvi@thinkpad>
References: <20241118082344.8146-1-manivannan.sadhasivam@linaro.org>
 <20241118125817.GA28046@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241118125817.GA28046@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241118_065828_516856_8D264186 
X-CRM114-Status: GOOD (  28.57  )
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

On Mon, Nov 18, 2024 at 01:58:17PM +0100, Christoph Hellwig wrote:
> On Mon, Nov 18, 2024 at 01:53:44PM +0530, Manivannan Sadhasivam wrote:
> > PCI core allows users to configure the D3Cold state for each PCI device
> > through the sysfs attribute '/sys/bus/pci/devices/.../d3cold_allowed'. This
> > attribute sets the 'pci_dev:d3cold_allowed' flag and could be used by users
> > to allow/disallow the PCI devices to enter D3Cold during system suspend.
> >
> > So make use of this flag in the NVMe driver to shutdown the NVMe device
> > during system suspend if the user has allowed D3Cold for the device.
> > Existing checks in the NVMe driver decide whether to shut down the device
> > (based on platform/device limitations), so use this flag as the last resort
> > to keep the existing behavior.
> 
> Umm, what?  The documentation of this attribute says:
> 
> "d3cold_allowed is bit to control whether the corresponding PCI
>  device can be put into D3Cold state.  If it is cleared, the
>  device will never be put into D3Cold state.  If it is set, the
>  device may be put into D3Cold state if other requirements are
>  satisfied too.  Reading this attribute will show the current
>  value of d3cold_allowed bit. Writing this attribute will
>  the value of d3cold_allowed bit."
> 
> Which honestly already sounds rather non-specific, but everything but
> a mandate for drivers to act on it.
> 
> The only place currently checking it is pci_dev_check_d3cold in the
> PCI core, which is used to set the bridge_d3 attibute.
> 

Yeah, it is pretty much used internally up until now. But the attribute looks
like a close match of what I could find for this usecase and that's why I used
it.

> So blindly using it in a driver to force a different PM strategy feels
> completely wrong.  Even if the attrite should have that effect it
> needs to happen through a well documented PCI or PM layer helper and
> open coded like this.
> 

Ok. I'd like to get some feedback from Bjorn H (PCI maintainer) about using this
attribute before moving forward with a helper.

Thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

