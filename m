Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D550C3064D
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jul 2024 11:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RTpDVjHhjrTAE7aue78RNyE0KXF4WuPkwfEHSeb/2H0=; b=bTfQrJsD9VsxUGkegdj3UF33AY
	iwDbr0OYoAW6EveohUbMVT4oOE58pOknjCE2i4YsFCw4piYQJ+nVojQwxDU+Ck36nFDa2tqrPXp5B
	WCWJRfNKY+amSLsmVIoogJZTegJP7zlH6iqxjXHp5Xj35gFi820WfFxZ+qmGuvHaEoWY/s3/W/Nk0
	yq025Kvi3LhaqLGx1d0XbyQTm9KOgVLHDBQ191um8u/TjcmCO6nPt7NPL4u+mZ5j/AzNQgExuwmQm
	x413KQlIOaanlLTWe+u/kZs6lfZZDB35agk7M0UfiOV9aTFliunM3Z3pMyiDmuutF4k4QPrzusadt
	G+Vr9sOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sObrh-00000006Uwh-3ilU;
	Tue, 02 Jul 2024 11:40:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sObre-00000006Uvv-36EP
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jul 2024 11:40:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D5A2A68AA6; Tue,  2 Jul 2024 13:39:54 +0200 (CEST)
Date: Tue, 2 Jul 2024 13:39:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de,
	martin.petersen@oracle.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, bvanassche@acm.org,
	javier.gonz@samsung.com, gost.dev@samsung.com,
	Hui Qi <hui81.qi@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v3] nvme: enable FDP support
Message-ID: <20240702113954.GA15325@lst.de>
References: <CGME20240702103348epcas5p1015eafbddf4795558843cd74b0453b12@epcas5p1.samsung.com> <20240702102619.164170-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702102619.164170-1-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_044002_944697_849283FC 
X-CRM114-Status: UNSURE (   8.76  )
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

Same NAK as before.  FDP was intentionally designed to not fit the
clearly documented Linux needs.  If you want support for Linux data
temperature hints work with the NVMe technical working group to make
it happen.


