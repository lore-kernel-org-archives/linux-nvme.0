Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07583EB64DA
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 15:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YWqrMjTIGyVNKFXuJI5phW8W0QZCQCu91E3BLMb68mQ=; b=2ZeBA5i6vj/jqdK04lhGs3IVHV
	w769gx4B1RwIqW4iEyaoJGg4YQu+iGBDEAyRvGNCzr83yvNQyZD+EiBQEQvLHJXVHOpywXoo5baD6
	PfMoHxL+ajiEDzhEkNd9Sdg8hV8QRHVwCzE5trAMlze9silySa+LcC4LFLju5Fcfq11byZsHzQaOa
	0TJfW4wPC0SykweEMpZoYWPT+KQbBv7sVUt4b1HNpdkaeW8QeguE09sgnuA9WlI6ybFR9rqsP/Nsm
	ONisPZOYXH88zKUR1Fo84f1iSSrXWTahghjTnyc6KRB9cNoRr1dKgm2a06dTcufP+yVPpBPYiEju4
	zaCx+Phw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qIsOG-00Bwv9-33;
	Mon, 10 Jul 2023 15:01:28 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qIsOE-00Bwtr-14
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 15:01:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 50EC061028;
	Mon, 10 Jul 2023 15:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB4CC433C7;
	Mon, 10 Jul 2023 15:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689001282;
	bh=fRniq925/5zOlOsSs3vy00RTNDr5SQ90nOWzhxQwy44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=goIqko9ctMkpwlHwPBBnArM5z7bEJy+aEkxJEa0sj0f28/6tmmbSnmeWOqhVGEKx4
	 blerIqBKU53ucaBr6UM852wojaFiujKGFl6XKW+ytyOh1enfu6LQ8Sr6m6kM6/M2xA
	 LW2dyijuq3MySWPH/RFFMypJQlXbgbE1+dcGdUaf/wiRQ0+vhbkWB2Ltjoli734L7o
	 7snAA5m0JRC1YVups9uhmtFgNJUULP9OqvlI3bCCUqNJJmnbTlund8pcBZvQz4U4BH
	 RuHEnnwVbdkaIEoen6H+VuZlybCSCvb7LIIBIfYtwn/mebuXRYqZZHE1daUDNVBfV5
	 e+zHMsegSXwPA==
Date: Mon, 10 Jul 2023 09:01:20 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/4] block: don't unconditionally set max_discard_sectors
 in blk_queue_max_discard_sectors
Message-ID: <ZKwdQJB3X9OGjr9Y@kbusch-mbp.dhcp.thefacebook.com>
References: <20230707094616.108430-1-hch@lst.de>
 <20230707094616.108430-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707094616.108430-2-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_080126_437496_4486FC75 
X-CRM114-Status: GOOD (  12.46  )
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

On Fri, Jul 07, 2023 at 11:46:13AM +0200, Christoph Hellwig wrote:
>  {
>  	q->limits.max_hw_discard_sectors = max_discard_sectors;
> -	q->limits.max_discard_sectors = max_discard_sectors;
> +	if (!q->limits.max_discard_sectors ||
> +	     q->limits.max_discard_sectors > max_discard_sectors)
> +		q->limits.max_discard_sectors = max_discard_sectors;

Could simplify to min_not_zero().

But this only allows you to make the limit smaller. If the user never
set max_discard_sectors before, and a firmware update allows a larger
max_hw_discard_sectors, the subsequent rescan won't use the new limit.

