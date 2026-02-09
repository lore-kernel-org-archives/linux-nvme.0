Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DE7E7E0B9
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Feb 2026 09:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eXWcvTSLW12Fg5ug1AJXh6M1M2KJGmAD1nYmXUDNb8g=; b=DDByHb1CRo0eIiTWDh6j/z7t41
	195/ScUcbIcMiwSIdb8xAnviDrcSy87fzaQkXAkVdN0xwvdIRnuxYoFjLfNPh4lIqjWldU/QtAGJU
	S1MzpoixVDgdUfc0UpEDJvKsQsqzBC/T7PvrCSK+xYU/J0dCq8RQWh4fmkEq4M+55nzapfaY+6VIi
	EQhzXpj+TXMPdnD4phXbDq9uOyylUri08ZPTxTV/a0xZlBwCVZBuktLRk0b4sV+i7yw293Kee3Gn5
	9tPOd0MzXw4sxEVR8FvrtkanAsCx1PrQMqZicYVlu7eo17NilgLOUqjCJgUlXvkk8TSvY02QZJYh2
	fXZdd6iA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpNyS-0000000FBr7-3jL1;
	Mon, 09 Feb 2026 09:54:32 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpNyP-0000000FBqY-1Gb0
	for linux-nvme@lists.infradead.org;
	Mon, 09 Feb 2026 09:54:31 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260209095420epoutp038aff65f1f86804bf7b3089aab2a4490d~Si2L0WhXA2954329543epoutp03p
	for <linux-nvme@lists.infradead.org>; Mon,  9 Feb 2026 09:54:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260209095420epoutp038aff65f1f86804bf7b3089aab2a4490d~Si2L0WhXA2954329543epoutp03p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770630860;
	bh=eXWcvTSLW12Fg5ug1AJXh6M1M2KJGmAD1nYmXUDNb8g=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Gsm8wXDdEO3GtT6H1CjwZrk0xzM6uURpZzflkgCUlGNdkMeDkqr2Olijcq+E8ZDGg
	 Q74E2V0G26F/7Dmxs0t5OQC5NMYXcaTvHYcW8MKdLr7IFcJrVD2OYn16lrsDo0AtsC
	 HAipOAblj/HGxUglwtG06S9U0JmztQPP9pxo5FD0=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260209095420epcas5p4ffe39a127437ec7dc55b654af6aa3c75~Si2LeUyQB1174511745epcas5p4R;
	Mon,  9 Feb 2026 09:54:20 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.88]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4f8g5N4bw9z2SSKb; Mon,  9 Feb
	2026 09:54:16 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260209095416epcas5p2503e4351e65e74189470ece4806f1066~Si2Hs-yj92877528775epcas5p2Q;
	Mon,  9 Feb 2026 09:54:16 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260209095414epsmtip27494fb2762a11dc60e7df19d1674a2a9~Si2GVTHcC2191421914epsmtip2i;
	Mon,  9 Feb 2026 09:54:14 +0000 (GMT)
Message-ID: <4068f00e-e84e-49b2-b1ac-72180ba19558@samsung.com>
Date: Mon, 9 Feb 2026 15:24:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] dmabuf backed read/write
To: Jason Gunthorpe <jgg@nvidia.com>, Pavel Begunkov
	<asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring <io-uring@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Christoph
	Hellwig <hch@lst.de>, Anuj Gupta <anuj20.g@samsung.com>, Nitesh Shetty
	<nj.shetty@samsung.com>, "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20260206152041.GA1874040@nvidia.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260209095416epcas5p2503e4351e65e74189470ece4806f1066
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260206152216epcas5p293f71122593a41954f8a92bff170202e
References: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
	<20260205174135.GA444713@nvidia.com>
	<dbcc2912-e1df-491d-b1e0-7812279297de@gmail.com>
	<20260205235647.GA4177530@nvidia.com>
	<3281a845-a1b8-468c-a528-b9f6003cddea@gmail.com>
	<CGME20260206152216epcas5p293f71122593a41954f8a92bff170202e@epcas5p2.samsung.com>
	<20260206152041.GA1874040@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260209_015430_021782_4CC482BA 
X-CRM114-Status: GOOD (  14.27  )
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

On 2/6/2026 8:50 PM, Jason Gunthorpe wrote:
>> I'm actually curious, is there a way to somehow create a
>> MEMORY_DEVICE_PCI_P2PDMA mapping out of a random dma-buf?
> No. The driver owning the P2P MMIO has to do this during its probe and
> then it has to provide a VMA with normal pages so GUP works. This is
> usally not hard on the exporting driver side.
> 
> It costs some memory but then everything works naturally in the IO
> stack.
> 
> Your project is interesting and would be a nice improvement, but I
> also don't entirely understand why you are bothering when the P2PDMA
> solution is already fully there ready to go... Is something preventing
> you from creating the P2PDMA pages for your exporting driver?

The exporter driver may have opted out of the P2PDMA struct page path
(MEMORY_DEVICE_PCI_P2PDMA route). This maybe a design choice to avoid
the system RAM overhead.
As an example, for a H100 GPU with 80 GB of VRAM and a 4 KB system page
size: we would need ~20 million entries, and with each 'struct page' as
64 bytes in size, this would amount to extra ~1.2 GB of RAM tax.

At this point, the series does not introduce any change on the
exporter side and that is a good thing. No?

