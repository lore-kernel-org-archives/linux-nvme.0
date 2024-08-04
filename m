Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64CE1C52D72
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 03:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xlk57dWXqV77ALqJZrDySJJvovhv9kbwJVS4WA6M5w0=; b=LBaI7RC1gpyzZ1OP0J7t8RqJdW
	umshIauwGEBMUcBmFakqYVwLbZjBb+PK+EYUxxJcom9HnSZznVm/h4gJP5Sx4rBZbBwmzJZh/FtNv
	plx23FfFunbR9LXBjJlixwKk2G2lHqO6SZGfC6ZEt0dpmF8FVtuGzPD3b9O39TScEBD73t8OhkpD7
	lnuFHGLHAhmrhPCKZR6reQZzQVZ1Bziawgr2lj0gOI1nzKXm/hG8Vq78el841PxHQuTX9B0SRrSpt
	TmzINveMVvgQuuOCddYgd9QB5GRK+cEVYuMGc52G5IGGxVu6+8TNalkx3a3MueCaimK06KWvmxkQX
	LvftDHUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbAeg-00000000LH5-3Vii;
	Tue, 06 Aug 2024 03:14:34 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1saStD-0000000CcJ0-2G5O;
	Sun, 04 Aug 2024 04:30:41 +0000
Received: by mail-pg1-x541.google.com with SMTP id 41be03b00d2f7-7a1be7b5d70so3307795a12.0;
        Sat, 03 Aug 2024 21:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722745838; x=1723350638; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xlk57dWXqV77ALqJZrDySJJvovhv9kbwJVS4WA6M5w0=;
        b=MTfrCJcf4UWwuLwkz2v+2BUe9EDCYiFsXKm6SSBE8GK3nmVv6tUDMDjroxrhGtkdDN
         2HuadNRN7uTlO3oMhQJxwIrqZXdO30ewZSeYASuyySMO7K1raHQBbO6QdbkK9wx/aBB5
         +OLPNqb2vzY3w5nmtTlnqyBFCg0x07DHs0JuP4fq04a615AWzJgWS2fI/4XrpOJDuW41
         XemTCbrYrkLd5RKsysN5CB1PdbWZLt3L3kjaXvGMu2ZeMJJkOM7yO11NaokmE7hAiyb0
         4rfz08XhsXXsKIIv5ZEH9ENEhizQnzxbKhm47R8WcCaeM2RUzBd8RITh0A9S0PaWBT53
         H8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722745838; x=1723350638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xlk57dWXqV77ALqJZrDySJJvovhv9kbwJVS4WA6M5w0=;
        b=oVL8wLrK2SKQaiddm4ETwlZI7KlQWCJ2+tF9eFOtmR/32nPJm5U5RW3MaLI4UEEVEk
         V3+5WLFJkrX0HjRUyyVxOP4/ucCDLA7QT9CyFSg9XbSD3cP4OMQanCsIFHqBQmzYf+Yd
         TZw8TWYMdu+x0I3zpu+6YbhAkp8mistzCbzvLheaoiHy1BNnvsU9byEFJGAFGqrpLOpr
         OwTy95C1Yi+5tIfnSib0fgFxkHEhmw65axgG1e44Uk2f2i8akQH2eVlhj/honGWRWtzw
         lHdnG2yD/0+uE7duaIvDBMLg5nFZvTQ9J+abvB13CFzqRqv0IYXKIWebnjK7Lgll1fJ8
         HYXw==
X-Forwarded-Encrypted: i=1; AJvYcCXn7sRAG+VcXFMa1E434nlnW8yJATIGTPCjHqpTlA+0SDPxTgz4B1GWhG4S5oVkO2ATzjtc+aqwhfaKtNbEo/zhRK+wA69paq2kEfT9l3u+WWu+/etLO1fYnagFVtg2C9gxR1E+m+DT5fF+aJfWRa1QKfiviBzq3owzr52CESV6X0YAQfke91mQ5ITHe6wtLF9ET5GFzRmJmdC9iBdMtC/RqvSL6lQofWzRejXAthKLFZGd7PohQxU=
X-Gm-Message-State: AOJu0YyVXd/OT+3DUdmNsBxxlcrYPfeNhkEHqSIi12lxqKeb4+MAuy/X
	7JnY3g+ymb0d92kjO/ypUVpruFQtUS7tDWH9QbcKpKbr6eTeqQqF
X-Google-Smtp-Source: AGHT+IGsvTDJ4EYqxMHnrnabL29RSd4zV3sYpylbcRFlgCkQFp8MTku4ddABSnqWe2wodzlqv0aHUA==
X-Received: by 2002:a05:6a21:3d8b:b0:1c6:9968:f4f4 with SMTP id adf61e73a8af0-1c699690eacmr14086917637.11.1722745837611;
        Sat, 03 Aug 2024 21:30:37 -0700 (PDT)
Received: from ?IPV6:2409:8a55:301b:e120:f82c:57ba:8bf:3093? ([2409:8a55:301b:e120:f82c:57ba:8bf:3093])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b764fb4994sm3417427a12.62.2024.08.03.21.30.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Aug 2024 21:30:37 -0700 (PDT)
Message-ID: <2a29ce61-7136-4b9b-9940-504228b10cba@gmail.com>
Date: Sun, 4 Aug 2024 12:30:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 04/14] mm: page_frag: add '_va' suffix to
 page_frag API
