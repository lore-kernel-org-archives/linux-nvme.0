Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C54D6C4332F
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Nov 2023 09:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W9Izk2WvE//k8jNjdK4m8HPq51LGyNfCf9eiPEGpJ7w=; b=Z4eiWjXJyOczZ5nrTeWoqO3FMK
	bKwqEghOYLOtUR7P19KRvARBIa/GtpynPu3L1S2XZT0rQ8pdvLpuVaUiojsU6EXVZb/moyynHZN1q
	W0tSW2gSFYWrqw6ORmtcG0M0rt8s3s/yXNBoKQ4FCg6VIUcIYCbJOf2xLE+mLStOrNiE+sxc3Psf6
	6wd+pv67KBpRp7ULT7TqhIfmRqjeurMvkNPd7Z9f02pyYrmu1cQIKaNUOkyCWbrOopYU8Y/iVDFv3
	d3EAcgBxZlkPLY8pLwsVZKYjyUIteLg47wMGrN/Z9DJs+Fq9rbXUSr79YmKOv6K+0nUtk6J9tDQcQ
	ZE3nI2Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qyqLP-00B2fe-0J;
	Fri, 03 Nov 2023 09:19:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qyqLN-00B2fI-03
	for linux-nvme@lists.infradead.org;
	Fri, 03 Nov 2023 09:19:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E0BBC67373; Fri,  3 Nov 2023 10:19:52 +0100 (CET)
Date: Fri, 3 Nov 2023 10:19:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 1/2] nvmet-rdma: avoid circular locking dependency on
 install_queue()
Message-ID: <20231103091952.GA18200@lst.de>
References: <20231102141903.66515-1-hare@suse.de> <20231102141903.66515-2-hare@suse.de> <20231103082305.GA17096@lst.de> <69b6f873-f8a1-482b-a739-b47da6e98cec@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69b6f873-f8a1-482b-a739-b47da6e98cec@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231103_021957_217400_81B31992 
X-CRM114-Status: GOOD (  13.01  )
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

On Fri, Nov 03, 2023 at 09:53:05AM +0100, Hannes Reinecke wrote:
> Retry? The DNR bit is not set, so the default action should be to retry.
> And the idea is that this condition is a very short-lived one anyway.
> No?

Maybe.  Best to explicitly state what is going to happen and how you
tested it in the commit log..

