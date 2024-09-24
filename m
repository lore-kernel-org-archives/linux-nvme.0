Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D96CF9C71
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2024 10:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xy+pnPfQ/fhfJR+VgmfMDTLtUy97yynqQ22gOZGMIlE=; b=19ua+mmvgxsMi3S6ylmxf2Wzv/
	IMd/ICqltS9fXpXY0t27WNeofgg/6prwpIr2pqJjMeWGabnyMbLph31jV2UQtB3DSwQDQRreK2M2l
	sNL0VAtHQrk7U7jORzsGRRZuOZzXjLBw4ZZxGiWjbHu6H6gtgSvGPkz+ioH41JZj8HtcBG7ujJuhi
	vpKAYcBtx05EHc85ucqajMKzQgEeJNpJeUAgafKyKJQno7st5LIQKgcBvnqnc4JeVnuRvOsXIkCOb
	aOy6HBkMF6kNfvNKFkDNAFFSJ/xXZeg64UlSIibwZtuvSlifwob7BTCKFeqhkehMMOWKiFi1D/oJ3
	yi3ub0UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1st32w-000000022zu-0z9x;
	Tue, 24 Sep 2024 10:45:30 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1st219-00000001qKi-3iAM
	for linux-nvme@lists.infradead.org;
	Tue, 24 Sep 2024 09:39:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 083ED227AB4; Tue, 24 Sep 2024 11:39:31 +0200 (CEST)
Date: Tue, 24 Sep 2024 11:39:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	bcrl@kvack.org, dhowells@redhat.com, bvanassche@acm.org,
	asml.silence@gmail.com, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-aio@kvack.org,
	gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com,
	Hui Qi <hui81.qi@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v6 1/3] nvme: enable FDP support
Message-ID: <20240924093930.GA27855@lst.de>
References: <20240924092457.7846-1-joshi.k@samsung.com> <CGME20240924093250epcas5p39259624b9ebabdef15081ea9bd663d41@epcas5p3.samsung.com> <20240924092457.7846-2-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240924092457.7846-2-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240924_023936_098065_2DF8CD7B 
X-CRM114-Status: UNSURE (   8.81  )
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

As far as I can tell this regresseѕ back to before when you tried
to actually make forward progress and is the same as the old version
again :(

For that:

Nacked-by: Christoph Hellwig <hch@lst.de>


