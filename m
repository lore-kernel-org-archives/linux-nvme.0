Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26265C36018
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Apr 2025 18:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UwKS83gjL8otXan3IgVJgr6hS9y5Lec7kMgl8CrxX/s=; b=KZqmXpz+pLx+ggB80Yo4NqxLEH
	mCrYL5rPLFrIDpTzGEPwI+6RKk2Xfh5J4QSs+7V/pNkES9QVGTGY6liEhEqI6V9zjHtAwTsyewqEe
	vAfLEjYB7d5tjrvs+DzGeOtp0ufidR/V9O8oDn48mOSc+LCDVqEd7KfIkNxxmPEdkh598CiE6ibfs
	PVt/t7MOj3Zj/T6T+5hUDC+1aHszvtlBZ8Iw3tklwx/PtMdMazx1LqwACRtF/AEI2X8ClWrWdgfBh
	9lhOVFFMveL1inGSiJX/HzkjryHKmKITtjz27Za1itkDmqLvCF8g4iPP2XQBbLc4xoaRjyPrOofDX
	t95B2C2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1r1S-00000001VCQ-1uje;
	Mon, 07 Apr 2025 18:16:38 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1ocp-0000000109J-1e2g
	for linux-nvme@lists.infradead.org;
	Mon, 07 Apr 2025 15:43:05 +0000
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so26593475e9.2
        for <linux-nvme@lists.infradead.org>; Mon, 07 Apr 2025 08:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744040582; x=1744645382; darn=lists.infradead.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UwKS83gjL8otXan3IgVJgr6hS9y5Lec7kMgl8CrxX/s=;
        b=oF7OzAjhhZP9wbJhhJHy/NoXY8UkyzL2jAMJf/EdLSzEiftR8d/h3aegbSSo7Yxrnh
         RYoSxyS4asKezKElGW0MlDlA03RmlQRINT7Fvl//yejvEknx05oNa3wz+2/54zO6Av/q
         8PFoRmcyWg5mBwyXBAcz9q4xuDZw2A4WjRt9ZP1RrgVec6KaynnhCObn2bmE6Idg1YVT
         pBPLGhCtqqAAudy0v3psm9zezCgh0n34ctU9BOo7duM8DHaYeRvHHeijZja/X92QNciK
         JcbjK+DlIZQkiBOUYyg2YJNi5AJ0ZIFr0GtPjZkQEGQ5IPKYJy1ufGhjHD2xrI0e3dza
         QpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744040582; x=1744645382;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwKS83gjL8otXan3IgVJgr6hS9y5Lec7kMgl8CrxX/s=;
        b=Ig+yom7joIsQ6H3hP4NQENH12G73/0LUQiQvH5Mo2KFdOXWQQUI06Clcwg/xXOU5YI
         UPvjDVA6dx2cNQQ1NyTEzNrFvVjRs+jPDWgTs3etp2i/1+/g3RPPzyeXoM8BxAiOJw18
         NY9/Ws1dKdAHX9uztiaaL5R8BrmgmUhi27LZAZM9Kl9fnbK/ZaA9fsAq6T2XMi4Of5Ea
         C0QC70xgJqtos/lBAGNsErTXxhlblZMdUgqf0fhrYIeJF3INsj+79Jet1Qmppe06mJqs
         u+8txdfZczmcDnharf1cVDN1D8mPAwg/zZKgsksDcm4iBDIbNUiIWRiBN/xhsUzIf5It
         5G4g==
X-Forwarded-Encrypted: i=1; AJvYcCUQb7k/pw06aQMnTTQn+/lDCkzqgPnqpEl2cd9fXSk7aUwkFRdqOEgizvrDak+RvSdCLgrmwtJa73oj@lists.infradead.org
X-Gm-Message-State: AOJu0Yzag8X+MGM1aE/DsFNGH39noW//ZVwzul1ruq6yZf1NDpK/Nlt7
	3hSAfu25UnaU63bNsV2O2rhvkg1nmL48+0UiP2A9uFVCCyIIUUHLoffAZeGXQZU=
