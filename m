Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B043C4167B
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Nov 2023 15:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eIOKD+FY+FEdP4H+POn6mN4+645LcKCDE25yrI69ycU=; b=IXwVF5m3PLVytvvcJurksiQDGm
	uCzznbJALP9hJuCekfrs2GTvyLKRyNwSQCceW3RxFo82pSelQqBlsACsYqLylQvENgKcweJfY+ZCe
	+XrAFZ7QLZQthQalYDrHzcNoUvk6l1fwDPL9BHAu26y4lBLiTNeX8NwYyVgkYix+0ISyGDAg6MJ37
	eg+cYDDbnLEEifaraOTFqJsbcQOSTvR1kPFZf1rpUd/C3cK05OcOMpjerIpC3FSBrP9XJbAG0AsmO
	aXP0reJMYuRybrdOrouGKfz6t43/gLMo1dHap5NyLaFJbvea4WHIlb2++z/RoHY31jUGhlRWkMMd2
	JzdxFS+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7dym-002tGN-1k;
	Mon, 27 Nov 2023 15:57:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7dyj-002tET-38
	for linux-nvme@lists.infradead.org;
	Mon, 27 Nov 2023 15:56:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3DA8067373; Mon, 27 Nov 2023 16:56:49 +0100 (CET)
Date: Mon, 27 Nov 2023 16:56:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC v1] nvme: add cse, ds, ms, nsze and nuse to sysfs
Message-ID: <20231127155649.GA1403@lst.de>
References: <20231127103208.25748-1-dwagner@suse.de> <20231127141857.GA25833@lst.de> <ZWS5dM5FzTMr5ftO@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWS5dM5FzTMr5ftO@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_075658_155249_F17753E9 
X-CRM114-Status: GOOD (  14.60  )
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

On Mon, Nov 27, 2023 at 08:44:52AM -0700, Keith Busch wrote:
> > I'd probably spell out metadata_size, or probably even better
> > metadata_bytes to match the unit postfixes elsewhere in the block code.
> 
> Should this even be an nvme specific attribute? I thought we should have
> blk-integrity.c report its 'tuple_size' attribute instead. That should
> work as long as we're not dealing with extended metadata at least, but
> that's kind of a special format that doesn't have block layer support.

Reporting the tuple size is a good idea.  But is that enough for
the existing nvme-cli use case?

