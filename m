Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240CFC55162
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 11:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CTvqpYjtWg+vT4mCaE7M1KQ1/JYnnec1wYW9BFRSCI0=; b=ywXOQNaeU4rt5VVNginFnykMBL
	xnpIzZLuQlcL8t434KdHscKthfzBsmJ6gd3dBroxHz5vPCX0ibBPHvi/nYIkDSbdYPxhO0shVPg8e
	d7BOXpRADbeB7QffKKElnLK9MonJaRJwHrI+8g5+NLRmQoRG/rfEdYl0QeOJHRKi60PTCBfhqG8XO
	8t4/LPIEZgSgItjcA24I162K7t87KycoqfLQ2hDXzM5J7DT+dLX93sLoZccVviNARgSTKbJQw5Clr
	LnIHmaYfBt1WYLyWhS0OHlCQSn9Au48R0/BcoYKqgkGzRbuSura9wtCPsUVaNF/kiU3LALpzXGWhE
	BnBvq2ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpP7Z-0000000ANBA-45cb;
	Thu, 30 Jul 2026 11:40:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpP7X-0000000ANAW-0Spu
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 11:40:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 47AF968BFE; Thu, 30 Jul 2026 13:40:10 +0200 (CEST)
Date: Thu, 30 Jul 2026 13:40:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	linux-nvme@lists.infradead.org, John Garry <john.garry@linux.dev>
Subject: Re: [PATCH RFC] nvme-multipath: don't retry adding head disk
Message-ID: <20260730114009.GA25956@lst.de>
References: <20260729182235.366634-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729182235.366634-1-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_044015_301724_60E5E792 
X-CRM114-Status: GOOD (  20.86  )
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

On Wed, Jul 29, 2026 at 06:22:35PM +0000, John Garry wrote:
> From: John Garry <john.garry@linux.dev>
> 
> If an attempt to add the head disk in nvme_mpath_set_live() ->
> device_add_disk() fails, then flag NVME_NSHEAD_DISK_LIVE is cleared and
> we bail out.
> 
> However, we may later call nvme_mpath_set_live() -> device_add_disk() again
> for another NS or from ANA updates for the same NS. This is broken, as we
> should not retry adding the disk - it breaks the driver model.
> 
> Add a flag NVME_NSHEAD_DISK_BROKEN to stop this happening.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
> I'm not happy with this solution, as we have a DOA disk and it would be
> better to remove the NSes in this case. OTOH, this device_add_disk()
> failure is very unlikely to happen, so we should not add a complex
> solution to handle it.

Yeah.  Broken is a bit weird of a name for something that would
either be a logic bug or a really messed up kernel, though.

I guess you arrive there by error injection?


