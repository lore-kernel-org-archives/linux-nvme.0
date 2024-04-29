Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D4DC4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Apr 2024 17:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tK0K6yuM2ErZaa56FWFc/pUIfXVI8UrCztL55MVgwKA=; b=MC9APlhNEiFUqjn+1dKQvR3I+5
	RCQ7RNA6imHY2tLtWnvT2lk4ElJ48q9NhcWY5OwQlGOIpaBG09TYDqMVDmE+d83uVQ69OUXe7SwM/
	bMLpC3u75W93mc8BqKiMo3IK5JBodmCQ4Ps4MidL/deWBhZbCidklV+nrnWfBd6eMbTkk278FlJ/1
	N7omID/3c2ReRN74z/R25SImiAs4HcKBRSg42RVKVtq9blpV5DWzcI2Y8c10QQR9sHEbn9WwAZmy2
	TdUUEPszahyB2txTsV0RwHXnEvQb1/t4oi5qym6CThQKWlBvL7ZRhxaw8Jf7yaTtFnaU5HYDpn9Z5
	w9Bwekrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1UTb-00000003gAf-3HFO;
	Mon, 29 Apr 2024 17:07:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1UTX-00000003g55-4BKq
	for linux-nvme@lists.infradead.org;
	Mon, 29 Apr 2024 17:07:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5B467227A87; Mon, 29 Apr 2024 19:07:29 +0200 (CEST)
Date: Mon, 29 Apr 2024 19:07:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Christoph Hellwig <hch@lst.de>,
	axboe@kernel.dk, martin.petersen@oracle.com, brauner@kernel.org,
	asml.silence@gmail.com, dw@davidwei.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 02/10] block: copy bip_max_vcnt vecs instead of
 bip_vcnt during clone
Message-ID: <20240429170728.GA31337@lst.de>
References: <20240425183943.6319-1-joshi.k@samsung.com> <CGME20240425184653epcas5p28de1473090e0141ae74f8b0a6eb921a7@epcas5p2.samsung.com> <20240425183943.6319-3-joshi.k@samsung.com> <20240427070331.GB3873@lst.de> <73cc82c3-fbf6-ea3e-94ec-3bdce55af541@samsung.com> <Zi-MvOZ_bYVuiuBb@kbusch-mbp.mynextlight.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zi-MvOZ_bYVuiuBb@kbusch-mbp.mynextlight.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240429_100736_201926_D31D7DDF 
X-CRM114-Status: GOOD (  15.43  )
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

On Mon, Apr 29, 2024 at 01:04:12PM +0100, Keith Busch wrote:
> An earlier version added a field in the bip to point to the original
> bvec from the user address. That extra field wouldn't be used in the far
> majority of cases, so moving the user bvec to the end of the existing
> bip_vec is a spatial optimization. The code may look a little more
> confusing that way, but I think it's better than making the bip bigger.

I think we need to do something like that - just hiding the bounce
buffer is not really maintainable once we get multiple levels of stacking
and other creative bio cloning.

