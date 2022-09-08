Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6236BECAAD5
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Sep 2022 11:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mjGYSBVHS8Pul2E4h+ytoHjuUee9SpuJ0Kh6onobmHI=; b=j+0bhR+6jbQV3bVZFba0FtIQzt
	LPY1tbzHwedQDQhc4eCHYhcEwYZbtgsI+fEoOAZdloyl3Mn1ZjqirWcVL6TeiYR+SIHKaFWZHxK5s
	3DU0M5jKmzheFQe7xJHRBzDriZt8wXGCK3izTiZfmEVCbrkt04Jr23m8OG2mtR1LTPu3hh/NHaW+2
	j2lvS0zLnYHGmNDsvtl+fIw/EGLnpYCo3zqOfgBYiy250MKRWwZwXGfdDf6r4H6OiW+3GXojYAMDz
	8o/wZi8l+1Z/oH4BGGcNlji7kIp48m1XCqM/oasleSxKOGsRbE10QHrCxyBW/samm9cLsoW7dtT4F
	6R/DHUaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWFIB-002Wi0-Km; Thu, 08 Sep 2022 11:01:55 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWFI8-002Wgx-FD
	for linux-nvme@lists.infradead.org; Thu, 08 Sep 2022 11:01:54 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220908110149epoutp026ca68f4db6100d84aa905858965d259f~S3aQp8UbH0868108681epoutp02O
	for <linux-nvme@lists.infradead.org>; Thu,  8 Sep 2022 11:01:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220908110149epoutp026ca68f4db6100d84aa905858965d259f~S3aQp8UbH0868108681epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1662634909;
	bh=mjGYSBVHS8Pul2E4h+ytoHjuUee9SpuJ0Kh6onobmHI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BRXLomuZT0D9N3Jqu/I6+2P8IF7+Q6XvcTx3MknblNjMO9alL2GsxPZrFCDWp2sK9
	 eJD4E795AP2q/+cD+LLQlj0za9XKyUh+fpXRuWfkGpZlh7Vnc7WhuvsnGElZ9UIek2
	 GNvuN5I84C6OnJW4GaOYDFD+bN7Ue5Ef4AH8bWGk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20220908110149epcas5p22f21433d49eba507f694fd5880205b82~S3aQS68552856728567epcas5p2t;
	Thu,  8 Sep 2022 11:01:49 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4MNbmB3w3bz4x9Pw; Thu,  8 Sep
	2022 11:01:46 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	19.E5.59633.A9BC9136; Thu,  8 Sep 2022 20:01:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20220908110146epcas5p17115045ae4bfee4e748e0bd811eb4343~S3aNUJpHi1157611576epcas5p1w;
	Thu,  8 Sep 2022 11:01:46 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220908110145epsmtrp2ea5806199c0eff81112b768b46e6c3d5~S3aNTQ2cs2289722897epsmtrp2l;
	Thu,  8 Sep 2022 11:01:45 +0000 (GMT)
X-AuditID: b6c32a49-dfdff7000000e8f1-0d-6319cb9ae6f9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1A.E0.14392.99BC9136; Thu,  8 Sep 2022 20:01:45 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20220908110144epsmtip202afb007005316b104ddeefd360d3885~S3aL3oRVY0626406264epsmtip2K;
	Thu,  8 Sep 2022 11:01:44 +0000 (GMT)
Date: Thu, 8 Sep 2022 16:22:00 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "asml.silence@gmail.com" <asml.silence@gmail.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: Re: [PATCH for-next v5 3/4] block: add helper to map bvec iterator
 for passthrough
