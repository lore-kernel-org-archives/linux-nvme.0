Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDF7C43458
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2026 13:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aTqjfRJAbWaB9uX8Stp0V6izDuTGrFXuZiVZT1U6ZM0=; b=WChuaa4CgXXuEy1Hv1u0LuIUYg
	qyKk2Ka2hZi+hBZepWEYdDSxmVno0BeXcq4Bva8Azv7oSWcPgLxwH1i0+y3y1socPn8zxY2P1kn0H
	I4mUdALaOT6/k1iMnjZXny3WtYAff09AfG98B6ewe2oZuLf5J2LSLvtS+l4+dB+w0MjbgRBD7gDQd
	ZVze96RccBQoKVwMEzInoARyMEy9tuANWuPqGqKqyms3zNl5QkB0sPJmHglEkblhn4gWtK15UjOdb
	woGq9+zOUdCB6CCedqEjEkb9ghOHQLDNygM89MpFosgBMvGsJboEqqNdGd/gcmFqVkl1pHVXnpMMk
	YfKImqDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjd2f-0000000C9PZ-2hyp;
	Tue, 14 Jul 2026 13:19:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjd2X-0000000C9NC-33KX
	for linux-nvme@lists.infradead.org;
	Tue, 14 Jul 2026 13:19:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5B8E268B05; Tue, 14 Jul 2026 15:19:05 +0200 (CEST)
Date: Tue, 14 Jul 2026 15:19:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: guzebing <guzebing1612@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Guzebing <guzebing@bytedance.com>
Subject: Re: [PATCH v2] nvme: reduce firmware activation poll interval
Message-ID: <20260714131905.GB31615@lst.de>
References: <20260714092846.3381169-1-guzebing1612@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714092846.3381169-1-guzebing1612@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260714_061913_925303_B193C85C 
X-CRM114-Status: GOOD (  11.67  )
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

On Tue, Jul 14, 2026 at 05:28:46PM +0800, guzebing wrote:
>  			nvme_try_sched_reset(ctrl);
>  			return;
>  		}
> -		msleep(100);
> +		usleep_range(1000, 2000);

Add a comment that this matches nvme_wait_ready?  Or even better add
a helper with a name like nvme_busy_wait and add a comment describing
the use case?


