Return-Path: <SRS0=z7iv=AZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC70C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 07:19:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38217221E8
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 07:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WtetRB7B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38217221E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=em+2bFem827P4NmhS1/Mc/z7lXwyFtyFDprlpkq0oVk=; b=WtetRB7BKZ73reP9AQkNYkBMr
	zaqZrjo/ov+AQA1sIkxpq1O784aZjRur9ujGfCQbqlWRFWFSrI5+LcLEMvEa9byYMq7fqris3ScTm
	NiDKN+UmwGpWgV/emmsDJ5pAkb6A9sEetXZiNHMRwF4wps9bJueoHQ7aeGPUGc51YVNuvCGVUQOVZ
	0k4ysg14JEJz+eSMKZYn1U98yWVjR3KsFjQqcvVUey0zs0CLTpyq2+eY2r3QIG/wC+lZdP4Wvr8hs
	bQxqZmUznypO5WkUmeiMOO7MTbW642xTpp05cASnZgby21Dg+ZGoxQ4K36ZXwJgpINvIhSkiZInEa
	9ev771mrg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jvFE7-0004me-3F; Tue, 14 Jul 2020 07:19:43 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jvFDx-0004ld-AB
 for linux-nvme@lists.infradead.org; Tue, 14 Jul 2020 07:19:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 5658868CFC; Tue, 14 Jul 2020 09:19:30 +0200 (CEST)
Date: Tue, 14 Jul 2020 09:19:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Coly Li <colyli@suse.de>
Subject: Re: [PATCH 1/2] nvme-tpc: don't use sendpage for pages not taking
 reference counter
Message-ID: <20200714071929.GD776@lst.de>
References: <20200710132610.11756-1-colyli@suse.de>
 <35048818-d28d-a32c-0cb0-5bb3c147dee2@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <35048818-d28d-a32c-0cb0-5bb3c147dee2@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200714_031933_639795_47713501 
X-CRM114-Status: GOOD (  10.32  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Vlastimil Babka <vbabka@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Philipp Reisner <philipp.reisner@linbit.com>, linux-nvme@lists.infradead.org,
 Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Jan Kara <jack@suse.com>,
 stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jul 13, 2020 at 08:30:36PM +0800, Coly Li wrote:
> Hi Christoph,
> 
> Could you please take a look at this patch ? I will post a v3 patch soon
> for your review.
> 
> Thanks in advance.

I want Sagi to take a look at this first.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
