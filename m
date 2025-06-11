Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA80C71136
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 19:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d6RRXHeZcPSRBj4idKDgkfQLTnwNHZAN9clsm2b0XBc=; b=JKvxjLr96PnZwS
	4vCTaa2TIwM4Z9QQZOGKz5C7LuqpwqW8yDF1AClpE0lc8P4vOXY+jTS6Gwz1QVlYHBAtVegDPSyqo
	ov07DSjg81BVa1SzAjeg3tvAi1rY/61yAWAuo7p2dmMMNVlfVXw2IX+tOFsbz2A6zDWz5hACitpKI
	KLVAE1RdUmwQK2HlRNS3mpbuJ7cFrV08uulXh472PH8mtPMJ0YpicQiBYPV9X8WrZ4NTnn+3KtyA1
	0jI+6uGuahNAp6Re24Nt+YGAex1gmOJb1IRjw7J7oRLnVE1ARLXpp3T+lF2Q+c5bkHV/A4K70TOjR
	OlUke8BoaAD6J2igsVjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPRYs-0000000B4yy-1mpH;
	Wed, 11 Jun 2025 19:56:40 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPOUV-0000000AdeA-3uPS
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 16:39:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=d6RRXHeZcPSRBj4idKDgkfQLTnwNHZAN9clsm2b0XBc=; b=qA1yO38mRxRbd4xGT6v0KcmgiE
	yUggBfZsHYzsbbrfDTIdjp9i2563S6AdusD6x6Vz5zhROHeYvKa/oNs9yllM5JQxUUPSxZYfbc371
	bdZKwShl1xQddBJSpC9203LiPiEmJ0or+PrBXAk+vVcZuFWemwkUR7tIwHtX9ANxeM13cYz5dNEpr
	8xVokJx5EA906S9iTmmRqr5vEXLdcV/WIcUqleq7VpXT/NMQijqpI1Zp+HHYV18/DVRljQZWeCAnP
	4VGOZWSFWWu3mZh8uNs/WMunTRBZNRqdHaJE5/nt27nxRgZBV3FNTsImgju1/C7ZCQ4eDuRYVZkGk
	DjgQtyGg==;
Received: from d172-219-145-75.abhsia.telus.net ([172.219.145.75] helo=[192.168.11.155])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1uPOUF-007hgw-2c;
	Wed, 11 Jun 2025 10:39:38 -0600
Message-ID: <5cddbda3-02bd-4dc1-9f7f-197279da6279@deltatee.com>
Date: Wed, 11 Jun 2025 10:39:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Leon Romanovsky <leon@kernel.org>, Nitesh Shetty <nj.shetty@samsung.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-2-hch@lst.de> <aEhROl2D89kFX8C7@kbusch-mbp>
 <20250611034316.GA2869@lst.de> <aEmuG1dUDGuci7VW@kbusch-mbp>
Content-Language: en-US
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <aEmuG1dUDGuci7VW@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.219.145.75
X-SA-Exim-Rcpt-To: kbusch@kernel.org, hch@lst.de, axboe@kernel.dk, sagi@grimberg.me, kch@nvidia.com, joshi.k@samsung.com, leon@kernel.org, nj.shetty@samsung.com, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 1/9] block: don't merge different kinds of P2P transfers
 in a single bio
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_093956_020829_FD808FA4 
X-CRM114-Status: GOOD (  13.12  )
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



On 2025-06-11 10:26, Keith Busch wrote:
> If I recall correctly, the PCIe ACS features will default redirect
> everything up to the root-complex when you have the IOMMU on. A device
> can set its memory request TLP's Address Type field to have the switch
> direct the transaction directly to a peer device instead, but how does
> the nvme device know how to set the it memory request's AT field?
> There's nothing that says a command's addresses are untranslated IOVAs
> vs translated peer addresses, right?  Lacking some mechanism to specify
> what kind of address the nvme controller is dealing with, wouldn't you
> be forced to map peer addresses with the IOMMU, having P2P transactions
> make a round trip through it only using mapped IOVAs?

That is all correct. In order to use P2P on a switch, with the IOMMU
enabled, it is currently required to disable ACS for the devices in
question. This is done with the command line parameter disable_acs_redir
or config_acs.

Logan


