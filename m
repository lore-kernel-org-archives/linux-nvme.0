Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2245C369A1
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 09:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c2X+K+LYczlWva2ZOAywArN79IeOIVAb8dEsmCJejNc=; b=q1f59Wbka4m6OgYecPl5qNkpX2
	cqs4hzLYu4h95mh9H3TXK8VrUShUrmD5r9CEAdv4uS1f351MWJvk9qcKRYo/9uiceCcTJ0fHANNaU
	0P6tgbhVIMXDc+BVfz2p1ZoGbhM5cS/8vVwKBhb9inVoaZJRgoNRrl6ydLYVSLEOQDAp0XrhyUvXZ
	VWVN12PKB69QMDv9bfcjEp7pHlIs0TvJDzIlHA6ubFmsEGDUrLcGCxDiADWJOzPwJW+314PA7Q0yU
	sHXIhs6FTCJICJsmxXL4akLx7yPpfUF/tIheNOUbubdp6/Jdfy24q6TFjHTvXZJcDvKZN56RrBkrG
	EOQZNRrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u25bj-00000003Vn8-3o3E;
	Tue, 08 Apr 2025 09:51:03 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u25No-00000003TJ0-1VMx
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 09:36:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 6AACBA49072;
	Tue,  8 Apr 2025 09:31:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0753EC4CEE5;
	Tue,  8 Apr 2025 09:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744104998;
	bh=NhA7bxfJCNkME8DTstpV9tqh1cqwE1796oGVhCFkVEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qwQoubicBlwx2gQbUo50rP967w+XMv47NsMLywWTYtyGuAp1td/sdBTgSUn8+kPQB
	 fpkInfJ3IGClbrwHkVDrV9MC+bK01DWfRDA1k5ibOWFPhQu2r90hhfRXaHkC7rI8CY
	 JmhEnPFE8w7BFzhcup9gIkcEfo/IE7x/NIBy3VPyvrInTBz4TChPjqZu0BjRI05Z6N
	 BVNWN2qR+IrTuL9p/hSVuWoRl08X/dWaW/rfSgZ1zsPdAx6OFJUdqjTJvzfi88TtdY
	 PFVAim52t2E2+80SXPdL/ZjYKHresFPgLByNe23qr9h/1xYb//iLbIutdrlTPY3NOP
	 7GyL0i9pp8UBQ==
Date: Tue, 8 Apr 2025 11:36:32 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ntb@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/3] PCI: endpoint: improve fixed_size bar handling
 when allocating space
Message-ID: <Z_TuIP-k1yLbjcys@ryzen>
References: <20250407-pci-ep-size-alignment-v3-0-865878e68cc8@baylibre.com>
 <20250407-pci-ep-size-alignment-v3-2-865878e68cc8@baylibre.com>
 <Z_Pw3I2xO7BMSGWW@ryzen>
 <1jjz7wvuyj.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1jjz7wvuyj.fsf@starbuckisacylon.baylibre.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250408_023640_542939_2239B2A6 
X-CRM114-Status: GOOD (  26.55  )
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

On Mon, Apr 07, 2025 at 05:43:00PM +0200, Jerome Brunet wrote:
> On Mon 07 Apr 2025 at 17:35, Niklas Cassel <cassel@kernel.org> wrote:
> 
> > Hello Jerome,
> >
> > On Mon, Apr 07, 2025 at 04:39:08PM +0200, Jerome Brunet wrote:
> >> When trying to allocate space for an endpoint function on a BAR with a
> >> fixed size, the size saved in the 'struct pci_epf_bar' should be the fixed
> >> size. This is expected by pci_epc_set_bar().
> >> 
> >> However, if the fixed_size is smaller that the alignment, the size saved
> >> in the 'struct pci_epf_bar' matches the alignment and it is a problem for
> >> pci_epc_set_bar().
> >> 
> >> To solve this, continue to allocate space that match the iATU alignment
> >> requirement but save the size that matches what is present in the BAR.
> >> 
> >> Fixes: 2a9a801620ef ("PCI: endpoint: Add support to specify alignment for buffers allocated to BARs")
> >> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> >> ---
> >>  drivers/pci/endpoint/pci-epf-core.c | 25 +++++++++++++++++--------
> >>  1 file changed, 17 insertions(+), 8 deletions(-)
> >> 
> >> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> >> index b7deb0ee1760b23a24f49abf3baf53ea2f273476..fb902b751e1c965c902c5199d57969ae0a757c2e 100644
> >> --- a/drivers/pci/endpoint/pci-epf-core.c
> >> +++ b/drivers/pci/endpoint/pci-epf-core.c
> >> @@ -225,6 +225,7 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
> >>  	struct device *dev;
> >>  	struct pci_epf_bar *epf_bar;
> >>  	struct pci_epc *epc;
> >> +	size_t size;
> >>  
> >>  	if (!addr)
> >>  		return;
> >> @@ -237,9 +238,12 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
> >>  		epf_bar = epf->sec_epc_bar;
> >>  	}
> >>  
> >> +	size = epf_bar[bar].size;
> >> +	if (epc_features->align)
> >> +		size = ALIGN(size, epc_features->align);
> >
> > Personally, I think that you should just save the aligned_size / mem_size /
> > backing_mem_size as a new struct member, as that avoids the risk that someone
> > later modifies pci_epf_alloc_space() but forgets to update
> > pci_epf_free_space() accordingly.
> 
> I tried but it looked a bit silly to store that when it was only a
> matter of calling ALIGN() with parameters we already had, and it is
> supposed to be only used in those two functions.

Another advantage is that you could kill patch 1/3 in this series, as
there would be no need to supply epc_features to pci_epf_free_space().


Kind regards,
Niklas

