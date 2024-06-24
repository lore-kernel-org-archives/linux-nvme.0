Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02B9C2BD09
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jun 2024 22:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iA7soJkpGVIKt7XVvk8Avygo72QDsaSjKA52TLDa3y4=; b=HBIPQxt1nJfBRjVJcqPZCnvFWv
	hdLVFrUlov5uko1JkF+ZzYl/sx+01580za84hefYJLnT/kHOXf7O+10KSsYWQvSyXTZQsNtwu5oGL
	XHX8iMI4cuJQqZxuW1o+GS5V+SSDqpgDdXFWuqIw/5/6xsRcHOwbhDfGQBn/BchEhcNmmjY0Gn1jS
	pZHRNEzHlw5DSTddLN2+hPZtaCzeE/+ChRoHwnmlI3ymyoMTtHLLClhwK09k6KDQn2/wVAZv4BFSZ
	42e2ldtLTqiVtsRSm5vldkU0831JIu8ls/ch5EPyVe4ODulDwpnNP1lGbZ6sNftjdNG6beBwFA4Id
	m1acDDvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLsdp-00000000uPr-49iM;
	Mon, 24 Jun 2024 22:58:29 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLsdm-00000000uPJ-49O4
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jun 2024 22:58:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0BCB6CE170E;
	Mon, 24 Jun 2024 22:58:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53667C2BBFC;
	Mon, 24 Jun 2024 22:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719269904;
	bh=iA7soJkpGVIKt7XVvk8Avygo72QDsaSjKA52TLDa3y4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cIgX487JN8lhIWwtdU5liMps5jnB/iuFfCdxzShBm0+k16Zc6TUnzq5B+IfX9ao9h
	 bvCAPx5R4d2FID4jv+PXsrL3rU+CdxSXD0FEz55Yytha/MVXjP4qDCMIOV76mfGvUK
	 RzGVX3+vG7RP3qfmNcGzcY77s6ybP1HFlnIdfemDqWPpp9e6OAcDCjkcf7enJbDEf8
	 z/T3Hgac1qVPR5zIsLevzeNCOVA2NJzbYir9lUyWmKJLRPzp9Z+AUFtGO0zgS3MJx/
	 CQS1ogR3PouW+eiO0maCC1Dwix1Dx4KUlCAD21OPYpzKHeecDTqvnNx0TENlrK+VwA
	 cR4rL1FSGnaMw==
Date: Mon, 24 Jun 2024 16:58:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, david@fromorbit.com, hare@suse.de,
	damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
	joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
Message-ID: <Znn6C-C73Tps3WJk@kbusch-mbp.dhcp.thefacebook.com>
References: <a866d5b5-5b01-44a2-9ccb-63bf30aa8a51@acm.org>
 <665850bd.050a0220.a5e6b.5b72SMTPIN_ADDED_BROKEN@mx.google.com>
 <abe8c209-d452-4fb5-90eb-f77b5ec1a2dc@acm.org>
 <20240601055931.GB5772@lst.de>
 <d7ae00c8-c038-4bed-937e-222251bc627a@acm.org>
 <20240604044042.GA29094@lst.de>
 <4ffad358-a3e6-4a88-9a40-b7e5d05aa53c@acm.org>
 <20240605082028.GC18688@lst.de>
 <CGME20240624105121epcas5p3a5a8c73bd5ef19c02e922e5829a4dff0@epcas5p3.samsung.com>
 <66795280.630a0220.f3ccd.b80cSMTPIN_ADDED_BROKEN@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66795280.630a0220.f3ccd.b80cSMTPIN_ADDED_BROKEN@mx.google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_155827_358064_218A6A88 
X-CRM114-Status: GOOD (  13.11  )
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

On Mon, Jun 24, 2024 at 04:14:07PM +0530, Nitesh Shetty wrote:
> c. List/ctx based approach:
> A new member is added to bio, bio_copy_ctx, which will a union with
> bi_integrity. Idea is once a copy bio reaches blk_mq_submit_bio, it will
> add the bio to this list.

Is there a reason to tie this to CONFIG_BLK_DEV_INTEGRITY? Why not use
the bio_io_vec? There's no user data here, so that's unused, right?

> 1. Send the destination BIO, once this reaches blk_mq_submit_bio, this
> will add the destination BIO to the list inside bi_copy_ctx and return
> without forming any request.
> 2. Send source BIO, once this reaches blk_mq_submit_bio, this will
> retrieve the destination BIO from bi_copy_ctx and form a request with
> destination BIO and source BIO. After this request will be sent to
> driver.

Like Damien, I also don't see the point of the 2-bio requirement. Treat
it like discard, and drivers can allocate "special".

