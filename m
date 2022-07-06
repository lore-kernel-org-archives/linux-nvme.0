Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4099AC43334
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 21:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8YduW0eS5FyJqaOqaP8Ime9Kxv0Nz0ax91qwOz8aVq0=; b=y5gOhhdKtY4CRp
	djWS+AGXFbRQQ4S++LpHKlh1kpTLbMES8nUoFpuzi2j4hdmmQjIdnNDxfYuEjlcMxyUqwGTjurId8
	+30bqISJzFn64O23T/wvVZnGqcUinkhFiT4y4fxNGiocAeCfp9BuO0yx0X2kNXzGcjsedDjNsL4qn
	V9Ea205r+eKm/VTJoMbWuQ355Y+PESd/xMQzy+G0oDIU46E0JKhS13jz4pD+dQMc6dFe0mX5Lpzme
	JJudcogZGBBhwcP1cdSdixNr2gscKOqSjkNYKQPK3GCSjj8iWP8JrUoHwa1+DVWmeSFzs3VXsTcGf
	e2MWyYVXAjs/LeFq6/FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9Cbg-00CSgH-21; Wed, 06 Jul 2022 21:30:48 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9Cbc-00CSfE-9M
	for linux-nvme@lists.infradead.org; Wed, 06 Jul 2022 21:30:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=8YduW0eS5FyJqaOqaP8Ime9Kxv0Nz0ax91qwOz8aVq0=; b=tJ8pa1OCY41/griklmW+EWfOVD
	GWRX3NjEHhYKoa1dirAXu9tcLaN+qpf0nzpSUt6AE2hSTAMaGkgPgv4NcYCGYPyn5+QpenS+wTnVf
	dzwHgdTgxI67I3CmK0cMnjTb734bjxbjYx7DQA9orlsLZwJnT7/WMP2dzbiZ7YbAQzYQu/y+kd36E
	NWKd/LUDPN2BcSU2j0kYeELLqOgQTg66ewIFq/UnLnPvN5w4UmYxGdTvEJEsZFKMhHTjiXUcAJU+a
	56SmKOp2xezp85myJotIUFWF91GMeRTiTwry5HfRHn7/M0IWeMCxtQww2OKOWXkI2zuBZnUl0FPwc
	DaJoW4Qg==;
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <logang@deltatee.com>)
	id 1o9CbT-008LWu-KY; Wed, 06 Jul 2022 15:30:36 -0600
Message-ID: <e40595f9-f398-d43f-b09d-08d3e88b3950@deltatee.com>
Date: Wed, 6 Jul 2022 15:30:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@lst.de>
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
References: <20220705161240.GB13721@lst.de>
 <a509b13c-244b-23fc-f989-339750a733a5@deltatee.com>
 <20220705164315.GB14484@lst.de>
 <acb91f37-0470-8ce4-19e4-426903cbc3a1@deltatee.com>
 <20220705165039.GB14566@lst.de> <YsRzNqmZYlgkL7fI@kroah.com>
 <1bd43ef7-0403-bd25-087c-d54d5af677e4@deltatee.com>
 <YsR4CNDgtt4JWonv@kroah.com>
 <b3deacdd-cb76-6ebb-0e29-ef6a5a426a0d@deltatee.com>
 <20220706065127.GA27132@lst.de> <YsU0Cb0rRbW8FGPX@kroah.com>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <YsU0Cb0rRbW8FGPX@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: gregkh@linuxfoundation.org, hch@lst.de, jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, dan.j.williams@intel.com, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, bhelgaas@google.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v7 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220706_143044_422420_B85781EB 
X-CRM114-Status: GOOD (  19.71  )
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



On 2022-07-06 01:04, Greg Kroah-Hartman wrote:
> On Wed, Jul 06, 2022 at 08:51:27AM +0200, Christoph Hellwig wrote:
>> On Tue, Jul 05, 2022 at 12:16:45PM -0600, Logan Gunthorpe wrote:
>>> The current version does it through a char device, but that requires
>>> creating a simple_fs and anon_inode for teardown on driver removal, plus
>>> a bunch of hooks through the driver that exposes it (NVMe, in this case)
>>> to set this all up.
>>>
>>> Christoph is suggesting a sysfs interface which could potentially avoid
>>> the anon_inode and all of the extra hooks. It has some significant
>>> benefits and maybe some small downsides, but I wouldn't describe it as
>>> horrid.
>>
>> Yeah, I don't think is is horrible, it fits in with the resource files
>> for the BARs, and solves a lot of problems.  Greg, can you explain
>> what would be so bad about it?
> 
> As you mention, you will have to pass different things down into sysfs
> in order for that to be possible.  If it matches the resource files like
> we currently have today, that might not be that bad, but it still feels
> odd to me.  Let's see an implementation and a Documentation/ABI/ entry
> first though.

I'll work something up in the coming weeks.

Thanks,

Logan

