Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC0E606A32C
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2026 02:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=UZDeiyhN;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oK9Dz8CZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=u0Zoqh32EWrGXQcGhBT7ZnCG7ZtF2oq9NGKEhRQfJyU=; b=UZDeiyhNc+lZaTYWiN+PFlZJ9X
	t7AMB4wGGxPgz4psbrQlQGKxNJntG35egqJG2izLODVMtdiU7da78MTh/2SYOo48jeFCUnNATVNpk
	GfneO7/pAAK8xXob3Ns6vkeb2S5hKvYaqBbTYiKh5YLE9oGcAOeF0jO2qf5eKU4ER6I89sgIb/2LG
	5YrHc/UC1yjnG59etNF9ZXCtxjmWe1vUs8Nb3PJjmI6ZkQVcqh5yrt9ovFB2Har7yITZXvhv9U1KR
	5d4tHFEfqIdy5JDK3eYnHMY99QWacArVaju4wf5u9hF1sdzpNNTuNHzm+gVPCb/Wu5KJiw1LWDaip
	hwaC+TwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTsDp-0000000AiLi-0qfc;
	Thu, 19 Nov 2026 02:50:01 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTsDi-0000000AiLI-3Cf7
	for linux-nvme@lists.infradead.org;
	Thu, 19 Nov 2026 02:49:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 20E52647C2;
	Thu, 19 Nov 2026 02:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8784B1F000C4;
	Thu, 19 Nov 2026 02:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795056592;
	bh=u0Zoqh32EWrGXQcGhBT7ZnCG7ZtF2oq9NGKEhRQfJyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oK9Dz8CZxUb20R2T7Vz0UiwudDGjHQ4RbUr5OXIIQU3814RRN3zUvLvi4dhNgpcjU
	 WcziBWW8s9G0SU+HCW/TJbUvgnFTRtNyADfe4+Qf2KFKm5NxrJq16CvGERu5UJ5QuS
	 g23vux14NJVvGuyMIxCx8t8HqmDmQZbY34FQMlT1BKFzXkbObIdHwfgGywjH7rv9do
	 RE96B6iS/dKtc5tNBH2euq90nORScTX0ddDGw7NQgrOsAcWzeYFA1Gcch+MALBHij7
	 oJhFBJDyUQQWBzNtHFa51yogdwF3KvRB6CG8a5Qo4XfxsmrtxMwBoX3Suwbl9GMSlR
	 ZtuSvaxs037kA==
Date: Wed, 18 Nov 2026 19:49:50 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Guixin Liu <kanie@linux.alibaba.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/2] nvme-auth: fix data race on ctrl->transaction
Message-ID: <av5jzr_dZROU4lH3@kbusch-mbp>
References: <20261116081211.1757155-1-kanie@linux.alibaba.com>
 <20261116081211.1757155-3-kanie@linux.alibaba.com>
 <6dc083eb-7286-418b-92fe-f7245f653ba0@suse.de>
 <avsjKMMlQPPit6IY@kbusch-mbp>
 <0366b9fc-50b4-4739-9564-53c8783bdb0c@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0366b9fc-50b4-4739-9564-53c8783bdb0c@suse.de>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 08:23:38AM +0100, Hannes Reinecke wrote:
> On 11/16/26 4:37 PM, Keith Busch wrote:
> 
> It's somewhat ambiguous.
> Spec says 'carrying the same transaction identifier value for the entire
> authentication transaction' (for AUTH_negotiate), and later on 'carrying
> the same transaction identifier' (for any other AUTH message).
> So actually we just have to make sure they are identical.
> (The random number is '4' ...)
> 
> But the overall idea here is to distinguish transactions, so the implication
> is that each transaction should carry different identifiers.
> And my issue here is precisely 'each transaction'. Surely within each
> queue, but I'd really would want to distinguish _across_ queues, too.
> (And possibly with a random starting value to boot).
> Just to avoid any fuzzers trying to be clever with guessing the
> authentication ID (or bugs setting the transaction ID to 0 for every
> queue ... same reason why we introduced the 'genctr' for the command
> ID).
> 
> But if you don't feel that's an issue, fine, I'll be shutting up.

I'd normally defer to you on this feature since you've more hands-on
experience here. I just think the qid:t_id pair already distinguishes
transactions on the wire; each queue is its own connection after all.

Regarding genctr, I thought that was because some intermediary switch
was replaying packets, but the commit message doesn't appear to support
that recollection. Regardless, the value is per-request, so it's on an
even more finer granularity than per-queue.

