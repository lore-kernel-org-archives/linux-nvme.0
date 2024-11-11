Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419EFD12D63
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 02:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LZzQtmhOW2A0Cbau7zJcHxp+bCIY31NKdrMFpZxwDXo=; b=KxZR5/DNenA/qQS9PCRaJrzmVk
	4dIBVZgDRXLx2O6TM8krR2R2j6+yQ22kt2BWDe5OrOMYS48WpX3BoPUMTiPzsE4jRS4qhf1JqL6mo
	jQ/MYQHopASEKz9NrEXrE0BVgJRaQaZ/FvaDo6q4CjqFEm4n7LwGE5F4ktxYVpTXvO5jGe/f4/jxa
	v06K/djTVGoANRrnX9u8EZWriyRJwOEwghneJ1kwEMaMXS+W5bfP6Mb5pigQ/qVSPfjnAv3yPP9qb
	zAz+wCdSAD4xACbd59SBUpI9+OyEYMNOEVVycozBNcX0Ed/rp3aE8hf8x/hsTwzfOipDOjNopaQsM
	4yHa9aWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAKdd-0000000GAmX-3Vbq;
	Mon, 11 Nov 2024 02:58:49 +0000
Received: from ms.lwn.net ([45.79.88.28])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAKda-0000000GAkP-2G5k
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 02:58:47 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 04194403E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1731293919; bh=LZzQtmhOW2A0Cbau7zJcHxp+bCIY31NKdrMFpZxwDXo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=P6ZlMDKuMAATbHo1fiGbEgO4Fdf7nPT7SqDPMzQuradyDOv6suOb6fxutsindrE+7
	 YAqe/nrrvIXe19T+BoIJr/MCECgPllblWRKx8hLHqgoYKi4NLzXbeUsRzQpHT46Apk
	 16WvyKjjWECdMAXfC++MoWNfnbZX+wQ26rLDNJXwPHBBonUUml1zP30i+yuASAkjfu
	 vyYGpz9zJfCirLY0C0kPoVZJ2DwCt1B305HCUxe1W4/wxWkSW8SGY7ATGH6Tlu1/oF
	 bK8Iuk+1i1x1IgiBH4F39RZX0SXtnRWWPHBQU2Di1gdMOpHExP/t+4A4PrTP3krfc3
	 mdt6p5c5a5xeg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 04194403E9;
	Mon, 11 Nov 2024 02:58:39 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: anish kumar <yesanishhere@gmail.com>, Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>, Robin
 Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
 <will@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>, Yishai Hadas
 <yishaih@nvidia.com>, Shameer Kolothum
 <shameerali.kolothum.thodi@huawei.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse
 <jglisse@redhat.com>, Andrew
 Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org, Randy Dunlap
 <rdunlap@infradead.org>
Subject: Re: [PATCH v3 09/17] docs: core-api: document the IOVA-based API
In-Reply-To: <CABCoZhAN-eeu=E5r+ZbZGTNwQta5yUw86sy8e_Je+Yri-+iuoQ@mail.gmail.com>
References: <cover.1731244445.git.leon@kernel.org>
 <dca3aecdeeaa962c7842bc488378cdf069201d65.1731244445.git.leon@kernel.org>
 <CABCoZhAN-eeu=E5r+ZbZGTNwQta5yUw86sy8e_Je+Yri-+iuoQ@mail.gmail.com>
Date: Sun, 10 Nov 2024 19:58:38 -0700
Message-ID: <875xouv5lt.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_185846_602961_79C42DF9 
X-CRM114-Status: GOOD (  18.67  )
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

anish kumar <yesanishhere@gmail.com> writes:

> On Sun, Nov 10, 2024 at 5:50=E2=80=AFAM Leon Romanovsky <leon@kernel.org>=
 wrote:
>>
>> From: Christoph Hellwig <hch@lst.de>
>>
>> Add an explanation of the newly added IOVA-based mapping API.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>> ---
>>  Documentation/core-api/dma-api.rst | 70 ++++++++++++++++++++++++++++++
>>  1 file changed, 70 insertions(+)
>>
>> diff --git a/Documentation/core-api/dma-api.rst b/Documentation/core-api=
/dma-api.rst
>> index 8e3cce3d0a23..61d6f4fe3d88 100644
>> --- a/Documentation/core-api/dma-api.rst
>> +++ b/Documentation/core-api/dma-api.rst
>> @@ -530,6 +530,76 @@ routines, e.g.:::
>>                 ....
>>         }
>>
>> +Part Ie - IOVA-based DMA mappings
>> +---------------------------------
>> +
>> +These APIs allow a very efficient mapping when using an IOMMU.  They ar=
e an
>
> "They" doesn't sound nice.
>> +optional path that requires extra code and are only recommended for dri=
vers
>> +where DMA mapping performance, or the space usage for storing the DMA a=
ddresses
>> +matter.  All the considerations from the previous section apply here as=
 well.
>
> These APIs provide an efficient mapping when using an IOMMU. However, they
> are optional and require additional code. They are recommended primarily =
for
> drivers where performance in DMA mapping or the storage space for DMA
> addresses are critical. All the considerations discussed in the previous =
section
> also apply in this case.
>
> You can disregard this comment, as anyone reading this paragraph will
> understand the intended message.

I don't understand the comment, honestly.  You say "they" doesn't "sound
nice", whatever that means, but your suggestion retains the "they"...?

I'm all for reviews that improve our documentation, but it is
*incredibly* easy to fall into the trivial bikeshed mode.  I've
certainly done it myself.  The end result is less documentation as
people decide, understandably, that it's not worth the pain.  Hopefully
we can all try to do a bit less of that.

FWIW, I think the paragraph is fine as written.

Thanks,

jon

