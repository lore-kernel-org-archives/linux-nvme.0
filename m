Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3B2EB64DC
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jul 2023 12:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A6CSdnWoHNwfH4kj12EMC7KfnLYNWpmURNF30/yrN+g=; b=p+79+i6FL44Hnvgwk051HzB2JJ
	xoDBKWUb2bnRStLOv6SRQ5wJ/myKn2JE6WCN+1HV5txMEh/+3bGSriBfnWnSkA4X/SiTMYls7KfYL
	EbW5VAy7e2QoxqdFdP7M4FSxJymM43+Dp2uXdtw3rcYuovTMkA2O1M4E31uBB/UUZ1L0m0wBjXlaH
	JZW3PANzbhxHDr44mmvQ1MUcqPgaA3NcdWSoHJC3Rsz2Zca2b4nzsmIRubj80rQcB5sf3FQeoY4t6
	Turd40GZ8C93cyiz6S0oYlDZiCZg9jz1aUNWGPt/+spNXUeqau9oEA9cTJ9DiP6548ohAMWCQGQtP
	KEhN69UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qHNlZ-001Yy4-0x;
	Thu, 06 Jul 2023 12:07:21 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qHNlU-001Yx3-0m
	for linux-nvme@lists.infradead.org;
	Thu, 06 Jul 2023 12:07:17 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1C7D221DEA;
	Thu,  6 Jul 2023 12:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688645229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A6CSdnWoHNwfH4kj12EMC7KfnLYNWpmURNF30/yrN+g=;
	b=hy57rb9Aa0kmR9Oh5ZsHhxr/R1DCQFjEsTU4FrlPUH+krueOoG6ESYIt1VjXW/oxUB7hEk
	Vsp5Qm6yg7kC1ZLcyAh9XIPY3Iy6JRUjYH7O6BDsv+sIsynud6qu+EP9BnV0uFiUrzDR+M
	Z2XhHOUJeN+zbYTxxANeAZjFOnkf6MU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688645229;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A6CSdnWoHNwfH4kj12EMC7KfnLYNWpmURNF30/yrN+g=;
	b=yJ7gydxHy8JaOUPrLu4a7gjy+YgzsJuhq4bX1+ZxeOXKg+2BcWqmlvUaJCmXwJkpL2mZgF
	yMpJ5OqQjNWdvHCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D90E1390F;
	Thu,  6 Jul 2023 12:07:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id YNuiAm2upmRyLAAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 06 Jul 2023 12:07:09 +0000
Date: Thu, 6 Jul 2023 14:07:08 +0200
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <jsmart2021@gmail.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, 
	Ewan Milne <emilne@redhat.com>
Subject: Re: [PATCH v2 4/5] nvme-fc: Make initial connect attempt synchronous
Message-ID: <7kcc75btp5bo5oqjnpqlwwo37l2f4atwfemknbmvqagrqicl2i@njn4tai7e4m7>
References: <20230620133711.22840-1-dwagner@suse.de>
 <20230620133711.22840-5-dwagner@suse.de>
 <594f73f2-59b0-bbcb-d7a0-6d89e2446830@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <594f73f2-59b0-bbcb-d7a0-6d89e2446830@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230706_050716_445238_CED05778 
X-CRM114-Status: GOOD (  21.23  )
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

Hi James,

On Sat, Jul 01, 2023 at 05:11:11AM -0700, James Smart wrote:
> As much as you want to make this change to make transports "similar", I am
> dead set against it unless you are completing a long qualification of the
> change on real FC hardware and FC-NVME devices. There is probably 1.5 yrs of
> testing of different race conditions that drove this change. You cannot
> declare success from a simplistic toy tool such as fcloop for validation.
> 
> The original issues exist, probably have even morphed given the time from
> the original change, and this will seriously disrupt the transport and any
> downstream releases.  So I have a very strong NACK on this change.
> 
> Yes - things such as the connect failure results are difficult to return
> back to nvme-cli. I have had many gripes about the nvme-cli's behavior over
> the years, especially on negative cases due to race conditions which
> required retries. It still fails this miserably.  The async reconnect path
> solved many of these issues for fc.
> 
> For the auth failure, how do we deal with things if auth fails over time as
> reconnects fail due to a credential changes ?  I would think commonality of
> this behavior drives part of the choice.

Alright, what do you think about the idea to introduce a new '--sync' option to
nvme-cli which forwards this info to the kernel that we want to wait for the
initial connect to succeed or fail? Obviously, this needs to handle signals too.

From what I understood this is also what Ewan would like to have.

Hannes thought it would make sense to use the same initial connect logic in
tcp/rdma, because there could also be transient erros (e.g. spanning tree
protocol). In short making the tcp/rdma do the same thing as fc?

So let's drop the final patch from this series for the time. Could you give some
feedback on the rest of the patches?

Thanks,
Daniel

