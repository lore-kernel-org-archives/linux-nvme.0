Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB81BC30658
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jul 2024 15:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AZaO7PzztV3+RodYWLP/7iMl+1tByKo+weh0E7vYnqQ=; b=1KF1n9FS6KJFCsZN1r5LJcY628
	QP6adcWZThMuqPd5Rx5UAz5+xMplNCUmFWrEuqQoK5+7uzPHJaQ0lV7Z3qnI6Gni0QnoqbeDknSQP
	w31/UnHjO49fwiuBTmmG2mFHMGUvcVobE3+xtX2QjGoV2rDDZCfh0PavpkiAvNQ2gtKUarpUMs56t
	ky3BD+TwI9ieTiT3OUmNlhbc9dbI7BL/Ji+8Y7HbhQTg85A6Dfx4IO8vGAzTd6699G6mBJFgL3jeV
	KYqClDJldDepjGe65tRn+AeSH8Mmeu9JTcIo6ORVduHNHPLu5zHoYIc6mY/E9Y0dSRfaamCkha5f9
	6qvnSS9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOfYb-00000007Dzo-3hQX;
	Tue, 02 Jul 2024 15:36:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOfYY-00000007DzL-3dU4
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jul 2024 15:36:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 79AA068AA6; Tue,  2 Jul 2024 17:36:31 +0200 (CEST)
Date: Tue, 2 Jul 2024 17:36:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	axboe@kernel.dk, martin.petersen@oracle.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, bvanassche@acm.org,
	javier.gonz@samsung.com, gost.dev@samsung.com,
	Hui Qi <hui81.qi@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v3] nvme: enable FDP support
Message-ID: <20240702153631.GA534@lst.de>
References: <CGME20240702103348epcas5p1015eafbddf4795558843cd74b0453b12@epcas5p1.samsung.com> <20240702102619.164170-1-joshi.k@samsung.com> <20240702113954.GA15325@lst.de> <ZoQZelWxFIiG5u4h@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoQZelWxFIiG5u4h@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_083635_068917_51D53614 
X-CRM114-Status: GOOD (  13.87  )
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

On Tue, Jul 02, 2024 at 09:15:06AM -0600, Keith Busch wrote:
> My first concern for applying something like this is what kind of
> maintenance burdens does this create, or any potential harm to users who
> don't subscribe to the feature? Nothing here looks alarming to me, and
> there is a clear demand to be able to access these features like this.
> Maybe it works out for some workloads, maybe it doesn't, but I don't see
> a need to block this at this point.

We're just abusing the interface, and giving how badly designed and
intentionally Linux-hostile it was I see no point.

If Samsung and Meta care enough about good Linux I/O temperature hint
support we'll get what we want in the technical working group, please
help working on that!

