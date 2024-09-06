Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B6AE6FE34
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2024 17:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yY/wHfam4wYgCepnkAHNAGhukYt3dscrwknv7RzjNZU=; b=hiG79cJBiLklBTffkUj+Jdy4fn
	iKSoWjkDBmREouLV0wOaAUihnRcjr/9De8Az9p9ldPa/eTXNMKYEoVjutb0wc2N1LisH/cOqzQE8w
	fb4N/DQA702TULnB5gE72WOMVOFIsgGRGN+pFZnY5wJsWWgmRp/VOcmoFsEsSmf5ASnrPeazHV6ml
	ROd1q9FmBZ07s2iYcRBm2OdQijvW2Mn4+D/EgxBXYRM0AsjhQA5dcwzaPs3IAAhhGBvr8tyGA5ked
	0aiXnI0DUDDp7S5t+ig36N+Da9aT08R62OKHCEtnaeJgWP+iPMdkg6+JJqk9E0ZCZpGX08Ngdm3IZ
	M/l2irPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smcm9-0000000D7fQ-1sJS;
	Fri, 06 Sep 2024 17:29:37 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1smclt-0000000D7YA-2VbD
	for linux-nvme@lists.infradead.org;
	Fri, 06 Sep 2024 17:29:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 687A6A451A0;
	Fri,  6 Sep 2024 17:29:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE96C4CEC4;
	Fri,  6 Sep 2024 17:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725643760;
	bh=4R4tYRjWtOV89KBFhREAoM4GZTU9lmpfXyFsNibTZZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uM1r0ECxl7c9gyXWZkjCSVPS5Ston5PwEgLBHqXMLSeMk6dcy2v7+vpFxQrguxTNU
	 eZC4qEyu0ucZc22RNTYfAPGvyHuYjQPB7/6IwK2G+OIVWkYS9w5sXvqThfimiYvp+a
	 VmnY9wQEpMjPQ2Oh/QoRLsjRI5ZmydEtIechOuc658K56gah1ZDDJR3F1SgsqQkeIi
	 5wXJIytWLcCj4vgBTZ2ra7+2tGg5FLaf1wQVDqbqJ2/u48ZlDikbCLnVXmNJbEWc3r
	 okempnT7DK0tV+KGi0vvYHZOFiYubDyUN4bMBLZDGE0MdK2hI8Zi3Lnp0cotb1BUlG
	 6Za0je7TerRng==
Date: Fri, 6 Sep 2024 11:29:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH-part-2 0/9] nvme support for sgl mptr, safe passthrough
Message-ID: <Zts77s6zRLzDSCqn@kbusch-mbp.mynextlight.net>
References: <20240904183818.713941-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904183818.713941-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240906_102921_743028_7DEA4D22 
X-CRM114-Status: GOOD (  10.17  )
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

On Wed, Sep 04, 2024 at 11:38:08AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> NVMe's implicit memory lengths is a danger to buffer overflows. It's
> been know for a long time this vulnerability exists.
> 
> The nvme protocol provides sgl with explicit lengths, so if the hardware
> is capable, let's use that.

Made some other fixes, minor modifications, and adjusted the patch order
to prevent any bisect hazards. Rather than resend the whole thing out
right now, I've set up a tested branch here:

  https://git.kernel.org/pub/scm/linux/kernel/git/kbusch/linux.git/log/?h=nvme-meta-sgl-2024-09-06