Message-ID: <20220908105200.GB15034@test-zns>
MIME-Version: 1.0
In-Reply-To: <81816f51-e720-4f9c-472f-17882f70b4f9@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJJsWRmVeSWpSXmKPExsWy7bCmhu6s05LJBq1/ZSyaJvxltpizahuj
	xeq7/WwW7w8+ZrW4eWAnk8XK1UeZLN61nmOxmHToGqPF3lvaFvOXPWV34PLYOesuu8fls6Ue
	m1Z1snlsXlLvsftmA5tHb/M7No++LasYPT5vkgvgiMq2yUhNTEktUkjNS85PycxLt1XyDo53
	jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAG6UEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xi
	q5RakJJTYFKgV5yYW1yal66Xl1piZWhgYGQKVJiQnfHx2XXmgvUKFdOubGdpYHwu2cXIwSEh
	YCKx7KtcFyMXh5DAbkaJqSv7mbsYOYGcT4wS27pUIRLfGCVWTtjMCpIAafh36SIbRGIvo8Sc
	P/cZIZxnjBLLj21gAqliEVCRmLx3OwvICjYBTYkLk0tBwiICehJXb91gB6lnFtjMLDHt7nIW
	kISwQKzEpWf7wTbwCuhK9PS8ZIewBSVOznwCVsMpYCexdUUzWFxUQFniwLbjTCCDJARWckjs
	aZgOdZ6LxNlt+9kgbGGJV8e3sEPYUhKf3+2FiidLXJp5jgnCLpF4vOcglG0v0XoK4n9mgQyJ
	D8+vQdl8Er2/nzBBwotXoqNNCKJcUeLepKdQa8UlHs5YAmV7SMw+NpcJEijvGSWefmxnnsAo
	NwvJP7OQrICwrSQ6PzSxzgJawSwgLbH8HweEqSmxfpf+AkbWVYySqQXFuempxaYFhnmp5fA4
	Ts7P3cQITrNanjsY7z74oHeIkYmD8RCjBAezkgiv6FqJZCHelMTKqtSi/Pii0pzU4kOMpsD4
	mcgsJZqcD0z0eSXxhiaWBiZmZmYmlsZmhkrivFO0GZOFBNITS1KzU1MLUotg+pg4OKUamKyb
	ChtC+Tb/f1CuVWG37JxPw/J5og9nn/mcWDh5nZ+j4xMnyxTOn1p1SUyNTcm5zvO6jk5MVSg2
	3P8m+8KxG7VpK1ZmJsicqvDzec7y8VLo/hcRe+b0rvPa93+ajMKZxglvfH+pKJUJHy+ckFnZ
	9frtYv2ME6k39rjMitc3P3+dZc7S/8xZ3/fbOR+oq5mdq3n/UGlBnHCVwpSw+E9a+35suC3G
	ZiU65bqgrGFu8dQzvAYPVt/O216a+2Fp/Zc/+pH+/SnRXj9LHhuuCE/Yez5NgTP4Snv6K3XZ
	+ctnrOl6eWbiV4MDs1/Z2Ac4HxRVyriTvKpTI+XTzUqPiHvM/Tcu8zq5Wtw5VVsnPeH2dCWW
	4oxEQy3mouJEABbtIes8BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSvO7M05LJBr/2mls0TfjLbDFn1TZG
	i9V3+9ks3h98zGpx88BOJouVq48yWbxrPcdiMenQNUaLvbe0LeYve8ruwOWxc9Zddo/LZ0s9
	Nq3qZPPYvKTeY/fNBjaP3uZ3bB59W1YxenzeJBfAEcVlk5Kak1mWWqRvl8CVcWvGS/aCh7IV
	2882MTYwbhbvYuTkkBAwkfh36SJbFyMXh5DAbkaJ9WfWskIkxCWar/1gh7CFJVb+ew5mCwk8
	YZSY/tsRxGYRUJGYvHc7SxcjBwebgKbEhcmlIGERAT2Jq7dusIPMZBbYyizx/fcDFpCEsECs
	xKVn+8Hm8wroSvT0vGSHWPyeUaJ7w3kmiISgxMmZT8AamAXMJOZtfsgMsoBZQFpi+T8OkDCn
	gJ3E1hXNYPeICihLHNh2nGkCo+AsJN2zkHTPQuhewMi8ilEytaA4Nz232LDAMC+1XK84Mbe4
	NC9dLzk/dxMjOHK0NHcwbl/1Qe8QIxMH4yFGCQ5mJRFe0bUSyUK8KYmVValF+fFFpTmpxYcY
	pTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwKXSYdLqruspFWKQ37F/yNbWXP1Vf08Wu
	YiKDhZwpU6huf3isQ4qnwa2nJeyxSSKXzTxfsayeNvHPhny+zQIuHxhutGoJv+M8Gb41e15b
	ynqNMsU7b0M2RLhlMuSmFQdxBie8jH5nn5Dk8dLq45ubu7dzCD6v1Vr6q2lfe73W5T4N/rVs
	9w49Xqui9bF3sYO8pNX6gzffyB++zHJo47JD/X9jPb+LS+uV/Jpf77tN/dep4M7t76bdLy+N
	zjuv7hft3WfRdXfGuuqH7fFLfrH9zr/3NaEtgWtH38LP/aYrmc14TW+GHwjYeP98hajImZ5z
	v4/ZXrr0Yn+Mjof+15QXi54pLa1g5300mTnJf6kSS3FGoqEWc1FxIgBbHsh+CwMAAA==
X-CMS-MailID: 20220908110146epcas5p17115045ae4bfee4e748e0bd811eb4343
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----STjx0DdB5XWzR39.p0qqcVQtF-toHyOxq53rKg1ScZo20x2r=_f0a20_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220906063729epcas5p1bf05e6873de0f7246234380d66c21fb9
References: <20220906062721.62630-1-joshi.k@samsung.com>
	<CGME20220906063729epcas5p1bf05e6873de0f7246234380d66c21fb9@epcas5p1.samsung.com>
	<20220906062721.62630-4-joshi.k@samsung.com>
	<81816f51-e720-4f9c-472f-17882f70b4f9@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220908_040152_862961_90474121 
X-CRM114-Status: GOOD (  22.99  )
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

