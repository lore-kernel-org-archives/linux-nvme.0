Return-Path: <SRS0=peCB=2B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FF9C43603
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 16:18:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37F24205C9
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 16:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hCy6K5lA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4Z8cw2P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37F24205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mYT7mMLkVAHW63jIb9dZG/lCEG4ZvPHAD8JawBqlogA=; b=hCy6K5lAfFcHLt
	3cD4yvFaBGeNkpqqepSlssWAeNvDKCf9VwYlhxrLI20+EQ5rZF36ZLbzbphtQZoCNUs2MTuJ6tASO
	/7zhn2RRyLSwaWCAv3XrQeq9FW/R2EV60VypO/7j3q9+nFGVJoRjAJhUFd+Wsaq0DP67JcTJIWqFh
	MUZTW0B7XolldHZ8uFPHbLazZR9keQMSVzQRBVfj+yZMgFn8Kj2yEgK4YXj7b9L4Vvq0m0kyGgrrn
	5LNrLayeZSRQjXId+y9QZuFHVVPRbu8xTq+znzqEvu4gzjA66U8nzuKqfZ5yZ+z+F6aDhKM1rhfhY
	leq6SwaBUQq+4lNy5D1Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1if4h7-0004o8-Ib; Wed, 11 Dec 2019 16:18:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1if4h4-0004nl-MA
 for linux-nvme@lists.infradead.org; Wed, 11 Dec 2019 16:18:31 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F2DD2205C9;
 Wed, 11 Dec 2019 16:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576081109;
 bh=wK2PSuxQD024ene7zXvOKPSUJnmOFoWdG8mDjLlZkT0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f4Z8cw2PcUbpKXRztsX8C2fxEXl3FwJ8W00zL7ZJqomEzeyd9DNIcxIW4iPn+TBVy
 IWNmIhq8nHQ13UgTW/nOMF7+rB0mH/NjJ9SAM72uJBzWz9DepgCHDp2ZVYLRVNlvGr
 xXd/JdSaCeHcNJc9JhanhPQE1PFKgo930ijjGtiM=
Date: Thu, 12 Dec 2019 01:18:23 +0900
From: Keith Busch <kbusch@kernel.org>
To: tsutomu.owa@kioxia.com
Subject: Re: [RFC PATCH 0/5] to add more nvme reset functions
Message-ID: <20191211161823.GA493@redsun51.ssa.fujisawa.hgst.com>
References: <346d379a5f9940dcba60242d2d9e119a@tgxml778.toshiba.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <346d379a5f9940dcba60242d2d9e119a@tgxml778.toshiba.local>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191211_081830_750568_C4EFE6BB 
X-CRM114-Status: GOOD (  13.07  )
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
Cc: hch@infradead.org, sagi@grimberg.me, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Dec 11, 2019 at 02:34:15AM +0000, tsutomu.owa@kioxia.com wrote:
> This series of patch is to add support for nvme reset functions
> described in NVM-Express specification 1.4 "7.3.2 Controller Level Reset" 
> (conventional hot reset, link down reset and function level reset)
> and "7.3.3 Queue Level" (queue level reset).

You're not providing any justification for why you want these implemented
in the nvme driver. What issue is this addressing?
 
> I'm still wondoring
> 	- if it's ok to export functions from drivers/pci.

Probably not. They are private for a reason.

> 	- if it would be better not to use CONFIG_NVME_PCI_RESET
> 	  and/or CONFIG_NVME_QUELE_LEVEL_RESET as these are noisy
> 	  and these features are based on specification anyway...

First, if you're going to introduce a Kconfig option, don't split the
patch that actually uses it. Second, don't introduce new kernel config
options for such features in the first place.

> 	- what is the best way to export nvme_pci_* functions in
> 	  drivers/nvme/host/pci.c to drivers/nvme/host/core.c.

Don't export functions that direction. Use ctrl->ops if core needs to
call a transport specific routine.

> Any comments would be highly appreciated.

The majority of this series is at the pci protocol level, and the pci
driver already provides the requested capabilities (but with a more
safe implementation). Let's not reinvent it just because one nvme
transport happens to use the pci bus.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
