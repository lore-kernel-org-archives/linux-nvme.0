Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F17D29C33
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Jan 2026 15:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0jeav41QIUHWhSoDptzFRbTAmSL8MmZG7TIS0IJTjF0=; b=r8RfoFb0ZftvfOI5jCVPNclpLQ
	vd9EoP21O9fM5FhA8bt1YRHMGjfCbcka8ldxxJTOEB9eiGmyZ3W6Hu9yP5AbpiehkLmlkgQbWmzzH
	YnUD6qGnhFzgHDVgAb148fhrCjSqUe/R7OyUkaurJtkbVgfBdKfT5gFqZyfV+ewCYaYoQoiapDiTI
	rj8MMfH2OKATPkd88yF6+OgP32uX5FU60KESsNXkIL/IIvyX2FqY145ak9E1nlGNZyt6uzI9PmGFx
	6fNxHdmC7sWjwiX9qFFgZ+PtyD8uxNUIG5dglj6eOSmYQmR7pyFitQLCAYrR3hnpDLeM58rkNZ8G1
	awQnyeIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhqrZ-00000002Jjx-1t9W;
	Mon, 19 Jan 2026 15:08:17 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhqqm-00000002JgV-3MPv
	for linux-nvme@lists.infradead.org;
	Mon, 19 Jan 2026 15:08:10 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260119150718epoutp01f2e65530c4f07aaf67556d184c66b43e~MKkc0eIqP2800128001epoutp01A
	for <linux-nvme@lists.infradead.org>; Mon, 19 Jan 2026 15:07:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260119150718epoutp01f2e65530c4f07aaf67556d184c66b43e~MKkc0eIqP2800128001epoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1768835239;
	bh=0jeav41QIUHWhSoDptzFRbTAmSL8MmZG7TIS0IJTjF0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=u7JplAdLbGepLlzFeBjNI128rr8r8mm94rGOFXcVnVMLWp0KVtUDgDGhi+4BotDTx
	 LsfTcE2UEHfyPs0iKocsbVEw9Wu+nFEiLonm5CloRYdfyJTssSc1+g+WYOc22Nwyhk
	 Gjf7Dv4+5G8OO2bhPKzG19eEoKdmPFHVQYyUmuw4=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260119150718epcas5p1f2155df96dd92bf19d47d1e967a301df~MKkcM6_bH2049720497epcas5p1K;
	Mon, 19 Jan 2026 15:07:18 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.90]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4dvv2F2Wh8z3hhT3; Mon, 19 Jan
	2026 15:07:17 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260119150716epcas5p3b1139cbdabe33c2e7d65832c32516fa1~MKka7CoCN2047920479epcas5p3-;
	Mon, 19 Jan 2026 15:07:16 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260119150714epsmtip231525018180c6659701036326a13e695~MKkY17Sj80973609736epsmtip2L;
	Mon, 19 Jan 2026 15:07:14 +0000 (GMT)
Message-ID: <ebb64c7a-e379-4c83-a7ce-89f9e9419257@samsung.com>
Date: Mon, 19 Jan 2026 20:37:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/2] nvme: optimize passthrough IOPOLL completion for
 local ring context
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20260116074641.665422-1-ming.lei@redhat.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260119150716epcas5p3b1139cbdabe33c2e7d65832c32516fa1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260116074819epcas5p37afab1cd05fdf9e0555a14b5fe89c2dd
References: <CGME20260116074819epcas5p37afab1cd05fdf9e0555a14b5fe89c2dd@epcas5p3.samsung.com>
	<20260116074641.665422-1-ming.lei@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260119_070747_790499_4B28CE70 
X-CRM114-Status: GOOD (  11.83  )
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

On 1/16/2026 1:16 PM, Ming Lei wrote:
> Hello,
> 
> The 1st patch passes `struct io_comp_batch *` to rq_end_io_fn callback.
> 
> The 2nd patch completes IOPOLL uring_cmd inline in case of local ring
> context, and improves IOPS by ~10%.

For me this was ~5%, but I suppose this is sensitive to the 
setup/config. Changes looked good to me, so

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

