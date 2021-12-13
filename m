Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EE5C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 22:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7iaOSPYC++rVBoYT3QRUQDaMarUdPJ3RFeXKP6p9rM4=; b=33DZrZJqv+D3PC
	DzVsVDitVU3Mn+XR8yQQrdR+6LqhHqmiqiWgoyXiLQR3yJXUeWHbQaEDkL7i8ofCpYPeWnibKvZbt
	U6opKtcQrF2uZHDOEZEC8L+xATK7KmW5UyY09c1EA2aLWZV6747g6zWTqHZKmOGOZG5CxEhbq+gga
	4Rzy+/JHhi1VHKDNr8cdIJyUOYqPN3tb+ZfcGrtWyCgyLbw4lzccLcdW5K8laeobNauJI3Fy3KwqT
	09Q5lUbKTCBx0kG8h9i2xcw+wIHy0ZQpOmmqk1dGrJ69YkO3TETEHQ7A/mi0WAt5GRVNTejmyGt3J
	YhqSPTekVZ6L4SsUEpCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwu2n-00BpSz-6d; Mon, 13 Dec 2021 22:43:41 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwtp0-00BkFG-1c
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 22:29:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=7iaOSPYC++rVBoYT3QRUQDaMarUdPJ3RFeXKP6p9rM4=; b=b3dBhIgajJAvUk635a5T6J+46S
 lWGtZao8HbOE8FQzCpvd1HGkyAd8ZKQCD7KmVuvwCjqFnOdp1/6fBQqIqviPbBW3OAlA7rK5mYuJp
 ISX4VUGcdu+eaAVoI4XiQfUSuYbsqkyzs9pinzLkr8frDEOIvCPGPHWNLRXiDfjEtx6iopkOFseh7
 3nVLEpOS4Euq+Xe2yxnR8Oqycsa1pui0qvcMZaJQZ7Y60d7xioQ6c13dSL4wCD4OmLA/3MOcr2wjy
 ErkKSypS9r+JtZqxUMXBuukP7mxIR+F+TYmxzDEHKJktVg54mBubaL0dovEnkeXllV049o5n8uat3
 N8KqHCbA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <logang@deltatee.com>)
 id 1mwtoY-0042Rf-6n; Mon, 13 Dec 2021 15:28:59 -0700
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Daniel Vetter
 <daniel.vetter@ffwll.ch>, Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>
References: <20211117215410.3695-1-logang@deltatee.com>
 <20211117215410.3695-12-logang@deltatee.com>
 <e4fda995-6b50-0f74-0af7-4d790ab66ba9@nvidia.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <af6cda4f-9996-0aad-9278-1d41f824a070@deltatee.com>
Date: Mon, 13 Dec 2021 15:28:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <e4fda995-6b50-0f74-0af7-4d790ab66ba9@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: mgurtovoy@nvidia.com, ckulkarnilinux@gmail.com,
 martin.oliveira@eideticom.com, robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 jhubbard@nvidia.com, christian.koenig@amd.com, jgg@ziepe.ca,
 dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com,
 iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 chaitanyak@nvidia.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v4 11/23] nvme-pci: convert to using dma_map_sgtable()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_142926_125946_2AC17AB6 
X-CRM114-Status: GOOD (  14.49  )
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


On 2021-12-13 3:21 p.m., Chaitanya Kulkarni wrote:
> 
>>   static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
>> -		struct request *req, struct nvme_rw_command *cmd, int entries)
>> +		struct request *req, struct nvme_rw_command *cmd)
>>   {
>>   	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>>   	struct dma_pool *pool;
>>   	struct nvme_sgl_desc *sg_list;
>> -	struct scatterlist *sg = iod->sg;
>> +	struct scatterlist *sg = iod->sgt.sgl;
>> +	int entries = iod->sgt.nents;
> 
> I don't see use of newly added entries variable anywhere in
> nvme_pci_setup_sgls(), what am I missing ?

'entries' is being moved out from the argument list of
nvme_pci_setup_sgls(), so there are already uses in the function that
don't show in the diff.

> Also, type of entries variable should be unsigned int to match
> the iod->sgt.nents.

Sure, I will fix that in the next version.

Thanks for the reviews!

Logan

