Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A96CC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 19:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=On3lskfefDO7Bl1q7PKJQXQAMhTxwnHGKT6na9XT9Wo=; b=4w94F0QiJQGis3up9YzxGiyN/e
	g7uMFgtqnvFA7NFlX+S1YN7yg6HkirRMs8kbG74X2Px5sjNU952lJBRbHdliwrbfJzUb2kH2HUy2w
	JxGwCQ7AJANr4o7lB+OJSSKvZErlaNfajh0JBoElkYUsKCpKHp4YvrkENWWtPfU7V9nJrUd6k5Tj/
	Ez3LUnP1INy6HkfhcaAGgiXMaiKn2+Fqm3Vjr5pylvbBlzo5BCA/oi9YLdgC6yhWNaazEAkx9uni0
	vaws3kcfhK+mBPWIqH00ac4/HvtR8YXj+X6dzcUHDoqvNqXIZFUVDwIzJ8Qq604KTgcZ/R8mSGllI
	Ks1m3wVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTqiA-006eCt-3c; Mon, 14 Mar 2022 19:50:34 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTqi6-006eAe-De
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 19:50:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 92967B80F9E;
 Mon, 14 Mar 2022 19:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFBBEC340EE;
 Mon, 14 Mar 2022 19:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1647287427;
 bh=On3lskfefDO7Bl1q7PKJQXQAMhTxwnHGKT6na9XT9Wo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WFZcNWXFGZVA+2W7kyzs6SFdlrv3FyV/aJpjGOYQrp3rgQAHpkzRjFdMvwqDhPEVY
 8HccX0Lo2E1PNfiZQDUrzkEZYvszKgIDh+jEv4UlieiUh562ltwNsZ+yC+z+A/sAvG
 VQMJafX4Ed9uPokPP2M97s8W6Z/uFiwrLEVIODiu9Lw4BvxBUz98r92nboGi0+u9DC
 rsyoWTTLz4oO2dWRjOaZxGA3OhCqhH9OiqCZtdX0G5qpVM+atFaGbdz5ZlHsYog415
 LYR+jbkEfGOWoZwkJxMlwjdHCgo0dnUlWfhid2a5xtgycNP4N1S4HQNjiP7N/dP0ey
 hYnS7fa2QRuvg==
Date: Mon, 14 Mar 2022 19:50:25 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Avi Shchislowski <Avi.Shchislowski@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
 "Bean Huo (beanhuo)" <beanhuo@micron.com>,
 "Luca Porzio (lporzio)" <lporzio@micron.com>,
 Manjong Lee <mj0123.lee@samsung.com>,
 "david@fromorbit.com" <david@fromorbit.com>,
 "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "song@kernel.org" <song@kernel.org>,
 "seunghwan.hyun@samsung.com" <seunghwan.hyun@samsung.com>,
 "sookwan7.kim@samsung.com" <sookwan7.kim@samsung.com>,
 "nanich.lee@samsung.com" <nanich.lee@samsung.com>,
 "woosung2.lee@samsung.com" <woosung2.lee@samsung.com>,
 "yt0928.kim@samsung.com" <yt0928.kim@samsung.com>,
 "junho89.kim@samsung.com" <junho89.kim@samsung.com>,
 "jisoo2146.oh@samsung.com" <jisoo2146.oh@samsung.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/2] block: remove the per-bio/request write hint.
Message-ID: <Yi+cgUXaSx+PN10B@gmail.com>
References: <CO3PR08MB797524ACBF04B861D48AF612DC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <e98948ae-1709-32ef-e1e4-063be38609b1@kernel.dk>
 <CO3PR08MB797562AAE72BC201EB951C6CDC0B9@CO3PR08MB7975.namprd08.prod.outlook.com>
 <d477c7bf-f3a7-ccca-5472-f9cbb05b83c1@kernel.dk>
 <c27a5ec3-f683-d2a7-d5e7-fd54d2baa278@acm.org>
 <PH0PR08MB7889642784B2E1FC1799A828DB0B9@PH0PR08MB7889.namprd08.prod.outlook.com>
 <ef77ef36-df95-8658-ff54-7d8046f5d0e7@kernel.dk>
 <bf221ef4-f4d0-4431-02f3-ef3bea0e8cb2@acm.org>
 <800fa121-5da2-e4c0-d756-991f007f0ad4@kernel.dk>
 <SN6PR04MB3872231050F8585FFC6824C59A0F9@SN6PR04MB3872.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB3872231050F8585FFC6824C59A0F9@SN6PR04MB3872.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_125030_630936_E1E2F3FB 
X-CRM114-Status: UNSURE (   9.57  )
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

On Mon, Mar 14, 2022 at 07:40:42AM +0000, Avi Shchislowski wrote:
>
> We also supports Samsung & Micron approach

Great, so send some patches upstream to have it be supported properly.

- Eric

