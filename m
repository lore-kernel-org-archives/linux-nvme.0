Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86FCC2D0A3
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 17:43:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DA5C2151B
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 17:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XOzgXpEH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="BMhMQO2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA5C2151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cRsTL/2RnJZ1VV+0kOIy9vEq/uLlWNdtCPzsJmdzBIE=; b=XOzgXpEHnURUIkLjs7ALJHugV
	UpkZ97EBIh1YIjdNHu8vYVPMSK/AjtMuXAroLpg+txz4jIDcizEPgJiJw+gC0Ki2qbJNg7vYCNN/Y
	G+X/3/yppLEiR1Hr/YMoH+CIeqvEe5c9C0OY10Un5iy/UvIE5h0YSDiwfzAT7EYTVd9iZPSYUQf49
	/iLLfv05qj0pgiG39bGe+WyEcJGg9sT19ZLGObzwZKJtctxFoiRRrakXmMRoDZyO3ACvcYZPuTMz+
	dwBjvrBY4RWn/0TxHzL8ktZUqqNpCst+iSp2rwPSxs4+qjHdJse1SlBumtLgnRJbcrejcs+jd9Vjf
	uYYvXEM6Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb5lr-0001Vo-0T; Fri, 06 Nov 2020 17:43:31 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb5lo-0001UR-0M
 for linux-nvme@lists.infradead.org; Fri, 06 Nov 2020 17:43:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+aVF8hXlDJ8MzPtxX+XTVoXEhgBr/LXYLuXvlOqZpGU=; b=BMhMQO2caJsqnlb1LxCr7nBMdq
 1Z2QCchiWLzUurwt3unaRF8yXphVx9GmAgyCNN72Z8goljgcSPoUwJVAZ1mDzXLyUGcszQIG0YL6V
 Xh3RTrZLilCq+i/q7PRDd0P4JcITPVliaZMPbMnmuO/M8ewMGtTo8uMTblJXHulgQKx9mbUFNcvt2
 5WwjAZfAP0p7IcvHkxV86Nh7/8FKbB35igvhByuo72QPVLb6cKG8TSef4tW5v/Br/8Hnj1dWC+CUd
 xWx2R4ulYSIMFvjaEWxIIrphSNBNS/KyMiSZvesXCRZGPs/wP5ZtVbHSsHSTvIGKOYH2FRcoJ0bNW
 pfRf3Ijw==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1kb5lh-0003H9-4R; Fri, 06 Nov 2020 10:43:22 -0700
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20201106170036.18713-1-logang@deltatee.com>
 <20201106170036.18713-16-logang@deltatee.com>
 <20201106173932.GT36674@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <da53aaa5-94fd-c150-c5a4-8fec042eb196@deltatee.com>
Date: Fri, 6 Nov 2020 10:43:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201106173932.GT36674@ziepe.ca>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: daniel.vetter@ffwll.ch, willy@infradead.org,
 ddutile@redhat.com, jhubbard@nvidia.com, iweiny@intel.com,
 christian.koenig@amd.com, dan.j.williams@intel.com, hch@lst.de,
 sbates@raithlin.com, iommu@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-pci@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH 15/15] nvme-pci: Allow mmaping the CMB in userspace
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201106_124328_074829_CE48CF0D 
X-CRM114-Status: GOOD (  22.35  )
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
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 linux-pci@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Ira Weiny <iweiny@intel.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, John Hubbard <jhubbard@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org




On 2020-11-06 10:39 a.m., Jason Gunthorpe wrote:
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
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>>  drivers/nvme/host/core.c | 11 +++++++++++
>>  drivers/nvme/host/nvme.h |  1 +
>>  drivers/nvme/host/pci.c  |  9 +++++++++
>>  3 files changed, 21 insertions(+)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index f14316c9b34a..fc642aba671d 100644
>> +++ b/drivers/nvme/host/core.c
>> @@ -3240,12 +3240,23 @@ static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
>>  	}
>>  }
>>  
>> +static int nvme_dev_mmap(struct file *file, struct vm_area_struct *vma)
>> +{
>> +	struct nvme_ctrl *ctrl = file->private_data;
>> +
>> +	if (!ctrl->ops->mmap_cmb)
>> +		return -ENODEV;
>> +
>> +	return ctrl->ops->mmap_cmb(ctrl, vma);
>> +}
> 
> This needs to ensure that the VMA created is destroyed before the
> driver is unprobed - ie the struct pages backing the BAR memory is
> destroyed.
> 
> I don't see anything that synchronizes this in the nvme_dev_release()?

Yup, looks like something that needs to be fixed. Though I'd probably do
it in the pci_p2pdma helper code instead.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
