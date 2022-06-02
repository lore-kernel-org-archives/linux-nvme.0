Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE7FC43334
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jun 2022 17:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iyck+wOifMpSZlLxRfCrWDgusCm3mWKdpT17Ia+B9wY=; b=sI6B14ZDqNYYqm
	w2RRQzPOKD2Wf3ZOl8l3q5kTn1rAJMEdMuYnSvicwWKtJEF59LjspLDyuVb8EL6VTDy/rzLY9HA4w
	0CPjJGt4Fv1Lgycn5We3/PA1Y2Hjws1sNnrmwsofOAo35xVGKYUpgfFP9lz4YW51iXhTDHNdqs4L8
	yyKDH5MjwEpf7KVJfdBKOo6lh7EnSfTgLJ+NALwx6rgGXHprMUmJ7PiE3iJzRdoBnAofocIrOtEZy
	hxdS9tlWenJBdQh2Hip+hbJiVERNeTfPWDquyFK5ZoycJ9sxu6pptg8a7IbjAKNQN7iyeO77FUdRs
	HO3eNDBvZ+zddOPiRNJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwox2-003uKm-Up; Thu, 02 Jun 2022 17:49:40 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwox1-003uJQ-0C
	for linux-nvme@lists.infradead.org; Thu, 02 Jun 2022 17:49:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=iyck+wOifMpSZlLxRfCrWDgusCm3mWKdpT17Ia+B9wY=; b=rnaKQUhn8m0zyN0RqZEYQDjsXS
	bQq3WwRpeKjVK1qMYZK6mfxOtb/vSCH4EYY+RMt8unUUNIFPAn8qkWOpu0WY8P+7ycxavtU8c1x42
	GL4bMz3u3uliqUKkk/rKHRiF6ip5UbjhpBdiEMfIJ6nrjfPr/5Sq6euvL6HgLOAijk7z3HlBHP7ls
	pcXQ0r9j5pF9NW3clGalNpKN8L7zkm/dgY51Cgy5nTN+GYoKstvVBkAR/a/aEoyXotFUOBWnP/yvp
	eUKOoQvmroULemDQpPRn3ppgTUJ3ZUx9YNJrBF5YBjbqtvmxd7j82k4fvWwyzEA+XJ6DtYonhy2aI
	X2SqWSig==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <logang@deltatee.com>)
	id 1nwoww-00EP6z-6D; Thu, 02 Jun 2022 11:49:35 -0600
Message-ID: <251c6028-c53a-28dd-2bbf-d5c8ec2496b3@deltatee.com>
Date: Thu, 2 Jun 2022 11:49:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-CA
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
 Ralph Campbell <rcampbell@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>
References: <20220407154717.7695-1-logang@deltatee.com>
 <20220407154717.7695-21-logang@deltatee.com>
 <20220527125501.GD2960187@ziepe.ca>
 <a2590e27-41e8-59dc-3576-b5b8d716a198@deltatee.com>
 <20220527190307.GG2960187@ziepe.ca>
 <d336cfe8-2451-04c3-a2ce-0e8e47afd1e3@deltatee.com>
 <20220602000038.GK2960187@ziepe.ca>
 <400baba7-1cd6-09d4-4de9-2a73f08afc79@deltatee.com>
 <20220602163059.GL2960187@ziepe.ca>
 <51cc6645-2504-6d01-5626-238ed6ffff04@deltatee.com>
 <20220602172811.GN2960187@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20220602172811.GN2960187@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, dan.j.williams@intel.com, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, bhelgaas@google.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v6 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220602_104939_092139_05025207 
X-CRM114-Status: GOOD (  18.29  )
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



On 2022-06-02 11:28, Jason Gunthorpe wrote:
> On Thu, Jun 02, 2022 at 10:49:15AM -0600, Logan Gunthorpe wrote:
>>
>>
>> On 2022-06-02 10:30, Jason Gunthorpe wrote:
>>> On Thu, Jun 02, 2022 at 10:16:10AM -0600, Logan Gunthorpe wrote:
>>>
>>>>> Just stuff the pages into the mmap, and your driver unprobe will
>>>>> automatically block until all the mmaps are closed - no different than
>>>>> having an open file descriptor or something.
>>>>
>>>> Oh is that what we want?
>>>
>>> Yes, it is the typical case - eg if you have a sysfs file open unbind
>>> hangs indefinitely. Many drivers can't unbind while they have open file
>>> descriptors/etc.
>>>
>>> A couple drivers go out of their way to allow unbinding while a live
>>> userspace exists but this can get complicated. Usually there should be
>>> a good reason.
>>>
>>> The module will already be refcounted anyhow because the mmap points
>>> to a char file which holds a module reference - meaning a simple rmmod
>>> of the driver shouldn't work already..
>>
>> Also, I just tried it... If I open a sysfs file for an nvme device (ie.
>> /sys/class/nvme/nvme4/cntlid) and unbind the device, it does not block.
>> A subsequent read on that file descriptor returns ENODEV. Which is what
>> I would have expected.
> 
> Oh interesting, this has been changed since years ago when I last
> looked, the kernfs_get_active() is now more narrowed than it once
> was. So manybe sysfs isn't the same concern it used to be!

Yeah, so I really think *not* blocking unbind indefinitely is the better
approach here. It's what has always been done with device dax, etc.
mmaps in userspace processes get unmapped and will fault with SIGBUS on
next access and unbind will actually unbind the device relatively
promptly. Userspace processes can fail or try to handle the device going
away gracefully.

Logan

