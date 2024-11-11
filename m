Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63ACBD2E9C6
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 14:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GwVTmx4eIglWLWGHYmk31OoK5pzNvXaKVe73vYEWSTk=; b=kXK1Fk5nueRiWyiWDc3p6q2/IT
	/TbMbSBPepT3Fp+3PxffBQ8l2fG2WgMzNTKxVdZ+mN3IygM8fqkbHt3hmRk8VWUl1ddQf6s9HOcPT
	IIs6HMd+LYsHxhm7F9+S6fdMqLlKn+rJ1AFOHgC3np76X1rUkK2nwmTX7PBVgedoAEyBpSrPPP+aW
	mTL3Kgo0ff8hRgdgxpV/+pIOyQUcl4Od+MbgA5cxlXmDe9s/R1SSITkXzcwu4pIrrkYqc7fvelUjc
	9jCmcHtoST9Dgr+9j3X0QIm7Rx672HbZS0OtSXoIjUcfdPOv5TprB6PwWo9LxLfLo5DdbKS3zZ13T
	YGpFOFAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAVt7-00000000Nty-2ELU;
	Mon, 11 Nov 2024 14:59:33 +0000
Received: from ms.lwn.net ([2600:3c01:e000:3a1::42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAVt4-00000000NtE-497X
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 14:59:32 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 45E36403F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1731337167; bh=GwVTmx4eIglWLWGHYmk31OoK5pzNvXaKVe73vYEWSTk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=U7Qof0wuVnJGcnP06ChHK+MJPNdREQXE7RLUzC2W70ULBaY9a9VnJ9vQEtqDAf9Ah
	 A3HwpVCu8PJVyEMghvrqu/hNDOC8sGYBt3mN173rM33gAFqU2dKpLTqp9ac4bjnapP
	 A1UN+AgpzI588tU7KIuantdLBUeWBgXdiFu11n7kGDH4ZxFGW1T97qYFC9t3FAzyYo
	 fgA7YQdK+SYmrHtsukzfx/wT5vFef/DoXSOK38XKAVdsxtI+fq2uPWuv8CV5NUKrxx
	 iQj4S70o2yK54j7jT8p8fewkBThJBXMBi2CZoLIkGaK5OJDLnfOOJSXDckk3X1rExZ
	 HhL9BYc+PyPqw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 45E36403F1;
	Mon, 11 Nov 2024 14:59:27 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: anish kumar <yesanishhere@gmail.com>, Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>, Jason
 Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, Joerg
 Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Sagi Grimberg
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
 kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 09/17] docs: core-api: document the IOVA-based API
In-Reply-To: <CABCoZhBVWY=aUQtQ5b=mF8hXqpgJw21_jAPf9YvEvdgPf_GALA@mail.gmail.com>
References: <cover.1730298502.git.leon@kernel.org>
 <881ef0bcf9aa971e995fbdd00776c5140a7b5b3d.1730298502.git.leon@kernel.org>
 <87ttchwmde.fsf@trenco.lwn.net> <20241108200355.GC189042@unreal>
 <87h68hwkk8.fsf@trenco.lwn.net> <20241108202736.GD189042@unreal>
 <20241110104130.GA19265@unreal> <20241111063847.GB23992@lst.de>
 <CABCoZhBVWY=aUQtQ5b=mF8hXqpgJw21_jAPf9YvEvdgPf_GALA@mail.gmail.com>
Date: Mon, 11 Nov 2024 07:59:26 -0700
Message-ID: <87o72lu88h.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_065931_053473_9373F93A 
X-CRM114-Status: GOOD (  12.48  )
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

> On Sun, Nov 10, 2024 at 10:39=E2=80=AFPM Christoph Hellwig <hch@lst.de> w=
rote:
>>
>> On Sun, Nov 10, 2024 at 12:41:30PM +0200, Leon Romanovsky wrote:
>> > I tried this today and the output (HTML) in the new section looks
>> > so different from the rest of dma-api.rst that I lean to leave
>> > the current doc implementation as is.
>>
>> Yeah.  The whole DMA API documentation shows it's age and could use
>> a major revamp, but for now I'd prefer to stick to the way it is done.
>>
>> If we have any volunteers for bringing it up to standards I'd be glad
>> to help with input and review.
>
> Jonathan, if you agree, I can take this up?

I am happy to see help with the documentation, but agreement from the
authors and maintainers of the DMA-mapping documentation is rather more
important than agreement from me.

jon

