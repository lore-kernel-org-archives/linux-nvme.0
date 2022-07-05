Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19241CCA47F
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 16:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=M9lshAzEWCp39q0M5lwlB1NZkjotUyijIzztbRqB0FM=; b=L2tvSv8sL9GmKG
	yrDInKcNdNoqhkH7FSmCOhVixdihkYEp8hZd6HqTDY9ecbfFV0fa/9K8pp76w0AthsAAenqrOFV3v
	D4FBYi5A15n/Qn7nc0tRTfqjm/7w6aMGIiLI5tIfwSa1ZteL0itYwaqpckGtHYejpBC/8Nccy44sx
	gD9jOtpK/DHCCgMLldihB+DjB3/sWI9JGWyo7wyqjQfy26oRLsEX86wPa6axSz2h1ZI0Q9xMDwSsW
	9FOGET9oHcU8ZOq3ESIHmMhC49tu0dD2fuyb7Ql/8ZRMu4qjJqX6z2SSc5MQHmh3hpY3aR2vltVdU
	3SXI5q+HxWVh4bYTjaJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8lfU-001Yjp-3d; Tue, 05 Jul 2022 16:44:56 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8lfQ-001Yhp-Qt
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 16:44:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=M9lshAzEWCp39q0M5lwlB1NZkjotUyijIzztbRqB0FM=; b=Mo2zW9GHbFuHB4N5lDT7TTpEFJ
	E/uvXhxH8NlLN3H7wf7jHeNIVGFBOn6kGpSwg9Q0PRmIT7B0NgN5HKfDvdWC/tq0oeR9ODWC5Sm8L
	4VzdLVqrNlvua2BOOpPdKo9XZ4N4qOdl1ANdXJB8gt/aOC2BGSJa5bzebNQZsA2RjPwMB0RJHFmUu
	ngvrq/ALiGMZNQzw/HVXX/Nbl91952L71agzO9IOMIUVjPxPiUnA2kW/08/SbESEi8UnI7QL08gqh
	JwtZmMz5Fhga9ZahrHQMYr0rc5ZM4OOgbdcBm7aT4OzddKkaTzcWtw3cLXJKAm1h0uFRofCOED5Ae
	PuCBNcTQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <logang@deltatee.com>)
	id 1o8lfO-007Sy1-H9; Tue, 05 Jul 2022 10:44:51 -0600
Message-ID: <acb91f37-0470-8ce4-19e4-426903cbc3a1@deltatee.com>
Date: Tue, 5 Jul 2022 10:44:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-CA
To: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Stephen Bates <sbates@raithlin.com>,
 Dan Williams <dan.j.williams@intel.com>,
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
 <99242789-66a6-bbd2-b56a-e47891f4522e@deltatee.com>
 <20220629175906.GU23621@ziepe.ca> <20220705075108.GB17451@lst.de>
 <20220705135102.GE23621@ziepe.ca> <20220705161240.GB13721@lst.de>
 <a509b13c-244b-23fc-f989-339750a733a5@deltatee.com>
 <20220705164315.GB14484@lst.de>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20220705164315.GB14484@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: hch@lst.de, jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, dan.j.williams@intel.com, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, bhelgaas@google.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v7 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220705_094452_929115_B01F2FDA 
X-CRM114-Status: GOOD (  13.83  )
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



On 2022-07-05 10:43, Christoph Hellwig wrote:
> On Tue, Jul 05, 2022 at 10:41:52AM -0600, Logan Gunthorpe wrote:
>> Using sysfs means we don't need all the messy callbacks from the nvme
>> driver, which is a plus. But I'm not sure how we'd get or unmap the
>> mapping of a sysfs file or avoid the anonymous inode. Seems with the
>> existing PCI resources, it uses an bin_attribute->f_mapping() callback
>> to pass back the iomem_get_mapping() mapping on file open.
>> revoke_iomem() is then used to nuke the VMAs. I don't think we can use
>> the same infrastructure here as that would add a dependency on
>> CONFIG_IO_STRICT_DEVMEM; which would be odd. And I'm not sure whether
>> there is a better way.
> 
> Why can't we do the revoke on the actual sysfs inode?

We might be able to. I'm not sure. I'll have to figure out how to find
that inode from the p2pdma code. I haven't found an obvious interface to
do that.

Logan

