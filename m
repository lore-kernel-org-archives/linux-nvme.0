Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBBFC3DA4A
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Aug 2024 06:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=AdiT02gkdAKOxFUhJv6MNdEtmw
	4YibyVEcRgvt+APPrW/k6pE7YmAVKT4Qq/QOnU0AyR8YeOPIMVnIAkz1jzdeYvEkivfcj9cER9YtS
	6/zsdW2IT3QsqVZJVt+fH/QFqm34jewxi8PLlwlQhv7dr+i3z9iH+9VZ2wLxZdRSi6sLofA6BwAc2
	bNUaey5Ktzrlh6zDWTwCoasNuuHEjEi4GtVwyS13mMTl84NTJvJjwrODFSSCG7a0ruwuo4MO9md65
	ZCSVOWQyqXRirXPeKuzTgOrPszG7yJMyfsw1DbgpU7uaxj8t4Ujw6acFDSdPpcwPneRyrhMOhUxJs
	6g5QdEaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh1g2-0000000Bhd3-3Ubw;
	Thu, 22 Aug 2024 06:52:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh1fU-0000000BhUz-2bdv
	for linux-nvme@lists.infradead.org;
	Thu, 22 Aug 2024 06:51:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 81B19227AAA; Thu, 22 Aug 2024 08:51:30 +0200 (CEST)
Date: Thu, 22 Aug 2024 08:51:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: sagi@grimberg.me, axboe@kernel.dk, hch@lst.de, kch@nvidia.com,
	linux-nvme@lists.infradead.org, me@yawk.at
Subject: Re: [PATCH V2] nvmet-tcp: fix kernel crash if commands allocation
 fails
Message-ID: <20240822065130.GA3141@lst.de>
References: <20240821142826.69366-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821142826.69366-1-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240821_235136_808277_21769752 
X-CRM114-Status: UNSURE (   9.13  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


