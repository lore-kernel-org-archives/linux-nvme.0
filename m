Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A091AC5321E
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Aug 2024 15:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ACxpErlOvFQuBRokph/wthh0GeLIFddWl+sG+UC+KHk=; b=iMeLmX753W7qlHhCSoW3XpNinK
	DDHFfGzutOnlU5PC73Xxs5Dh8G+FzWvklKp6vjDhVGpwoOe4mYZcyhePlJ6m8J82yI/bONv0Y+qRb
	Ha6ramjkzBbNewdUKYgk0NNBOJCP8GaY+5TKxAZkVnTloWlH1RmDJsFizk3PTQIcYMZfmfgf+GxZx
	SHVwq/VAdsSF4gjGhp/osLL0//CMHaPDB67qVNINcProXIW5TAUFEI5RKIloDuGYjcKFUC2HO2Mb2
	pbdjD56TpzdsZkTcePHHI66rHRFqSDqTjXhOmfNtYeu/b+1zDr+vnBvl+y5o69LgbpbmAeEmOmzG6
	EDuUcFXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siF18-00000004ZCG-237s;
	Sun, 25 Aug 2024 15:18:58 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgRKg-00000005vYi-1JMx;
	Tue, 20 Aug 2024 16:03:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ACxpErlOvFQuBRokph/wthh0GeLIFddWl+sG+UC+KHk=; b=PzLgLGJ1TcTeAFdwvz1sjSqlIz
	LlV81otlFEv9Bm1PiU68Yun3u0CAonLAyNbJ111d1iFy6wFxs22FfXz4vGwENGZ3W8uU4FS0GKz3m
	vGaguzwL6kMjcqeyErZLneWZ9i7bDWv7ACxfnlSROhtD3+HoTfEt87QUAh2JAuqgVGKGHxG6/fJPF
	b4fA2AugVUxwAF66xZ6sYgjZY8Zo+T9583nByvqW1hyEPX1miWQp6jgw2Q7vZAFF/3G1b3jG43N2f
	I0uy4LLWhRUqevZtxTM/U0dO7JBIVNfG60xKmTWEZvhmg9BQu74p14IUBCf6JSTdcLCXJH3SMmw/p
	2+kiUrKQ==;
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgRKc-00000009Msj-2RQb;
	Tue, 20 Aug 2024 16:03:40 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-428141be2ddso44980755e9.2;
        Tue, 20 Aug 2024 09:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724169815; x=1724774615; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACxpErlOvFQuBRokph/wthh0GeLIFddWl+sG+UC+KHk=;
        b=PHuwFgaRoPsGuZhYm3kKmsDUBR4jIBJgooxI1mqOm0l9hupgEprBbbmTQYyjzfmcP4
         zQv4N2U0zHL4yYMTtm4efzOvMalHJQZdLqKg+ia/v+XCbyxkwYZcGUom5ZJbA36cm+/N
         x8iQfBqPqF1na+UmpRhAg8Z9HBw152duqXVVwvuFqTVo9aB88Eer8jhlOmrUSNlPO1SY
         0BHRx8Ln9P1O1DRZrqQ1nlqfaXHRwuveioStbQTL5HnTfeB/KM1GMLT+7/u8HtxGFU+Y
         2Ydkj1MiKeM6/A5OM/ASPnPMN5iE1IJn4zfOEfmxT1UWVEgK7ZFNW70wjbgNjoyi3Yoo
         NXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724169815; x=1724774615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACxpErlOvFQuBRokph/wthh0GeLIFddWl+sG+UC+KHk=;
        b=pQXhHIwMYqf3mSLk9p7gt1I1FhZlSpi9BaMMq5BMUGw6jcLgW/Os3BQ2h5YzANJRFY
         lJ1kQ/fsviK5Nlky7u002AZpi2etZuGVOqYIWIxzTBWIUk7kNx7nlFp6l2J9bRE+dBTX
         TUDp0Nzb2Zc+NfLDRzsu2MDzzF2UyT1ZtfxWgcRk7Gyf+DSabfw9VT3Ze9CQB7I+ioUV
         cErZWTGbkAaz9Jshnda0d1ZtUeArXn2vbgPSTIOnueqUFPa3RdvtLGyeOSoriq/LhngG
         oLePr0/eCnl2p20//RuyFh9Q7L0GmBb98ONL+OYXvCpbnftsbjHS6NTV4cTywhKU0vjD
         LDEw==
