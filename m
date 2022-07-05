Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E5AC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 18:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3rV+tiVBCGETS+0m1VAyBeVrP084h9ybGuEcnOkL1jA=; b=IXyx6Lc3HD4M/f
	04QtMG3Xl9K1dM4KsD7xfts+xqHI3nEW6STBplCW9Q9BcRjwYGzlKaGT+iSP2Huy8p0v6Y6siBKa3
	Z5ZJEehF2xaLMZgXfGkRMcW3xXlb1T38YXHdgvZtqvLR/ku7XWI+O7USP1RiUT/d/XaH5/rg0AWQM
	jXsQVh/+r1+M2/AmmoCDL6ZkwD4wtvxSdWEAUkUj64hFwSzXUrcrCQAkg/eLXrpf4Hw+toiTxSxbQ
	OudZMfgUEf/fTwH/vUM5u7SBxYbAucJGlh4+9+6ld32IWmpgD1wm3vB/gXYx30MOJ2+wyM/Nm8Rqq
	OsyrwemblrhpiTzbIWMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8n6Y-0024hm-3g; Tue, 05 Jul 2022 18:16:58 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8n6V-0024gJ-Nj
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 18:16:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=3rV+tiVBCGETS+0m1VAyBeVrP084h9ybGuEcnOkL1jA=; b=lfZ2jUE/Pcr0euHS/PfSv8pLp+
	4/PPUzTkxnoApUidHmt7v626OqXgmL9EfNAu2FXDE82dIkZS4evTLlHJEcLA0sTsaZOdUL7sJXe1K
	llHNHqCgIXLxKGdC2EFMJ+uJ5Hokog7lmJrw7QTYdr9sTAhi3Hh9CcwjoJd4Ouhncx4sMJASxJZo5
	Z45htSKhX9sgtg0ghREzgU5ID+skNQqwC9IlBlCgbwMhIXpFTCZpyt8HpOowWyAcZWE8tHzKxRvGy
	MFCCqqfCCaFi3VeOomss+vTbx17EVsq2HRcn8flYVkfHi6Hg6MM5xYspG5eOMY/FjnLQKBs2TXntf
	tmVTSv/w==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <logang@deltatee.com>)
	id 1o8n6O-007Udo-RE; Tue, 05 Jul 2022 12:16:49 -0600
Message-ID: <b3deacdd-cb76-6ebb-0e29-ef6a5a426a0d@deltatee.com>
Date: Tue, 5 Jul 2022 12:16:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-CA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
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
References: <20220629175906.GU23621@ziepe.ca> <20220705075108.GB17451@lst.de>
 <20220705135102.GE23621@ziepe.ca> <20220705161240.GB13721@lst.de>
 <a509b13c-244b-23fc-f989-339750a733a5@deltatee.com>
 <20220705164315.GB14484@lst.de>
 <acb91f37-0470-8ce4-19e4-426903cbc3a1@deltatee.com>
 <20220705165039.GB14566@lst.de> <YsRzNqmZYlgkL7fI@kroah.com>
 <1bd43ef7-0403-bd25-087c-d54d5af677e4@deltatee.com>
 <YsR4CNDgtt4JWonv@kroah.com>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <YsR4CNDgtt4JWonv@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: gregkh@linuxfoundation.org, hch@lst.de, jgg@ziepe.ca, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, dan.j.williams@intel.com, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, bhelgaas@google.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v7 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220705_111655_825060_F3285D55 
X-CRM114-Status: GOOD (  20.52  )
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



On 2022-07-05 11:42, Greg Kroah-Hartman wrote:
> On Tue, Jul 05, 2022 at 11:32:23AM -0600, Logan Gunthorpe wrote:
>>
>>
>> On 2022-07-05 11:21, Greg Kroah-Hartman wrote:
>>> On Tue, Jul 05, 2022 at 06:50:39PM +0200, Christoph Hellwig wrote:
>>>> [note for the newcomers, this is about allowing mmap()ing the PCIe
>>>> P2P memory from the generic PCI P2P code through sysfs, and more
>>>> importantly how to revoke it on device removal]
>>>
>>> We allow mmap on PCIe config space today, right?  Why is this different
>>> from what pci_create_legacy_files() does today?
>>>
>>>> On Tue, Jul 05, 2022 at 10:44:49AM -0600, Logan Gunthorpe wrote:
>>>>> We might be able to. I'm not sure. I'll have to figure out how to find
>>>>> that inode from the p2pdma code. I haven't found an obvious interface to
>>>>> do that.
>>>>
>>>> I think the right way to approach this would be a new sysfs API
>>>> that internally calls unmap_mapping_range internally instead of
>>>> exposing the inode. I suspect that might actually be the right thing
>>>> to do for iomem_inode as well.
>>>
>>> Why do we need something new and how is this any different from the PCI
>>> binary files I mention above?  We have supported PCI hotplug for a very
>>> long time, do the current PCI binary sysfs files not work properly with
>>> mmap and removing a device?
>>
>> The P2PDMA code allocates and hands out struct pages to userspace that
>> are backed with ZONE_DEVICE memory from a device's BAR. This is quite
>> different from the existing binary files mentioned above which neither
>> support struct pages nor allocation.
> 
> Why would you want to do this through a sysfs interface?  that feels
> horrid...

The current version does it through a char device, but that requires
creating a simple_fs and anon_inode for teardown on driver removal, plus
a bunch of hooks through the driver that exposes it (NVMe, in this case)
to set this all up.

Christoph is suggesting a sysfs interface which could potentially avoid
the anon_inode and all of the extra hooks. It has some significant
benefits and maybe some small downsides, but I wouldn't describe it as
horrid.

Logan

