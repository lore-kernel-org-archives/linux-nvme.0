Return-Path: <SRS0=3Lap=G6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87157C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 09:22:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E640F2075B
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jan 2021 09:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E640F2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eR8my8aEw2ymza2RFf2j9KRPWgenuV8Mp2Utjsi7QMM=; b=Fl1zOm1h55CfTtQlaOp2qhlbU
	f/tLmUjjfUIcNX6C7zNEtLg4yuWdKJV026Wr1EQbu/isajh2DPqwSpa34Wi1Ki1RW37sDSd6mZpuH
	5rq42K5USRHs+heaP8o0sqMHYpl/r2izZIeyBqUll5WoMs7GvKZ3JCefmsskxoVoOgLK5vGNoo/Lp
	cFhznePV25y5/iqWXqqz6BQ3lMJYy/jNXz42GtyhPL/QHgeCq2IPem60D5hiCn/Oy5GOSbHjfoP+J
	rD0qZpoqIr7tY+97Cvb5q/S534WICawWlNbsF8veCJeWrweQXZxPqn0sCFSE+ukOGElM0PrIGXuET
	5p7Ehy1IA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4h1x-0000Dv-Lu; Wed, 27 Jan 2021 09:22:29 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4h1v-0000DA-9h
 for linux-nvme@lists.infradead.org; Wed, 27 Jan 2021 09:22:28 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 0316EB9C0;
 Wed, 27 Jan 2021 09:22:26 +0000 (UTC)
Date: Wed, 27 Jan 2021 10:22:25 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] nvme: return -ETIMEDOUT in nvme_submit_sync_cmd()
Message-ID: <20210127092225.5b5n3bhp4edmhzic@beryllium.lan>
References: <20210127080605.146627-1-hare@suse.de>
 <20210127080605.146627-3-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210127080605.146627-3-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_042227_453040_2A2596BD 
X-CRM114-Status: GOOD (  15.31  )
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
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jan 27, 2021 at 09:06:05AM +0100, Hannes Reinecke wrote:
> When a command times out we should be returning -ETIMEDOUT in
> nvme_submit_sync_cmd(), and not requiring the caller to guess whether
> a specific NVMe status should be interpreted as a timeout.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  drivers/nvme/host/core.c | 2 ++
>  drivers/nvme/host/nvme.h | 1 +
>  drivers/nvme/host/rdma.c | 1 +
>  drivers/nvme/host/tcp.c  | 1 +

I wonder if we have to do something similar for FC. As far I understand
an abort command is issued and the drivers will return the original
request with FCPOP_STATE_ABORTED which then will be mapped to
NVME_SC_HOST_PATH_ERROR.

Can't say if this is good or bad, it's a just different.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
