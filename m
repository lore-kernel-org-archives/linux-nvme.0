Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD13E9D3FB
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Feb 2026 15:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GMZkkwt+ygUc95YJRehpOJ9rDzYC29QaYgbwGeEI8Ug=; b=rCtGdJkaVuIOiqT+oHKI41btQL
	xreDnTF3tODDJMCKtoZeXMYIyS61PBGo9mC/NmEQfGR+3FoQs/hB2OQ89/YuLCOIa1EjG2EIS65sG
	tswFpNEhuyO8JCxXncyX7d92t6PyTLwHKulIk1fxlYb/udpyeMflZQpMALWAbafuCX6CL8Our0S/d
	RFmoICLCWnq3Bm8dRetz4N0u8fAyMc5waqR89WV5t8kK9NtkzK7aFINWTJGoc5iuMMV0pnE5pySPi
	bTaWIP4M9LXd4//1frzfjB4xwrk+VQXCGOkVGZfoz8cBmIiLKAkBAZ7AO75Wm86NVM0MqcD0VXGOY
	i+Xypqnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vneqU-00000008fZW-3fVB;
	Wed, 04 Feb 2026 15:31:10 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vneqP-00000008fWn-2lEC
	for linux-nvme@lists.infradead.org;
	Wed, 04 Feb 2026 15:31:09 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260204153052epoutp018908c799e44a6c3f99bf8df58c62abf9~RFNl4S56J0392303923epoutp01V
	for <linux-nvme@lists.infradead.org>; Wed,  4 Feb 2026 15:30:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260204153052epoutp018908c799e44a6c3f99bf8df58c62abf9~RFNl4S56J0392303923epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770219052;
	bh=GMZkkwt+ygUc95YJRehpOJ9rDzYC29QaYgbwGeEI8Ug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ETvM2beWlcbgm9+kdvXrTuLOPGX4U+u2zjDgRC317q3FIRG6a+cS2XAEKZIA38ePQ
	 P/hF7tLETT3P+C7lKNKkEoyFWvzGwyT+Y+rnSzQk42u6cv4U7KSBR/Oq6/+wnPv2h3
	 dpSZcK+vrII5Pie97JGOnE42vcF1xwaGqDm+wkXw=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260204153052epcas5p2a5dd889761fbbe0da0188d4f55423645~RFNlpYRUi0658106581epcas5p23;
	Wed,  4 Feb 2026 15:30:52 +0000 (GMT)
Received: from epcas5p2.samsung.com (unknown [182.195.38.95]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4f5kp34KGfz2SSKX; Wed,  4 Feb
	2026 15:30:51 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260204153051epcas5p1c2efd01ef32883680fed2541f9fca6c2~RFNkOnJ8g2260322603epcas5p16;
	Wed,  4 Feb 2026 15:30:51 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260204153049epsmtip22ed4d2525789b012deef6b6b5c76c314~RFNii_-zk3140331403epsmtip2K;
	Wed,  4 Feb 2026 15:30:48 +0000 (GMT)
Date: Wed, 4 Feb 2026 20:56:34 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring <io-uring@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Christian
	=?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Christoph Hellwig
	<hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta
	<anuj20.g@samsung.com>, "lsf-pc@lists.linux-foundation.org"
	<lsf-pc@lists.linux-foundation.org>
Subject: Re: [LSF/MM/BPF TOPIC] dmabuf backed read/write
Message-ID: <20260204152634.gyybb2axszwpewrk@green245.gost>
MIME-Version: 1.0
In-Reply-To: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
X-CMS-MailID: 20260204153051epcas5p1c2efd01ef32883680fed2541f9fca6c2
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----dZkOkAIazzHoUX-2rQXwJ8woeHD-_lbejx.E5KOGiu3cq0eS=_150a72_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260204153051epcas5p1c2efd01ef32883680fed2541f9fca6c2
References: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
	<CGME20260204153051epcas5p1c2efd01ef32883680fed2541f9fca6c2@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260204_073107_119764_555B8F35 
X-CRM114-Status: GOOD (  16.73  )
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

------dZkOkAIazzHoUX-2rQXwJ8woeHD-_lbejx.E5KOGiu3cq0eS=_150a72_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On 03/02/26 02:29PM, Pavel Begunkov wrote:
>Good day everyone,
>
>dma-buf is a powerful abstraction for managing buffers and DMA mappings,
>and there is growing interest in extending it to the read/write path to
>enable device-to-device transfers without bouncing data through system
>memory. I was encouraged to submit it to LSF/MM/BPF as that might be
>useful to mull over details and what capabilities and features people
>may need.
>
>The proposal consists of two parts. The first is a small in-kernel
>framework that allows a dma-buf to be registered against a given file
>and returns an object representing a DMA mapping. The actual mapping
>creation is delegated to the target subsystem (e.g. NVMe). This
>abstraction centralises request accounting, mapping management, dynamic
>recreation, etc. The resulting mapping object is passed through the I/O
>stack via a new iov_iter type.
>
>As for the user API, a dma-buf is installed as an io_uring registered
>buffer for a specific file. Once registered, the buffer can be used by
>read / write io_uring requests as normal. io_uring will enforce that the
>buffer is only used with "compatible files", which is for now restricted
>to the target registration file, but will be expanded in the future.
>Notably, io_uring is a consumer of the framework rather than a
>dependency, and the infrastructure can be reused.
>
We have been following the series, its interesting from couple of angles,
- IOPS wise we see a major improvement especially for IOMMU
- Series provides a way to do p2pdma to accelerator memory

Here are few topics which I am looking into specifically,
- Right now the series uses a PRP list. We need a good way to keep the
   sg_table info around and decide on‑the‑fly whether to expose the buffer
   as a PRP list or an SG list, depending on the I/O size.
- Possibility of futher optimization for new type of iov iter to reduce
   per IO cost

Thanks,
Nitesh

------dZkOkAIazzHoUX-2rQXwJ8woeHD-_lbejx.E5KOGiu3cq0eS=_150a72_
Content-Type: text/plain; charset="utf-8"


------dZkOkAIazzHoUX-2rQXwJ8woeHD-_lbejx.E5KOGiu3cq0eS=_150a72_--

