Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575C6C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Dec 2021 17:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tHUZjlzEP3lopTOQQN8mNVWiWWJwS29dSxMFB9HD+A8=; b=fkSmaoubEB579U
	oZK4/FKUgqlpSrn88JJRK1e4sYflBb8XlUbqIjF2yv6t1lr8N6DBg7XbuhBhlaKyVQxD7zYnMjPjs
	YJUHmqV8yYSh2J1WklfJzreia97mpFJJRiFnkfuYf9Q4Vu9bNM20uT9wB6IIb43OrFiD0C2JtwzWZ
	1Y7sHk/WxmnmCPIchLeYI7YlTC/UgGRY28NliT9hmXMZ44gXJ57vUtxd+zGB//idjnLf0woVpL9wN
	pn0UWJcUP72+guUf38myVvP+XthsHkWYQHo3hKu045Zf4Kb6yyRMsgwg+FnpCl/f/KS/haQ35Gdx9
	xp6t8FzZIjFp0gwv6sDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mzivI-007qLz-4I; Tue, 21 Dec 2021 17:27:36 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzivF-007qKP-Hp
 for linux-nvme@lists.infradead.org; Tue, 21 Dec 2021 17:27:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=tHUZjlzEP3lopTOQQN8mNVWiWWJwS29dSxMFB9HD+A8=; b=BGAK1lUDvyuZ48bEqcCgg4po+X
 NmanPhpAS6+UNAz03pYcDzNhaFu6mxvVL+qqnx53zeLQX6h1PxLDsBp8IULQlncbyQRvfjX79PRX9
 gvGf08CiKgzW2Sj7hkGZNGAo4+HMl1MGmxNHvizb/NiE6kQd8yfGXJ/3dXLgtk53IKoxY4ZDedsfU
 DPyaBVJpdtBflN4LZlAsXbgLCmRJRoBDGMAfmDRTKiT01PhljpgcRRK1n7m1/kODICqJNT8gQZlWb
 9hO76EMgdAOZiU3xTp4NH/AWvbL4YKf/4o7K7oRm5tr5TSQHxlKuC+ozusnGeek8c5BYNcduFKMx3
 t6BHI/9w==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <logang@deltatee.com>)
 id 1mziuv-00AX3M-08; Tue, 21 Dec 2021 10:27:14 -0700
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Stephen Bates <sbates@raithlin.com>,
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
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
References: <20211117215410.3695-1-logang@deltatee.com>
 <20211117215410.3695-22-logang@deltatee.com> <20211221090648.GE7949@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <369770be-c2d1-fcbf-f317-279981707cb9@deltatee.com>
Date: Tue, 21 Dec 2021 10:27:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211221090648.GE7949@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: ckulkarnilinux@gmail.com, martin.oliveira@eideticom.com,
 robin.murphy@arm.com, ira.weiny@intel.com, helgaas@kernel.org,
 jianxin.xiong@intel.com, dave.hansen@linux.intel.com, jason@jlekstrand.net,
 dave.b.minturn@intel.com, andrzej.jakowski@intel.com, daniel.vetter@ffwll.ch,
 willy@infradead.org, ddutile@redhat.com, jhubbard@nvidia.com,
 christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v4 21/23] mm: use custom page_free for P2PDMA pages
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211221_092733_601484_FFBE39B6 
X-CRM114-Status: GOOD (  16.08  )
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



On 2021-12-21 2:06 a.m., Christoph Hellwig wrote:
> On Wed, Nov 17, 2021 at 02:54:08PM -0700, Logan Gunthorpe wrote:
>> When P2PDMA pages are passed to userspace, they will need to be
>> reference counted properly and returned to their genalloc after their
>> reference count returns to 1. This is accomplished with the existing
>> DEV_PAGEMAP_OPS and the .page_free() operation.
>>
>> Change CONFIG_P2PDMA to select CONFIG_DEV_PAGEMAP_OPS and add
>> MEMORY_DEVICE_PCI_P2PDMA to page_is_devmap_managed(),
>> devmap_managed_enable_[put|get]() and free_devmap_managed_page().
> 
> Uuuh.  We are trying hard to kill off this magic free at refcount 1
> behavior in the amdgpu device coherent series.  We really should not
> add more of this.

Ah, ok. I found Ralph's patch that cleans this up and I can try to
rebase this onto it for future postings until it gets merged.

Your other comments I can address for the next time I post this series.

Thanks for the review!

Logan