To: Alexander Duyck <alexander.duyck@gmail.com>,
 Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Subbaraya Sundeep <sbhatta@marvell.com>,
 Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Shailend Chand <shailend@google.com>, Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
 hariprasad <hkelam@marvell.com>, Felix Fietkau <nbd@nbd.name>,
 Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, linux-mm@kvack.org,
 bpf@vger.kernel.org, linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org
References: <20240731124505.2903877-1-linyunsheng@huawei.com>
 <20240731124505.2903877-5-linyunsheng@huawei.com>
 <CAKgT0UcqdeSJdjZ_FfwyCnT927TwOkE4zchHLOkrBEmhGzex9g@mail.gmail.com>
 <22fda86c-d688-42e7-99e8-e2f8fcf1a5ba@huawei.com>
 <CAKgT0UcuGj8wvC87=A+hkarRupfhjGM0BPzLUT2AJc8Ovg_TFg@mail.gmail.com>
 <877efebe-f316-4192-aada-dd2657b74125@huawei.com>
 <CAKgT0UfUkqR2TJQt6cSEdANNxQEOkjGqpPXhaXmrrxB0KwXmEQ@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <CAKgT0UfUkqR2TJQt6cSEdANNxQEOkjGqpPXhaXmrrxB0KwXmEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240803_213039_610444_2008FAA4 
X-CRM114-Status: GOOD (  35.42  )
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

On 8/3/2024 1:00 AM, Alexander Duyck wrote:

>>
>>>
>>> As far as your API extension and naming maybe you should look like
>>> something like bio_vec and borrow the naming from that since that is
>>> essentially what you are passing back and forth is essentially that
>>> instead of a page frag which is normally a virtual address.
>>
>> I thought about adding something like bio_vec before, but I am not sure
>> what you have in mind is somthing like I considered before?
>> Let's say that we reuse bio_vec like something below for the new APIs:
>>
>> struct bio_vec {
>>          struct page     *bv_page;
>>          void            *va;
>>          unsigned int    bv_len;
>>          unsigned int    bv_offset;
>> };
> 
> I wasn't suggesting changing the bio_vec. I was suggesting that be
> what you pass as a pointer reference instead of the offset. Basically
> your use case is mostly just for populating bio_vec style structures
> anyway.

I wasn't trying/going to reuse/change bio_vec for page_frag, I was just
having a hard time coming with a good new name for it.
The best one I came up with is pfrag_vec, but I am not sure about the
'vec' as the "vec" portion of the name would suggest, iovec structures 
tend to come in arrays, mentioned in the below article:
https://lwn.net/Articles/625077/

Anther one is page_frag, which is currently in use.

Or any better one in your mind?

> 
>> It seems we have the below options for the new API:
>>
>> option 1, it seems like a better option from API naming point of view, but
>> it needs to return a bio_vec pointer to the caller, it seems we need to have
>> extra space for the pointer, I am not sure how we can avoid the memory waste
>> for sk_page_frag() case in patch 12:
>> struct bio_vec *page_frag_alloc_bio(struct page_frag_cache *nc,
>>                                      unsigned int fragsz, gfp_t gfp_mask);
>>
>> option 2, it need both the caller and callee to have a its own local space
>> for 'struct bio_vec ', I am not sure if passing the content instead of
>> the pointer of a struct through the function returning is the common pattern
>> and if it has any performance impact yet:
>> struct bio_vec page_frag_alloc_bio(struct page_frag_cache *nc,
>>                                     unsigned int fragsz, gfp_t gfp_mask);
>>
>> option 3, the caller passes the pointer of 'struct bio_vec ' to the callee,
>> and page_frag_alloc_bio() fills in the data, I am not sure what is the point
>> of indirect using 'struct bio_vec ' instead of passing 'va' & 'fragsz' &
>> 'offset' through pointers directly:
>> bool page_frag_alloc_bio(struct page_frag_cache *nc,
>>                           unsigned int fragsz, gfp_t gfp_mask, struct bio_vec *bio);
>>
>> If one of the above option is something in your mind? Yes, please be more specific
>> about which one is the prefer option, and why it is the prefer option than the one
>> introduced in this patchset?
>>
>> If no, please be more specific what that is in your mind?
> 
> Option 3 is more or less what I had in mind. Basically you would
> return an int to indicate any errors and you would be populating a
> bio_vec during your allocation. In addition you would use the bio_vec

Actually using this new bio_vec style structures does not seem to solve
the APIs naming issue this patch is trying to solve as my understanding,
as the new struct is only about passing one pointer or multi-pointers
from API naming perspective. It is part of the API naming, but not all
of it.

> as a tracker of the actual fragsz so when you commit you are
> committing with the fragsz as it was determined at the time of putting
> the bio_vec together so you can theoretically catch things like if the
> underlying offset had somehow changed from the time you setup the

I think we might need a stronger argument than the above to use the new
*vec thing other than the above debugging feature.

I looked throught the bio_vec related info, and come along somewhat not
really related, but really helpful "What’s all this get us" section:
https://docs.kernel.org/block/biovecs.html

So the question seems to be: what is this new struct for page_frag get
us?

Generally, I am argeed with the new struct thing if it does bring us
something other than the above debugging feature. Otherwise we should
avoid introducing a new thing which is hard to argue about its existent.

> allocation. It would fit well into your probe routines since they are
> all essentially passing the page, offset, and fragsz throughout the
> code.

For the current probe routines, the 'va' need to be passed, do you
expect the 'va' to be passed by function return, double pointer, or
new the *_vec pointer?

> 



