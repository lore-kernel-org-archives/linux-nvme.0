Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF44C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 15:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RwsqoTrGIY7Tbo1kKMzZTENYWfctEw96MWDcSqkrqp4=; b=Jm0YrrFfE0KLbr6+3TcIazk0zp
	zATtsGiOvxp6PHH/QibMXhFPkcQR8iYapOiijP78Z44Ou4aGPAv9cgrbu5Za1jacnEpWtc6c+EhLm
	Bag8gnNEOmFWiAhpM21BizTlSg6E0DO2ZCFK7mUhr9UcHzf9BoGvhuaT5oiTYnk0GD/UshEfHJtkW
	+K300yehV9gmDWwQpYSoltBcVomKx/+BIl69oGDaCMaf+yKsu5HNKzm7HwMz7FoWzdMPQuilrgxum
	zfhoFf4FYeKRhwh2MWKVtw+kouCUf7hJMUV7X9LqES156gH8T7i+yP+TBprQp4YAIlqPBZ6welxCd
	6qIfOPBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osnRX-00Eqeh-Qp; Wed, 09 Nov 2022 15:56:47 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osnRC-00Eq4j-Tt; Wed, 09 Nov 2022 15:56:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 55F0561B7A;
	Wed,  9 Nov 2022 15:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E61C433D6;
	Wed,  9 Nov 2022 15:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668009385;
	bh=RwsqoTrGIY7Tbo1kKMzZTENYWfctEw96MWDcSqkrqp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tt9qOPnv0yhHWgfeZjeB6kHUPCbU1LzCrlKCugfOk7kHj/y4kndDjaWPe+Fci/Rug
	 L8lShhHKYVUHkCYRRnfrCNu4pZgsvQ46EMrEAvXpxskUda02gSvQ9RlkuHLPUFlTHV
	 n4eGiMDRwRtKaAAbZFNqXNPVfsmmYvp71Fxh/EbdjREic7FgW7hmvqT06IRSB9rqnx
	 XDn2dGzstGdRA+idym+5Ec4rFswQTzgqHzhjnT8bhVJMf5X2mRjVT0oKbLqyL+myI1
	 pMWAMwSaHiC8lL+Vk6zy810gEl7zFAZ6Kq3gg4udvl1wmrax00fVeKnszB7Wn+rPB5
	 DbRaC8RDYu0Dg==
Date: Wed, 9 Nov 2022 08:56:22 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 11/12] nvme-pci: split the initial probe from the rest
 path
Message-ID: <Y2vNpi050Yoe4EZ1@kbusch-mbp.dhcp.thefacebook.com>
References: <20221108150252.2123727-1-hch@lst.de>
 <20221108150252.2123727-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108150252.2123727-12-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221109_075627_114168_8AC3BA72 
X-CRM114-Status: GOOD (  11.66  )
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

On Tue, Nov 08, 2022 at 04:02:51PM +0100, Christoph Hellwig wrote:
> To make sure the system isn't single threaded on enabling nvme
> controllers, set the PROBE_PREFER_ASYNCHRONOUS flag in the device_driver
> structure so that the driver core probes in parallel.

Please ignore my previous message; I replied before getting to this
part. :)

