Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01080C87FCA
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Jul 2025 16:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+8S4vPJGfMv7NlAHMZN0/uhfNYiYBWUuW6amhbVE+qY=; b=bJZC+clEa1VczKbl9JyEv4Eesb
	QiWC7Qhyf+3S0v2htMYAxblTGlp04z1fMXBiUg7aKsI0rXkumX0FAfULq4H/dKSTEKg4R/VqQuv9q
	qfmOMwTyleUncH/GPHqPegEsOcLSHXqkncCcEE8uxn5rt5vPYflXUnMDdYWA6Ig7ba6RPFF/DnHws
	OTep5kT3QG+OWRpdNMQ6IDBtzkD9kn9X3LlFI8NkZUUnusiSDcrgEItXzI7QYrsHZpnR4qFoe1k7h
	VeAOqkP4FqzXxGj8wKOBkVppZpcQpf5A9BKKIcHK67HOu8TEWejvvdm7pmjl8qsZ8FDQxaieXwRKV
	ieWdXWOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhVty-000000043bI-16Wz;
	Thu, 31 Jul 2025 16:13:06 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhU96-00000003oUw-1qDS
	for linux-nvme@lists.infradead.org;
	Thu, 31 Jul 2025 14:20:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A9BD6A55275;
	Thu, 31 Jul 2025 14:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 665BCC4CEEF;
	Thu, 31 Jul 2025 14:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753971635;
	bh=+8S4vPJGfMv7NlAHMZN0/uhfNYiYBWUuW6amhbVE+qY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eJYIETxU4+WnO6sWcVkai7o1TRmmfX1yBCZ//VDX+ipnNITmKe85QxMu8c1kWWgpU
	 WKyLh+rRLU2XL1867dSv2taBrR0ESbbGST3RCJY/1KQhxn/9cRcBjDNzaSNKSy/nU3
	 xhCvcmaYhIcV8p/o4yGJDzYJDANoTLjGkYkh2n8Ymu4MgPA05pFM15NqUwFF4nJ4rh
	 bWr78ByBh/KQlS7QBrG/IExPsdwatpl5vJJBXhGJSB0xWQqna8sU46jQjxSXDfRUll
	 IWbptYoEKeCNZq+qsjHwSTvhk6I5wOzS66KrVc/FSK6v1XurlEAB58n5zTsxO2NZhF
	 if/R9YExYEOPA==
Date: Thu, 31 Jul 2025 07:20:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, borisp@nvidia.com, galshalom@nvidia.com,
 mgurtovoy@nvidia.com, tariqt@nvidia.com, gus@collabora.com,
 edumazet@google.com
Subject: Re: [PATCH v30 00/20] nvme-tcp receive offloads
Message-ID: <20250731072033.030866c4@kernel.org>
In-Reply-To: <253wm7o354g.fsf@nvidia.com>
References: <20250715132750.9619-1-aaptel@nvidia.com>
	<253wm7o354g.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250731_072036_549288_E268CF02 
X-CRM114-Status: UNSURE (   5.00  )
X-CRM114-Notice: Please train this message.
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

On Thu, 31 Jul 2025 15:40:47 +0300 Aurelien Aptel wrote:
> Any thoughts regarding the series?

What thoughts do you expect me to have?

