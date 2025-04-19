Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA30C369BD
	for <linux-nvme@archiver.kernel.org>; Sat, 19 Apr 2025 04:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uXzOal0nfIQ8bFg2XccSM090HwsdWEh3UWZ58CwncMQ=; b=BywGTSH1mbxGZv6BcoZhOzyrtR
	fgu97EQSbTQ1shq0dF0+34UYzWsB0ii6q16VoB51JbEGwqqxc0czMGBnCXB5sQdYt/WuqSfBDiSy0
	p0c5xZNJUJpsJK2UwraNZf3hirVSJC7lXfyld2iq0o//pSkntSv7bY7AIhen1vH4mHsvT2TyxkZsN
	vidJ2BkA+jQs1z3H9tUCIP6fpbTEG/FIRAfmF2/5/NMYlvbg4P/yRQOIM6qMn02o9tLIFkOBpfDZp
	Pj66sd3737pdcFCB061wxAO1GKeVNvOePlxAl2aqAclto37bny3iJx/AxDHkafnYCWQM6g2KPmLT1
	ag/9xRGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5zuL-00000000pRR-1Xsw;
	Sat, 19 Apr 2025 04:34:25 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5zuD-00000000pR5-1HuL
	for linux-nvme@lists.infradead.org;
	Sat, 19 Apr 2025 04:34:18 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-736c1cf75e4so2204826b3a.2
        for <linux-nvme@lists.infradead.org>; Fri, 18 Apr 2025 21:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745037256; x=1745642056; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uXzOal0nfIQ8bFg2XccSM090HwsdWEh3UWZ58CwncMQ=;
        b=iZ8y0pxr5Y6cxUxSW5zyRgEGYYgb6m0arlqnvwWjQmHcyNkAtjG+CdajoLSZn5883P
         KMcheMq3PsN0Zq9sW7sm6DfBn3R3gdBKYwMAbWjD8cBdT2s8ndj+CErrcmT1r49b3ILu
         OhotnI10ONJDxEa4C5JZprYa4097bkBj+UgdtuR0/cMU9zo1ed22krXd54xNd6YZReht
         dK4SoLcFL19o6t3dB3szIJGupra2zArqvL/PZamR+TRI7NBGXpj79X9Q3a0MsAAlTV+K
         nQWo3TCFVjDsq0WGMGjgxIBKs9Bf7NFzhaiUisc4WTJGYUwAnJcpF9jtu+JJ1899YWh1
         DoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745037256; x=1745642056;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uXzOal0nfIQ8bFg2XccSM090HwsdWEh3UWZ58CwncMQ=;
        b=b6LLTovjBWYFtCkUff3uhVLsBz4/IfIgPigFk/sX76lKcshjYmQk25ip8e4THFVvTZ
         pk/1ILCHZlmfrVcJQHMzCun4k4J67bh2+Wbba/y7/elW0FtVWo3sOHpuzwXzP8r3TrAH
         1oSnCPquLNuWJHLdfEJ80fhBSKsOjlq8oCfBZORG6xmkA+2tLsKjzAu7lSq5EHKp1h9O
         GNHvZ72aMq1+whNCsEaWTg6OT8mVPN3nh1rxImHo0MqJGh8iA/cqTotmNyCizvBWT2xr
         jEBwXnxKKQxzz41xvJtmfatPI9EFSeWhmBzanQGNzZsZ4UNVj2qQB3uuS+flKgappwSL
         jZxg==
X-Forwarded-Encrypted: i=1; AJvYcCWmRP+f3NkbugeC/c+3HExPegP4DUWQV96+rb74/uqUfzKWlyOABLAfTSFTIMfdJrqGnaMkbEX9tsYG@lists.infradead.org
X-Gm-Message-State: AOJu0YwFhJZz7osHLvQteXhsowdARRwqzcXC/gNOk6ppSblb2q4gkzKO
	f4d9yvlXnn25z5hqdOvmidKUPTc6LvOHnl8gJhwBEsLw6HQta740lvCwrh3GNQ==
X-Gm-Gg: ASbGnctZa2TcKHYkgUYjtmgVtao7oi8MIuMWWc8MkI0fDZmI9PVGmqleou/EobX951O
	13W8FXu1PBxcbtEvGLHGE/SBwgW1AKMau/EMexwZfY/SEdsGqfKzF180QCh4bsWFXA79ZU///hH
	8a11dS2N9vKFGIsloX1O7zVudTfrN82jKe+iPbikGzRDjdkN6FNMMLSEQnYl+F47kdiH590tly/
	1VrNJx8Xu+seb13EXuAmwLj3sE+Yp0UezixLsJ3qWyotRb6sXaawEK6D9431D9fGkKOD4ulVfri
	2JtM3JsTS67NKmUBWJq53kswjhMzJCxec01iOKbBBANznzRqvLrA
