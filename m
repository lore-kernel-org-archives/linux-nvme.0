Return-Path: <SRS0=Bcfk=ED=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A08BC4363A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2020 07:46:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B52322245
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2020 07:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xyyjt8WI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B52322245
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FLODkHB5K7Kt9/KIes8AAjG5OiLEMxprQdXyBWRW5+I=; b=xyyjt8WIKcP6pzIhZcrOkIWlY
	1ialm1/R45jaeU0ZdYnVcQh0sTtV9cUvUWqYRtyT7fYttts8Nzcv95sED2v5P5dX+vWrhSRJc5w8m
	Gzg6i5Q3GQZX7IzIPc9p170UzmHQoA2YNSqHxXLUmT1vFdj+VEeYfNHaxz1de0U9J3Ng+GWAv/1rf
	YPobIgy4huuKm09MbD/CqdsnIYuwboIl53q2QthqDBhPr9Sc6bWUhR8CnQRuxgpwa7OXxELbBKcvm
	2gp3PlSzbixdXKB5j1l6v8dBDsfr5OIVxw3OBxviWnYFHGyycdeGVbaOMngrTUad/7Igp78CA1M+r
	sh94gOwDw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kXgAV-00050A-2G; Wed, 28 Oct 2020 07:46:51 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXgAS-0004zj-IO
 for linux-nvme@lists.infradead.org; Wed, 28 Oct 2020 07:46:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 14C0B67373; Wed, 28 Oct 2020 08:46:43 +0100 (CET)
Date: Wed, 28 Oct 2020 08:46:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jongpil Jung <jongpuls@gmail.com>
Subject: Re: [PATCH V2 1/1] nvme: Add quirk for LiteON CL1 devices running
 FW 220TQ,22001
Message-ID: <20201028074642.GA16651@lst.de>
References: <20201028074000.GA320668@image-900X5T-900X5U>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201028074000.GA320668@image-900X5T-900X5U>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201028_034648_744507_A1EE97BF 
X-CRM114-Status: UNSURE (   8.70  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, gloria.tsai@ssstc.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, jongpil19.jung@samsung.com, dj54.sohn@samsung.com,
 Keith Busch <kbusch@kernel.org>, jongheony.kim@samsung.com,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Oct 28, 2020 at 04:40:00PM +0900, Jongpil Jung wrote:
> When NVMe device receive D3hot from host, NVMe firmware will do
> garbage collection. While NVMe device do Garbage collection,
> firmware has chance to going incorrect address.

What does "going incorrect address" mean?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
