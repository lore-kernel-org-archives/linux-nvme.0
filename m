Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEFFC46CD4
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Dec 2023 08:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nmoCaH7sCDqSmFmYxL2m3ImOZ97T7jiVDtoO5+9MNDU=; b=MtWWy2f4M5aV7KD1dbjm1mOqeC
	xHa+x917v+ALm6Krll3BAOQbZukyDK226id7eWK32GUQAROBe1/jTe/uxEmfXfmR4AYX1qs2RxVbR
	NGBWF42CztRgc7/fQsNx10VxACIYo5mSQAAebuOh7X9Quygkbfs/6/fuLNDBfNb5+dZ5GM7u5gJK9
	nhq/KIiWVlE5QCW3FgWT3+fLciccCWvO0UhJ7AW6oDyztIiLPznNFmF2Y3JcR4Pai12+uSkm6yb6T
	BYOZBND5Qd8S1+Ham566KeqnAaJWTLRkMPx/6S6l8GzGokKGLHQRM8Csn/CSXLsZvBGegmAMFJIY8
	LbkPu5eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rIOxR-00EC5i-0W;
	Wed, 27 Dec 2023 08:08:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rIOxO-00EC59-0T
	for linux-nvme@lists.infradead.org;
	Wed, 27 Dec 2023 08:08:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EFC3368B05; Wed, 27 Dec 2023 09:07:53 +0100 (CET)
Date: Wed, 27 Dec 2023 09:07:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/4] nvme: also skip discard granularity updates in
 nvme_config_discard
Message-ID: <20231227080753.GA21943@lst.de>
References: <20231226085844.203878-1-hch@lst.de> <20231226085844.203878-3-hch@lst.de> <63948c97-d7e3-418f-b498-ddba3eb5fee4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63948c97-d7e3-418f-b498-ddba3eb5fee4@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231227_000802_352723_7187DB2C 
X-CRM114-Status: GOOD (  10.53  )
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

On Wed, Dec 27, 2023 at 01:18:13AM +0200, Max Gurtovoy wrote:
> maybe worth to add a small helper like we have for other discard limits:

I'd rather not add more wrappers like this.  They dont really
scale, so I'm looking into atomic bulk updates of all settings right
now, and the last I need is random churn due to a new helper..


