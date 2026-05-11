Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60176CD37B5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 08:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uFaovpkKvLq2iCtNGQWPXe5LVT42ncsoLOz6oKFD3PM=; b=tPGrBWfhloP0i56r7KRXQjbHiY
	jcLOmh0EuNgOIJgySe1TMKtGt3sYVrksM7ejM95vKljot/jg/3ITs5mZwNA01RCGfQXay9oA1CiAn
	85T77ODhhZUVJhSH0n0GFzKysBwme3lMtd0NBbLX4RKrhJvXhTsgJ+1Og+ub81WSWvJ1xKDGYFoq4
	6Er+FBalCfv8GYFHkb+cyAQBmXUMXXn/XpfrVp/yeJd1Ql4DrdvO7mqBAN+d1d0iOUmf4BWa2t/x1
	XomFpBqcUGYPa6Whupcj5e+Ti1dunJdatja4SFfSsnS5yyIqsCskcCQYrEzhQpSG/o33fJ4OhC2hi
	8ADPzZOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMLiv-0000000CiUZ-3uaN;
	Mon, 11 May 2026 08:10:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMLit-0000000CiTY-2iDA
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 08:10:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4214768BEB; Mon, 11 May 2026 10:10:40 +0200 (CEST)
Date: Mon, 11 May 2026 10:10:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com,
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
	dwagner@suse.de, mlombard@arkamax.eu, mkhalfella@purestorage.com,
	chaitanyak@nvidia.com, hare@kernel.org, hch@lst.de
Subject: Re: [PATCH V4 6/9] nvme: use per controller timeout waits over
 depending on global default
Message-ID: <20260511081040.GF29677@lst.de>
References: <20260508133335.98612-1-mlombard@redhat.com> <20260508133335.98612-7-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508133335.98612-7-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_011043_829858_EE14978B 
X-CRM114-Status: GOOD (  10.03  )
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

On Fri, May 08, 2026 at 03:33:32PM +0200, Maurizio Lombardi wrote:
> Instead of passing NVME_IO_TIMEOUT as a parameter with every call to
> nvme_wait_freeze_timeout, use the controller's preferred timeout.

This should probably go very early in the series before even adding
configurable timeouts as it just drops a pointless paramter.

The patch itself looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


