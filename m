Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D212C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 07:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GHst/fg5KebU+K1i477z80529nQeE97zp+/z5V2mW5g=; b=1fZsnHAV/xMt2Sf0fdr3kETUzQ
	iwqplTVJlDQK119/bSEzJYWTwhdaEF5twmWcEcSK25tFLnLh1Lf6t32meBh7isy0Ce5WHuslWZBS1
	qkRcj8NPRSA+GT8SbXB7RGULoyxhrSkfIWs/DV7RdjmbpQwlaxfKqxGngW8wDFnOj5n6U/N9h0vcJ
	XE5TpHVONYsYRJn/F6n0bY4nblcRl8fSfftb+2HcwKqwlbtEu7VeTkIXuzihwBMUs4JmimN0bR48F
	jL1PEv7BYDN64T07fGM+0Xo/jK3qb0aD3O+lKCFN4IzxrSjxy+SbZHjGyWv1PH6l5JkkyHDEbWK2U
	2LlimtPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol3U2-00GAwR-1z; Wed, 19 Oct 2022 07:27:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol3Ty-00GAuU-21
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 07:27:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 32DB368C4E; Wed, 19 Oct 2022 09:27:15 +0200 (CEST)
Date: Wed, 19 Oct 2022 09:27:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, kbusch@kernel.org, axboe@kernel.dk
Subject: Re: [PATCH v2 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20221019072714.GA11606@lst.de>
References: <20221013094450.5947-1-lengchao@huawei.com> <20221013094450.5947-2-lengchao@huawei.com> <20221017133906.GA24492@lst.de> <20221017152136.GI5600@paulmck-ThinkPad-P17-Gen-1> <20221017153105.GA32509@lst.de> <20221017224115.GJ5600@paulmck-ThinkPad-P17-Gen-1> <20221018051956.GA18802@lst.de> <Y09GROYqk3FMM21W@T590> <9da048fc-71ee-cc38-a861-59acc96671fe@grimberg.me> <20221019072535.GA11402@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019072535.GA11402@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_002719_081732_D0828EF6 
X-CRM114-Status: GOOD (  14.89  )
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

On Wed, Oct 19, 2022 at 09:25:35AM +0200, Christoph Hellwig wrote:
> Yes, the only multiple request_queue per tag_set cases right now
> are nvme-tcp and mmc.  There have been patches from iSCSI, but they
> seem to be stuck.

... and looking at the only blk_mq_quiesce_queue caller in mmc,
it would benefit from a tagset-wide quiesce after a bit of refactoring
as well.

