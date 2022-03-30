Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DD2C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Mar 2022 02:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bUVuURAHJHgTx0fJiIjVF4U9QByC/2ULGYKpUR215ME=; b=zu/Er2oK2t3hXwis1PJ1H9E6VF
	ynK4ut5yejgeIG+bra6QtIcg+fBsX4215ndYrSHsEt0Fito7vi2SM6ahlgM3GbRT/3Cftjj+4O06f
	7zdhCCFgCPui0gpxogAYdkJ64OVNKPktq94yjX7sNeLi/ZSX51CJXQOXaxG2w0z6jUu8DUy42V6am
	X8zx+ZrG3SduUrBRz0f/FtmUJKBgbPEJROi1Lt5lBv20kQOzfwDajp6Y+oUtS08/OQf51qZYNJ2Wf
	WaJqZ+Wzs06n1IRVZVHy38kxjpEeoQwWxFIM2uBAAvlPBeHCBYG028vlfr2futBhZIVylW9uFo7lT
	9EZC0TOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nZNke-00DyZp-CL; Wed, 30 Mar 2022 02:08:00 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nZNkb-00DyYW-CO
 for linux-nvme@lists.infradead.org; Wed, 30 Mar 2022 02:07:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1267E613EA;
 Wed, 30 Mar 2022 02:07:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB78C340ED;
 Wed, 30 Mar 2022 02:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648606075;
 bh=AkX5e+wTeMQ4ic3oAOrKXqI5NwuiPlYRzw+ul249Sbs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tQy9NUUh3xga5wupjPsuzUsYwXnifgXgAWGNXxkQYScz+ZwhOBPuXmYCtaYya6ke7
 SRw8kb1ev68v+Rw/+f5TBqfDzH29FxQrA2N4GAV3iK9gp/GuBs4v+49145X2DIfObC
 hmDfngkjXkYFU59Vwi5z5BfMEhzoVhDW56Q+8f20r3tg4nToKwTlJ+q10IAhRsYfPg
 Rwkr8xnS4nRJYy/F/NlYylYWiphqUGlB18LZh29KKiRjBlFpEfG3dhk5FXW41Vr+wu
 8pmkvlFZxcfrOSLGCfwdSCin5RLbSBn4E5OB1eRffiY0w5v3YDwW+PuPERH9pawigT
 ZhunVUkzXINLg==
Date: Tue, 29 Mar 2022 20:07:51 -0600
From: Keith Busch <kbusch@kernel.org>
To: Tanjore Suresh <tansuresh@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Asynchronous shutdown interface and example
 implementation
Message-ID: <YkO7d7Eel4BVQOy4@kbusch-mbp.dhcp.thefacebook.com>
References: <20220328230008.3587975-1-tansuresh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220328230008.3587975-1-tansuresh@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220329_190757_510916_BFF2BC3D 
X-CRM114-Status: GOOD (  20.70  )
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

On Mon, Mar 28, 2022 at 04:00:05PM -0700, Tanjore Suresh wrote:
> Problem:
> 
> Some of our machines are configured with  many NVMe devices and
> are validated for strict shutdown time requirements. Each NVMe
> device plugged into the system, typicaly takes about 4.5 secs
> to shutdown. A system with 16 such NVMe devices will takes
> approximately 80 secs to shutdown and go through reboot.
> 
> The current shutdown APIs as defined at bus level is defined to be
> synchronous. Therefore, more devices are in the system the greater
> the time it takes to shutdown. This shutdown time significantly
> contributes the machine reboot time.
> 
> Solution:
> 
> This patch set proposes an asynchronous shutdown interface at bus level,
> modifies the core driver, device shutdown routine to exploit the
> new interface while maintaining backward compatibility with synchronous
> implementation already existing (Patch 1 of 3) and exploits new interface
> to enable all PCI-E based devices to use asynchronous interface semantics
> if necessary (Patch 2 of 3). The implementation at PCI-E level also works
> in a backward compatible way, to allow exiting device implementation
> to work with current synchronous semantics. Only show cases an example
> implementation for NVMe device to exploit this asynchronous shutdown
> interface. (Patch 3 of 3).

Thanks, I agree we should improve shutdown times. I tried a while ago, but
lost track to follow up at the time. Here's the reference, fwiw, though it
may be out of date :):

  http://lists.infradead.org/pipermail/linux-nvme/2014-May/000826.html

The above solution is similiar to how probe waits on an async domain.
Maybe pci can schedule the async shutdown instead of relying on low-level
drivers so that everyone implicitly benefits instead of just nvme? I'll
double-check if that's reasonable, but I'll look through this series too.

