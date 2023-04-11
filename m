Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74E0C77B6F
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 17:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F/OOPolKQSFOekrfGwCedSM/Ei3MwvG9g5yOZjlsNwk=; b=Q/NbPdz978XAIDXgVUH0I9s/Td
	SgkyaNTftp4yWg3bxrQoHDWEIAqzgF+/hK3FGuptIsB7/BiatdshFwqJRqFW+I8cGEI9ItYSU0Gf+
	8vQ2dE+mYhGUipWnytb3mzWsfRI9KoYouBOWdctByYM/T1SVujDtT1g0J3U26EnyPhcM+ai/UfN9J
	fnxxypqE60p/VKdW+Zsn1APNDxTTHNJSZOGtnX5yhAMPY5YzlwoJOfLEYaqQHKRhESPBKXZvwQv2m
	EC99jV2LDmJBupbD5PnPivRi7pgKKsuzFKEcLyBkGqdoEq6Ysa2JP4ef2CxHUbfjrPBC2hNKgRuAc
	ESpNyC1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmI4T-000k7X-0z;
	Tue, 11 Apr 2023 17:46:21 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmI4Q-000k6f-0I
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 17:46:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3341462A37;
	Tue, 11 Apr 2023 17:46:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5719CC433EF;
	Tue, 11 Apr 2023 17:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681235176;
	bh=+KwAX5jvhr8OZFxH2Ho3mZVxPLvKchdh8zwtFvTu3bI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hIA74WpO3nlSIHGYDKgAvn00Y7DrZF18Ee7jLN1maDVdy55Ra+zKLSV0tcPyYD/iS
	 3BnE923JR7q9lN+K9q1sAM+PkseTcTGGsmmQ/Jglw5We4I5yO1L2GQPCCmwrmEHip5
	 z8yYINC4Bp6PQcwc5Y7AudEpq16NQZ/RCWTn7/g+7vHd9T8Md6a/zmQSzLL0r5+FmE
	 F8OuCbkaogR+ageptS1irNh5atdKzEnhbOLBU8QLX3kdfpuA1maPCFucviw1shMqYO
	 7qN9Tk3qBaUh/nmc1ZHa++bvktaXNuksJUhbpC0ttZlQzYY5IqlYC8HZMIuzYJx/4S
	 0Fefvg41+aQxw==
Date: Tue, 11 Apr 2023 10:46:14 -0700
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCHv2 2/5] nvme: simplify passthrough bio cleanup
Message-ID: <ZDWc5iavegZADUyY@kbusch-mbp>
References: <20230407191636.2631046-1-kbusch@meta.com>
 <CGME20230407191711epcas5p3b9b27aa2477b12ec116b85ea3c7d54b7@epcas5p3.samsung.com>
 <20230407191636.2631046-3-kbusch@meta.com>
 <20230410112503.GA16047@green5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410112503.GA16047@green5>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_104618_189285_9200352A 
X-CRM114-Status: GOOD (  12.55  )
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

On Mon, Apr 10, 2023 at 04:55:03PM +0530, Kanchan Joshi wrote:
> On Fri, Apr 07, 2023 at 12:16:33PM -0700, Keith Busch wrote:
> > +static void nvme_uring_bio_end_io(struct bio *bio)
> > +{
> > +	blk_rq_unmap_user(bio);
> > +}
> > +
> > static int nvme_map_user_request(struct request *req, u64 ubuffer,
> > 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
> > 		u32 meta_seed, void **metap, struct io_uring_cmd *ioucmd,
> > @@ -204,6 +209,7 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
> > 		*metap = meta;
> > 	}
> > 
> > +	bio->bi_end_io = nvme_uring_bio_end_io;
> > 	return ret;
> > 
> > out_unmap:
> > @@ -249,8 +255,6 @@ static int nvme_submit_user_cmd(struct request_queue *q,
> > 	if (meta)
> > 		ret = nvme_finish_user_metadata(req, meta_buffer, meta,
> > 						meta_len, ret);
> > -	if (bio)
> > -		blk_rq_unmap_user(bio);
> 
> Is it safe to call blk_rq_unamp_user in irq context?

Doh! I boxed my thinking into the polling mode that completely neglected the
more common use case. Thanks, now back to the drawing board for me...

