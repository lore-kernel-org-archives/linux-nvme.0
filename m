Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CC21C00140
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jul 2022 15:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ms6Eo/4vk2U2FvUSJ1ASbG7HxuQl+uR0mXnaHaYNTv4=; b=AKtn7dOpcuvHIz
	atqMjH4BU9CFck1WRHEqnEg3SYcZ2pBQDWs5MDqDLdyvzfyUYDr5MtYkCqzQT9wtoQywbsA+MfEcy
	jiFuwz6TYv+O0COttCBPGWu75Ke1ppLzPAyNF7G+uuzbv4b2dc49x+U7bYiVmveX/ga54igWaoyXY
	H5rsYEugFhYsXbvK68VOu/+cc1nawbDVZrv9oF18w8KeOQP/Ju9BHRx0NBuK55BJ18o3o6vtNBPLI
	AR9i54F6bjw51ffEwkIM4wQetXRzNXxzMLyr4HS27YcoSPfrLJ2MT2NZrR7wkpscw5C0DvvJ0YbKf
	KBpCsqIzuq/cW7WXdp3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGMu7-000mTn-No; Tue, 26 Jul 2022 15:55:27 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGMu4-000mPu-OG
	for linux-nvme@lists.infradead.org; Tue, 26 Jul 2022 15:55:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=Ms6Eo/4vk2U2FvUSJ1ASbG7HxuQl+uR0mXnaHaYNTv4=; b=NrrgVQUsop8jszUXB0cv9CDrL+
	fdEfO5urrJbCJWNS1Iq22L1BvAroUNoor2CQLfdd2fNdrd3IpBRHKvsxSYOo0vvWmym8s+v4433IL
	y1rGN9rbsQ+UvIDbRjl0eOWA1J1Qc4CPH33eBIJYfVPowrgNDYqlXANBYBSkVqIHAY8T5hiM3eVzj
	bzA9109KtzluUUx/kVOjSvMQWDprJiiWIwyH2jZiYrOkhSLoqIahhj2e9nvvPHfP6OEWaepTh3iLQ
	9EDAlLY/HgG/NpsGsYFpP2sAW6PiYh6LvI5jOulinFHwJ3MJcCIZZSwUI6umqKiVvyjyiGmC/P1g4
	7WdDWlCQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <logang@deltatee.com>)
	id 1oGMtz-000rlz-Bq; Tue, 26 Jul 2022 09:55:20 -0600
Message-ID: <a9a1641a-aa5c-ce29-e4a4-c266f4494004@deltatee.com>
Date: Tue, 26 Jul 2022 09:55:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-CA
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
 Stephen Bates <sbates@raithlin.com>, Dan Williams
 <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Ralph Campbell <rcampbell@nvidia.com>
References: <20220708165104.5005-1-logang@deltatee.com>
 <20220726112906.GA2169@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20220726112906.GA2169@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: hch@lst.de, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, iommu@lists.linux.dev, sbates@raithlin.com, dan.j.williams@intel.com, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v8 00/13] DMA Mapping P2PDMA Pages
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220726_085524_813234_F10EE8EA 
X-CRM114-Status: GOOD (  11.00  )
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



On 2022-07-26 05:29, Christoph Hellwig wrote:
> I've applied this to the dma-mapping for-next branch.
> 
> I'd have liked a review from Robin, but as he seems to be out and the
> rework was to fit his comments I'd rather have us unblocked before
> the end of the merge window.

Great thanks! If Robin has some feedback when he gets back I'd be happy
to make a couple more cleanup patches.

Logan

