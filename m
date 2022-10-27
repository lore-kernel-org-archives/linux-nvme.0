Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D3DFA3744
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Oct 2022 14:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LyOCU4xpjTTzBhxH1rdyd7TExb5ifJ5snNn8tAmKhaY=; b=ZP5NUnCWV9ZyEW
	OEU6Olf4tW+ekOY+5Y9ZfI8gzWjOgpPxK1SiUz4IaDiUJR07DkdeRWZKWunW08khqNFdi6lIkgop2
	bEVnhlW473d285AyCYgSWnL48X7m6tlyuTzw2oWQrmtL66EtGeHD910OT8e04Yd8qoq3/Gaon44fV
	Nve4Kcrd7LFnxqYJ1Kp7CouXmw1osjJKlJKmPH3MtW1ZnQLFGnNRni6PfNP5gHrt2WUffwRrdFGIj
	QQUk0YLg94q9CsX5ai+Ppyns9e4SClNHOJ83y4o0KXcXXgElZcemzL7jpSKmKj3aKQONikjRiUlZ0
	1mrSdvb0dEDWR0dbOwXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo3mr-00Dn9w-7f; Thu, 27 Oct 2022 14:23:13 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo3mo-00Dn9H-BS
	for linux-nvme@lists.infradead.org; Thu, 27 Oct 2022 14:23:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=LyOCU4xpjTTzBhxH1rdyd7TExb5ifJ5snNn8tAmKhaY=; b=MAQjGDL+n0Jp7ezjgZqNWaIPdv
	kbAEpt3r4ap1EWC5XSVaw+OWN25y8+PPt63ZAA/BusDAV9ToTonAcRLlj3w7fE+XaTQBJ7DGoz3EM
	SciMfLGcUvNFBUwWlWabew4Xe3Nzv082uIYP1utpislLqNawQNXRwtcU7DIddQsndpd99Ljp3ol+v
	W95zxl5FEpr8Wp9GGLpXq/tdZHIxpM9OetLizn6UBfYQu69h8t0JlJ6xK8wINfYHzqeqgD6tYCDit
	jMpUoU+WzmqoLrPPWbM/jNu5FXoc8kKf+w89lF6byFO6bjdU12S+7MUCGNmexF+f/TZRFmj7FoNSY
	AOrYbDQg==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <logang@deltatee.com>)
	id 1oo3mi-0012H3-V8; Thu, 27 Oct 2022 08:23:06 -0600
Message-ID: <e27a14f9-ed4d-b98b-940c-2ede0ebcb31b@deltatee.com>
Date: Thu, 27 Oct 2022 08:22:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-CA
To: Jay Fang <f.fangjian@huawei.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org
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
 <20221021174116.7200-4-logang@deltatee.com>
 <c73c426f-d9f5-2f17-bb88-b72792103703@huawei.com>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <c73c426f-d9f5-2f17-bb88-b72792103703@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: f.fangjian@huawei.com, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, gregkh@linuxfoundation.org, dan.j.williams@intel.com, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, sbates@raithlin.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v11 3/9] iov_iter: introduce
 iov_iter_get_pages_[alloc_]flags()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221027_072310_469318_2B314860 
X-CRM114-Status: GOOD (  14.61  )
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



On 2022-10-27 01:11, Jay Fang wrote:
> On 2022/10/22 1:41, Logan Gunthorpe wrote:
>> Add iov_iter_get_pages_flags() and iov_iter_get_pages_alloc_flags()
>> which take a flags argument that is passed to get_user_pages_fast().
>>
>> This is so that FOLL_PCI_P2PDMA can be passed when appropriate.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> ---
>>  include/linux/uio.h |  6 ++++++
>>  lib/iov_iter.c      | 32 ++++++++++++++++++++++++--------
>>  2 files changed, 30 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/uio.h b/include/linux/uio.h
>> index 2e3134b14ffd..9ede533ce64c 100644
>> --- a/include/linux/uio.h
>> +++ b/include/linux/uio.h
>> @@ -247,8 +247,14 @@ void iov_iter_pipe(struct iov_iter *i, unsigned int direction, struct pipe_inode
>>  void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count);
>>  void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
>>  		     loff_t start, size_t count);
>> +ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
>> +		size_t maxsize, unsigned maxpages, size_t *start,
>> +		unsigned gup_flags);
>>  ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
>>  			size_t maxsize, unsigned maxpages, size_t *start);
>> +ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
>> +		struct page ***pages, size_t maxsize, size_t *start,
>> +		unsigned gup_flags);
>>  ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
>>  			size_t maxsize, size_t *start);
>>  int iov_iter_npages(const struct iov_iter *i, int maxpages);
>> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
>> index c3ca28ca68a6..53efad017f3c 100644
>> --- a/lib/iov_iter.c
>> +++ b/lib/iov_iter.c
>> @@ -1430,7 +1430,8 @@ static struct page *first_bvec_segment(const struct iov_iter *i,
>>  
>>  static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
>>  		   struct page ***pages, size_t maxsize,
>> -		   unsigned int maxpages, size_t *start)
>> +		   unsigned int maxpages, size_t *start,
>> +		   unsigned int gup_flags)
> 
> Hi,
> found some checkpatch warnings, like this:
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> #50: FILE: lib/iov_iter.c:1497:
> +		   size_t *start, unsigned gup_flags)

We usually stick with the choices of the nearby code instead of
the warnings of checkpatch.

Thanks,

Logan