------STjx0DdB5XWzR39.p0qqcVQtF-toHyOxq53rKg1ScZo20x2r=_f0a20_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Wed, Sep 07, 2022 at 03:32:26PM +0000, Chaitanya Kulkarni wrote:
>On 9/5/22 23:27, Kanchan Joshi wrote:
>> Add blk_rq_map_user_bvec which maps the bvec iterator into a bio and
>> places that into the request. This helper will be used in nvme for
>> uring-passthrough with fixed-buffer.
>> While at it, create another helper bio_map_get to reduce the code
>> duplication.
>>
>> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
>> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
>> ---
>>   block/blk-map.c        | 94 +++++++++++++++++++++++++++++++++++++-----
>>   include/linux/blk-mq.h |  1 +
>>   2 files changed, 85 insertions(+), 10 deletions(-)
>>
>> diff --git a/block/blk-map.c b/block/blk-map.c
>> index f3768876d618..e2f268167342 100644
>> --- a/block/blk-map.c
>> +++ b/block/blk-map.c
>> @@ -241,17 +241,10 @@ static void bio_map_put(struct bio *bio)
>>   	}
>>   }
>>
>> -static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>> +static struct bio *bio_map_get(struct request *rq, unsigned int nr_vecs,
>>   		gfp_t gfp_mask)
>>   {
>> -	unsigned int max_sectors = queue_max_hw_sectors(rq->q);
>> -	unsigned int nr_vecs = iov_iter_npages(iter, BIO_MAX_VECS);
>>   	struct bio *bio;
>> -	int ret;
>> -	int j;
>> -
>> -	if (!iov_iter_count(iter))
>> -		return -EINVAL;
>>
>>   	if (rq->cmd_flags & REQ_POLLED) {
>>   		blk_opf_t opf = rq->cmd_flags | REQ_ALLOC_CACHE;
>> @@ -259,13 +252,31 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>>   		bio = bio_alloc_bioset(NULL, nr_vecs, opf, gfp_mask,
>>   					&fs_bio_set);
>>   		if (!bio)
>> -			return -ENOMEM;
>> +			return NULL;
>>   	} else {
>>   		bio = bio_kmalloc(nr_vecs, gfp_mask);
>>   		if (!bio)
>> -			return -ENOMEM;
>> +			return NULL;
>>   		bio_init(bio, NULL, bio->bi_inline_vecs, nr_vecs, req_op(rq));
>>   	}
>> +	return bio;
>> +}
>> +
>> +static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>> +		gfp_t gfp_mask)
>> +{
>> +	unsigned int max_sectors = queue_max_hw_sectors(rq->q);
>> +	unsigned int nr_vecs = iov_iter_npages(iter, BIO_MAX_VECS);
>> +	struct bio *bio;
>> +	int ret;
>> +	int j;
>> +
>> +	if (!iov_iter_count(iter))
>> +		return -EINVAL;
>> +
>> +	bio = bio_map_get(rq, nr_vecs, gfp_mask);
>> +	if (bio == NULL)
>> +		return -ENOMEM;
>>
>>   	while (iov_iter_count(iter)) {
>>   		struct page **pages, *stack_pages[UIO_FASTIOV];
>> @@ -612,6 +623,69 @@ int blk_rq_map_user(struct request_queue *q, struct request *rq,
>>   }
>>   EXPORT_SYMBOL(blk_rq_map_user);
>>
>> +/* Prepare bio for passthrough IO given an existing bvec iter */
>> +int blk_rq_map_user_bvec(struct request *rq, struct iov_iter *iter)
>> +{
>> +	struct request_queue *q = rq->q;
>> +	size_t iter_count, nr_segs;
>> +	struct bio *bio;
>> +	struct bio_vec *bv, *bvec_arr, *bvprvp = NULL;
>> +	struct queue_limits *lim = &q->limits;
>> +	unsigned int nsegs = 0, bytes = 0;
>> +	int ret, i;
>> +
>
>consider this (untested), it also sets the variable i data type same
>as it comparison variable in nr_segs the loop i.e. size_t :-
>
>+       struct bio_vec *bv, *bvec_arr, *bvprvp = NULL;
>+       struct request_queue *q = rq->q;
>+       struct queue_limits *lim = &q->limits;
>+       unsigned int nsegs = 0, bytes = 0;
>+       size_t iter_count, nr_segs, i;
>+       struct bio *bio;
>+       int ret;
>
>
>> +	iter_count = iov_iter_count(iter);
>> +	nr_segs = iter->nr_segs;
>> +
>> +	if (!iter_count || (iter_count >> 9) > queue_max_hw_sectors(q))
>> +		return -EINVAL;
>
>can we remove braces for iter_count >> 9 without impacting the intended
>functionality?

I think removing that make it hard to read.
I will fold all other changes you mentioned in v6.


------STjx0DdB5XWzR39.p0qqcVQtF-toHyOxq53rKg1ScZo20x2r=_f0a20_
Content-Type: text/plain; charset="utf-8"


------STjx0DdB5XWzR39.p0qqcVQtF-toHyOxq53rKg1ScZo20x2r=_f0a20_--

