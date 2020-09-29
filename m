Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E90C4727C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 18:34:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3256C2074A
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 18:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="epRcAhn/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3256C2074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=agooB62fNw0m9FbCiyAORWvutC5RgC43BByCybadZyk=; b=epRcAhn/8IsfMhyhynzQWHoDg
	mw1RQpPg2B1CFD+TzXjptvfhqHmLjBT5j6MWqpOP7vQHGL7LGT4b9DPi9ZK+QoJ96nipOXcuGmiib
	LtGi4MyRgMCxlU1bjfQyc5phLTTV+G5WLW1O5CagC2ytlJoej7RV6iTBC9iggf1KvARQpFSku5Ztn
	5BefdYfQjS6maRuoas1u3K32qdgsOiZengQRfXX7hddS3ZWqpBM8vnB3s0kXGlD9C538Z76vSwJ75
	E/eHfSloxUMkVDOnAO+x68bCCdXVBaBwvGojH4oLiw8a3XPozX0MzyIN6FUezQ+dAxEz1upjUAwdi
	DaU2SbFGg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNKRw-0004u1-OF; Tue, 29 Sep 2020 18:34:04 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNKRt-0004tR-Te
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 18:34:03 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5B72B67373; Tue, 29 Sep 2020 20:34:00 +0200 (CEST)
Date: Tue, 29 Sep 2020 20:34:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 11/20] nvme: clean up the check for too large logic
 block sizes
Message-ID: <20200929183400.GF12948@lst.de>
References: <20200928123502.435373-1-hch@lst.de>
 <20200928123502.435373-12-hch@lst.de>
 <27bc18e4-d547-6995-d65c-1c45f84919a2@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <27bc18e4-d547-6995-d65c-1c45f84919a2@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_143402_496296_F7490FB2 
X-CRM114-Status: GOOD (  11.77  )
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

On Tue, Sep 29, 2020 at 01:50:28AM -0700, Sagi Grimberg wrote:
>> Use a single statement to set both the capacity and fake block size
>> instead of two.
>
> I have some vague recollection why these needed to be split, but
> can't remember why...

Well, capacity isn't used between the old and the new assignment,
so I can't see how this makes a difference.  Might have been different
in the past, though.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
