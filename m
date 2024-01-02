Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C5A8C46CD2
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jan 2024 17:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r6sIBSNwcMAxH8iyuOdka7jiePEzDs4/WCcSlyvbr4E=; b=JpgF+liOoyg2fxuoIDQMm1LrVR
	snWiatRFkxPFbQhx9OcROpbMF8PdTNabfsOoSOJo07JJHiPKVAbJ3sEOq6s6MqWCgiP6bnzpmXbis
	1wjcniOjRl1QjoCeb8BWXs+1efp1DB0rb3/dlsMKsFa2OF7SUVftq7qby8jGhI4L26GTq6p1OHgm7
	2CNcOz0WmBdM2P+o/c0voKHpIry0KtryJHWD0S1fFhzDtFpLwQgpeYI1aeCBzx04TuRMsQBpPMAk1
	34ZuvJWDoKMbXC6lr2hgOBMtgBBJTkVpoXxeV6gtgajSKprlcPrwkNoXvTYpj1naSVPoM4fbBCsy9
	Edb6Y7Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKiZ0-008bdA-2g;
	Tue, 02 Jan 2024 17:28:26 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKiYy-008bch-0C
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jan 2024 17:28:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id F20AECE0EF3;
	Tue,  2 Jan 2024 17:28:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA281C433C8;
	Tue,  2 Jan 2024 17:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704216499;
	bh=hBKuQbO0XOlf2bNaU7rSEMcWOttIYWyQyk64tWZxnhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JYay/E67viy0Lq7Ja8PaA1BhN7bBHON2YFw/b3GBwlDhPvkhqsuRZ8a2fNSyAtpM6
	 iLhSyB68sFBfJLH7GPVm6WlzgvAlEy20Q4lXjtrZ3hdWvES3SvkY9MXz6oh8BxW24P
	 j2UWzt2EuCjOyEqGWGAcawY9kJo/k4PdGsTcSDXg6qSQxPY9TZvh+zJjmefb19nsq7
	 F9fnJESEQKOX0KaAYPt/HYvaq1ms5tfS/Psal6RPfKwW0w39uMkm7S95SZVxfe4qL7
	 IXtOtPHNVJE1wF4+6fBde2uZ91LbtIp/EEyJbgHsNxkLlbjUqzevFUtrYh30eTbKh3
	 rhDZnWdSl24Gw==
Date: Tue, 2 Jan 2024 10:28:16 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/4] nvme: fix max_discard_sectors calculation
Message-ID: <ZZRHsFrdL2OcO_Cb@kbusch-mbp>
References: <20231226085844.203878-1-hch@lst.de>
 <20231226085844.203878-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226085844.203878-4-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_092824_367328_0589B492 
X-CRM114-Status: GOOD (  15.86  )
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

On Tue, Dec 26, 2023 at 08:58:43AM +0000, Christoph Hellwig wrote:
> ctrl->max_discard_sectors stores a value that is potentially based of
> the DMRSL field in Identify Controller, which is in units of LBAs and
> thus dependent on the Format of a namespace.

Is it just me, or is this one of the more annoying conventions in NVMe
standard: controller scoped identification fields are in units of
namespace specific formats?! Why not define these in namespace
identifications, or provide a fixed unit size? As it is now, these types
of fields would be in units of the largest LBA size of any attached
namespace, and that's kind of awkward in a multi-namespace environment.
 
> @@ -1750,7 +1751,7 @@ static void nvme_config_discard(struct nvme_ctrl *ctrl, struct gendisk *disk,
>  	if (queue->limits.max_discard_sectors)
>  		return;

Since DMRSL can change when you format a namespace to a new LBA size,
might the old limit be using the wrong max_discard_size if we skip
updating it here? Probably not a big deal.

And let's say the user explicitly disabled max_discard_sectors through
sysfs. The next driver namespace rescan will turn it back on, probably
against the user's expectations. Should this limit check use
'max_hw_discard_sectors' instead?

Anyway, the driver was like that already, and the series looks good to
me. I just noticed this weirdness while reviewing.

> -	blk_queue_max_discard_sectors(queue, ctrl->max_discard_sectors);
> +	blk_queue_max_discard_sectors(queue, max_discard_sectors);
>  	blk_queue_max_discard_segments(queue, ctrl->max_discard_segments);
>  	queue->limits.discard_granularity = queue_logical_block_size(queue);

