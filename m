Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65F4C04A95
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 15:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=f8Du+MtqcshkZAivSawu/fPBgzGqyOuTUC9w0UwA0us=; b=aUBdjYM+fb3wJ/
	DH1A97Q8z3+vusaDsAOR/w+gw288xgRbRpns8V87fMkze/2j6J8a8XRKd7lbDNY3+g+MQRSDqF7PF
	Fz/dz/ih72Wpq8jTAFGZLpg2BzJXye9zkXYz7/oGjCwyOXGLLlCIxYQtRGW0QH4LZB9xoygT638rL
	OcSqibz/7GRgbeP3pE4uZkTeg+GQJPQsgA55oqvA/zc+m/k5EzBKa2VvyjgsUpf0zeRJ4mi0mwqmu
	rGzAacAgELCJ16G8ZnR9XfexCzPfOa8xVl2+Z2IKG3q+iZV4OS2RuylEukF5WrjkopcSovkWw4kEh
	sH+Ped1hKLcvPz5993kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onLzo-0068wS-NB; Tue, 25 Oct 2022 15:37:40 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onLzm-0068vc-QM
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 15:37:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=f8Du+MtqcshkZAivSawu/fPBgzGqyOuTUC9w0UwA0us=; b=ma12HTv07ZvN/PMtXNYq8f4UVE
	tKXtoxcuzCMVqGLKjEXOj7DMUtJYVGj5+rPki6TxyFFCVpP46hxCji5pMn3E9YHtuuherZrziOpaW
	DH0G+ZZM5c5NQTW5Y3uRl0wIvA6qiQ3zQt6Bx/ixCGbeutwRoUdLhsNp/QeIQf9DclGpoHLHCPx8b
	VQ9U8Qs3jUiMZU1aWJnEuAT1K3GPkZ2M0LwAwXaBbiCoSJYnesVrmxPgqhLBib86Lqx3YeRc/zDAW
	IYZAXgSHru2stPrxuF0ZSV1HZTm4k6O75N1xXS/uIro7syUZ3yRkEPuMD0oloe6g8+dQEHQ9Ln/8G
	kHBW5WdA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <logang@deltatee.com>)
	id 1onLzk-00H0S9-TU; Tue, 25 Oct 2022 09:37:37 -0600
Message-ID: <458b5dce-e130-6608-119a-63ccf6bd1eae@deltatee.com>
Date: Tue, 25 Oct 2022 09:37:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-CA
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc: Christoph Hellwig <hch@lst.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
 Ralph Campbell <rcampbell@nvidia.com>, Stephen Bates <sbates@raithlin.com>
References: <20221021174116.7200-1-logang@deltatee.com>
 <20221021174116.7200-7-logang@deltatee.com>
 <f2995bf6-66c9-ea22-bd94-9efb87682a49@nvidia.com>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <f2995bf6-66c9-ea22-bd94-9efb87682a49@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: chaitanyak@nvidia.com, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, gregkh@linuxfoundation.org, dan.j.williams@intel.com, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, sbates@raithlin.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v11 6/9] block: set FOLL_PCI_P2PDMA in
 __bio_iov_iter_get_pages()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_083738_883505_DB5EFC48 
X-CRM114-Status: GOOD (  10.94  )
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



On 2022-10-24 19:23, Chaitanya Kulkarni wrote:
> /*
>>   	 * Each segment in the iov is required to be a block size multiple.
>>   	 * However, we may not be able to get the entire segment if it spans
>> @@ -1217,8 +1221,9 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
>>   	 * result to ensure the bio's total size is correct. The remainder of
>>   	 * the iov data will be picked up in the next bio iteration.
>>   	 */
>> -	size = iov_iter_get_pages2(iter, pages, UINT_MAX - bio->bi_iter.bi_size,
>> -				  nr_pages, &offset);
>> +	size = iov_iter_get_pages(iter, pages,
>> +				  UINT_MAX - bio->bi_iter.bi_size,
>> +				  nr_pages, &offset, gup_flags);
> 
> nit, 3rd param in above call fits on the first line ? plz check :-
> 
> iov_iter_get_pages(iter, pages, UINT_MAX - bio->bi_iter.bi_size,
>                     nr_pages, &offset, gup_flags);

Oh, yup, this just fits. I'll queue up the fix for if I send v12.

Logan

