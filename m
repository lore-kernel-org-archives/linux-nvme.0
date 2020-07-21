Return-Path: <SRS0=MSYC=BA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B302FC433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2020 00:06:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 800E22080D
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2020 00:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dyWHfkvN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIbOtN6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800E22080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FOVBejjV2nr8jdDS7bd5gV21I08QJdWM4DYopJ8S5Wk=; b=dyWHfkvN3Tr6oLCPMhtljQgPY
	q4SceLkDV9e/kEY31QsCCgZSEfMJgDFOAVjh/vFHdswz1SkC/WlknfIMQIuXz0f3pTQAO609eigdR
	5MQGP9prU2w+TR8XSjQ2p3Mzs27CjYYLvoDc3RumKUnflmyX4XT3hi/E+0LOlVsascCs/lI9d7HGi
	+8z7Nv7iVbAh3sMhWZ/MqcsnDCCv0KHMR/BGDPF3CMMyTT3YVa0DKhiiO+InSbHsaMyhv6Lebfb5H
	ea3qLP3nKvEaV5whWWSFnavyzfpf3V0ec5KsUuAD7TtCtBan1vx6/GbOj6FeayfJovSyWJkWKciYr
	08rrT8hoA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jxfno-0004kb-AC; Tue, 21 Jul 2020 00:06:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jxfnl-0004k4-7x
 for linux-nvme@lists.infradead.org; Tue, 21 Jul 2020 00:06:34 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D02942080D;
 Tue, 21 Jul 2020 00:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595289992;
 bh=EW7oIpJ+y8HgxhGR+cTjQSN8iQFBZEoFBFJqo6VkJc4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GIbOtN6gdd/KjqUWCOdqHBjmZduwPt6VjjqgUeWDfmwr3OT/dztdvQRfdb9u2prua
 z1xjI/rO/mBSO/m4KtmMZMyke0KkQe+JffTcbd1BMneSvkHn6Xc7k19Zfb+1ZKw2zR
 NJxwZvh1KWAcy6KoW+6JQvIXmqG5lk/3blX6D6nQ=
Date: Mon, 20 Jul 2020 17:06:30 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v15 7/9] nvmet-passthru: Add passthru code to process
 commands
Message-ID: <20200721000630.GA682317@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200716203319.16022-1-logang@deltatee.com>
 <20200716203319.16022-8-logang@deltatee.com>
 <20200720141606.GF4627@lst.de>
 <e939dd43-9e7f-8ef0-162b-2a27f53e6e1a@grimberg.me>
 <5cc390cf-9b0b-b48b-7447-37934be51ee0@deltatee.com>
 <2dc39232-4042-1f93-3dcc-3266e70cf6f0@grimberg.me>
 <b8fc47a2-0b53-3316-775f-0e9a8eddfdc2@deltatee.com>
 <20200720231701.GA682160@dhcp-10-100-145-180.wdl.wdc.com>
 <d7596065-f33b-5533-7254-153b82e6b88b@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d7596065-f33b-5533-7254-153b82e6b88b@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200720_200633_465903_5A1BD73B 
X-CRM114-Status: GOOD (  17.29  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Max Gurtovoy <maxg@mellanox.com>, Logan Gunthorpe <logang@deltatee.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jul 20, 2020 at 04:28:26PM -0700, Sagi Grimberg wrote:
> On 7/20/20 4:17 PM, Keith Busch wrote:
> > On Mon, Jul 20, 2020 at 05:01:19PM -0600, Logan Gunthorpe wrote:
> > > On 2020-07-20 4:35 p.m., Sagi Grimberg wrote:
> > > 
> > > > passthru commands are in essence REQ_OP_DRV_IN/REQ_OP_DRV_OUT, which
> > > > means that the driver shouldn't need the ns at all. So if you have a
> > > > dedicated request queue (mapped to the I/O tagset), you don't need the
> > > > ns->queue and we can lose the ns lookup altogether.
> > 
> > We still need a request_queue to dispatch the command. I guess you could
> > make a generic one for the controller that isn't tied to a namespace,
> > but we lose the fair shared tag allocation.
> 
> What do you mean fair shared tag allocation?

See hctx_may_queue().

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
