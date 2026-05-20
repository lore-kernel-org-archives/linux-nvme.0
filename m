Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C25BCD4F5E
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 06:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PQyE2sjonzdzHK3b0QvSKBdcBtvd/iEDjOKguePEnKc=; b=QDldbN1TyQFwUzxhOYTltk7wB3
	9lq/bivRxE8eYjdoOBCyjq/fa0SqnpWWdGNr99JvW6bVE/B3TF3a30IiTc/jgHDneXHb/xIanHfwb
	elTrIwN8M28MJHLUkAliTh5AmoxWgE/DOj52Go3hPdn2U2cba3DcY4KyoCnd/0cJikicTpdK+mmR8
	eadXqr8/ultqbb0IQGmBnS45sGMe2eRxJRrP7z3+ekFcYfaTPvV8+JhSacBDHAOgxCPJxX+JVNEHJ
	9PjkbWPs9sg7a2WRnXfMOgbql2oTfDbdu82Vawqp32V9bckFdTDOhlvB5SSDyJHg4x9IT96pTwc0E
	f3bbTwJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wParG-00000003j6x-0O0f;
	Wed, 20 May 2026 06:56:46 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wParE-00000003j6h-2TYh
	for linux-nvme@lists.infradead.org;
	Wed, 20 May 2026 06:56:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B12016012B;
	Wed, 20 May 2026 06:56:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945361F000E9;
	Wed, 20 May 2026 06:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779260203;
	bh=PQyE2sjonzdzHK3b0QvSKBdcBtvd/iEDjOKguePEnKc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JoIPtbsd0F8vSjYNkhi/4yI0YDiqEe3rIRrtAcaLYw1SxJq9MKEhB2tqsOyoykvKO
	 RboRy6tG7VU7/xGIowXy6BOfeOCoN3+wjXdcXFHDZc95sAlN2wBIwCakZsIxCihKDV
	 AT2l8/wKWIY/9PljhZ/vpQHB4BFCOUo2dCi16afHvQi9Cn495ogqT/uBd5CVIfr9sQ
	 LmeMMrp82HoujmJgf1eweDrYiaXrKxX3tSM9JMlr+N+6BUJzavTDW17mQ4JvnuWJVO
	 mHku3ob61qnKa6XuXt0Z91jwYBsgft2zCxucTHWKxW54OhwzGeMO5crSKTyJGIxXsb
	 ft6omnEu/yViA==
Message-ID: <b791c4de-ff5c-4f68-af26-7b6d37013fef@kernel.org>
Date: Wed, 20 May 2026 08:56:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/5] blk-mq: fix status for unaligned bio
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk, hch@lst.de, tom.leiming@gmail.com, coshi036@gmail.com,
 Igor.Achkinazi@dell.com, Keith Busch <kbusch@kernel.org>
References: <20260519172326.3462354-1-kbusch@meta.com>
 <20260519172326.3462354-2-kbusch@meta.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260519172326.3462354-2-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 2026/05/19 19:23, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> A bio requesting sectors unaligned to the logical format is invalid
> rather than an IO error. Fix up the return code because there are some
> device mappers that care about distinguishing these kinds of errors.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

It seems that this one could go in regardless of this series (so I do not think
it needs to be RFC).

-- 
Damien Le Moal
Western Digital Research

