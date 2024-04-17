Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB96C04FF6
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Apr 2024 15:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:CC:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FDzWnSlq74AzsNs+2Gtmdpu32oqvbvNVWifQvd45vz8=; b=A4arBiUF/Cy5G789CcSNGbarZ6
	MpI1WCWXKWIFPTX550BrUVbcQ0gxW3udGw2UFmQunVvVM/5askQ01vJL3H1PQhifAodnCjkWY6E3J
	ErtDzPnO7G/TFPp5cIFOfE682oArD1tsATD/Pl4h6lgDHKIPeRa7F078nbXsKkCKD9Lq30HEsAjCn
	X+bbJdIS99OG/Qvr3Og8xYUcUB1AAYf3B+DdjTcuWHoAXyDee5qbXlrvJtli913kUR1YeUamaABdH
	SBNYM6+StYnUaBl4qRgkbXVo/HEHzYB5Xg/TLwBnB4fZVNvKo0LG4Ig4TsM55sKKZ2hlhR0CScmkr
	FVqtqn8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxqSB-00000006E8t-3PCv;
	Fri, 19 Apr 2024 15:47:07 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx5Bd-0000000G5Hp-0emy;
	Wed, 17 Apr 2024 13:18:54 +0000
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VKLxQ3gh3zXlNZ;
	Wed, 17 Apr 2024 21:15:22 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 812AD140485;
	Wed, 17 Apr 2024 21:18:41 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 17 Apr
 2024 21:18:41 +0800
Subject: Re: [PATCH net-next v2 07/15] mm: page_frag: add '_va' suffix to
 page_frag API
To: Alexander H Duyck <alexander.duyck@gmail.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Jeroen de Borst
	<jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>, Eric Dumazet <edumazet@google.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Sunil Goutham <sgoutham@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>, Felix Fietkau <nbd@nbd.name>, Sean Wang
	<sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Keith
 Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
	<jasowang@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
	<jolsa@kernel.org>, David Howells <dhowells@redhat.com>, Marc Dionne
	<marc.dionne@auristor.com>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton
	<jlayton@kernel.org>, Neil Brown <neilb@suse.de>, Olga Kornievskaia
	<kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
	<tom@talpey.com>, Trond Myklebust <trond.myklebust@hammerspace.com>, Anna
 Schumaker <anna@kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-nvme@lists.infradead.org>, <kvm@vger.kernel.org>,
	<virtualization@lists.linux.dev>, <linux-mm@kvack.org>,
	<bpf@vger.kernel.org>, <linux-afs@lists.infradead.org>,
	<linux-nfs@vger.kernel.org>
References: <20240415131941.51153-1-linyunsheng@huawei.com>
 <20240415131941.51153-8-linyunsheng@huawei.com>
 <18ca19fa64267b84bee10473a81cbc63f53104a0.camel@gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <74e7259a-c462-e3c1-73ac-8e3f49fb80b8@huawei.com>
Date: Wed, 17 Apr 2024 21:18:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <18ca19fa64267b84bee10473a81cbc63f53104a0.camel@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240417_061853_553392_0809DA98 
X-CRM114-Status: GOOD (  16.21  )
X-Mailman-Approved-At: Fri, 19 Apr 2024 08:47:04 -0700
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

On 2024/4/17 0:12, Alexander H Duyck wrote:
> On Mon, 2024-04-15 at 21:19 +0800, Yunsheng Lin wrote:
>> Currently most of the API for page_frag API is returning
>> 'virtual address' as output or expecting 'virtual address'
>> as input, in order to differentiate the API handling between
>> 'virtual address' and 'struct page', add '_va' suffix to the
>> corresponding API mirroring the page_pool_alloc_va() API of
>> the page_pool.
>>
>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> 
> This patch is a total waste of time. By that logic we should be
> renaming __get_free_pages since it essentially does the same thing.
> 
> This just seems like more code changes for the sake of adding code
> changes rather than fixing anything. In my opinion it should be dropped
> from the set.

The rename is to support different use case as mentioned below in patch
14:
"Depending on different use cases, callers expecting to deal with va, page or
both va and page for them may call page_frag_alloc_va*, page_frag_alloc_pg*,
or page_frag_alloc* API accordingly."

Naming is hard anyway, I am open to better API naming for the above use cases.

> 
> .
> 

