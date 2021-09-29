Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368CCC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 21:42:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF97610CC
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 21:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EAF97610CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oR5Mjc9Qn0WF+A4oblbLXIaBPgL9kcro6nxnGb56epg=; b=VfkSRZHw2BpSUU
	uk0myVcxHvn4rLxM/s8omEHZb8xpmh1XuePNVg79B2ZTDHkAJasVC39sAJqIb2fKR4hkb5ab8fcM3
	8KyGYmpqHvwX/XN+pyRwIA/BwB8kfMxEISgMUC07yB/AOJS8jH9Ke3sl1dN69wINx0ltLq512Rk7y
	D+DtS5rC8zRY4JaX3j6K3eiQ3x7AEw+KnCqID9t+HfygiB/Uo/PxtjxngXllUhjfOcAWSoloLihgP
	eFj7DxNGNSBsxMeZIjKpKxSoaP2Wk71FJjpPtfOlCGG7eTCKpnEOCEosvd3xhaD1GAhNwd/dRadAR
	tbG6lB1NcN0pG52PKtpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVhLF-00CPhw-0M; Wed, 29 Sep 2021 21:42:17 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVhLC-00CPh5-6u
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 21:42:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:content-disposition;
 bh=3WA1KpyUg4a9gkCdh4NdRSTCNhCxgDrQHUyIFuEcPKQ=; b=YQ7Pgy3UA4s4WDhJgR56ldVLZa
 aarTUnhSWeZoaQ9XqoPtb8J4kCHbW5DZWtfpd6kiFewgouwOGQmyuMkSarYIcMeXLTQt4tDJSPf4a
 s3Cles1vcGAIVK5HH+sKtExXol+X/LJ0ITXpylU2RUjtAfnFitq7egHhPN+vnbLfsjBT727eeJJYW
 H7b2kX4EmNJ56lcfRB71Eg53F9hf8LVdioB4nnhm6Gm5kaDhd+o1XSlQkhJU859u9pc2Kf8Ej5LEB
 QjScyz4JhjwVsjawSaxV3AQfZ0qXHixKZL72zEfKVQ17MznS+q5nLDZ+sbw85NHk2exob1mrzGBrY
 X59623ew==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1mVhL0-0006W2-Fd; Wed, 29 Sep 2021 15:42:03 -0600
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
 <20210916234100.122368-20-logang@deltatee.com>
 <20210928195518.GV3544071@ziepe.ca>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8d386273-c721-c919-9749-fc0a7dc1ed8b@deltatee.com>
Date: Wed, 29 Sep 2021 15:42:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210928195518.GV3544071@ziepe.ca>
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
Subject: Re: [PATCH v3 19/20] PCI/P2PDMA: introduce pci_mmap_p2pmem()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210929_144214_265566_A78EE5E4 
X-CRM114-Status: GOOD (  16.78  )
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



On 2021-09-28 1:55 p.m., Jason Gunthorpe wrote:
> On Thu, Sep 16, 2021 at 05:40:59PM -0600, Logan Gunthorpe wrote:
>> +int pci_mmap_p2pmem(struct pci_dev *pdev, struct vm_area_struct *vma)
>> +{
>> +	struct pci_p2pdma_map *pmap;
>> +	struct pci_p2pdma *p2pdma;
>> +	int ret;
>> +
>> +	/* prevent private mappings from being established */
>> +	if ((vma->vm_flags & VM_MAYSHARE) != VM_MAYSHARE) {
>> +		pci_info_ratelimited(pdev,
>> +				     "%s: fail, attempted private mapping\n",
>> +				     current->comm);
>> +		return -EINVAL;
>> +	}
>> +
>> +	pmap = pci_p2pdma_map_alloc(pdev, vma->vm_end - vma->vm_start);
>> +	if (!pmap)
>> +		return -ENOMEM;
>> +
>> +	rcu_read_lock();
>> +	p2pdma = rcu_dereference(pdev->p2pdma);
>> +	if (!p2pdma) {
>> +		ret = -ENODEV;
>> +		goto out;
>> +	}
>> +
>> +	ret = simple_pin_fs(&pci_p2pdma_fs_type, &pci_p2pdma_fs_mnt,
>> +			    &pci_p2pdma_fs_cnt);
>> +	if (ret)
>> +		goto out;
>> +
>> +	ihold(p2pdma->inode);
>> +	pmap->inode = p2pdma->inode;
>> +	rcu_read_unlock();
>> +
>> +	vma->vm_flags |= VM_MIXEDMAP;
> 
> Why is this a VM_MIXEDMAP? Everything fault sticks in here has a
> struct page, right?

Yes. This decision is not so simple, I tried a few variations before
settling on this.

The main reason is probably this: if we don't use VM_MIXEDMAP, then we
can't set pte_devmap(). If we don't set pte_devmap(), then every single
page that GUP processes needs to check if it's a ZONE_DEVICE page and
also if it's a P2PDMA page (thus dereferencing pgmap) in order to
satisfy the requirements of FOLL_PCI_P2PDMA.

I didn't think other developers would go for that kind of performance
hit. With VM_MIXEDMAP we hide the performance penalty behind the
existing check. And with the current pgmap code as is, we only need to
do that check once for every new pgmap pointer.

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
