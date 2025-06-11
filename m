Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B8AC71136
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 21:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VSC4VLuuqrdFvSXDA+rlUN6veLmxqQV+QLrJEvwX08Q=; b=e6ccT9JPxXuAHe
	fh5cgpfzkNKga9/XOR5yXyxHmnGxL9FJtBvCEeRgyENVTctWGvUvg3LgEkkyAdJnTbFuIJ3clPwAp
	hfzdRe2TcUbSnQTn5hsnkmgAQXtVXAVr8C19uDoonpwqZ1/VLIxwY+oDpyuiQZja4xT/afWQWbrcL
	7DF9o0qwx0qWYwqhpNUcuX8KoEt7+qjCNPHbiRnbhhPawKDDZGCfq7PaxSXpgX3gbOjN7bocaDxC8
	KKrpL+yGNixbZJue6NjRAUDAl4LdiovUR9OtbrOs6l2a2VNgfPITbKT91ji6EmVGqzA5WyGymJShS
	o/1e40pm9hHGG46jTjjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPTJk-0000000BOVG-0E1c;
	Wed, 11 Jun 2025 21:49:08 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPRKx-0000000AyVv-13Gw
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 19:42:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=VSC4VLuuqrdFvSXDA+rlUN6veLmxqQV+QLrJEvwX08Q=; b=KPVQKLdDPsClMuuVGMBe8LXrmh
	G53AnrgF1N0xpZMb7vXcrT8nZVluJTX4rQ/LRLftfz5UKOqEdL0GBeeuDsTy7tgCFVRzFNyCRXKEO
	nJvfOePPPlZU55A4uKaElhDrKoGWcpUAE4Fci4V8SiT7YJRF/6BrsEbiQ9q52347jWGSmvw76nv2h
	MWc7nuD8tRw3MGjeXYz6bhcEqV2sufkKd3YyLExMkLwVSQu3QMWc1zxSouXITaPWKcCAIe8NvsNOG
	BV/QDRryc6YZ1FDJ4iYDhF/XFyyEc5ymlChDCt/ezgz/wm0P4Q9QN+4fOnQ78+RgxgHcYDAR/9tG7
	vhbWMdIA==;
Received: from d172-219-145-75.abhsia.telus.net ([172.219.145.75] helo=[192.168.11.155])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1uPRKo-007k41-1S;
	Wed, 11 Jun 2025 13:42:05 -0600
Message-ID: <88fe6154-6086-409d-a180-665d62d72d47@deltatee.com>
Date: Wed, 11 Jun 2025 13:41:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Leon Romanovsky <leon@kernel.org>,
 Nitesh Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-2-hch@lst.de> <aEhROl2D89kFX8C7@kbusch-mbp>
 <20250611034316.GA2869@lst.de> <aEmuG1dUDGuci7VW@kbusch-mbp>
 <5cddbda3-02bd-4dc1-9f7f-197279da6279@deltatee.com>
 <aEmxn0K6m34HsZeN@kbusch-mbp>
Content-Language: en-US
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <aEmxn0K6m34HsZeN@kbusch-mbp>
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
X-CRM114-CacheID: sfid-20250611_124215_291242_6AD1C716 
X-CRM114-Status: GOOD (  13.40  )
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



On 2025-06-11 10:41, Keith Busch wrote:
> On Wed, Jun 11, 2025 at 10:39:17AM -0600, Logan Gunthorpe wrote:
>> On 2025-06-11 10:26, Keith Busch wrote:
>> That is all correct. In order to use P2P on a switch, with the IOMMU
>> enabled, it is currently required to disable ACS for the devices in
>> question. This is done with the command line parameter disable_acs_redir
>> or config_acs.
> 
> Is there some other mechansim that ensures a host memory mapped IOVA
> doesn't collide with a PCI bus address then?

Yes, in the absence of a switch with ACS protection this can be a problem.

I haven't looked at this in a long time, but the iommu drivers reserve
regions where the PCI addresses are valid so no iova will be allocated
with a similar bus address. After a quick search, I believe today, this
is handled by iova_reserve_pci_windows().

Logan

