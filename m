Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48672C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Dec 2022 13:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ToUWiIXSQPRI5dpDtsV5SElyAS3W+l1iyq2mJws9KlM=; b=rG+YtV7G6OwnzLH1vK1NJZa8/Q
	aJJsoWCDOmkbF1BcNh5TuJtzvVea/HHuhzDiFEy87bWqH+zr9zVBBczvkutgwtTbXCB07b/iia6Jh
	rW+DbU9LBMpUdaj8tzhcrsYL8S1+eD1f6LssIoPNVmA4ao5y/2sMoe7gNQIj25eU/3VOi1llf4ADu
	vcngLIJUDXEFxuYzLmSl1TIMJAQWpkMhrIYlLscU6CBf6HolnCZXQsgYiotH8V2VUDMa3yabQEHKr
	QqFgG/Ee6zy5TeDnRIyDcgSypKpu05j05aYL21xtGmVhR0QAcfFGHMWDHbaj+DdJmY+BYYtiAPDw8
	tr9rW/9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5nys-009VQ2-2N; Thu, 15 Dec 2022 13:08:58 +0000
Received: from ms.lwn.net ([2600:3c01:e000:3a1::42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5nyq-009VOD-Ag
	for linux-nvme@lists.infradead.org; Thu, 15 Dec 2022 13:08:57 +0000
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C2338735;
	Thu, 15 Dec 2022 13:08:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C2338735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1671109728; bh=ToUWiIXSQPRI5dpDtsV5SElyAS3W+l1iyq2mJws9KlM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iICZvmolEZyTiuzGZ2Lq0O3x31bvfgE8MW1ww6GdThWTmIqlGkC3ceb8fvIJWvONl
	 RnBAOD95lCbJUP16U+jK/+EwcK9syCEl9MHEQOZNE5eEn3BLtyuNnaG5DCfg8uN/wL
	 Wpglw1kWHZA9Vgtm5vdU31nr21w/X7ZgXTU6kn7gyKlo1ZS0i2WJ6i5jI1DXpEhV+J
	 b52pO3yNReNIQNYjv651z44RPY54p1i2FTxCsEIbrODhNHWjpgFfEbbYvpSG0s6JZA
	 KM0ivYeevv/amnq3hR3G1KW6Eooige1y8jniO117LqmcGEVJjQqt6yJJOqWzjsShDe
	 dXL3QEzpp5xag==
From: Jonathan Corbet <corbet@lwn.net>
To: Christoph Hellwig <hch@lst.de>, axboe@meta.com, sagi@grimberg.me,
 kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] docs, nvme: add a feature and quirk policy document
In-Reply-To: <20221215125130.261098-1-hch@lst.de>
References: <20221215125130.261098-1-hch@lst.de>
Date: Thu, 15 Dec 2022 06:08:44 -0700
Message-ID: <87zgboddb7.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221215_050856_384514_167A5352 
X-CRM114-Status: GOOD (  13.68  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Christoph Hellwig <hch@lst.de> writes:

> This adds a document about what specification features are supported by
> the Linux NVMe driver, and what qualifies for a quirk if an implementation
> has problems following the specification.
>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/process/index.rst               |  1 +
>  .../process/nvme-feature-and-quirk-policy.rst | 77 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  3 files changed, 79 insertions(+)
>  create mode 100644 Documentation/process/nvme-feature-and-quirk-policy.rst

The document looks fine, but I do wonder if it wouldn't be better placed
with the other maintainer entries in Documentation/maintainer?

Thanks,

jon

