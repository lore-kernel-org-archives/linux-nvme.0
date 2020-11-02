Return-Path: <SRS0=Iz8v=EI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66ADC2D0A3
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2020 18:13:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E7C322226
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2020 18:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oSv7W/QL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7C322226
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ODQ0jknV4EEl/mWzr/VJ7k9ZTeA/6hgYevPht2J933g=; b=oSv7W/QLBQHUD4TO1HFBLpnoG
	S06kEqYQLgA3oQhhBSzsEAiMhZ7zmMa3W8mBsY69C86K5p7LWWNAbI50Xj52bDZZXQLEbTRXrNvqX
	rwCc9y1hYMRADSsbp6nDbk0yKPIbYc15zG9ztlF+J4fDxYr0oDjLaDzzVBJyJmwCQFPsMzsV8P0CE
	3ZINc607J1nwQOMyL65yyvU7uhu4QZyofKv2idKlsod2wpQfvkZENvlmrWCA4HVNqbco1b1qCfXTY
	6qliXB5HL07ffbyR/xWigNFopKsRXw28M+LKnS7F6N1+KTKoCEhCvRBa8WG2f/qN/NajZNCTDvN7G
	sHvcoXkQA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kZeKi-0007zj-Sz; Mon, 02 Nov 2020 18:13:32 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kZeKg-0007yz-Bc
 for linux-nvme@lists.infradead.org; Mon, 02 Nov 2020 18:13:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 51EEC68B05; Mon,  2 Nov 2020 19:13:27 +0100 (CET)
Date: Mon, 2 Nov 2020 19:13:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jongpil Jung <jongpuls@gmail.com>
Subject: Re: [PATCH V3 1/1] nvme: Add quirk for LiteON CL1 devices running
 FW 220TQ,22001
Message-ID: <20201102181327.GD20182@lst.de>
References: <20201028091421.GA667673@image-900X5T-900X5U>
 <20201029145529.GA19011@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201029145529.GA19011@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201102_131330_575896_55CC0013 
X-CRM114-Status: GOOD (  15.83  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, gloria.tsai@ssstc.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, jongpil19.jung@samsung.com, dj54.sohn@samsung.com,
 Keith Busch <kbusch@kernel.org>, jongheony.kim@samsung.com,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 29, 2020 at 03:55:29PM +0100, Christoph Hellwig wrote:
> I'm still worried about this.
> 
> If power state based suspend does always work despite a HMB and is
> preferred for the specific Google board we should have purely a DMI
> based quirk for the board independent of the NVMe controller used with
> it.
> 
> But if these LiteON devices can't properly handle nvme_dev_disable
> calls we have much deeper problems, because it can be called in all
> kinds of places, including suspending when not on this specific board.
> 
> That being said, I still really do not understand this sentence and thus
> the problem at all:
> 
> > When NVMe device receive D3hot from host, NVMe firmware will do
> > garbage collection. While NVMe device do Garbage collection,
> > firmware has chance to going incorrect address.

Any progress in describing the problem a little better?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
