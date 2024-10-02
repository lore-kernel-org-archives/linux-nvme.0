Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2260ACF31A0
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Oct 2024 07:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tcw0enn6delaF8+NKTMiYPOsteyOb+Vh+AzQKS2MBX8=; b=gHw4/htzYituvWnRbtB4wjk1mo
	xEF81UMujxis+2V15bbGv2gyIlCnPO9P0CRyPXBRJg7NDM93Cx9f7n5293XcXWBY/xnel0jxqXb0H
	0lsOZA7CfqgaE9lq4g2N5U40pnKKBs85yigaBr01ztQ4REpiSjWF5mp6J9VNwPPGHggNaQVaEGiM3
	wodvFrSgYAWXreKIeNP6pIbocwlyiAaA7f+eErZWNYhjxVs9vd0m7tBh++Swa5amMeqnYc76MKjze
	MC+K9flRc8K7K/OR9d/8PU2le8ex7/LXu9SqIbxyYuQDFcdY1bKtQnWXiq/sNN1Up3wSqOiCcnuHa
	JMZNFEdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1svu9c-000000054uS-1184;
	Wed, 02 Oct 2024 07:52:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svu75-000000054N3-2XTN
	for linux-nvme@lists.infradead.org;
	Wed, 02 Oct 2024 07:49:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A8387227A8E; Wed,  2 Oct 2024 09:49:26 +0200 (CEST)
Date: Wed, 2 Oct 2024 09:49:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	axboe@kernel.dk, hare@suse.de, sagi@grimberg.me,
	martin.petersen@oracle.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	bcrl@kvack.org, dhowells@redhat.com, bvanassche@acm.org,
	asml.silence@gmail.com, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-aio@kvack.org,
	gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <20241002074926.GA20819@lst.de>
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com> <20240930181305.17286-1-joshi.k@samsung.com> <20241001092047.GA23730@lst.de> <ZvwiD0v3ASF8Hap2@kbusch-mbp.mynextlight.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvwiD0v3ASF8Hap2@kbusch-mbp.mynextlight.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241002_004935_805329_A39371B2 
X-CRM114-Status: GOOD (  12.06  )
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

On Tue, Oct 01, 2024 at 10:23:43AM -0600, Keith Busch wrote:
> I think because he's getting conflicting feedback. The arguments against
> it being that it's not a good match, however it's the same match created
> for streams, and no one complained then, and it's an existing user ABI.

People complained, and the streams code got removed pretty quickly
because it did not work as expected.  I don't think that counts as
a big success.