X-Forwarded-Encrypted: i=1; AJvYcCUkTxHILWB3UAjdgtUMpvP6ouOPOd5fI1+K27FBIm4hGy20pBc7O/QSqP5bAz2mO0abPOkCz98jYhosMA6/g4wjDg==@lists.infradead.org, AJvYcCV6PTjgPhNFh/TlpqYC7gpUgBo49wbSQCRbE9HHqNiTCVSqUl4MaPdnbUp9Lx0YGHkwQ60W62T7vtY=@lists.infradead.org, AJvYcCVe1maxTaxxS9xwBs5H0/wB7p2JDcHnUpIkpy2NzjG104OrbAQSVTc8s/x1Jyy9zrLmUC6tgznW0Nci88kXsXw=@lists.infradead.org, AJvYcCX6+/K7d3UFrPX38pbAmA1AqN4w5MCZcZd4hSAMEE8ome2tRUPjnxUErMIjSfXCgYg9cXiVB3GjVPLBHg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwXy0BcPOulaAv5At30ZGtlRyl453+P4vLjm6fdJRlSL8rjCEwX
	KAV1KrZ4rhsDQqj+UsyWAK3H1OUmy4DhvjnBDejhBuBgA4fGwkYsnNA+hDGRRoaRTnq45SYao76
	724rPDBDm/NjOE9/S6+J1MdmGCO8=
X-Google-Smtp-Source: AGHT+IF4DoS60WZqDqVaq8Y/5SjjI7zscaIxzpj60ezQwLm3viTYLpGZpmD+jTekneRZUAoDJMoW7JwgYwWaXYZHKdQ=
X-Received: by 2002:adf:f285:0:b0:371:888d:7aaa with SMTP id
 ffacd0b85a97d-371946b1ae9mr9087932f8f.49.1724169814881; Tue, 20 Aug 2024
 09:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240808123714.462740-1-linyunsheng@huawei.com>
 <20240808123714.462740-5-linyunsheng@huawei.com> <d1a23116d054e2ebb00067227f0cffecefe33e11.camel@gmail.com>
 <676a2a15-d390-48a7-a8d7-6e491c89e200@huawei.com> <CAKgT0Uct5ptfs9ZEoe-9u-fOVz4HLf+5MS-YidKV+xELCBHKNw@mail.gmail.com>
 <3e069c81-a728-4d72-a5bb-3be00d182107@huawei.com> <CAKgT0UcDDFeMqD_eRe1-2Og0GEEFyNP90E9SDxDjskdgtMe0Uw@mail.gmail.com>
 <98ceade3-8d60-45bf-a419-ff3982a96101@huawei.com>
In-Reply-To: <98ceade3-8d60-45bf-a419-ff3982a96101@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 20 Aug 2024 09:02:57 -0700
Message-ID: <CAKgT0Uc+e3MUb4CK1i7H7F=y-fHTxiGF8zddBFiqFRdbd6ofLg@mail.gmail.com>
Subject: Re: [PATCH net-next v13 04/14] mm: page_frag: add '_va' suffix to
 page_frag API
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Subbaraya Sundeep <sbhatta@marvell.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Sagi Grimberg <sagi@grimberg.me>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Shailend Chand <shailend@google.com>, 
	Eric Dumazet <edumazet@google.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Sunil Goutham <sgoutham@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, hariprasad <hkelam@marvell.com>, Felix Fietkau <nbd@nbd.name>, 
	Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	intel-wired-lan@lists.osuosl.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, linux-mm@kvack.org, 
	bpf@vger.kernel.org, linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240820_170338_782195_8B0E51D6 
X-CRM114-Status: GOOD (  56.77  )
X-Mailman-Approved-At: Sun, 25 Aug 2024 08:18:56 -0700
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

On Tue, Aug 20, 2024 at 6:07=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/8/19 23:54, Alexander Duyck wrote:
>
> ...
>
> >>>>
> >>>> "There are three types of API as proposed in this patchset instead o=
f
> >>>> two types of API:
> >>>> 1. page_frag_alloc_va() returns [va].
> >>>> 2. page_frag_alloc_pg() returns [page, offset].
> >>>> 3. page_frag_alloc() returns [va] & [page, offset].
> >>>>
> >>>> You seemed to miss that we need a third naming for the type 3 API.
> >>>> Do you see type 3 API as a valid API? if yes, what naming are you
> >>>> suggesting for it? if no, why it is not a valid API?"
> >>>
> >>> I didn't. I just don't see the point in pushing out the existing API
> >>> to support that. In reality 2 and 3 are redundant. You probably only
> >>> need 3. Like I mentioned earlier you can essentially just pass a
> >>
> >> If the caller just expect [page, offset], do you expect the caller als=
o
> >> type 3 API, which return both [va] and [page, offset]?
> >>
> >> I am not sure if I understand why you think 2 and 3 are redundant here=
?
> >> If you think 2 and 3 are redundant here, aren't 1 and 3 also redundant
> >> as the similar agrument?
> >
> > The big difference is the need to return page and offset. Basically to
> > support returning page and offset you need to pass at least one value
> > as a pointer so you can store the return there.
> >
> > The reason why 3 is just a redundant form of 2 is that you will
> > normally just be converting from a va to a page and offset so the va
> > should already be easily accessible.
>
> I am assuming that by 'easily accessible', you meant the 'va' can be
> calculated as below, right?
>
> va =3D encoded_page_address(encoded_va) +
>                 (page_frag_cache_page_size(encoded_va) - remaining);
>
> I guess it is easily accessible, but it is not without some overhead
> to calculate the 'va' here.

