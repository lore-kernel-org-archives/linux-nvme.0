Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D22606A332
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2026 00:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=xn5M84MI;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=CfWdV9CK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=93LpAO/id56ppRhvVzI61Jg5poHMAi2vvaGMxilw0w4=; b=xn5M84MIuzsWEK
	B7tUNCPOn3kIM/M/J945mdJB2wdGeDcEk8bog3Wl7Tmcy+Y1sAOmIuc/zqRldZgEt7rEFYtjIEbmG
	PqssU7ovNIXeCZittoBi4Bx6BCyHrNVnD1etVK4hab2GWVnr7jtVQAnrIYXznTi65G/RZNBJiMbWx
	0WfoelSTkWG+H1l/wfSJvkc7bi4mfTHmo9mcAoFXJLgAIILAEwEe+VFDvbH52AUxLt2BckIaEXEq7
	0dCZoLB/1MRPROE6rV0EgcdSMQMn5tGoWo1lUSxtnoBSYSwvZfo1LQtUptptHUnb31bZQJ74JaGLr
	AEP516p3M5mM/GDJRc/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTphI-0000000AYX6-1t9o;
	Thu, 19 Nov 2026 00:08:16 +0000
Received: from 011.lax.mailroute.net ([199.89.1.14])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTphF-0000000AYWP-2HeY
	for linux-nvme@lists.infradead.org;
	Thu, 19 Nov 2026 00:08:14 +0000
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4jVJhY1Zhnz1XMlX4;
	Thu, 19 Nov 2026 00:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1795046890; x=1797638891; bh=93LpAO/id56ppRhvVzI61Jg5
	poHMAi2vvaGMxilw0w4=; b=CfWdV9CK3lxOF69Sx3zS5GTu1RsXPrMgz92WgmzW
	3Un1CpN0kVnzXpCOJPA+01LwPmC6WGX7XkA2FQALflXDmazYAeZWuvrrvUpIUPjv
	2fn3YjHfD34lB1/na24FiFNRrxfKGxxWIMJ1v3EH1chUsq3ho9oUHjROdbiCDKDb
	yOGp4l2YDORMF6FUyHqrZYqvkcTH863/OLdqliqqSh+5qhHOxnop7uqIzAAfeQjU
	H/s7h/ujfK9Ut0tvJRj4Gz8umN3doHkwGe7AwO2HHbxOSidI1VfuE2oVY37hSWnh
	5hUKQ/0FPtzMeZb018fuqwqh731hbmEPvJifXIKoImCWtw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tztGdGRoYbjX; Thu, 19 Nov 2026 00:08:10 +0000 (UTC)
Received: from [192.168.51.14] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4jVJhT65F8z1XLVPd;
	Thu, 19 Nov 2026 00:08:09 +0000 (UTC)
Message-ID: <da37a4fa-656f-440a-9ca7-50266619813e@acm.org>
Date: Wed, 18 Nov 2026 16:08:09 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/22] nvmet: fix nvmet_ns::bdev access using
 nvmet_subsys::lock
To: Nilay Shroff <nilay@linux.ibm.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org
References: <20261118073505.288910-1-nilay@linux.ibm.com>
 <20261118073505.288910-3-nilay@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261118073505.288910-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_160813_597173_23EEE1F6 
X-CRM114-Status: UNSURE (   8.83  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
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

On 11/17/26 11:34 PM, Nilay Shroff wrote:
> +		/*
> +		 * Both ctrl->subsys->lock and ns->subsys->lock refer to the
> +		 * same lock. However there's no way for us to annotate such
> +		 * locking semantics using clang context annotation. So
> +		 * explicitly assert the capability.
> +		 */
> +		__assume_ctx_lock(&ns->subsys->lock);

__assume_ctx_lock() should be avoided whenever possible. Please either
modify this function such that "subsys" is passed as an argument or use
lockdep_assert_held().

Thanks,

Bart.

