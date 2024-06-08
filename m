Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0A1C25B76
	for <linux-nvme@archiver.kernel.org>; Sat,  8 Jun 2024 05:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=REiL2L2wljhLsNLIIkadqSd+mtXSC59zQIbypX/tQug=; b=lhcNhE1d4Jr1uIGn57mSh8a+PF
	5An/XKJQ6FCLGj7Sz4kIK//GYNLtfLT5OT2ONVcSwU5RAyNy+o5z0ntj7eBtTUzjRuyCY5Gt2b9DF
	dqYWKNtaMTfT3046TT4dfhe+uraJ+p2u54JkgokEoPByS9VaATAMwEBUAEaHb7eg9/TZ/IRwciVpk
	eTaQ3ApE7iEAFCxyA6icqcvVN6HYdmDLqeviIwh/Ca/7Lw0abhoYll6+opFl0BsBeVoXAufmuIjdT
	l4JedzphdHfUUqskX8UN0wzZEKoBls5Dou8rY25EbitiFQdEiaecandysW9xu5VfsiUDxlb+VkqrC
	Hd9wCi2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFoSd-0000000GbNY-3mq7;
	Sat, 08 Jun 2024 05:17:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFoSY-0000000GbN6-0Amp
	for linux-nvme@lists.infradead.org;
	Sat, 08 Jun 2024 05:17:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9DDEC68AFE; Sat,  8 Jun 2024 07:17:41 +0200 (CEST)
Date: Sat, 8 Jun 2024 07:17:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	javier.gonz@samsung.com, bvanassche@acm.org, gost.dev@samsung.com,
	Hui Qi <hui81.qi@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v2] nvme: enable FDP support
Message-ID: <20240608051740.GA24010@lst.de>
References: <CGME20240528151007epcas5p32583675f647553923e5ba4987e9bc6ed@epcas5p3.samsung.com> <20240528150233.55562-1-joshi.k@samsung.com> <ZmMj3d1Rvv-5E6Ey@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmMj3d1Rvv-5E6Ey@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240607_221746_249683_01842357 
X-CRM114-Status: UNSURE (   9.81  )
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

Nacked-by: Christoph Hellwig <hch@lst.de>

This is a really overcomplicated way that does not in any way fit the
FDP use case (which is also rather overcomplicated).

If you want to pass on life time information to a NVMe device please
work with the NVMe technical working group to add the equivalent of
the life time hints added to SCSI as part of the
constrained streams in SBC.  It would be implementable in the Linux
nvme driver in a few lines of code, similaly trivially in the device
and actually makes things work.


