Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBD7ECAAD1
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Sep 2022 16:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gWB7AkU129dDdxRryZ2jSpLBk9x3EnCafEtHnrURW1U=; b=kS6av/pJSEP/P3
	XqFdvwzi0qHXTRdkEpeYT3Ae1DEg7a6PxWHLoaF0LQVgp1AZ1xVHGMPUV2feTKAWAXtjnJKzCoGe5
	MTQx9ZgxsfFtwySn7CAE4Vcb2cQzCa5Qb4AD561u/S0FzjX2WY9QLaVfRJ8HpDH4FpxjNRJkayjS5
	WAGlP0C84o7Tj9y1W7J79RNy//E4PbsFiXVs1UxmRugYKGm1K14cQITFdHer6MeGkESjTgwNOSUCw
	ZXiptkhQ6ojokyEAShbIONMYX8XusJ3d4B0fqgPu4JB/jQ5rqWb+VMlFOO6yBFhU6yaQh5itTcBke
	+OeJwIigzOx48+W+lGlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTn81-00DMvN-9G; Thu, 01 Sep 2022 16:33:17 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTn7z-00DMtO-74
	for linux-nvme@lists.infradead.org; Thu, 01 Sep 2022 16:33:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=gWB7AkU129dDdxRryZ2jSpLBk9x3EnCafEtHnrURW1U=; b=tzIU9tkaQtRCXK/eQMdFUjouq/
	OLtnRxLdR21K25rOsuC+rxqm88C8fy+h5QFzqBi5dr+pejTjEcIOtgtfluefiWi8f+Z0TyEsGMkUM
	RDqnH0TVRjgNzHYN+Ijg6jowNK+jo5x3fdGoCdNLzu9SoyK7hAn45jikbhtgsg21e5bnkOkYaJ0yn
	KCfM22nWcOfx7h4G5F8xF93Ds76Ovr1puzkD8KNrduc9/bMuCmkmGfieORAwe4SPRikaF6SE1c1ny
	igT/8FqPdbeNMVjMAsiLVNpvf758gTZlwhapo93t6+wJQ/e5hwMvcYXbMDQ7gQ/58Uu62aFQJ5lO3
	wjlC7nqw==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <logang@deltatee.com>)
	id 1oTn7x-00DuVQ-Oi; Thu, 01 Sep 2022 10:33:14 -0600
Message-ID: <33207035-17b3-4873-afba-51a0665ca30c@deltatee.com>
Date: Thu, 1 Sep 2022 10:33:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-CA
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 Christoph Hellwig <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>, John Hubbard <jhubbard@nvidia.com>,
 Don Dutile <ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Ralph Campbell <rcampbell@nvidia.com>, Stephen Bates <sbates@raithlin.com>
References: <20220825152425.6296-1-logang@deltatee.com>
 <20220825152425.6296-9-logang@deltatee.com> <YxDbQ3CBlQVvQFIW@kroah.com>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <YxDbQ3CBlQVvQFIW@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, dan.j.williams@intel.com, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, sbates@raithlin.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v9 8/8] ABI: sysfs-bus-pci: add documentation for p2pmem
 allocate
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220901_093315_318790_34A3C166 
X-CRM114-Status: GOOD (  15.64  )
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



On 2022-09-01 10:18, Greg Kroah-Hartman wrote:
> On Thu, Aug 25, 2022 at 09:24:25AM -0600, Logan Gunthorpe wrote:
>> Add documentation for the p2pmem/allocate binary file which allows
>> for allocating p2pmem buffers in userspace for passing to drivers
>> that support them. (Currently only O_DIRECT to NVMe devices.)
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> ---
>>  Documentation/ABI/testing/sysfs-bus-pci | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
>> index 6fc2c2efe8ab..dca5e032b4fa 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-pci
>> +++ b/Documentation/ABI/testing/sysfs-bus-pci
>> @@ -171,7 +171,7 @@ Description:
>>  		binary file containing the Vital Product Data for the
>>  		device.  It should follow the VPD format defined in
>>  		PCI Specification 2.1 or 2.2, but users should consider
>> -		that some devices may have incorrectly formatted data.  
>> +		that some devices may have incorrectly formatted data.
>>  		If the underlying VPD has a writable section then the
>>  		corresponding section of this file will be writable.
>>  
> 
> Not relevant change :(

Oops! Will fix.

Thanks,

Logan

