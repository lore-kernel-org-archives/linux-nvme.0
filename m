Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9760C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 21:50:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 655D7613A6
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 21:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 655D7613A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ryEsT14pebcvIx/VrMOf2jl8ZBzag4mWu3Scrabj1Ug=; b=kpHw7spJvftuEO
	810q2ULjkgeEeOA0+Wsn6tUJZ/L9zBSdJvLsF7eEk+uBNzxv/e/VnDATl1Vf9A2CNVHcl+Rqt+fsq
	DhgZ+XwTf36dWnQHLqRPfOBUmnQSJYVyaHDoiiFbgTBHSB7MBcvm3KxB7SFC6adA/8aWl8VuViZPt
	Im4UOFefzoMzJi9r/Hk7ujFNW5VmMPBiI8T8tcmLI0MdKeyVLx1cCDqObhs2JhuvP2T2rVq7wYm2X
	MpVm1mMeVrT1cQFbcGP+jQuviNoCgDHCm7lJ30WJdQGxh1UM43KNvDB4m0zXQkhA6kJu0evoT9fw8
	mfsKSudB0OK9O1AWT3VQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVhSy-00CQZc-HQ; Wed, 29 Sep 2021 21:50:16 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVhSw-00CQYI-4w
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 21:50:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=Lipa8/ALS8oYFWfVY3pT4Pn+zABFEEx9dAykyQxwk8c=; b=ZVGFFP4651Y+5v4vLGLSOBAG3u
 H7RYE6QhfamhFneKZKQ46Cdxhog5vCjEN2jyHQk352gkYme97nOILO16hJfYgB8pwnxGID0dD+4bp
 uKOjwDhYnmRn1YxZ9ijxPw3d6j2nob2qHXT3/hVBlTIJjrjSqk6e9vYclG32v5THrImHW+UFoopI3
 ZzdJ+zzfA0DgzHxmT5UmAM1OiTEzmh3wlZStvhwtuZMP57Jib8jry/niE9TJuTsaKLSEhdNUr2SVM
 iwIAM3961udGLD7JgI5mtAgrNS2qHEzwTHjiwyinIc/K3UBui85RG8KKHo4If+3VO4rRxbMOxeTK7
 5Z3GTKVQ==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1mVhSl-0006bf-Ep; Wed, 29 Sep 2021 15:50:04 -0600
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Stephen Bates <sbates@raithlin.com>,
 Christoph Hellwig <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>,
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
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210928200216.GW3544071@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <06d75fcb-ce8b-30a5-db36-b6c108460d3d@deltatee.com>
Date: Wed, 29 Sep 2021 15:50:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928200216.GW3544071@ziepe.ca>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com,
 robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org,
 jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net,
 dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch,
 willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com,
 christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v3 00/20] Userspace P2PDMA with O_DIRECT NVMe devices
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210929_145014_255111_44CBDFA4 
X-CRM114-Status: GOOD (  20.18  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2021-09-28 2:02 p.m., Jason Gunthorpe wrote:
> On Thu, Sep 16, 2021 at 05:40:40PM -0600, Logan Gunthorpe wrote:
>> Hi,
>>
>> This patchset continues my work to add userspace P2PDMA access using
>> O_DIRECT NVMe devices. My last posting[1] just included the first 13
>> patches in this series, but the early P2PDMA cleanup and map_sg error
>> changes from that series have been merged into v5.15-rc1. To address
>> concerns that that series did not add any new functionality, I've added
>> back the userspcae functionality from the original RFC[2] (but improved
>> based on the original feedback).
> 
> I really think this is the best series yet, it really looks nice
> overall. I know the sg flag was a bit of a debate at the start, but it
> serves an undeniable purpose and the resulting standard DMA APIs 'just
> working' is really clean.

Actually, so far, nobody has said anything negative about using the SG flag.

> There is more possible here, we could also pass the new GUP flag in the
> ib_umem code..

Yes, that would be very useful.

> After this gets merged I would make a series to split out the CMD
> genalloc related stuff and try and probably get something like VFIO to
> export this kind of memory as well, then it would have pretty nice
> coverage.

Yup!

Thanks for the review. Anything I didn't respond to I've either made
changes for, or am still working on and will be addressed for subsequent
postings.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
