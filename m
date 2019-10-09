Return-Path: <SRS0=7vxi=YC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147FCECE596
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2019 22:18:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE7E02190F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Oct 2019 22:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Yo1EqK/l";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRNllptc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7E02190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XiOzshmjw1HkIrngbIVB5Ljys6ps1Jf0tz3lBjpc4f8=; b=Yo1EqK/lcFcjNP
	tpF+AYOVNEDgzRHopnfqXYulkSOobeZrk34oM1LerLngg3i04X8Tzbno6l6nT5Ie28KfH/J0HFiKb
	SpZzU2JYBayyIzRmcgq0xJBsSFW8n0yHCKI645+/0GSvBgUfTAWyh0Qt8JDPLtQs93mRjJI4CEYEp
	CIFFhBl0I/NwTdG0Re5//cXsqZrdWTGj0d41v+ZcyzZynAr/0S263J1Stv6TwFn0fxLCHU8iyNbSK
	BVS8yNjUEwMxN0aGgfvEdfNjVdQVrMV00afSil90kAnI/VXX5KOLV5YNy6trkpLsMWDZoP7Z5yHvI
	DPROCneBal0KRVq1OJQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iIKHy-0008V1-RX; Wed, 09 Oct 2019 22:18:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iIKHv-0008UN-Eo
 for linux-nvme@lists.infradead.org; Wed, 09 Oct 2019 22:18:32 +0000
Received: from washi1.fujisawa.hgst.com (unknown [199.255.47.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A9EAB206BB;
 Wed,  9 Oct 2019 22:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570659511;
 bh=Z8opOSsiiw6yi2V6o/VkdYx7/ZpiJj4Zuueg28GFZeg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YRNllptcmVIvwmzccQrTA6O74wQUuBcbg5Ai42vUf1gYunJt7APnYaj2z/LEx+S/Y
 rGmYKw1yv0uzptGkgxQnFk44EfFaOX3ILHTY/TOiz0UZmeTifFAgptYzGRLKwRgQgJ
 ZwtMmo9coQUWEz5OsQ51E85otiNnf1pQJUOXt9oY=
Date: Thu, 10 Oct 2019 07:18:27 +0900
From: Keith Busch <kbusch@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v9 04/12] nvmet: make nvmet_copy_ns_identifier() non-static
Message-ID: <20191009221827.GE3009@washi1.fujisawa.hgst.com>
References: <20191009192530.13079-1-logang@deltatee.com>
 <20191009192530.13079-5-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191009192530.13079-5-logang@deltatee.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191009_151831_519327_CF6F1A2B 
X-CRM114-Status: UNSURE (   9.45  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Oct 09, 2019 at 01:25:21PM -0600, Logan Gunthorpe wrote:
> This function will be needed by the upcoming passthru code.
> 
> Passthru will need an emulated version of identify_desclist which
> copies the eui64, uuid and nguid from the passed-thru controller into
> the request SGL.
> 
> [chaitanya.kulkarni@wdc.com: this was factored out of a patch
>  originally authored by Chaitanya]
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> ---

Looks fine

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
