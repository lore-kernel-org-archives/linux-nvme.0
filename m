Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F4AECAAD5
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 17:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oQfM+bbedgrkFi9Dsc85HjLHDXM0DDmDD1eypkwzHoM=; b=H5dK+vSxUoO7P7
	/usprW2O9uYxSihuVyc/gQsf+kQUsGs3hLOEWPjzWfWIWr43hrTHmA4BeS/vzEsQjPnSqytbZephn
	gd7Pb5iKcTG9VEPJhLU2hMbKzlkep577cRUSGqfgiUplsGN6GbR6kkBupaeiS3GJEPuYGXEo+sN9Y
	VdW4xGFrycGqh3AuIj2XuBF8KH70MwDqrsx1Jw8ORFYQ9ko1wsnSzjJEO06PDmqsLMDhAFTQVU0ZM
	1apuaGsw3zSHRUj2VbNJ/Nqn4TAZ4uKmjDvvtLs1J82RMtWjK/Mt0vBNne/QgPv3CvDbmrBhME7Sj
	JmcEpl4kLhdyNG3VQ8jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVc69-00Fmkd-ME; Tue, 06 Sep 2022 17:10:53 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVboe-00FdCg-0t
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 16:52:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=oQfM+bbedgrkFi9Dsc85HjLHDXM0DDmDD1eypkwzHoM=; b=D58L0g/IbRJh0NwzF1kBsWd+Sp
	b5rUpHebAhlqXJVTYhn7VJeETG6epcXYVUe3HnihWpolRiQFsxdX7FQUp1tmYW/B4jqW4hn/Rp+Jk
	Jq3yo6xlTaeaEljYRVbASSeSwrvunYqqBafdoBgbFO6BVZfVg5xeqSwz8YCIzz1BqQulVG8GYhiQW
	Z9QPU88VVEly+0Y+BvB1f5zpXlCsxmIcy55BrN73xxsKSF8+/U1iry3rB4/TTWNMYnfGWbH6zyxWd
	lB7nAn02WSXZgMpn/R0eqy57Fqqb2NJjEgadbl0CJNJc1y0GkaKqZlgtVL1J8Xjvg+xyZxW+5mRsF
	GyNaxlJg==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <logang@deltatee.com>)
	id 1oVboX-000Gty-8S; Tue, 06 Sep 2022 10:52:42 -0600
Message-ID: <8d76a5b2-3185-369e-caf6-4670d4339fce@deltatee.com>
Date: Tue, 6 Sep 2022 10:52:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-CA
To: John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org
Cc: Christoph Hellwig <hch@lst.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
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
 <20220825152425.6296-3-logang@deltatee.com>
 <24ee706f-b70c-28d0-15a7-13d0dc9254bb@nvidia.com>
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <24ee706f-b70c-28d0-15a7-13d0dc9254bb@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: jhubbard@nvidia.com, linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, gregkh@linuxfoundation.org, dan.j.williams@intel.com, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, dave.b.minturn@intel.com, jason@jlekstrand.net, dave.hansen@linux.intel.com, jianxin.xiong@intel.com, helgaas@kernel.org, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, rcampbell@nvidia.com, sbates@raithlin.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v9 2/8] iov_iter: introduce
 iov_iter_get_pages_[alloc_]flags()
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_095248_178237_F2B362F9 
X-CRM114-Status: GOOD (  17.06  )
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



On 2022-09-05 17:21, John Hubbard wrote:
> Looking ahead, interestingly enough, it turns out that this approach to
> the wrappers is really pretty close to what I posted in patch 4/7 of my
> "convert most filesystems to pin_user_pages_fast()" series [1]. Instead
> of passing gup_flags through, I tried to avoid that (because FOLL_PIN
> is, as a mild design preference, supposed to remain internal to gup.c),
> but given that you need to do it, I think I can just build on top of
> your approach, and pass in FOLL_PIN via your new gup_flags arg.

Seems to me like we could just provide the one exported function with a
flag then use an static inline helper for the pin version. That would
help keep the FOLL_PIN flag contained as you like.

> Along those lines, I've copied you in on "New topic branch for block + 
> gup work?", let's see what happens over there.
> 
> [1] https://lore.kernel.org/r/20220831041843.973026-1-jhubbard@nvidia.com

Thanks for the review. All the feedback makes sense. I'll apply all the
changes from you and Christoph for the next version.

I'm happy to base the next version off of any other changes to the iov
functions. I suspect my patches can hold off a cycle or two more while
we do it. Let me know if you'd like some help making the conversions,
I'm also fine to do some work to aid with the effort.

Thanks,

Logan


