Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912F9C6FD1C
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Mar 2023 09:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=my+7ZoPyfJLmRZu525yQfHvah6qYH5aDlPEDfFiOVIg=; b=g7qoLZdcEuHTmdzgSQKxhiRd8K
	29xCifqxi86ObzadqyKlLXqssC3qFbL4NcGWZnao8TIEH6kKwrabqjEoUHtLQXj1PQmheu2tlQWbW
	AX7za1BJwkWzz/EOWdOZZxpC9X4zpuq3+MG+aW8xgKopMKqarFniyOy+K4kLjRVd4cAqAmU6GsbxV
	iWEF7bZ0Zzf2JgrkivaAWXJRo2MN0EHbJCwZnkmebSUk5S18n83GuOTwoKsRP5eralzhlB/LBh1QV
	QqdYmYupurJZACkAt7Y2uCa+ub2FRsIEileJDDf2Pc37uGjckIK4xQXBMw8rx7XMOfHkPnjbD+JuC
	ClzaGJrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paChs-008q0U-0f; Thu, 09 Mar 2023 09:37:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1paChp-008pzI-Gy
	for linux-nvme@lists.infradead.org; Thu, 09 Mar 2023 09:37:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 83D2968BEB; Thu,  9 Mar 2023 10:36:57 +0100 (CET)
Date: Thu, 9 Mar 2023 10:36:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	elvis.angelaccio@kde.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme: Add a module parameter for users to force
 simple suspend
Message-ID: <20230309093657.GA24373@lst.de>
References: <20230301203302.28889-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301203302.28889-1-mario.limonciello@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230309_013701_732417_FB9C81BA 
X-CRM114-Status: GOOD (  15.61  )
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

On Wed, Mar 01, 2023 at 02:33:01PM -0600, Mario Limonciello wrote:
> Elvis Angelaccio reports that his HP laptop that has two SSDs takes
> a long time to resume from suspend to idle and has low hardware sleep
> residency.  In analyzing the logs and acpidump from the BIOS it's clear
> that BIOS does set the StorageD3Enable _DSD property but it's only
> set on one of the SSDs.

Please quirk the platform in the PCIe core instead of requiring the
user to override manually in the nvme drivers that is not relevant.

And as a representative for a CPU/platform vendor that is all behind
this stupid crap please work with Microsoft and Intel to sort it out
properly the firmware level.  It's a never ending pain caused on us
that you guys caused for absolutely no reason.

