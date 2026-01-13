Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5ACD29DDE
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jan 2026 07:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qJlSVSZIA/vsqZj27L0xVgR++YJ1Ii2BRw2zRW2TCw4=; b=xOuoiT8apxRCWwe+v72WDuaTBa
	cyejs1Fqy6hiwh7OFm9CADyjTlArUobSySnt8yr0N9rMNW7h16VuUgZvJcQcLKg058nT9F1+i88fU
	F6mYsAhbCQv135sW4xzHQh+MujztN+Z6CK9EdLHWhzV+HzWOPytEqERcm/Dg8r4XGoJO9JAIUiClO
	3FRQHdlXtfGXbBQmuDiDEoa2Ic+9CevkPKzFAkMyd0IvLZIKg/NwW6ofqUtlevGNoCSUJ/e+/bEER
	AZ+IUBtpjHGTS18e2yRXG6LZyDku27n72qa6Hpily8se8ol74Asd/W2kefhZmIXx28Ze91DuSj++7
	ZNlVsAcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfYlE-00000006e6t-0QuM;
	Tue, 13 Jan 2026 07:24:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfYlC-00000006e68-16pn
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jan 2026 07:24:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7B3B267373; Tue, 13 Jan 2026 08:24:09 +0100 (CET)
Date: Tue, 13 Jan 2026 08:24:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, nitheshshetty@gmail.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme: blk_rq_dma_map_iter_next is no longer using
 iova state
Message-ID: <20260113072408.GA26776@lst.de>
References: <20260112135736.1982406-1-nj.shetty@samsung.com> <CGME20260112140208epcas5p4c3ef0209b01be379c836f705a10efa7d@epcas5p4.samsung.com> <20260112135736.1982406-2-nj.shetty@samsung.com> <5b07dbce-2644-4079-a768-9167cbe3e25a@kernel.org> <20260112142822.tk34ei4evgypw3qv@green245.gost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260112142822.tk34ei4evgypw3qv@green245.gost>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260112_232414_442279_C72A6A7B 
X-CRM114-Status: GOOD (  13.81  )
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

On Mon, Jan 12, 2026 at 07:58:22PM +0530, Nitesh Shetty wrote:
>> Hu... Why is this not squashed with the previous patch ? If only patch 1 is
>> applied, this will not compile, right ?
>>
> I couldn’t decide whether to use the layering convention or a unified patch,
> so I chose one patch per layer.
> Agreed, independently this doesn't compile, merging make sense.
> I will resend.

Rule number one is: don't break compilation after each step.
Everything else is secondary.

Also I'm only seeing patch 2 anyway, and not patch 1.


