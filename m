Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC37C47DDF
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jan 2024 14:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=29J+yLNud3+aW8VuUKma2XsPriJLgJmtu07XOWMpBhU=; b=frEAVzvk88RaOsZruYKLtfmpQN
	Mg2S0JGwDvG3vBhyDh2UgArpBBP/hFVPKGkX7h8kxBHnI2ElWd/CLUPTNx9Y86Wko8kRHsFgFDY2F
	AFJ53fDwBB6kLyYDKO9s+gpeiO+aMWKw97CAJ1W9OdvPjMoTLzXBPH35oWd0r3A9W/lEfuRH31qeJ
	GGDE9pZsE1ATKUCxidaYx2Y42D6OejeZho7/acpFid5f9TJw8J2tgfK8Wm+DUMW8nMk0HH2YFZoBN
	jVIFIhiP7QGRnT2U4N4T/iV8a528Qp52HfLP3QoxEKHifH17FQNvETQD2C6mt5Cu1c0yRCjVxh8v6
	AuokdpwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT0vB-00000000Pe9-29r6;
	Thu, 25 Jan 2024 14:41:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT0v8-00000000Pdi-3hKg
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jan 2024 14:41:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AE7BE67373; Thu, 25 Jan 2024 15:41:30 +0100 (CET)
Date: Thu, 25 Jan 2024 15:41:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, oren@nvidia.com, israelr@nvidia.com,
	dwagner@suse.de, oevron@nvidia.com
Subject: Re: [PATCH 5/8] nvme: sync the namespace scanning during ctrl start
Message-ID: <20240125144130.GA18804@lst.de>
References: <20240122145659.5574-1-mgurtovoy@nvidia.com> <20240122145659.5574-6-mgurtovoy@nvidia.com> <20240123090231.GD30773@lst.de> <f168e3d8-ddec-46cd-a032-2ca771b6cd23@nvidia.com> <20240124094832.GA31289@lst.de> <1315cf2b-038a-4830-87ac-5ac1fbd5a1e9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1315cf2b-038a-4830-87ac-5ac1fbd5a1e9@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240125_064135_104516_B18E521D 
X-CRM114-Status: GOOD (  10.58  )
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

On Wed, Jan 24, 2024 at 12:23:33PM +0200, Max Gurtovoy wrote:
> Even in this case of re-creation we must sync the namespace identification.

But a format is not a re-creation.


