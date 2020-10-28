Return-Path: <SRS0=Bcfk=ED=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78421C388F7
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2020 17:17:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43C60247AF
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2020 17:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1y8VWto1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C60247AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cfprBvMyPPhw6SE5otF6+F5JpEJeSu68eDFl06cC6Zc=; b=1y8VWto1xZyY/X3xLgGAHIOC1
	n3N26bcx3yP+lnnwICKnvatWDVqDVW3Sr+qk2vQSvesA/be/umZRXZ3+RgAKhiLK+hEYlWi2vSsnl
	PGvJXs2e9wY+ipmq+uCnDhnGpgPgIx2Imp59r8olOyrwFXW7wwaDX9swGAs6LIZBJ4mn55xYRqHSt
	hUgxQoAO6rDlUP1PHOMWFajik9nWCRCVG7OTcOVzWflFHjHBurnQ1vvERo4D3ud9X12YNcy8XQOI9
	tcShfl4xqexPTCNKZGX3ymRVgROCI+qQ3kMeMtJzTMs7YV3Mo4z5uEiUSIujMJZhP6kqoJ3/7dWJ6
	rism0aUkg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kXp4p-00051G-Mh; Wed, 28 Oct 2020 17:17:35 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXp4n-00050a-Df
 for linux-nvme@lists.infradead.org; Wed, 28 Oct 2020 17:17:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0DC5D6736F; Wed, 28 Oct 2020 18:17:26 +0100 (CET)
Date: Wed, 28 Oct 2020 18:17:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jongpil Jung <jongpuls@gmail.com>
Subject: Re: [PATCH V3 1/1] nvme: Add quirk for LiteON CL1 devices running
 FW 220TQ,22001
Message-ID: <20201028171726.GA9897@lst.de>
References: <20201028091421.GA667673@image-900X5T-900X5U>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201028091421.GA667673@image-900X5T-900X5U>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201028_131733_597486_21B6EB46 
X-CRM114-Status: GOOD (  11.32  )
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

On Wed, Oct 28, 2020 at 06:14:21PM +0900, Jongpil Jung wrote:
> LiteON(SSSTC) CL1 device running FW 220TQ,22001 has bugs with simple
> suspend.
> 
> When NVMe device receive D3hot from host, NVMe firmware will do
> garbage collection. While NVMe device do Garbage collection,
> firmware has chance to going incorrect address.

I'm still lost on what this means.  The device doesn't receive 'D3hot'
from the host, it receives a shutdown request.  And we don't just do
that when hibernating, but also when doing an actual shutdown, a suspend
to disk, unbinding the driver, etc.  So if the device has a problem
with shutdowns we really are in trouble.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