It is just the encoded_page_address + offset that you have to
calculate anyway. So the only bit you actually have to do is 2
instructions, one to mask the encoded_va and then the addition of the
offset that you provided to the page. As it stands those instruction
can easily be slipped in while you are working on converting the va to
a page.


> >
> >>> page_frag via pointer to the function. With that you could also look
> >>> at just returning a virtual address as well if you insist on having
> >>> something that returns all of the above. No point in having 2 and 3 b=
e
> >>> seperate functions.
> >>
> >> Let's be more specific about what are your suggestion here: which way
> >> is the prefer way to return the virtual address. It seems there are tw=
o
> >> options:
> >>
> >> 1. Return the virtual address by function returning as below:
> >> void *page_frag_alloc_bio(struct page_frag_cache *nc, struct bio_vec *=
bio);
> >>
> >> 2. Return the virtual address by double pointer as below:
> >> int page_frag_alloc_bio(struct page_frag_cache *nc, struct bio_vec *bi=
o,
> >>                         void **va);
> >
> > I was thinking more of option 1. Basically this is a superset of
> > page_frag_alloc_va that is also returning the page and offset via a
> > page frag. However instead of bio_vec I would be good with "struct
> > page_frag *" being the value passed to the function to play the role
> > of container. Basically the big difference between 1 and 2/3 if I am
> > not mistaken is the fact that for 1 you pass the size, whereas with
> > 2/3 you are peeling off the page frag from the larger page frag cache
>
> Let's be clear here: The callers just expecting [page, offset] also need
> to call type 3 API, which return both [va] and [page, offset]? and it
> is ok to ignore the overhead of calculating the 'va' for those kinds
> of callers just because we don't want to do the renaming for a existing
> API and can't come up with good naming for that?
>
> > after the fact via a commit type action.
>
> Just be clear here, there is no commit type action for some subtype of
> type 2/3 API.
>
> For example, for type 2 API in this patchset, it has below subtypes:
>
> subtype 1: it does not need a commit type action, it just return
>            [page, offset] instead of page_frag_alloc_va() returning [va],
>            and it does not return the allocated fragsz back to the caller
>            as page_frag_alloc_va() does not too:
> struct page *page_frag_alloc_pg(struct page_frag_cache *nc,
>                                 unsigned int *offset, unsigned int fragsz=
,
>                                 gfp_t gfp)
>
> subtype 2: it does need a commit type action, and @fragsz is returned to
>            the caller and caller used that to commit how much fragsz to
>            commit.
> struct page *page_frag_alloc_pg_prepare(struct page_frag_cache *nc,
>                                         unsigned int *offset,
>                                         unsigned int *fragsz, gfp_t gfp)
>
> Do you see subtype 1 as valid API? If no, why?

Not really, it is just a wrapper for page_frag_alloc that is
converting the virtual address to a page and offset. They are the same
data and don't justify the need for two functions. It kind of explains
one of the complaints I had about this code. Supposedly it was
refactoring and combining several different callers into one, but what
it is actually doing is fracturing the code path into 3 different
variants based on little if any actual difference as it is doing
unnecessary optimization.

> If yes, do you also expect the caller to use "struct page_frag *" as the
> container? If yes, what is the caller expected to do with the size field =
in
> "struct page_frag *" from API perspective? Just ignore it?

It should be populated. You passed a fragsz, so you should populate
the output fragsz so you can get the truesize in the case of network
packets. The removal of the page_frag from the other callers is making
it much harder to review your code anyway. If we keep the page_frag
there it should reduce the amount of change needed when you replace
page_frag with the page_frag_cache.

Honestly this is eating up too much of my time. As I said before this
patch set is too big and it is trying to squeeze in more than it
really should for a single patch set to be reviewable. Going forward
please split up the patch set as I had suggested before and address my
comments. Ideally you would have your first patch just be some
refactor and cleanup to get the "offset" pointer moving in the
direction you want. With that we can at least get half of this set
digested before we start chewing into all this refactor for the
replacement of page_frag with the page_frag_cache.

