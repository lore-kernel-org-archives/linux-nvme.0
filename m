Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03ADC3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jan 2024 08:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DLaQDXv/o541Mf6RFWDz0tDlyTVW0GP6vSZ0hHB2kts=; b=vz9jhMGgIcQGwDYA85Vaxb0XlY
	sFjeooATEjlJO9rsMXYU0RzmxmcpPNFnN3EW644w8oE9ogKCP2jDmnGGg67+3l5CZAbEoP1NLzYMR
	+y6AvsstSg7w44Z5fDOft4k91swlTbSjTUq+R6rYRmSZ/xRa2V7HXuC0yPpqx2kJ4ZepGYMvtNAx/
	hna2VE3zBpBXegB/+xYnKH/CnyBeyJw7cjwwdQQUhVh8fsTJcDzc7BqyHW2XP9s5NwLVanaeqLlW3
	j/FIF5OC6ahMOoWz0HPVOPrvQNgUg9DTfbT+o2U0cHaUZu1CTupTYyv4Z3J/zR0YNcQSJ3LPxnes1
	zMGj5KIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMkzi-004JED-1u;
	Mon, 08 Jan 2024 08:28:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMkzf-004JAL-07
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jan 2024 08:28:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DE82668BEB; Mon,  8 Jan 2024 09:28:19 +0100 (CET)
Date: Mon, 8 Jan 2024 09:28:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jeremy Allison <jra@samba.org>,
	Jeremy Allison <jallison@ciq.com>, tansuresh@google.com,
	gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/4] driver core: Support two-pass driver shutdown
Message-ID: <20240108082819.GA4752@lst.de>
References: <20240105042955.GC23630@lst.de> <20240105181517.GA1861750@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105181517.GA1861750@bhelgaas>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240108_002823_219477_EEBEEA14 
X-CRM114-Status: GOOD (  13.38  )
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

On Fri, Jan 05, 2024 at 12:15:17PM -0600, Bjorn Helgaas wrote:
> This is a bit of hand waving because I'm not a workqueue expert, but
> it seems like basically the same amount of overhead without having to
> add .shutdown_wait() to the bus_type and the pci_driver.

It spawns a new work for the busy wait for the shutdown.  That's not a
very efficient programming model.

