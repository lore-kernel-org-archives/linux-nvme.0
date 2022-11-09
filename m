Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F27C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 06:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SyHDGAYrBE+yVBLX7kzFthkF6gAhjWFKrmRol/P0t6o=; b=syH/Qv1rFnqNtM3Bd4opzAfmG9
	jAD2DWa79oUHhutgZxM7EAA3FEPqb815jLGqNXwDuXD8xwg/WOiN0JM1cmWkFncZVRMKwMWFKwkxj
	xIgvuCUX+IDYDa/oHtcZhPZNyKw/yTlyZLcEnGJ6pvaiiHU8d/pg4+Lk6LCSzvus3MPDyU1y1Mlax
	PGX6PMc0u5Or+sezHiawhWb8EAtMXF6ij9ypYRhm3vKL8bX20AiRsCGfjeIH9Us2kAIZdjwhClX1x
	QzTw2fIRhOlIuSEol1oOKb6Quyzbx9bgReAs+B5XSFtI1zznVi71YcK8sPYz+gfnrsEXu5O9r7gVK
	rrU7s6zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osek5-00BHJB-CT; Wed, 09 Nov 2022 06:39:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osek1-00BHIM-JA
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 06:39:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E79BD68AFE; Wed,  9 Nov 2022 07:39:14 +0100 (CET)
Date: Wed, 9 Nov 2022 07:39:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 08/16] nvme-auth: don't keep long lived 4k dhchap buffer
Message-ID: <20221109063914.GB10893@lst.de>
References: <20221109034420.1000086-1-sagi@grimberg.me> <20221109034420.1000086-9-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109034420.1000086-9-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_223917_796368_A6328945 
X-CRM114-Status: GOOD (  16.06  )
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

On Wed, Nov 09, 2022 at 05:44:11AM +0200, Sagi Grimberg wrote:
> dhchap structure is per-queue, it is wasteful to keep it for the entire
> lifetime of the queue. Allocate it dynamically and get rid of it after
> authentication. We don't need kzalloc because all accessors are clearing
> it before writing to it.

Btw, do we need a mempool here to make sure we always get one for
a reconnect under memory pressure?

> +	/*
> +	 * Allocate a large enough buffer for the entire negotiation:
> +	 * 4k should be enough to ffdhe8192.
> +	 */
> +	chap->buf_size = 4096;

Same comments as for Hannes previous series:  no need for ->buf_size,
this can be a global constant.

And in the comment the should is weird, it is enough.

