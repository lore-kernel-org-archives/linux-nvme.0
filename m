Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2638BC4167B
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Nov 2023 13:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lf40PTCxBv5iAG3/8E0RyfPSb8+F6NNBbJiqZ7gQ3ak=; b=hIyL0J/HIOqpILgNwKg5xWsNvU
	+jpteDv/PRcev7ZW7GTXSPI8eBd0BJseIR8WftRgW2C2CpRk6T26TLKiIYkteRqKkJ3hbFAOyYyGW
	EOeVdUte4StWU3CnW69ENiT1DNw6/yJ5rgvTugjSeMCieqquSBtmhuBg+UaeiOlKzyWeyumrxNi3o
	SjGLNAmn9sGnEvbOVkIHYHlFQvazPBJKcWrCgLC7hUoDbFRjEJw8HMdi/KSI0IsuHv1+YjC8dfjkX
	j5lg436grgNbUmHhhzOCCtIfRED4wG51xXbTf7ARBL3qc1fboYMW11QjCV4wMFpO4fEMtUISBJWCb
	HfHTX5gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7c7j-002dFc-0I;
	Mon, 27 Nov 2023 13:58:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7c7g-002dEm-0a
	for linux-nvme@lists.infradead.org;
	Mon, 27 Nov 2023 13:58:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 647A567373; Mon, 27 Nov 2023 14:57:55 +0100 (CET)
Date: Mon, 27 Nov 2023 14:57:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC v1] nvme: add cse, ds, ms, nsze and nuse to sysfs
Message-ID: <20231127135755.GB23928@lst.de>
References: <20231127103208.25748-1-dwagner@suse.de> <ZWRy-4Bhqw0Gxo4c@kbusch-mbp.dhcp.thefacebook.com> <mwen6fl5yszmk5nh2hbsqtu5pu76ir6rh6jpdfppbczsov7qfz@vivqeew6y7wk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mwen6fl5yszmk5nh2hbsqtu5pu76ir6rh6jpdfppbczsov7qfz@vivqeew6y7wk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_055804_383314_CF9125E6 
X-CRM114-Status: GOOD (  16.97  )
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

On Mon, Nov 27, 2023 at 01:07:32PM +0100, Daniel Wagner wrote:
> libnvme itself is also cashing this value and exposes it via the
> nvme_ns_get_lba_util() getter. I'd say libnvme shouldn't cache it
> either. Instead the function should just issue the ns command to report
> the current nuse value.
> 
> I'll drop the nuse sysfs entry.
> 
> Unfortunately, 'nvme list' is using the 'nuse' field for showing the
> currently used space. I was hoping to get 'nvme list' working without
> issuing any commands.

I'd be ok with implementing nuse in a way where we issue an identify
command to read it, but rate limit the calls to something reasonable.
I think the kernel can do that much better than userspace because it
can keep that state a lot better.

