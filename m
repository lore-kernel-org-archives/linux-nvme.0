Return-Path: <SRS0=mxs5=EP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82F3C63777
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 16:50:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62DF620809
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 16:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b0oHMcJH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="ThtDTaP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62DF620809
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fYJrhGx8kUdJ2CLrSl4f9f1nei9iWu3DGnOMEsjE+aM=; b=b0oHMcJH+KPm6nyhZUPJH6E6E
	rHF+dr3ve20nP6vYT54i/yw9KdNukofBTXohLuK0t5D8oRJE6PCkyfwuSiXqC1jbne+ywxLCPJ/fI
	WyqOSQrwMom+Ull+05tsMTdZtD6UQa50DwH2bRU6vaTimayoDBUJxMYdELjmIlDIbDIK/CdQ2u/K6
	dz+9dpOHE9XVzIjS/OqbrbrC1K0ImVbhcopwU4YNUJ3Pal91T/T7O4WoGQj+3Rizq+P5zL/HDPEnL
	mCtb4yD+9MCyPHJZ/tz4N+KbC6W3WWxaCRFMWKzQzeyIXPzyodS6PkqY/J2sfGY6y20PMxT41qywP
	pESe7WD7Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcAN0-0005jQ-A3; Mon, 09 Nov 2020 16:50:18 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcAMx-0005iB-56
 for linux-nvme@lists.infradead.org; Mon, 09 Nov 2020 16:50:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JvTSJOBJXMYeKQM3WvNBTHeii6rtMfOVYOuXeE1KNJE=; b=ThtDTaP+0JSTSqxTpv0Wbo5rpZ
 iRui8AXvdDo2GGy2jD+Ihq9bjJnDiDzsI2eDLeMfjQgtCqgG1tvLOdsfhRmNEUO5jfT5M0MI5pI2v
 q2scQ0uSLY0gF95SrT5uiioU6950uU8eKRlO3IC5Z9K0t/8xAxKw/BHncD9WkCSO21vni9bfdfdjX
 Ln7KngxHrH+R5I2NkjQEaqpyQ8667dJ8gO+usI96NSRpENPnyhncaujMAMnPoIfhN4BFg8hdAnZFw
 mUlKnwOWo6dpdcffw7/1fMcc6qlFJ5qgEkOsQqBOUl2OSNvLl4XkpF9pd5ChHmt9ndYzbgPOuwY5t
 OGbul4GA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
 by ale.deltatee.com with esmtp (Exim 4.92)
 (envelope-from <logang@deltatee.com>)
 id 1kcAMk-00013k-Ea; Mon, 09 Nov 2020 09:50:03 -0700
To: Keith Busch <kbusch@kernel.org>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-16-logang@deltatee.com>
 <20201109150326.GA2221592@dhcp-10-100-145-180.wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e718b81f-9cb8-dfe8-b1a6-ebb79f302732@deltatee.com>
Date: Mon, 9 Nov 2020 09:50:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201109150326.GA2221592@dhcp-10-100-145-180.wdc.com>
Content-Language: en-CA
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: daniel.vetter@ffwll.ch, willy@infradead.org,
 ddutile@redhat.com, jhubbard@nvidia.com, iweiny@intel.com,
 christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 kbusch@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH 15/15] nvme-pci: Allow mmaping the CMB in userspace
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_115015_244340_2B107292 
X-CRM114-Status: GOOD (  14.24  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-pci@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Ira Weiny <iweiny@intel.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Don Dutile <ddutile@redhat.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Dan Williams <dan.j.williams@intel.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2020-11-09 8:03 a.m., Keith Busch wrote:
> On Fri, Nov 06, 2020 at 10:00:36AM -0700, Logan Gunthorpe wrote:
>> Allow userspace to obtain CMB memory by mmaping the controller's
>> char device. The mmap call allocates and returns a hunk of CMB memory,
>> (the offset is ignored) so userspace does not have control over the
>> address within the CMB.
>>
>> A VMA allocated in this way will only be usable by drivers that set
>> FOLL_PCI_P2PDMA when calling GUP. And inter-device support will be
>> checked the first time the pages are mapped for DMA.
>>
>> Currently this is only supported by O_DIRECT to an PCI NVMe device
>> or through the NVMe passthrough IOCTL.
> 
> Rather than make this be specific to nvme, could pci p2pdma create an
> mmap'able file for any resource registered with it?

It's certainly possible. However, other people have been arguing that
more of this should be specific to NVMe as some use cases do not want to
use the genalloc inside p2pdma.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
