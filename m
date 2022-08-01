Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36799C00144
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Aug 2022 14:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2l9PNEk0VzHS+XC6b5H8xF6ld6p+aUzJlOLEzm+qj2g=; b=zfN0HFNb/CLMk5fd48qvse7UFn
	n6qTvqhMg09o9lGF+758L+471QXybUjGaclwG40ARN4pBCYdD/miz/xK3jFDXEVj3t8ELxT1RsLXk
	tGf+oRTLXHqK/XQBaOTAzDMaYYpD4r9Daua3/83OPb/OMZ/im+QiPZsXkx7Cxyf1ubAL2/RD6cJz9
	NKtc7aCZgOagAJH3f0QhSW4nlO1D4cNQXTSWCAfjuCeJV9IJ8pZmoTeAmsUXJHuVjbiCS/dLAcVPs
	s2sdIxIY+RX/Qktn1QYWE8WuijvZiQJe0/u3U2V2JXsJylLTSjbWo3Zn0TE6wSDqNRhC23GeAVm6k
	wxxFmltg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIW2g-006uyI-Fh; Mon, 01 Aug 2022 14:05:10 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIW2d-006uwD-2A
	for linux-nvme@lists.infradead.org; Mon, 01 Aug 2022 14:05:08 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBF9DED1;
	Mon,  1 Aug 2022 07:05:05 -0700 (PDT)
Received: from [10.57.10.23] (unknown [10.57.10.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 877DA3F73B;
	Mon,  1 Aug 2022 07:05:00 -0700 (PDT)
Message-ID: <57431a71-a71e-472a-9fb4-7acd4f9534cc@arm.com>
Date: Mon, 1 Aug 2022 15:04:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 00/13] DMA Mapping P2PDMA Pages
Content-Language: en-GB
To: Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
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
 Ira Weiny <ira.weiny@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Ralph Campbell <rcampbell@nvidia.com>
References: <20220708165104.5005-1-logang@deltatee.com>
 <20220726112906.GA2169@lst.de>
 <a9a1641a-aa5c-ce29-e4a4-c266f4494004@deltatee.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <a9a1641a-aa5c-ce29-e4a4-c266f4494004@deltatee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220801_070507_192750_391D92DA 
X-CRM114-Status: GOOD (  12.63  )
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

On 2022-07-26 16:55, Logan Gunthorpe wrote:
> 
> 
> On 2022-07-26 05:29, Christoph Hellwig wrote:
>> I've applied this to the dma-mapping for-next branch.
>>
>> I'd have liked a review from Robin, but as he seems to be out and the
>> rework was to fit his comments I'd rather have us unblocked before
>> the end of the merge window.
> 
> Great thanks! If Robin has some feedback when he gets back I'd be happy
> to make a couple more cleanup patches.

Indeed I've been taking some (rather overdue) holiday the last couple of 
weeks, sorry I forgot to take a look at this version beforehand. From a 
quick skim, nothing stands out as objectionable; thanks for taking my 
suggestions on board!

At some point once this lands I'll have a go at using the new flags to 
improve iommu-dma bounce buffering, so if I do spot anything else while 
I'm in there I'm sure could clean it up myself.

Cheers,
Robin.

