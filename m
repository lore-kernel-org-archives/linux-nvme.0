Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13D1C56202
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 10:00:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 309292145D
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 10:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="2FQlrAlV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309292145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=L8VdLb0NBkrXPMLMV4UNnBYarsR7FrD6qRUm49QGDwI=; b=2FQlrAlVyXc1xZITRkFbi2NDO
	gUG5QUoxXPy5JGUbD/SGbe30wrj9maHkO8Qh9I6Q+bqij9xkAnXDNmEkn+HfbKO8vr3kpYv1T2NfS
	y/1Ddkh5z9H0T/EN1KQtsQD77bqbmcqpTgU11y5MG2akdvSwJ67tUTdAZGtAYfjNAZPEf8KG4tsJw
	bQkP/Rs3pGyvAmQJznmzeihXi3ugiUeqI3BuInnR9l6ihT2K0hALS9fuZRdNHlVl87wPNJy+YSB+w
	Hra2uOlXsUEq/d9RR8/dw5ZcomWJpUbxj09LgKC0MYIxASIsrLn5rbQ1NLWMDKI4v3kdHKTU6IYXt
	dkhH42RYw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kiE4G-000077-VI; Thu, 26 Nov 2020 10:00:01 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kiE4C-000064-8B
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 09:59:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9883168B02; Thu, 26 Nov 2020 10:59:48 +0100 (CET)
Date: Thu, 26 Nov 2020 10:59:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 60/78] zram: remove the claim mechanism
Message-ID: <20201126095948.GA24035@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
 <20201116145809.410558-61-hch@lst.de> <20201126011107.GA57352@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201126011107.GA57352@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201126_045956_470463_10B62D1D 
X-CRM114-Status: GOOD (  10.73  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-nvme@lists.infradead.org, Song Liu <song@kernel.org>,
 dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com,
 linux-scsi@vger.kernel.org, xen-devel@lists.xenproject.org,
 Ilya Dryomov <idryomov@gmail.com>, Jack Wang <jinpu.wang@cloud.ionos.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-raid@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 ceph-devel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 linux-fsdevel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Nov 25, 2020 at 05:11:07PM -0800, Minchan Kim wrote:
> With this patch, how deal with the race?
> 
> CPU 1                                     CPU 2
> 
> hot_remove_store
>   zram_remove
>     zram_busy
>       return -EBUSY
>                                          open /dev/zram0
>     del_gendisk
>     zram_reset and destroy

Yeah, it looks like zram does not really handle hot unplugging unlike
other drivers.  So I've dropped this one for now.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
