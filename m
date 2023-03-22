Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F43C7619A
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 08:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mWrJnqj4p/7ZROVw3PX58fqmiFYRhPVkQIFcn9g3idg=; b=gQYZBr7SXrSZn5Pnf7d+CzL6wg
	282wJyt5s4rvKCxceFjXSPIFPnpQbby2K54oZSU2Jh/nydmDkagtQt5fivm2KhQ804axl8/02AbOQ
	uCIbp+W53mfrphSIrZLbkZ2f14F1Sjmz8piLV6lCBOlb9BHt0St0QrS10Sl/k70HTI8A+5Qp9CW3I
	61rV0nND53/WseYPsWofpfTSfnSxPuHS87saPm6ucHg62Wu7GHXJ413qlhXI3aOzOGyQPR1XYv3LO
	8H82v+4H0BGH6+rwjIPt7RLpmZPwE0tVfK5HMoYXpIx3QyF1H6xyw5BrV3nvj9xsu+udFN+SLV3o/
	AIl36xUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1petyk-00FDOA-2w;
	Wed, 22 Mar 2023 08:37:54 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1petyi-00FDNK-0f
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 08:37:53 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DC6FC20B60;
	Wed, 22 Mar 2023 08:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679474267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mWrJnqj4p/7ZROVw3PX58fqmiFYRhPVkQIFcn9g3idg=;
	b=iN7ZwnGPXR8E23tjegIc6MGObr+U7X0OCc4wHBC3HwZSc7Q70weXnFpeELVKx35W3EmB4a
	kJ37AJ4+ta3hboJM4SX4s4TASM7D5Hh/tO7TrQNeuIA4O8n6N6x5mdSW8/83rnlmR+AO+P
	Xn5Lmy1K46+JCcgDVqlLMIpB8OFevh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679474267;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mWrJnqj4p/7ZROVw3PX58fqmiFYRhPVkQIFcn9g3idg=;
	b=+P+Foo7QMzEgC25X5uqPYf52DCms1lCautGD8QR3ZB31nue+gkYk1o77N3zUw9Ib6Ocru/
	plGCzaHy3LYLrPDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE04E138E9;
	Wed, 22 Mar 2023 08:37:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id lVhJMlu+GmQfRAAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 22 Mar 2023 08:37:47 +0000
Date: Wed, 22 Mar 2023 09:37:47 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk,
	linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>
Subject: Re: [PATCH 3/3] blk-mq: directly poll requests
Message-ID: <20230322083747.ljos4iqkklworudl@carbon.lan>
References: <20230322002350.4038048-1-kbusch@meta.com>
 <20230322002350.4038048-4-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322002350.4038048-4-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_013752_409243_03436E4D 
X-CRM114-Status: GOOD (  11.39  )
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

On Tue, Mar 21, 2023 at 05:23:50PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Polling needs a bio with a valid bi_bdev, but neither of those are
> guaranteed for polled driver requests. Make request based polling use
> directly use blk-mq's polling function.
> 
> When executing a request from a polled hctx, we know the request's
> cookie, and that it's from a live multi-queue that supports polling, so
> we can safely skip everything that bio_poll provides.
> 
> Link: http://lists.infradead.org/pipermail/linux-nvme/2023-March/038340.html
> Reported-by: Martin Belanger <Martin.Belanger@dell.com>
> Reported-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

I've tested the whole series and this patch alone with rdma and tcp.

Tested-by: Daniel Wagner <dwagner@suse.de>
Revieded-by: Daniel Wagner <dwagner@suse.de>

