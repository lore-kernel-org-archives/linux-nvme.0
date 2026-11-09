Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124D2606A325
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 21:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Nzld3Ej4;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=VjiB7V1j
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=fLLhg2WUJvAm21+E4LtzurXKIiEmTP+gbE4+JMoGAEM=; b=Nzld3Ej42a6wZr
	WY1KO3UZWYC40kIMxUsE/nhBy8V0s8bPBONSqWZx8WtB1Hdd4gfLaLqOoGtr4YvNoFcQlbfuPrBqy
	ogydUFdER55gq+u1qzayq2vGnpHueu6dWL619Rl9ENb9sGRa0NabBKMtoMCTjDVAqo4zRRYmVfeFe
	Ow8a1sKnfvYYWBr3j10VHiIO/ktemdKRYPfJz45BvUat4hZYQm/51M9YeCWaEfCLZTzyf/sq1a1lj
	GNsWf9miK+8U/Tj7M+zntbIKXmr5y+i4VwcBYDjdEY3zdYG+QCcktT/ejK96FbOLcKh9K839ofpim
	za9Elok0WrzT6P8RS9ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQXBu-00000001oBr-0b7q;
	Mon, 09 Nov 2026 21:46:14 +0000
Received: from 013.lax.mailroute.net ([199.89.1.16])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQXBr-00000001oAj-3aCA
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 21:46:13 +0000
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jNjyp6TqNzlfvqS;
	Mon,  9 Nov 2026 21:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1794260768; x=1796852769; bh=fLLhg2WUJvAm21+E4LtzurXK
	IiEmTP+gbE4+JMoGAEM=; b=VjiB7V1jvju3ypuxdmxkR6PeUCMIqSUQv2OcKN6H
	N5jXVfgIEz4m92sknMCxOLVA/DHQG3O6zhobII58b+bzKvi36lo6ctxrO2CzyTf2
	++uHJLnNaAZ+vPAy9MMDremSl6TYxUiK53GvPQzYLZav+arJ0SZR2Ol4Ap9JyRf5
	3hQhkQXalOUlZDpmCN2F071OuvxlJwc+5X6m17+uiRnjAs0Omogf28K9meHiYvUL
	E9gpzTUbQiSDZT9zubQYnc/uBs6/OMoXQVumXB5bxLUJzQFSyGg6N9+hAwl6G3IU
	PLi2RkLbIJblfLou7QBQVTwgH7HFooSvn1gcs8EuAtxVLg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Fki4ulnokL2w; Mon,  9 Nov 2026 21:46:08 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jNjyl6Gb4zlfwgB;
	Mon,  9 Nov 2026 21:46:07 +0000 (UTC)
Message-ID: <8beba915-07a5-4eae-b8a4-3ec7330c90f7@acm.org>
Date: Mon, 9 Nov 2026 13:46:07 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/23] nvmet: add context annotation for nvmet_ns::bdev
To: Nilay Shroff <nilay@linux.ibm.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org
References: <20261109033102.982191-25-nilay@linux.ibm.com>
 <20261109033102.982191-26-nilay@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261109033102.982191-26-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_134612_086795_BE17B191 
X-CRM114-Status: GOOD (  10.51  )
X-Spam-Score: -2.8 (--)
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/8/26 7:28 PM, Nilay Shroff wrote:
 > The nvmet_ns::bdev field is protected by nvmet_subsys::lock. Annotate
 > it with __guarded_by(&subsys->lock) so that the clang context analyzer
 > can validate accesses to this field.

This patch introduces a compiler error in nvmet_get_smart_log_all() when
built with CONFIG_WARN_CONTEXT_ANALYSIS=y:

   drivers/nvme/target/admin-cmd.c: error: reading variable 'bdev' requires
   holding mutex 'ns->subsys->lock' [-Werror,-Wthread-safety-precise]

This is only resolved in patch 02. Please make sure this series is
bisectable.

 > +	/*
 > +	 * Both ctrl->subsys->lock and ns->subsys->lock refers to the same 
lock.

"refers to" -> "refer to".

 > +	 * However there's no way for us to annotate such locking semantics
 > +	 * using clang context annotation. So explicitly assert the capability.
 > +	 */
 > +	__assume_ctx_lock(&ns->subsys->lock);

__assume_ctx_lock() wouldn't be necessary if subsys would be passed
as a function argument, isn't it? In general, I strongly prefer to
add a function argument rather than using __assume_ctx_lock().

Thanks,

Bart.

