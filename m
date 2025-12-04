Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC0AD216A6
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Dec 2025 16:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ek0IXxY4v+pIrOWrtAGFYOAULg0b2babKUpaBvYCafg=; b=McpOiqmAMlrq1Hb76xNbzQRs0k
	OwhmJLFAT2ApmUSUaCmn4PGgZXTrNAEsLxIEVZwNKeDGEh8Ncaw1a/3sAzWHmBbf5ZW8sxj6ciDP8
	DFPw66SriUiAb6fwIGaAdHVLmLQuQhFRASQDdD7pYVhjGnVj4pr+RN7sb+Z/mDXTqrJ3aDDD+pyKO
	Xuunsm8ieEelQj14ZyV17e8kjBgVhyU9zeuauw/4nCrQr+/cgtOPvEUoOoHaUidHRW1j24Z42C/Lm
	4+dfUcfVB/UInPMrm9Zz1JOd0Ql0MZm7/D2aK6Okw4ChHrR4bXcYo3gSKszpHw5Zxl9etXgG9+e9M
	yFtxw/mQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRBxc-00000008GWN-0lT1;
	Thu, 04 Dec 2025 16:13:40 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRBxb-00000008GW1-00pd
	for linux-nvme@lists.infradead.org;
	Thu, 04 Dec 2025 16:13:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 707D4601FD;
	Thu,  4 Dec 2025 16:13:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F52C116B1;
	Thu,  4 Dec 2025 16:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764864818;
	bh=dPa40n5AKnKlrNlskv/FUjA9yCvquwkpnHnyVW3i2pQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=APSJURr2VsYUmQRuuI7QLaGcGJGCE4vCbvyU3CQ244nrd3+qrF7qbKoAUZtFtMZHl
	 GfLjSlT8zM8wC5tUOB4bxo1kHvJkvcLrCDbxaYYme9h8hLgSqnxcNncy5N7f5VkmHW
	 KzU/6/Jr30FRLlpAstZFrujNt6Z6yCSUAyrY8qlZO5JBExfQJoqypwqkK1Zvr8VoCa
	 vXz0agwnynKggj2VOkqvK1veO1D3VbfT1Le3pkW9e8nAcdk6niLSK2cYhW9BSSPZip
	 afinCwdcFiE1TgYEGVV5gNGd5otFARDslNklh+K+06oVx/Pr7BicswcigIso43dME7
	 9VqAdNtwqwj/w==
Date: Thu, 4 Dec 2025 09:13:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Heyne, Maximilian" <mheyne@amazon.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvme: Let the blocklayer set timeouts for requests
Message-ID: <aTGzL5t7Gu1tpebp@kbusch-mbp>
References: <20251204-tests-bryce-8b3b2823@mheyne-amazon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204-tests-bryce-8b3b2823@mheyne-amazon>
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

On Thu, Dec 04, 2025 at 02:11:50PM +0000, Heyne, Maximilian wrote:
> @@ -724,10 +724,8 @@ void nvme_init_request(struct request *req, struct nvme_command *cmd)
>  		struct nvme_ns *ns = req->q->disk->private_data;
>  
>  		logging_enabled = ns->head->passthru_err_log_enabled;
> -		req->timeout = NVME_IO_TIMEOUT;
>  	} else { /* no queuedata implies admin queue */
>  		logging_enabled = nr->ctrl->passthru_err_log_enabled;
> -		req->timeout = NVME_ADMIN_TIMEOUT;
>  	}

I was trying to think of any in-kernel path using __submit_sync_cmd with
an IO queue, and quick search shows there's just one: zns report zones.

Everything else uses the admin queue, which doesn't have a sysfs tunable
for its request_queue's default timeout. All we have is the nvme module
parameter, which is writable after loading. Since that's the only way a
user can modify the default time for that queue, I think we need to
leave that req->timeout value as-is.

