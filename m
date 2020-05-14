Return-Path: <SRS0=zrHs=64=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C656DC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 04:12:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B28B020659
	for <linux-nvme@archiver.kernel.org>; Thu, 14 May 2020 04:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gMIKOHqX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yFnSMkP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28B020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eoUljaAuY+hwoZDiI1Gnmemnk8CQ23gb+w/AnH1BtLY=; b=gMIKOHqXsLXOBw
	kR0TBSZ/2Kah00rsn8utSOaSzQPX9ri5kJBoV+gLZHSiSJQR9JkPVw1rmxgAsOcUAAEEnLogGxvlk
	5dozFM0/NzoX2ZX6iD0BGO0Vl96s8Gvd2J8yG4rzEQjsF7xjtaSOWbHgt08bl8FL7WFxkFbSgnSvb
	c7sS4psckUC7DOhLgTvA2SV5FgPUU8BHXj36MBOxRtXD7jMQJqyaC7g0iYbIqJWumlk0g64Olsr04
	BTdziUeX0Uv+6ztz2aS5mf/5rFnwtW7fSSq88A2f7XqqJT8NIdLa6uevWhDHZwy7jICl5G0uJxDej
	Kun2M1YBC/BOC7psOHqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jZ5EQ-0003EX-2g; Thu, 14 May 2020 04:12:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jZ5EO-0003EB-CT
 for linux-nvme@lists.infradead.org; Thu, 14 May 2020 04:12:25 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F31A520659;
 Thu, 14 May 2020 04:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589429544;
 bh=PUjf1aR0rPZ/Cl0phAE4zoz2LvgkASqdLLeOWwiku0U=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=yFnSMkP6ZoSc5CNoPQmvzr4VXycQyc5xIqoHkDHs31TgHEC419M9MNk5k/igYboUP
 n8rom+D+EFQSLTlhpQ4vh0IxOmakr6uhN8/ynAbuQrloO326daBs4bu8PDybFK3al/
 4prJ8boOdC6YZctP9I/eJfaS/QyXIiigtTLnJ83U=
Date: Thu, 14 May 2020 13:12:15 +0900
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] nvme: Fix io_opt limit setting
Message-ID: <20200514041215.GA1900@redsun51.ssa.fujisawa.hgst.com>
References: <20200514015452.1055278-1-damien.lemoal@wdc.com>
 <20200514034033.GB1833@redsun51.ssa.fujisawa.hgst.com>
 <BY5PR04MB6900584D1F292E65425827F4E7BC0@BY5PR04MB6900.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BY5PR04MB6900584D1F292E65425827F4E7BC0@BY5PR04MB6900.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200513_211224_440039_F91F99EF 
X-CRM114-Status: GOOD (  17.33  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, May 14, 2020 at 03:47:56AM +0000, Damien Le Moal wrote:
> On 2020/05/14 12:40, Keith Busch wrote:
> > On Thu, May 14, 2020 at 10:54:52AM +0900, Damien Le Moal wrote:
> >> Currently, a namespace io_opt queue limit is set by default to the
> >> physical sector size of the namespace and to the the write optimal
> >> size (NOWS) when the namespace reports this value. This causes problems
> >> with block limits stacking in blk_stack_limits() when a namespace block
> >> device is combined with an HDD which generally do not report any optimal
> >> transfer size (io_opt limit is 0). The code:
> >>
> >> /* Optimal I/O a multiple of the physical block size? */
> >> if (t->io_opt & (t->physical_block_size - 1)) {
> >> 	t->io_opt = 0;
> >> 	t->misaligned = 1;
> >> 	ret = -1;
> >> }
> >>
> >> results in blk_stack_limits() to return an error when the combined
> >> devices have different but compatible physical sector sizes (e.g. 512B
> >> sector SSD with 4KB sector disks).
> >>
> >> Fix this by not setting the optiomal IO size limit if the namespace does
> >> not report an optimal write size value.
> > 
> > Won't this continue to break if a controller does report NOWS that's not
> > a multiple of the physical block size of the device it's stacking with?
> 
> When io_opt stacking is handled, the physical sector size for the stacked device
> is already resolved to a common value. If the NOWS value cannot accommodate this
> resolved physical sector size, this is an incompatible stacking, so failing is
> OK in that case.

I see, though it's not strictly incompatible as io_opt is merely a hint
that could continue to work if the stacked limit was recalculated as:

	if (t->io_opt & (t->physical_block_size - 1))
	 	t->io_opt = lcm(t->io_opt, t->physical_block_size);

Regardless, your patch does make sense, but it does have a merge
conflict with nvme-5.8.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
