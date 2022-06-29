Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8043C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jun 2022 16:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DB/o3OL3a8p7Pc5UauzdC49YqSJaVUxyZzB2ozvl7YI=; b=UhwMcK6I52JsqJ
	LnH+Z37UEiVmoADyr93iPfTRvW263qXNykR6mgyA2wqsd37ujLoFlVGczsvQt7PNrQZBc/Xd9j42A
	7Y6VwLdWvwGbyOKgEIFkOxluouU81jJdVxujy0nFRqwGSY4f/2IdIzd+Pgp6I7CSsekv4XcbP4Y2V
	W9EapsSvIy2uIAmmrdccG/Z4092pxgFveQnDnsAOMkcFVstbsmQc3HjVBpIuL0MFhKqWxw2seOnk2
	QWNTGP0jkB4VE6IsKE/5oQ6Xy8rkOZEgIcsqbgRZvbQSYE25g2XtPrM0NLWLdnbMkT3Iuh9Isy5A5
	/44azO7vXX7x8OwfAJ9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6a9H-00CpnF-RQ; Wed, 29 Jun 2022 16:02:39 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6a6u-00CoTI-Ed
	for linux-nvme@lists.infradead.org; Wed, 29 Jun 2022 16:00:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=DB/o3OL3a8p7Pc5UauzdC49YqSJaVUxyZzB2ozvl7YI=; b=iZsQhnlbpW9sXN/GJaS3jAMw+w
	8mn6izIwy085ybj1EKwF9DeEsOt9qyrlLxTvp+P9EVdEEjbQUwL5dVFTMDhjOaBp5PaGks7Gp0vTL
	Pz4wv3iQN06W33bmzngimPEHWIwXW/s9XuLr428TJq/t9Jpay97zThl6gUaoJoo9UCQ2zqUNOyzir
	HCs15GX4eR/A0kDWtJ7SaGXsATfCWkaQvG0flWXjWzNvEQkpGnbcu6afAc4ry10M/XvkH8tpuj6H7
	pV0F7DMjJNZAL9ALRpJtO4Tl1f8+YWZ+iaFmr74pOp+DJyj7fvd7YDPPvJ3gnFshVDAC+8VlO6cQM
	jCOY9fhQ==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <logang@deltatee.com>)
	id 1o6a6s-002RzJ-UG; Wed, 29 Jun 2022 10:00:11 -0600
Message-ID: <99242789-66a6-bbd2-b56a-e47891f4522e@deltatee.com>
Date: Wed, 29 Jun 2022 10:00:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-CA
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Stephen Bates <sbates@raithlin.com>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
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
 Ralph Campbell <rcampbell@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>
References: <20220615161233.17527-1-logang@deltatee.com>
 <20220615161233.17527-21-logang@deltatee.com> <20220629064854.GD17576@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20220629064854.GD17576@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: hch@lst.de, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, dan.j.williams@intel.com, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, bhelgaas@google.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v7 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220629_090012_523317_D1A55772 
X-CRM114-Status: GOOD (  17.26  )
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




On 2022-06-29 00:48, Christoph Hellwig wrote:
> On Wed, Jun 15, 2022 at 10:12:32AM -0600, Logan Gunthorpe wrote:
>> A pseudo mount is used to allocate an inode for each PCI device. The
>> inode's address_space is used in the file doing the mmap so that all
>> VMAs are collected and can be unmapped if the PCI device is unbound.
>> After unmapping, the VMAs are iterated through and their pages are
>> put so the device can continue to be unbound. An active flag is used
>> to signal to VMAs not to allocate any further P2P memory once the
>> removal process starts. The flag is synchronized with concurrent
>> access with an RCU lock.
> 
> Can't we come up with a way of doing this without all the pseudo-fs
> garbagage?  I really hate all the overhead for that in the next
> nvme patch as well.

I assume you still want to be able to unmap the VMAs on unbind and not
just hang?

I'll see if I can come up with something to do the a similar thing using
vm_private data or some such.

I was not a fan of the extra code for this either, but I was given to
understand that it was the standard way to collect and cleanup VMAs.

Thanks for the reviews,

Logan

