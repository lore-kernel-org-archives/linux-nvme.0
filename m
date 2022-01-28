Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0256CC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jan 2022 16:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TwdFNzdxDdgz+26v8ucb90p5GLD0CB3VYearw7eL4TE=; b=e0OUCcoiKWP/xm
	yaDpjcStO5vv0Imlj/REsD/qDwMpw5ej4P1xQKpA6MTsHE5pbtYGKR6Jik5nCql9Q5G5KZqET8Izh
	qZJZq/AnqL41WgcLFhiVVA6QluWFENQiMqsc1zu+5c0iyIrDxygp82A5hLeZNEc+l8kl7FoEVdnWH
	XUBXvf424mEZ+b2EptdpLPmwWa5IuhXjb1L1LGch97nNNi9F7c0ZF8p2wXRqRWMOt5aFBy457pLpR
	04NvPj7FJcBaOYJ1fqfu5h5ykzL4hdg66L6Rv0/79URtyTxtWGIUJiINnLoub97ZRdstG/xCqbuUD
	hTB8IcGptskYxTj1aTlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDUUK-0035Ka-RL; Fri, 28 Jan 2022 16:52:40 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDUUG-0035Hr-FP
 for linux-nvme@lists.infradead.org; Fri, 28 Jan 2022 16:52:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=TwdFNzdxDdgz+26v8ucb90p5GLD0CB3VYearw7eL4TE=; b=Jjmj+T8NaOnEcL6xfeeEEnDoy1
 Jwe8ThuF6gDiurLsgr0uGnv9DtwA/YJGSAnk4YZieWRprMNN1XZTwMxLvg1xLTfdEF5shDUo1oKVB
 dGm8uPC2nP7BeAAxYGpVDjN5PUUN2dF+lmH4w3GEZWrOcUdeidJ3eaZUbWN7mRLo4ueWSGNDBPHcA
 n16IZ9yCMCIyGHmi5gDa34nnEEktr//UIijZEjTEMKttvW/djXEMc19q3vTDkuYD11X80MS+G2fw6
 WeaxTsJGGnS1Qt8qyvAZPSnnzqFXDE1edRZ8gpanjHUFDkfU4ljqOz+DMGoVetIUcDrsOOBqJRnuy
 Yyx62grQ==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200]
 helo=[192.168.0.10]) by ale.deltatee.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <logang@deltatee.com>)
 id 1nDUTz-0068Ws-Uv; Fri, 28 Jan 2022 09:52:20 -0700
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
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Ralph Campbell <rcampbell@nvidia.com>
References: <20220128002614.6136-1-logang@deltatee.com>
 <20220128002614.6136-23-logang@deltatee.com> <20220128142251.GV8034@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8ca5e74e-b02b-427f-cf7b-485f8153d689@deltatee.com>
Date: Fri, 28 Jan 2022 09:52:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220128142251.GV8034@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: rcampbell@nvidia.com, ckulkarnilinux@gmail.com,
 martin.oliveira@eideticom.com, robin.murphy@arm.com, ira.weiny@intel.com,
 helgaas@kernel.org, jianxin.xiong@intel.com, dave.hansen@linux.intel.com,
 jason@jlekstrand.net, dave.b.minturn@intel.com, andrzej.jakowski@intel.com,
 daniel.vetter@ffwll.ch, willy@infradead.org, ddutile@redhat.com,
 jhubbard@nvidia.com, christian.koenig@amd.com, dan.j.williams@intel.com,
 hch@lst.de, sbates@raithlin.com, iommu@lists.linux-foundation.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v5 22/24] mm: use custom page_free for P2PDMA pages
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220128_085236_524907_88482615 
X-CRM114-Status: UNSURE (   9.04  )
X-CRM114-Notice: Please train this message.
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



On 2022-01-28 7:22 a.m., Jason Gunthorpe wrote:
> On Thu, Jan 27, 2022 at 05:26:12PM -0700, Logan Gunthorpe wrote:
>> When P2PDMA pages are passed to userspace, they will need to be
>> reference counted properly and returned to their genalloc after their
>> reference count returns to 1. This is accomplished with the existing
> 
> It is reference count returns to 0 now, right?

Right, yes.

Thanks,

Logan

