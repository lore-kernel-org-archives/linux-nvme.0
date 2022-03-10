Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C39AC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 08:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wtH8mchd1b2CZSaRfgIGgFaMQtcQJtuDYhTDQ3yfJgU=; b=PsYSJdnUaMQ3TQyNbMcYOGx6US
	dgUU6abiOIcbPPj5lcOohP74i2GIXwcsQ015Tm7sBtU8RPtO7b7+N2ZsspAQZs8lS0lNfLQXiqzyB
	52PJu0IUt9AC6kegpC5+lA+uxeIPkqjXuaEErvoAPDQUAqXslHHNcHmlF2PQDaKlrxZdTxZohhiwm
	IKlwYc8+e/z0f6kjZ5RGU9uaQvODSiU+cRQDSww0qL91uS6YvNqbd/gS1f2mluu46/izhjMCd2kKB
	qkHmnYWBIhd2ltpLiQxzEK/dwPF4UdyTbnMizGlYoMfEta2zbu0hnwXFZBA/3Pesc5QoQp2ntLQns
	z/toLG0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSEIa-00Bwil-Bx; Thu, 10 Mar 2022 08:37:28 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSEI4-00BwVm-UN
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 08:36:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D4F5768AFE; Thu, 10 Mar 2022 09:36:52 +0100 (CET)
Date: Thu, 10 Mar 2022 09:36:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, sbates@raithlin.com,
 logang@deltatee.com, pankydev8@gmail.com, javier@javigon.com,
 mcgrof@kernel.org, a.manzanares@samsung.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com
Subject: Re: [PATCH 17/17] nvme: enable non-inline passthru commands
Message-ID: <20220310083652.GF26614@lst.de>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152729epcas5p17e82d59c68076eb46b5ef658619d65e3@epcas5p1.samsung.com>
 <20220308152105.309618-18-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308152105.309618-18-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_003657_164225_FB5E5600 
X-CRM114-Status: GOOD (  11.58  )
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

On Tue, Mar 08, 2022 at 08:51:05PM +0530, Kanchan Joshi wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> On submission,just fetch the commmand from userspace pointer and reuse
> everything else. On completion, update the result field inside the
> passthru command.

What is that supposed to mean?  What is the reason to do it.  Remember
to always document the why in commit logs.

>  
> +static inline bool is_inline_rw(struct io_uring_cmd *ioucmd, struct nvme_command *cmd)

Overly long line.

