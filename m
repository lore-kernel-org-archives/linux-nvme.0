Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F105C4727C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 18:30:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40596208B8
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 18:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fmbMt4cJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40596208B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=s/ZseG+z7usktRIJyfkivtReOMJcrnWs2jWUK11jgHE=; b=fmbMt4cJW9Ab1G5nKhEuWbAgo
	Ww5fj+o6m9Cxe+XG/upR3/kDwzQPbQvm1QSBYyGWAxUM43IlXsTebPggNTCoDpySz5OT8NDSI29dS
	jkLVWjgUi02UJmPE16Nyopic+AJhGuhfYsz9HTfhpQep75dklTUEVPfjFhu1yyyz4L41IAuSvLcFl
	XquDNnl33jzW605mDhYgFSXGRI3O9ZJ7dXCPY9zQsO00KEq+315OciPnq/o+EXVdJqX5VZtWiZoEE
	uCGY/Y1sLVNk8mSiHv5ycgzyz1Erhy412245kXbfFPwYSgPxfbeI4w2YvFqeDobl9n0b5hVOEBO9T
	PVikb5WPQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNKOJ-00041L-6V; Tue, 29 Sep 2020 18:30:19 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNKOG-00040t-OW
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 18:30:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4774867373; Tue, 29 Sep 2020 20:30:15 +0200 (CEST)
Date: Tue, 29 Sep 2020 20:30:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 08/20] nvme: call nvme_identify_ns as the first thing
 in nvme_alloc_ns_block
Message-ID: <20200929183014.GC12948@lst.de>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-9-hch@lst.de>
 <19d74cf6-cc55-e7aa-ab01-e8561ef23be2@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <19d74cf6-cc55-e7aa-ab01-e8561ef23be2@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_143016_907938_48FF24F6 
X-CRM114-Status: GOOD (  11.39  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 29, 2020 at 01:39:31AM -0700, Sagi Grimberg wrote:
>
>> Check if the namespace actually exists as the very first thing and don't
>> bother with any extra work if not.  This should speed up and simplify
>> the sequential scanning for NVMe 1.0 devices.
>
> What exactly is this speeding up? Its just a few assignments+allocations

Yes, that is all.  Although some of the block layer teardown can
be a little more costly with various atomics.  Nothing really major,
but just simple work avoidance for a non-failure early exit path.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
