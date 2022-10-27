Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11676C67871
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Oct 2022 07:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5nQpf/TOjOvjXkFnBvzaSrRJjeZpmMvbNedZIbrtX8w=; b=FuWprWniQwzRpJkW08hpK5fKwn
	MHw1SsgwYaNyA5orbdKDXMIoDGCsQnn6gDxA1OG5BFtkQI/sFSGjG6pgV+nc3mIHWw4QbsvkEaCQD
	c1uN/0WC2YEWJjDhRoPSerwqY6sm7lTODUfwesUfux+PClRVUEwr5Nstbgc0ltP0vrPZ/f17eCMev
	uNgVk8SkZbNAQj24P7Bkj4EGMEfUA3fPGk9434RMiR4czY6BCRAgbbul8vj9ONm0Ql+WC4rGsfGuB
	Pn8UKCUh2eBDix6BvloOJwaJyZK4zrxOz/29IGphr/AK6ng1WfV1jh1Uf+aJ47izyGVZWsn9M4r+o
	Wv2Q6hfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onx39-00C88j-0x; Thu, 27 Oct 2022 07:11:35 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onx32-00C84q-Fv
	for linux-nvme@lists.infradead.org; Thu, 27 Oct 2022 07:11:34 +0000
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.56])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MycCv6s1gz15MC0;
	Thu, 27 Oct 2022 15:06:19 +0800 (CST)
Received: from [10.40.188.234] (10.40.188.234) by
 kwepemi500015.china.huawei.com (7.221.188.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 27 Oct 2022 15:11:13 +0800
Subject: Re: [PATCH v11 3/9] iov_iter: introduce
 iov_iter_get_pages_[alloc_]flags()
To: Logan Gunthorpe <logang@deltatee.com>, <linux-kernel@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-mm@kvack.org>
CC: Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, =?UTF-8?Q?Christian_K=c3=b6nig?=
	<christian.koenig@amd.com>, John Hubbard <jhubbard@nvidia.com>, Don Dutile
	<ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>, Daniel Vetter
	<daniel.vetter@ffwll.ch>, Minturn Dave B <dave.b.minturn@intel.com>, Jason
 Ekstrand <jason@jlekstrand.net>, Dave Hansen <dave.hansen@linux.intel.com>,
	Xiong Jianxin <jianxin.xiong@intel.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Ira Weiny <ira.weiny@intel.com>, Robin Murphy <robin.murphy@arm.com>, Martin
 Oliveira <martin.oliveira@eideticom.com>, Chaitanya Kulkarni
	<ckulkarnilinux@gmail.com>, Ralph Campbell <rcampbell@nvidia.com>, Stephen
 Bates <sbates@raithlin.com>
References: <20221021174116.7200-1-logang@deltatee.com>
 <20221021174116.7200-4-logang@deltatee.com>
From: Jay Fang <f.fangjian@huawei.com>
Message-ID: <c73c426f-d9f5-2f17-bb88-b72792103703@huawei.com>
Date: Thu, 27 Oct 2022 15:11:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20221021174116.7200-4-logang@deltatee.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.188.234]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221027_001128_965553_219059CC 
X-CRM114-Status: GOOD (  16.85  )
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

On 2022/10/22 1:41, Logan Gunthorpe wrote:
> Add iov_iter_get_pages_flags() and iov_iter_get_pages_alloc_flags()
> which take a flags argument that is passed to get_user_pages_fast().
> 
> This is so that FOLL_PCI_P2PDMA can be passed when appropriate.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/uio.h |  6 ++++++
>  lib/iov_iter.c      | 32 ++++++++++++++++++++++++--------
>  2 files changed, 30 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/uio.h b/include/linux/uio.h
> index 2e3134b14ffd..9ede533ce64c 100644
> --- a/include/linux/uio.h
> +++ b/include/linux/uio.h
> @@ -247,8 +247,14 @@ void iov_iter_pipe(struct iov_iter *i, unsigned int direction, struct pipe_inode
>  void iov_iter_discard(struct iov_iter *i, unsigned int direction, size_t count);
>  void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
>  		     loff_t start, size_t count);
> +ssize_t iov_iter_get_pages(struct iov_iter *i, struct page **pages,
> +		size_t maxsize, unsigned maxpages, size_t *start,
> +		unsigned gup_flags);
>  ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
>  			size_t maxsize, unsigned maxpages, size_t *start);
> +ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
> +		struct page ***pages, size_t maxsize, size_t *start,
> +		unsigned gup_flags);
>  ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
>  			size_t maxsize, size_t *start);
>  int iov_iter_npages(const struct iov_iter *i, int maxpages);
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index c3ca28ca68a6..53efad017f3c 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1430,7 +1430,8 @@ static struct page *first_bvec_segment(const struct iov_iter *i,
>  
>  static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
>  		   struct page ***pages, size_t maxsize,
> -		   unsigned int maxpages, size_t *start)
> +		   unsigned int maxpages, size_t *start,
> +		   unsigned int gup_flags)

Hi,
found some checkpatch warnings, like this:
WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#50: FILE: lib/iov_iter.c:1497:
+		   size_t *start, unsigned gup_flags)

>  {
>  	unsigned int n;
>  
> @@ -1442,7 +1443,6 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
>  		maxsize = MAX_RW_COUNT;
>  
>  	if (likely(user_backed_iter(i))) {
> -		unsigned int gup_flags = 0;
>  		unsigned long addr;
>  		int res;
>  
> @@ -1492,33 +1492,49 @@ static ssize_t __iov_iter_get_pages_alloc(struct iov_iter *i,
>  	return -EFAULT;
>  }
>  
> -ssize_t iov_iter_get_pages2(struct iov_iter *i,
> +ssize_t iov_iter_get_pages(struct iov_iter *i,
>  		   struct page **pages, size_t maxsize, unsigned maxpages,
> -		   size_t *start)
> +		   size_t *start, unsigned gup_flags)
>  {
>  	if (!maxpages)
>  		return 0;
>  	BUG_ON(!pages);
>  
> -	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages, start);
> +	return __iov_iter_get_pages_alloc(i, &pages, maxsize, maxpages,
> +					  start, gup_flags);
> +}
> +EXPORT_SYMBOL_GPL(iov_iter_get_pages);
> +
> +ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
> +		size_t maxsize, unsigned maxpages, size_t *start)
> +{
> +	return iov_iter_get_pages(i, pages, maxsize, maxpages, start, 0);
>  }
>  EXPORT_SYMBOL(iov_iter_get_pages2);
>  
> -ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
> +ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
>  		   struct page ***pages, size_t maxsize,
> -		   size_t *start)
> +		   size_t *start, unsigned gup_flags)
>  {
>  	ssize_t len;
>  
>  	*pages = NULL;
>  
> -	len = __iov_iter_get_pages_alloc(i, pages, maxsize, ~0U, start);
> +	len = __iov_iter_get_pages_alloc(i, pages, maxsize, ~0U, start,
> +					 gup_flags);
>  	if (len <= 0) {
>  		kvfree(*pages);
>  		*pages = NULL;
>  	}
>  	return len;
>  }
> +EXPORT_SYMBOL_GPL(iov_iter_get_pages_alloc);
> +
> +ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
> +		struct page ***pages, size_t maxsize, size_t *start)
> +{
> +	return iov_iter_get_pages_alloc(i, pages, maxsize, start, 0);
> +}
>  EXPORT_SYMBOL(iov_iter_get_pages_alloc2);
>  
>  size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
> 


