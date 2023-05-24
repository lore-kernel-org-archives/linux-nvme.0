Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8EFC77B73
	for <linux-nvme@archiver.kernel.org>; Wed, 24 May 2023 20:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ktRmAJRMi6aY1cylt8GoXviGdP9H2W9zn/1Qm+vIFBA=; b=OwNQdOx+2iShlo/zcORI1sJJ+P
	MZ+BWZ+BCzsvQBiE4WyNsuSiSm5JAofyX1OOxS0OnNLuPQpUEjV0c8hSLZdITl3GAwMidSZOKJuWH
	6Fs4LieXLKStisvms8/Q5yGJdZM2LSY3ctIv2fU6D9EkqzHDuLpVgyBD6eq/dXzJuRrgd/f3cFthv
	sr6TFSwsQws5wKO8JKIzEWfeGL3CJDm+KeECsYlxbQfq0E2+OMefkuqT6x54Nev7MmSvvlLWC6FqR
	MS68sPN1J9q0uA9ZXJFIWazSKDCj7uHjTiDyDxBZOOXpFFk/hwYd4fbwiU6t9dORbkhoQ0bqinBZv
	8TIPBIeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1vGP-00EdJ8-2t;
	Wed, 24 May 2023 20:39:17 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1vGM-00EdI2-2t
	for linux-nvme@lists.infradead.org;
	Wed, 24 May 2023 20:39:16 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BE32A63751;
	Wed, 24 May 2023 20:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F727C433D2;
	Wed, 24 May 2023 20:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684960753;
	bh=BF2C3W/W0nXLXRE4B4KtpigbaHitJUTqH59YcU8jbpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cLL/MvVx7hJA9QQCvnsKhZTsHuLPuBnU5+njVHXODriC52G+9ABwBaavXcuxUekef
	 +qjrnMDyZON4I/mdi0aEinxhey82g7ZFy9aX2PrWkaq1atiUUJ0NeO1Hncg9SADo3k
	 i1+5BCBsQVUd3wv/OjDrmt7Az4jA6pL5czX9DyDf3VMuxfcEhcxgQvPVZYedwSshmP
	 5+9IbU3IWPL4pd5wsno/rw5C7IqGOA9TF1XIdhaO5HTtb9Lq2Q5oGVJSgi282oXBsG
	 WkCtgdJaRiVxSvgU1Kj27sDpcZ6pgivKrZdb24k+RKLKlvc1JnXZgiA/heM4r4wfWn
	 52vrB7ADyUUrw==
Date: Wed, 24 May 2023 14:39:10 -0600
From: Keith Busch <kbusch@kernel.org>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Costa Sapuntzakis <costa@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 2/3] nvme: check IO start time when deciding to defer
 KA
Message-ID: <ZG517psk+ZQU1h+s@kbusch-mbp.dhcp.thefacebook.com>
References: <20230524193809.1360269-1-ushankar@purestorage.com>
 <20230524193809.1360269-3-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524193809.1360269-3-ushankar@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230524_133914_997194_CA5BA351 
X-CRM114-Status: GOOD (  12.28  )
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

On Wed, May 24, 2023 at 01:38:08PM -0600, Uday Shankar wrote:
> +	/*
> +	 * Completions of long-running commands should not be able to
> +	 * defer sending of periodic keep alives, since the controller
> +	 * may have completed processing such commands a long time ago
> +	 * (arbitrarily close to command submission time).
> +	 */
> +	if (ctrl->kas && nvme_req(req)->start_time >= ctrl->ka_last_check_time)
>  		ctrl->comp_seen = true;

Instead of saving start_time, 'req->deadline - req->timeout' should get
the same result. And you won't have to set nvme's start_time twice for
the mpath case.

