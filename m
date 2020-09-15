Return-Path: <SRS0=GAdO=CY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B60BC433E2
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 02:55:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22BFD20829
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Sep 2020 02:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rUt2i7aw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hl96Fl+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22BFD20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=u79KuuokylzUKFypavzke52BOOMHH+Pgn6yEy9m3/pk=; b=rUt2i7awqkPgmqDNHQGmGsJh1
	vhnALgJ+RKcC+VJEuxXRhLGLYMdHr+5abLv9pAHH96QZH92a2fAzIPj7z1TSA//EVQ/RYsX7rBWPZ
	SEU9BLmrx5X2VSDEWmH7NMixRWYFXNumE9oqdsE54V30Hmt63bYA6qS5szqCQUGfOYXRNdFgs9Fqe
	wSSsPzgtrLIAqoYQpcbikX6lWBQT1GOOTSzZ3oGbW489yVOn4LKrUfYqNW4qQYW/4BNobM3NerJk1
	ODYdTdfC4l9itMaABlLTFDPveJk20Uqwn/6wNOW8adXr/cdf/fC9Omn93rXpyNpOWIWQQ1Ui51xtv
	89jk1eHfQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kI17w-0002Rs-S7; Tue, 15 Sep 2020 02:55:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kI17u-0002RS-0O
 for linux-nvme@lists.infradead.org; Tue, 15 Sep 2020 02:55:26 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6823120829;
 Tue, 15 Sep 2020 02:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600138524;
 bh=c97r2TrPBHVNLUMJM/YrmEx8Ph/yWMjoh25ysrs46w0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Hl96Fl+AQpvX3Dg4mCtz5+3YbYI2BvkjmLJJodWAvGR8p1Jnfp+V31eLyJSMM/hM3
 xgExRSCw2l/tq+203MCd0eo+IV6OM/fQ2MvH8aMpIu5TmvnehT/qjAcMg8SG2T1vWF
 dvWSiJuhVdxX1gB/yEiNje8DTOcGsOQvWUObsCQM=
Date: Mon, 14 Sep 2020 19:55:22 -0700
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] nvme: translate zns errors to blk_status_t
Message-ID: <20200915025522.GA3659321@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200909203324.3356679-1-kbusch@kernel.org>
 <20200910052643.GA18283@lst.de>
 <CY4PR04MB375101AA0F80FB54BAFBC427E7270@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200911061022.GA21597@lst.de>
 <CY4PR04MB3751B5CEE2967C1B3B29554CE7240@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200912064104.GA19223@lst.de>
 <20200914194421.GC10507@redsun51.ssa.fujisawa.hgst.com>
 <CY4PR04MB3751DB156A3A2F4663F49DD6E7230@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CY4PR04MB3751DB156A3A2F4663F49DD6E7230@CY4PR04MB3751.namprd04.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200914_225526_123333_5F7DDF76 
X-CRM114-Status: GOOD (  13.19  )
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
Cc: Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 14, 2020 at 11:25:08PM +0000, Damien Le Moal wrote:
> On 2020/09/15 4:44, Keith Busch wrote:
> > Selecting an existing unused errno feels a bit arbitrary for a status
> > that is currently specific to NVMe ZNS. Could you provide a little more
> > guidance on what you're looking for?
> 
> Not just NVMe ZNS. SCSI/ZBC and ATA/ZAC too (both sd driver) :)

Gotcha, I did not realize those may have open zone limits too.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
