Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9DB7C54E64
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 04:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ECCXPJp8PjXkgIFQfRBazSaEcbJ745AxpEHi/LrDy18=; b=IvWOvTCKZ3w/PopPaVGm7m2ord
	DZ1rSVkVccvkAFCRKfs8cx8uLKbypwnB3A8zrJpBZYLTpnQG3cGKFBfdoKWPX+W3sm8mYcVaFdQRl
	DhC6betbhqUfJgbOdkjq+f6Z8tm2bqJQTVsqcseQ1Us4qDPWEUwF5lG5cixwjKBcN4uUt3lyY85xu
	DyR6bYRaKlXHl0zg0Ud4RtNm4EP2xBlMn7Dlm1xDGIP52OMIoNqtYIGNsLHAsicR4H2RLg7zt8kc+
	M0HlR4E2mZc7uuXm8KHhPrDQr+0Eb8AqwjfZ07anvQAULEHp0Aa2HgHpHd6m3ic5tq1fCSBNg+RSZ
	DtXtmaIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rphh4-0000000CQw5-0aP5;
	Thu, 28 Mar 2024 04:48:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rphgz-0000000CQu5-2yLa
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 04:48:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3D9F668B05; Thu, 28 Mar 2024 05:48:41 +0100 (CET)
Date: Thu, 28 Mar 2024 05:48:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 08/30] block: Introduce zone write plugging
Message-ID: <20240328044841.GA14113@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org> <20240328004409.594888-9-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328004409.594888-9-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_214845_954470_E137CF40 
X-CRM114-Status: GOOD (  10.52  )
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

> +	spin_lock_irqsave(&zwplug->lock, flags);
> +	while (zwplug->wp_offset < zone_capacity &&
> +	       (bio = bio_list_peek(&zwplug->bio_list))) {

Nit: I find this mix of a comparism and a combined assignment / NULL
check just a bit too dense.  I'd move one them out of the loop condition
and to use a separate break to make things a little easier to digest.

Otherwise this looks good modulo the freelist discissoon in the
next patch.

