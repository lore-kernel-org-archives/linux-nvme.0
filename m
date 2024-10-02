Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579B3CF319D
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Oct 2024 07:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iI6ldaQnJU8m1nt+oJ4QuBqJDAcakWV6wRBOVi1C3Jc=; b=TTucY+LiJATVCYwTWB7uvX133c
	bp2Z+CJqW5zyaK5eN3Qbcb2kNCINL1PcmLyiz7N9/UelVvHbG3/EYmHcwZwI1nz2oLQxB08kCVHyE
	CP4E04jdbAZppwHFafvWb4yNdA8zlrE35sh8CeO9OlyqLlOWHFHjna4+Xitla8+VviXHQAmvNAlDJ
	MzVDFVGQuF/c0iTSzKHLZDi7nKOVETo9SYyE01ozHJCB4KoyCuHRH3CJUfuCRV0m/9NXK/S89TpT/
	UUBzwPAlaumc7MIdpUZ83PrnqegR6n7uDPAixjzyQdGpeR/rSqlYTOIHkSZEaKJ7H1yztQKDZnY+m
	S0RHlr5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1svuC7-000000055N9-1YJ2;
	Wed, 02 Oct 2024 07:54:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1svu9D-000000054pa-43tV
	for linux-nvme@lists.infradead.org;
	Wed, 02 Oct 2024 07:51:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0633D227A8E; Wed,  2 Oct 2024 09:51:41 +0200 (CEST)
Date: Wed, 2 Oct 2024 09:51:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>,
	kbusch@kernel.org, hare@suse.de, sagi@grimberg.me,
	martin.petersen@oracle.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	bcrl@kvack.org, dhowells@redhat.com, bvanassche@acm.org,
	asml.silence@gmail.com, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-aio@kvack.org,
	gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <20241002075140.GB20819@lst.de>
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com> <20240930181305.17286-1-joshi.k@samsung.com> <20241001092047.GA23730@lst.de> <99c95f26-d6fb-4354-822d-eac94fdba765@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99c95f26-d6fb-4354-822d-eac94fdba765@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241002_005148_170378_049BDB35 
X-CRM114-Status: GOOD (  12.75  )
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

On Tue, Oct 01, 2024 at 10:18:41AM -0600, Jens Axboe wrote:
> Have to say, that neither have your responses been. Can't really fault
> people for just giving up at some point, when no productive end seems to
> be in sight.

I heavily disagree and take offence on that.

The previous stream separation approach made total sense, but just
needed a fair amount of work.  But it closely matches how things work
at the hardware and file system level, so it was the right approach.

Suddenly dropping that and ignoring all comments really feels like
someone urgently needs to pull a marketing stunt here.


