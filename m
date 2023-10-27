Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62607C25B47
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Oct 2023 09:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VbUNMubTE9vUqysjGe+jqogFpEoQdehGgBJ1/qIemXo=; b=ENdfBkXoDGAwfWZmENCnNAN4sy
	EA+sSaaFJXaclw8kW2Jmj7UCV0argHv2+02nxuEawoFMQfHWgTPl+RZcBvhdr700zGhq66VwCIS14
	3OBmrnqTHxGAEya1D9izpLe03ySUuuZVx8S3AXAxfKEBwbk/zrf/RwXMKfAwY/P47QYaAM5J081Il
	hZVStfGxGiU8Lft7T62DHdaNrBwz0v8ViJuYsGoukLmcsium3Z3VueNlMNw4hxfW6f9SjiFXy+H0O
	XZT5WYYforRsIzA/1Cr1y8wMD9ounvOtDxoImZPliptDgG9zV3vMaM27PEJ2vlW0YLe86Cc7vPbdj
	vCOMzX0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qwJ2U-00G1DU-2R;
	Fri, 27 Oct 2023 09:21:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qwJ2S-00G1CH-09
	for linux-nvme@lists.infradead.org;
	Fri, 27 Oct 2023 09:21:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 61AF367373; Fri, 27 Oct 2023 11:21:50 +0200 (CEST)
Date: Fri, 27 Oct 2023 11:21:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme: keyring: fix conditional compilation
Message-ID: <20231027092150.GA21039@lst.de>
References: <20231026130804.142586-3-hare@suse.de> <b138c4c5-9b49-4338-a79a-2f77a13381e8@app.fastmail.com> <d497429d-a1a2-4bf4-a958-3865294d9f2e@suse.de> <20231027052118.GB7885@lst.de> <78d1b4e3-4bce-4cbb-8ebe-8eb3f0fe9930@suse.de> <468cd6c9-c541-47ea-a2bc-f6cd09155351@app.fastmail.com> <20231027083003.GA17042@lst.de> <9bd4e078-b206-48b8-b94b-bc411317bb3d@suse.de> <20231027085644.GA19366@lst.de> <cdf931ad-626b-4efa-bc74-f4566b88e404@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdf931ad-626b-4efa-bc74-f4566b88e404@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231027_022156_232130_C6AC7F81 
X-CRM114-Status: GOOD (  11.58  )
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

On Fri, Oct 27, 2023 at 11:08:23AM +0200, Hannes Reinecke wrote:
> obj-$(CONFIG_MOD1)	+= mod1.o mod-common.o
> obj-$(CONFIG_MOD2)	+= mod2.o mod-common.o
>
> and mod-common contains a 'module_init()' and a 'module_exit()' function, 
> what happens if I load mod2 after mod1?

mod-common is already loaded and won't be loaded again.

> And what happens if I unload mod2, but keep mod1?

mod-common doesn't become available for unloading until all
modules using it are unloaded first.

