Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB49C3ABDD
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 16:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4exlvaWiZStICEmxDGRhB1/5dfYeOMHszVI40B24+p0=; b=F16R+H8gP0M6gJ7vEqXONVefZg
	VKtuvfMs93Ze3Pfk6WbAm+jgqYLeAxZuVHxYauNy6tRfI0kAmR5mgbVOH0zXBVqUbChny4bzrojBw
	sAQzHkqpwK4FtQaebBsPOlxHUqfoJQ20jfRFcUrOireRyStlsatdSUsCZsPhCFXbqC/JINNgbgPAj
	ZFJ03oe8vcxwFKKr7Ngj8sTjmskumCfTTjM98TdW1eZbcfdB4Azjnvb765rLGI7dqp3ix2//RzuCx
	143xig4biSvnCn+ky0aD7lCD82Fba9EEdXi7nXevYURFAOcPKwFerrnVhCe0G9AnRJu0xb8Drb+aq
	DrKhw0vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFEfW-0000000Fger-0ny2;
	Wed, 14 May 2025 16:09:18 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFDr1-0000000FYah-2Huy
	for linux-nvme@bombadil.infradead.org;
	Wed, 14 May 2025 15:17:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4exlvaWiZStICEmxDGRhB1/5dfYeOMHszVI40B24+p0=; b=BnROXkNezqFSAaLZUAI0qROd1A
	VKrwHqdyOk1x7FN4t/s9fu7qvTEFluoYcmE8Ls3+gBQDpqrD/fzPeo+4CCoMKnpgynhpTjAfRrotz
	bCEuCMxDmjv06+ZdGPrCFY0fB1J/gbF7n4Mr90LpU3r34YvQ/7ZWmZR24SXBq0EQXlNoHEodmV1ea
	+iwRk5Q/v56M9qCmTSTsnOPNYxSfR3CbLYNUt0emq0mvqSG8wplK+kqRpoHClY36YwboseD8Mabc4
	wRpfN1q1G+ix0dM2tbwl8uqfgJPlgDKiQ8V5gIa25nGcNiBfncg0ZFrb4YZyTITOBqx5livlnwFjt
	rRoGakAQ==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1uFDqy-0000000HEO4-2X9z
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 15:17:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E2C7168AFE; Wed, 14 May 2025 17:16:55 +0200 (CEST)
Date: Wed, 14 May 2025 17:16:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: ilya guterman <amfernusus@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers/nvme: Add quirks for device 025e:f1ac
Message-ID: <20250514151655.GA31705@lst.de>
References: <0250510102130.14710-1-amfernusus@gmail.com> <20250514151130.701885-1-amfernusus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514151130.701885-1-amfernusus@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250514_161704_796589_9966869C 
X-CRM114-Status: UNSURE (   8.84  )
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

Thanks! Applied to nvme-6.15 with a little tweaking to the commit
message.


