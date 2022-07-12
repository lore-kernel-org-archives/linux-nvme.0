Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3F9C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jul 2022 06:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DPKeMO/PaGNiIxRfoDr87m7kX3XO1hLM+sCkvnIZxbA=; b=CcvSPYM2OvU0r0Lr/sgBeRXXHD
	6zn2VHtllHJNspJXca/wUWWWXS9Zc7QGR6lG/Ddwh04cPc9ClTSe1hh9vZxfQv9nHIg3ZarW9/VhT
	yY9tEgxY+M3MYY68DRL7TGOZWgT08B0I0UkvEvVX686M6bwElNKunJoXj1mNWxHFSwUiZAVR9Nu+x
	PxrYeXZCgvA4P/jwtyFkkxRWLiTwk0I8ppSeLsd0pNokqpu3/6WgDSbLNahHig3Oxp3ok4LAoCLJo
	uUkRYY0LxXtEMPtCZ4OaNPvbf+tYshW9nZRfXGYuvcGNCylLW5887sjNOKt/oKm1uy86sRZcnogxO
	cMoo4VMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oB9lR-0089Bx-P4; Tue, 12 Jul 2022 06:52:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oB9lP-00898u-2R
	for linux-nvme@lists.infradead.org; Tue, 12 Jul 2022 06:52:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 394AF68AA6; Tue, 12 Jul 2022 08:52:51 +0200 (CEST)
Date: Tue, 12 Jul 2022 08:52:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@kernel.dk,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, asml.silence@gmail.com,
	joshiiitr@gmail.com, anuj20.g@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH for-next 4/4] nvme-multipath: add multipathing for
 uring-passthrough commands
Message-ID: <20220712065250.GA6574@lst.de>
References: <20220711110155.649153-1-joshi.k@samsung.com> <CGME20220711110827epcas5p3fd81f142f55ca3048abc38a9ef0d0089@epcas5p3.samsung.com> <20220711110155.649153-5-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711110155.649153-5-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220711_235255_281716_93A67CBB 
X-CRM114-Status: UNSURE (   9.19  )
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

Hmm, I'm a little confused on what this is trying to archive.

The io_uring passthrough already does support multipathing, it picks
an available path in nvme_ns_head_chr_uring_cmd and uses that.

What this does is adding support for requeing on failure or the
lack of an available path.  Which very strongly is against our
passthrough philosophy both in SCSI and NVMe where error handling
is left entirely to the userspace program issuing the I/O.

So this does radically change behavior in a very unexpected way.
Why?