X-Gm-Gg: ASbGncumf/GAXBUWnZ2/wE5vprnWrXA9CHdWliZlceXrneVMfpFS4lTIU5x8g5cWvjN
	nxhBfWRCkYEDgHJFdw8cWJzBlDLTpZH6OVz50aYJ74TJSq2Vdtk4fG2su2XyjQnvypHi4QWWa7n
	VIXYn+95ZmzsGFTGWAlsHwclVUAG6q589wxSgY8q542C2qbbpPivJZOXeg27w06apXyovNKpa1z
	EE8vJu9n6UV6jipIwTu8YaNmDkvwrYLNmhnR/shicWMzf1mbOTbRD9oDVxdfC0OzURKw8G5QWXX
	44VC0PS/Ofu7j8Q33UgEoODMy03ZD4ffF1ZCX68rH2CxhbuX5jj3kLs=
X-Google-Smtp-Source: AGHT+IEvLb0NTyDHj4c780QWtXn9xkplpLX5dvvjj3YvSoxW0R3QPk0BF940mrnTtyAAxjx1VydCvA==
X-Received: by 2002:a05:6000:2a5:b0:39a:ca04:3e4d with SMTP id ffacd0b85a97d-39d6fc00aabmr7580240f8f.7.1744040581642;
        Mon, 07 Apr 2025 08:43:01 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:1122:cb29:d776:d906])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39c301a0a90sm12335092f8f.21.2025.04.07.08.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 08:43:01 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,  Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,  Kishon Vijay Abraham I
 <kishon@kernel.org>,
  Bjorn Helgaas <bhelgaas@google.com>,  Lorenzo Pieralisi
 <lpieralisi@kernel.org>,  Jon Mason <jdmason@kudzu.us>,  Dave Jiang
 <dave.jiang@intel.com>,  Allen Hubbe <allenbh@gmail.com>,  Christoph
 Hellwig <hch@lst.de>,  Sagi Grimberg <sagi@grimberg.me>,  Chaitanya
 Kulkarni <kch@nvidia.com>,  Marek Vasut <marek.vasut+renesas@gmail.com>,
  Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,  Yuya Hamamachi
 <yuya.hamamachi.sx@renesas.com>,  linux-pci@vger.kernel.org,
  linux-kernel@vger.kernel.org,  ntb@lists.linux.dev,
  linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/3] PCI: endpoint: improve fixed_size bar handling
 when allocating space
