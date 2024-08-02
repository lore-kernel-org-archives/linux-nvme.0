Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B04BC3DA7F
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 03:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o1VuG22BS9DaP4wx49W1xoCTDYwmTxC1L8+ARqes2ck=; b=WhUX4IySnJQe7kdfWq9TL8ysxt
	rA9lgA416LZTiCVmlpIK43/5rIapwUXIP2m2ix/5lVxS6Mj0ccrOjbZTmrrUMHh7fsj2YZVxdFJim
	ypkD780ovRe6mx1s3iMIPZII9e9A2rMMEm5M8eyD1z47DD/O6J3/CahhCT1qbZcNVgzJOxUl2uvNg
	FftN5dSHIKIpXUkENEQ8ZRE4LQb2t4fkt2NPdPBacsGPFY4uvZf3MVbjPu8RTJdNtmfNPvJVidsTo
	pksq/V6t4QLnYaoN62lHJMEWK7ZHKnhQRdyARUBlNPDn3C0Lwn4zQ0iHJqEvgMdUQYiPz1p9WixAT
	PUUcDZeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbAef-00000000LGh-1wu8;
	Tue, 06 Aug 2024 03:14:33 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZpAt-00000008P0W-0lx5;
	Fri, 02 Aug 2024 10:06:17 +0000
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wb1ZM6Y7HzQnl8;
	Fri,  2 Aug 2024 18:01:31 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0F1351800A1;
	Fri,  2 Aug 2024 18:05:53 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 2 Aug 2024 18:05:52 +0800
Message-ID: <877efebe-f316-4192-aada-dd2657b74125@huawei.com>
Date: Fri, 2 Aug 2024 18:05:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 04/14] mm: page_frag: add '_va' suffix to
 page_frag API
To: Alexander Duyck <alexander.duyck@gmail.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Subbaraya Sundeep
	<sbhatta@marvell.com>, Jeroen de Borst <jeroendb@google.com>, Praveen
 Kaligineedi <pkaligineedi@google.com>, Shailend Chand <shailend@google.com>,
	Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Sunil Goutham
	<sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>, hariprasad
	<hkelam@marvell.com>, Felix Fietkau <nbd@nbd.name>, Sean Wang
	<sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Keith
 Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
	<jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>,
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, Neil
 Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, Dai Ngo
	<Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, Trond Myklebust
	<trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <linux-nvme@lists.infradead.org>,
	<kvm@vger.kernel.org>, <virtualization@lists.linux.dev>,
	<linux-mm@kvack.org>, <bpf@vger.kernel.org>, <linux-afs@lists.infradead.org>,
	<linux-nfs@vger.kernel.org>
References: <20240731124505.2903877-1-linyunsheng@huawei.com>
 <20240731124505.2903877-5-linyunsheng@huawei.com>
 <CAKgT0UcqdeSJdjZ_FfwyCnT927TwOkE4zchHLOkrBEmhGzex9g@mail.gmail.com>
 <22fda86c-d688-42e7-99e8-e2f8fcf1a5ba@huawei.com>
 <CAKgT0UcuGj8wvC87=A+hkarRupfhjGM0BPzLUT2AJc8Ovg_TFg@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0UcuGj8wvC87=A+hkarRupfhjGM0BPzLUT2AJc8Ovg_TFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.120.129]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240802_030615_814972_C9356F52 
X-CRM114-Status: GOOD (  26.05  )
X-Mailman-Approved-At: Mon, 05 Aug 2024 20:14:30 -0700
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

On 2024/8/1 23:21, Alexander Duyck wrote:
> On Thu, Aug 1, 2024 at 6:01 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2024/8/1 2:13, Alexander Duyck wrote:
>>> On Wed, Jul 31, 2024 at 5:50 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>>>
>>>> Currently the page_frag API is returning 'virtual address'
>>>> or 'va' when allocing and expecting 'virtual address' or
>>>> 'va' as input when freeing.
>>>>
>>>> As we are about to support new use cases that the caller
>>>> need to deal with 'struct page' or need to deal with both
>>>> 'va' and 'struct page'. In order to differentiate the API
>>>> handling between 'va' and 'struct page', add '_va' suffix
>>>> to the corresponding API mirroring the page_pool_alloc_va()
>>>> API of the page_pool. So that callers expecting to deal with
>>>> va, page or both va and page may call page_frag_alloc_va*,
>>>> page_frag_alloc_pg*, or page_frag_alloc* API accordingly.
>>>>
>>>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>>>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>>>> Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
>>>
>>> I am naking this patch. It is a pointless rename that is just going to
>>> obfuscate the git history for these callers.
>>
>> I responded to your above similar comment in v2, and then responded more
>> detailedly in v11, both got not direct responding, it would be good to
>> have more concrete feedback here instead of abstract argument.
>>
>> https://lore.kernel.org/all/74e7259a-c462-e3c1-73ac-8e3f49fb80b8@huawei.com/
>> https://lore.kernel.org/all/11187fe4-9419-4341-97b5-6dad7583b5b6@huawei.com/
> 
> I will make this much more understandable. This patch is one of the
> ones that will permanently block this set in my opinion. As such I
> will never ack this patch as I see no benefit to it. Arguing with me
> on this is moot as you aren't going to change my mind, and I don't
> have all day to argue back and forth with you on every single patch.

Let's move on to more specific technical discussion then.

> 
> As far as your API extension and naming maybe you should look like
> something like bio_vec and borrow the naming from that since that is
> essentially what you are passing back and forth is essentially that
> instead of a page frag which is normally a virtual address.

I thought about adding something like bio_vec before, but I am not sure
what you have in mind is somthing like I considered before?
Let's say that we reuse bio_vec like something below for the new APIs:

struct bio_vec {
	struct page	*bv_page;
	void		*va;
	unsigned int	bv_len;
	unsigned int	bv_offset;
};

It seems we have the below options for the new API:

option 1, it seems like a better option from API naming point of view, but
it needs to return a bio_vec pointer to the caller, it seems we need to have
extra space for the pointer, I am not sure how we can avoid the memory waste
for sk_page_frag() case in patch 12:
struct bio_vec *page_frag_alloc_bio(struct page_frag_cache *nc,
				    unsigned int fragsz, gfp_t gfp_mask);

option 2, it need both the caller and callee to have a its own local space
for 'struct bio_vec ', I am not sure if passing the content instead of
the pointer of a struct through the function returning is the common pattern
and if it has any performance impact yet:
struct bio_vec page_frag_alloc_bio(struct page_frag_cache *nc,
				   unsigned int fragsz, gfp_t gfp_mask);

option 3, the caller passes the pointer of 'struct bio_vec ' to the callee,
and page_frag_alloc_bio() fills in the data, I am not sure what is the point
of indirect using 'struct bio_vec ' instead of passing 'va' & 'fragsz' &
'offset' through pointers directly:
bool page_frag_alloc_bio(struct page_frag_cache *nc,
			 unsigned int fragsz, gfp_t gfp_mask, struct bio_vec *bio);

If one of the above option is something in your mind? Yes, please be more specific
about which one is the prefer option, and why it is the prefer option than the one
introduced in this patchset?

If no, please be more specific what that is in your mind?