X-Google-Smtp-Source: AGHT+IEP9iQj2KkpKrslEj+551ckgO39xK+3CJrtgDzGeG3sOciJvji42KgL9hedUsr1SldlGwzI4w==
X-Received: by 2002:a05:6a00:4606:b0:739:3f55:b23f with SMTP id d2e1a72fcca58-73dc14d3124mr5780129b3a.14.1745037256037;
        Fri, 18 Apr 2025 21:34:16 -0700 (PDT)
Received: from thinkpad ([220.158.156.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfa58333sm2450467b3a.118.2025.04.18.21.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 21:34:15 -0700 (PDT)
Date: Sat, 19 Apr 2025 10:04:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Marek Vasut <marek.vasut+renesas@gmail.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev, 
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/3] PCI: endpoint: improve fixed_size bar handling
 when allocating space
Message-ID: <xzn36fjifrwgmxpymmn6v7truzan5of37oxvvriegitnqeuwwr@cgrckqiittfh>
References: <20250407-pci-ep-size-alignment-v3-0-865878e68cc8@baylibre.com>
 <20250407-pci-ep-size-alignment-v3-2-865878e68cc8@baylibre.com>
 <Z_Pw3I2xO7BMSGWW@ryzen>
 <1jjz7wvuyj.fsf@starbuckisacylon.baylibre.com>
 <Z_TuIP-k1yLbjcys@ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_TuIP-k1yLbjcys@ryzen>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250418_213417_361836_67936265 
X-CRM114-Status: GOOD (  29.12  )
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

On Tue, Apr 08, 2025 at 11:36:32AM +0200, Niklas Cassel wrote:
> On Mon, Apr 07, 2025 at 05:43:00PM +0200, Jerome Brunet wrote:
> > On Mon 07 Apr 2025 at 17:35, Niklas Cassel <cassel@kernel.org> wrote:
> > 
> > > Hello Jerome,
> > >
> > > On Mon, Apr 07, 2025 at 04:39:08PM +0200, Jerome Brunet wrote:
> > >> When trying to allocate space for an endpoint function on a BAR with a
> > >> fixed size, the size saved in the 'struct pci_epf_bar' should be the fixed
> > >> size. This is expected by pci_epc_set_bar().
> > >> 
> > >> However, if the fixed_size is smaller that the alignment, the size saved
> > >> in the 'struct pci_epf_bar' matches the alignment and it is a problem for
> > >> pci_epc_set_bar().
> > >> 
> > >> To solve this, continue to allocate space that match the iATU alignment
> > >> requirement but save the size that matches what is present in the BAR.
> > >> 
> > >> Fixes: 2a9a801620ef ("PCI: endpoint: Add support to specify alignment for buffers allocated to BARs")
> > >> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > >> ---
> > >>  drivers/pci/endpoint/pci-epf-core.c | 25 +++++++++++++++++--------
> > >>  1 file changed, 17 insertions(+), 8 deletions(-)
> > >> 
> > >> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> > >> index b7deb0ee1760b23a24f49abf3baf53ea2f273476..fb902b751e1c965c902c5199d57969ae0a757c2e 100644
> > >> --- a/drivers/pci/endpoint/pci-epf-core.c
> > >> +++ b/drivers/pci/endpoint/pci-epf-core.c
> > >> @@ -225,6 +225,7 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
> > >>  	struct device *dev;
> > >>  	struct pci_epf_bar *epf_bar;
> > >>  	struct pci_epc *epc;
> > >> +	size_t size;
> > >>  
> > >>  	if (!addr)
> > >>  		return;
> > >> @@ -237,9 +238,12 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
> > >>  		epf_bar = epf->sec_epc_bar;
> > >>  	}
> > >>  
> > >> +	size = epf_bar[bar].size;
> > >> +	if (epc_features->align)
> > >> +		size = ALIGN(size, epc_features->align);
> > >
> > > Personally, I think that you should just save the aligned_size / mem_size /
> > > backing_mem_size as a new struct member, as that avoids the risk that someone
> > > later modifies pci_epf_alloc_space() but forgets to update
> > > pci_epf_free_space() accordingly.

+1. It is always a better approach to store the aligned size during allocation
and use it while freeing. It indeed avoids the alloc/free to go unsymmetry in
the future.

> > 
> > I tried but it looked a bit silly to store that when it was only a
> > matter of calling ALIGN() with parameters we already had, and it is
> > supposed to be only used in those two functions.
> 
> Another advantage is that you could kill patch 1/3 in this series, as
> there would be no need to supply epc_features to pci_epf_free_space().
> 

Yes!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