In-Reply-To: <Z_Pw3I2xO7BMSGWW@ryzen> (Niklas Cassel's message of "Mon, 7 Apr
	2025 17:35:56 +0200")
References: <20250407-pci-ep-size-alignment-v3-0-865878e68cc8@baylibre.com>
	<20250407-pci-ep-size-alignment-v3-2-865878e68cc8@baylibre.com>
	<Z_Pw3I2xO7BMSGWW@ryzen>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 07 Apr 2025 17:43:00 +0200
Message-ID: <1jjz7wvuyj.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_084303_432431_28E31F3E 
X-CRM114-Status: GOOD (  28.97  )
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

On Mon 07 Apr 2025 at 17:35, Niklas Cassel <cassel@kernel.org> wrote:

> Hello Jerome,
>
> On Mon, Apr 07, 2025 at 04:39:08PM +0200, Jerome Brunet wrote:
>> When trying to allocate space for an endpoint function on a BAR with a
>> fixed size, the size saved in the 'struct pci_epf_bar' should be the fixed
>> size. This is expected by pci_epc_set_bar().
>> 
>> However, if the fixed_size is smaller that the alignment, the size saved
>> in the 'struct pci_epf_bar' matches the alignment and it is a problem for
>> pci_epc_set_bar().
>> 
>> To solve this, continue to allocate space that match the iATU alignment
>> requirement but save the size that matches what is present in the BAR.
>> 
>> Fixes: 2a9a801620ef ("PCI: endpoint: Add support to specify alignment for buffers allocated to BARs")
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  drivers/pci/endpoint/pci-epf-core.c | 25 +++++++++++++++++--------
>>  1 file changed, 17 insertions(+), 8 deletions(-)
>> 
>> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
>> index b7deb0ee1760b23a24f49abf3baf53ea2f273476..fb902b751e1c965c902c5199d57969ae0a757c2e 100644
>> --- a/drivers/pci/endpoint/pci-epf-core.c
>> +++ b/drivers/pci/endpoint/pci-epf-core.c
>> @@ -225,6 +225,7 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
>>  	struct device *dev;
>>  	struct pci_epf_bar *epf_bar;
>>  	struct pci_epc *epc;
>> +	size_t size;
>>  
>>  	if (!addr)
>>  		return;
>> @@ -237,9 +238,12 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
>>  		epf_bar = epf->sec_epc_bar;
>>  	}
>>  
>> +	size = epf_bar[bar].size;
>> +	if (epc_features->align)
>> +		size = ALIGN(size, epc_features->align);
>
> Personally, I think that you should just save the aligned_size / mem_size /
> backing_mem_size as a new struct member, as that avoids the risk that someone
> later modifies pci_epf_alloc_space() but forgets to update
> pci_epf_free_space() accordingly.

I tried but it looked a bit silly to store that when it was only a
matter of calling ALIGN() with parameters we already had, and it is
supposed to be only used in those two functions.

>
> But I will leave the decision to the PCI endpoint maintainers.
>

Ultimately, I do not have a strong opinion on this. Either way is fine
by me.

>
> Kind regards,
> Niklas
>
>
>> +
>>  	dev = epc->dev.parent;
>> -	dma_free_coherent(dev, epf_bar[bar].size, addr,
>> -			  epf_bar[bar].phys_addr);
>> +	dma_free_coherent(dev, size, addr, epf_bar[bar].phys_addr);
>>  
>>  	epf_bar[bar].phys_addr = 0;
>>  	epf_bar[bar].addr = NULL;
>> @@ -266,7 +270,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>>  			  enum pci_epc_interface_type type)
>>  {
>>  	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
>> -	size_t align = epc_features->align;
>> +	size_t aligned_size, align = epc_features->align;
>>  	struct pci_epf_bar *epf_bar;
>>  	dma_addr_t phys_addr;
>>  	struct pci_epc *epc;
>> @@ -287,12 +291,17 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>>  			return NULL;
>>  		}
>>  		size = bar_fixed_size;
>> +	} else {
>> +		/* BAR size must be power of two */
>> +		size = roundup_pow_of_two(size);
>>  	}
>>  
>> -	if (align)
>> -		size = ALIGN(size, align);
>> -	else
>> -		size = roundup_pow_of_two(size);
>> +	/*
>> +	 * Allocate enough memory to accommodate the iATU alignment requirement.
>> +	 * In most cases, this will be the same as .size but it might be different
>> +	 * if, for example, the fixed size of a BAR is smaller than align
>> +	 */
>> +	aligned_size = align ? ALIGN(size, align) : size;
>>  
>>  	if (type == PRIMARY_INTERFACE) {
>>  		epc = epf->epc;
>> @@ -303,7 +312,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>>  	}
>>  
>>  	dev = epc->dev.parent;
>> -	space = dma_alloc_coherent(dev, size, &phys_addr, GFP_KERNEL);
>> +	space = dma_alloc_coherent(dev, aligned_size, &phys_addr, GFP_KERNEL);
>>  	if (!space) {
>>  		dev_err(dev, "failed to allocate mem space\n");
>>  		return NULL;
>> 
>> -- 
>> 2.47.2
>> 

-- 
Jerome

