Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F1DC77B7C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 12:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2E4q/VTewWdAiwGBze8dCv3IXOy5Ea14A1k3uP8YBWc=; b=TWorTE6zh7mAF1u09kmoCVvKdi
	pzOAqMo3wI39C+mi5vUrTfAISU2XIHS6f/2t01yEVetZjwLK9DV6S9YR9EA/O9PfZ1At0Iw84YztV
	pu4Jy2F7TlgVUfLbQfcVP4AoJDDb6+atPwJ2IOgY3Steerl2Vnjn2mVgiMsjPEPNuzebi7cGkuahx
	X7vyF9xtBV1RhkJfrIMD5bIXa6qM5cMb0veJsAttFes2NGFZaPKRObw/wJxPsGWDyn5ln+UB79AY0
	6s2dg80uRwW9VbDgMcCP84BVJG+e6CmwUgmhFUIpJilK2dl03SejVyRanayJ9U3+TOpJShVmz9t3O
	2ZL4dONQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXJKL-0000000BNKM-3ZVK;
	Thu, 03 Jul 2025 12:46:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXIM2-0000000BCNE-10MZ
	for linux-nvme@lists.infradead.org;
	Thu, 03 Jul 2025 11:43:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C1C3367373; Thu,  3 Jul 2025 13:43:38 +0200 (CEST)
Date: Thu, 3 Jul 2025 13:43:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
	sagi@grimberg.me, hare@suse.de, mlombard@bsdbackstore.eu
Subject: Re: [PATCH V2] nvme-tcp: log TLS handshake failures at error level
Message-ID: <20250703114338.GA17686@lst.de>
References: <20250702140629.70378-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702140629.70378-1-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_044350_417883_1FE0C287 
X-CRM114-Status: UNSURE (   7.42  )
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

Thanks, applied to nvme-6.17.

