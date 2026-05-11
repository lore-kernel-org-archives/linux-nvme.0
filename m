Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC62CD37B5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 06:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+cdkCNHoLTwZZcIVgX3M00dklUEPfGT0gkkrgSpbR9w=; b=Ad7zEpip81PDRI5SshQbzUSL48
	o22hxUPUKOEsW1XDHxpC/utH8kS3lqfQcSnPLqZBqR/RWXkvblwiskBRCIRgQMUfhQm2VGJZnEf2M
	9YO4VmvNvMgDfy64LG3uf7WmkToO2IzJy650DDG2sdtpgIWQGfq9cyzTFnaS09W/WWbOE7jAqqxnz
	aNXCYeXV7o2619nbiJUT+pWCkk4E7aJgn6Be5JTdlY4VHcAvAtcbqpQPgBlC+nHV02PTaL4X5Gq7f
	JmleAd6/qrwFnY4Vo8iKjM9vf2SztlicgS001mcsI+k4nNLn8L1IQ3da0i7IUlkGLaEetBZzCROxP
	0U43RJOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMKFN-0000000CVDE-2ISC;
	Mon, 11 May 2026 06:36:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMKFK-0000000CVCa-2kgN
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 06:36:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B84E068BFE; Mon, 11 May 2026 08:36:03 +0200 (CEST)
Date: Mon, 11 May 2026 08:36:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Shivam Kumar <kumar.shivam43666@gmail.com>, hch@lst.de,
	mlombard@arkamax.eu, kch@nvidia.com, linux-nvme@lists.infradead.org,
	kbusch@kernel.org, gregkh@linuxfoundation.org, security@kernel.org
Subject: Re: [PATCH v3] nvmet-tcp: set and enforce a default MDTS for TCP
 transport
Message-ID: <20260511063603.GB26080@lst.de>
References: <DI4KADNWR1XG.ILIR3Q697X77@arkamax.eu> <20260508203912.320938-1-kumar.shivam43666@gmail.com> <d06002f7-2da6-44bd-a0df-d9f2ef87a66c@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d06002f7-2da6-44bd-a0df-d9f2ef87a66c@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260510_233606_840778_4038464C 
X-CRM114-Status: GOOD (  10.79  )
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

On Sun, May 10, 2026 at 11:42:48PM +0300, Sagi Grimberg wrote:
> I think what we want is to limit the tcp to a sane limit similar to the 
> nvmet-rdma driver.

Agreed.

We might still need the early enforcement in Shivam's patch, though.


