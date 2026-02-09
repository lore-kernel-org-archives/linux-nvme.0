Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8BFE7E0AF
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Feb 2026 10:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wt+xzp1ENYsfh++JT8pJEqjJy6IREEFFHEG8QaQpp2M=; b=rp5mbE5dYX9ZDw4UMEJH9zY6vc
	85qKDpzp9lmEg2mGR4MgnI8aPhrGSSBmJFrlWe2ClRnQBVr0oMsXr4Q5/0WE9+uG15pBkDFPUcFKB
	Gf6bz1vTQCAl6zCLfc1V/A4FDpw7Zi2F7902KorF4Nw7Pok4iz6HJ9FIKFVc5w0tO+LysFiUkwovx
	NE8YmAqDNwpvzArkxWmRrvI1lcaFFdNPuOMAGsouzZPa9afR/Tu2kn6ZM38aMQA3w5yLggFgJ7F/O
	P8IloNm9B7yDBFR1H6+8XBvhx7chKb7VFjLa/uhYRBoeGzRl9wACnFugY7WPK6fOdI8OrcGKUTY+V
	pjs37CKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpO8f-0000000FDUe-0u1k;
	Mon, 09 Feb 2026 10:05:05 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpO8b-0000000FDTA-1mtx
	for linux-nvme@lists.infradead.org;
	Mon, 09 Feb 2026 10:05:04 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260209100451epoutp01832407db4488377daf5162a710e31f46~Si-XMhnGc0256002560epoutp01X
	for <linux-nvme@lists.infradead.org>; Mon,  9 Feb 2026 10:04:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260209100451epoutp01832407db4488377daf5162a710e31f46~Si-XMhnGc0256002560epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1770631491;
	bh=wt+xzp1ENYsfh++JT8pJEqjJy6IREEFFHEG8QaQpp2M=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=M0PU4SJAclY0eXdEEkxL7W3l4RdvfkAlxlzdKax8lupZZA9Cl/jrx3j6ZOZP25yX+
	 aEpRs8klxsOfPDog79GlTXng/MXN3vmtQU1Iyp+6hldb0cK5uuJbrbTaNyAdn1TzPn
	 R54qbHwrhOful2d1/CJ51zzsOdS1N40jgdgoaZGY=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260209100451epcas5p10e8d99b66259e22b08fab2a6a4df98a8~Si-W6nlVY0968409684epcas5p1Q;
	Mon,  9 Feb 2026 10:04:51 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.91]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4f8gKY6xgMz6B9mB; Mon,  9 Feb
	2026 10:04:49 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260209100448epcas5p11e31b66680677cd4399fd0efca35e6fe~Si-UuYSWS0968909689epcas5p1N;
	Mon,  9 Feb 2026 10:04:48 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260209100444epsmtip2e68e1b03792622abf5a5c487565e1186~Si-Q3OchA2836828368epsmtip2M;
	Mon,  9 Feb 2026 10:04:44 +0000 (GMT)
Message-ID: <0ddc5a14-26c3-4912-96a0-d619ca0fb36c@samsung.com>
Date: Mon, 9 Feb 2026 15:34:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] dmabuf backed read/write
To: Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org
Cc: io-uring <io-uring@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, =?UTF-8?Q?Christian_K=C3=B6nig?=
	<christian.koenig@amd.com>, Christoph Hellwig <hch@lst.de>, Anuj Gupta
	<anuj20.g@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260209100448epcas5p11e31b66680677cd4399fd0efca35e6fe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260203143112epcas5p4eea9225d9378dad9151e1b843c0522ce
References: <CGME20260203143112epcas5p4eea9225d9378dad9151e1b843c0522ce@epcas5p4.samsung.com>
	<4796d2f7-5300-4884-bd2e-3fcc7fdd7cea@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260209_020501_645561_580BB19C 
X-CRM114-Status: GOOD (  12.55  )
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

On 2/3/2026 7:59 PM, Pavel Begunkov wrote:
> Good day everyone,
> 
> dma-buf is a powerful abstraction for managing buffers and DMA mappings,
> and there is growing interest in extending it to the read/write path to
> enable device-to-device transfers without bouncing data through system
> memory. I was encouraged to submit it to LSF/MM/BPF as that might be
> useful to mull over details and what capabilities and features people
> may need.

Guilty as charged, I'm interested in the topic. Thanks for posting.
We've had several attempts to move the DMA mapping cost out of the fast 
path; hopefully, this will be the final one.



