Return-Path: <SRS0=hg6U=YO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA98DCA9EAF
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2019 13:55:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B0812089C
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2019 13:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NCZ4TBwR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vw9Q+Y9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B0812089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=p9ir03NMccF3n9nfHEsxopc5e5jgQFJiiXrxRWgIa44=; b=NCZ4TBwRav9f/g
	0E5BixSmedNy4RqjQMoWq5V7O+kfk+x0yajXzUhe+21/vIZraEN+wKIUP1C/2UnRZGAqc2cMbQRgD
	Y7rEPWKUnlwkLxW7kT1Pg2wSwOz7cl7B3JuzuRHi5R4s30Cm65J6ttUGVf1T8K3QhF49vsNxYW/Rf
	RxoWGgTCt6HlT5beGJWW/qxnriWGOwYn7rtc7zsqV3sGBWYIHXwWmwL6XV9D46cAjp2AsXQDkksHc
	AwA6j+x00fWxiIgVTJrHW1VlCNRA5tRv6JBbfbj2FMUAQdbecMKWx7zI63vxM13VN/M934lNPgvHg
	xyDEQC/iax3BMLcifgRw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iMY9w-0008NQ-Ba; Mon, 21 Oct 2019 13:55:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iMY9t-0008Mi-Ir
 for linux-nvme@lists.infradead.org; Mon, 21 Oct 2019 13:55:42 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 886132089C;
 Mon, 21 Oct 2019 13:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1571666140;
 bh=9xG00Cs4w+lEsaZ67H86HMtwcgJo+NjnOqwm8alRtnA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=vw9Q+Y9sI89YJagP3TtStQt+niz5HRkUke6B8aDzhDrYSyK0Fm0c5xxTm0nUE5GYY
 hFPrt6jBEZOxFramLOjNamYkrz2W9F+QB2yJk4P9/d8kds0PzNKdj+CEYrOXDKsLqM
 t/ze353WIiJPDmf5rXEGPlg8RDGYpAKXgShyUK+4=
Date: Mon, 21 Oct 2019 22:55:35 +0900
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <damien.lemoal@wdc.com>
Subject: Re: [PATCH 0/2 v2] Small cleanups
Message-ID: <20191021135535.GA12633@redsun51.ssa.fujisawa.hgst.com>
References: <20191021034004.11063-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191021034004.11063-1-damien.lemoal@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191021_065541_636991_C4694D5C 
X-CRM114-Status: UNSURE (   9.92  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Oct 21, 2019 at 12:40:02PM +0900, Damien Le Moal wrote:
> This is series is a couple of cleanup patches. The first one cleans up
> the helper function nvme_block_nr() using SECTOR_SHIFT instead of the
> hard coded value 9 and clarifies the helper role by renaming it to
> nvme_sect_to_lba(). The second patch introduces the nvme_lba_to_sect()
> helper to convert a device logical block number into a 512B sector
> value.

Thank you, patches applied to nvme-5.5 with the reviews.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
