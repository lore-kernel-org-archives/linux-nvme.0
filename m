Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB679606A331
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2026 00:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Mj+BmtkC;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=2Jh3grUT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=6Zc2w12TG5qh6JIQZTNkP3ymtsZ+y7xVTFGfxvDyM9E=; b=Mj+BmtkC9S1RnJ
	WrbFP92cAorIc4sa++yXkE3tKRsqhPzbbprQhWz83wvMf41hF4aOfNT0I2HwMOabBjsUS6UR5TGbm
	LlvFeJMbTypkPoorEEKi4daL4IhXOHz/rNvsI8GqFUM2Ww/oNBL1QtkcdwmkMq0C/hpWpLC7zr+PH
	q78Kq/h/3c/w0QT3XAVFvHNpbdbJvDdDm5KMi7GDIft53+6c1fnkVx+REM8ZuJ1t8HT3tRqtLwgUS
	STLFs+Sbjh42OfXnHAj9LTWUu2sltY63Z0vXjQ0lP0wRbXXhpsvyc4Q4dc2rmJSQpTK55pDGaTpte
	w2oKGPLjftn1v+jeIWUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTpfq-0000000AYIs-0AnB;
	Thu, 19 Nov 2026 00:06:46 +0000
Received: from 013.lax.mailroute.net ([199.89.1.16])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTpfn-0000000AYIX-2A3l
	for linux-nvme@lists.infradead.org;
	Thu, 19 Nov 2026 00:06:45 +0000
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jVJfn1zhlzlfcV8;
	Thu, 19 Nov 2026 00:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1795046798; x=1797638799; bh=6Zc2w12TG5qh6JIQZTNkP3ym
	tsZ+y7xVTFGfxvDyM9E=; b=2Jh3grUTnU1k35QJc9+DKllpfeQH4xrchl+bzaJN
	W0Av/21o+BaXamHmtb9Of2USsKIyfxJJbDCmuxAfQ7pVezPNYa0ibArRFZUdyINc
	en+QB57YPpcuS3mPPf1kAnfs3sPNbpvXCyR3vxm4kTx0KFEC4YgVURWF3KPmXQBQ
	9+zPGSEwJkn6Ix4whgNT0XqBwSAcClSAEnxBOJOcD4YPgefJdC4Ftg5SEfiGoXsC
	aoCXQvRuSPtjw8quwAdbAOLWuyJNerhMWBEbty0jQOAtF6v6FG0Ge1Gy/GozJ5UH
	EQM7YLjGSlC8fbGUGoAQsVaIUP/h7CaCzlse4S15IfTHYw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id h3aZdEVPQ8xs; Thu, 19 Nov 2026 00:06:38 +0000 (UTC)
Received: from [192.168.51.14] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jVJfj6SQNzlfcm2;
	Thu, 19 Nov 2026 00:06:37 +0000 (UTC)
Message-ID: <23016086-7d09-4a42-94d4-3270caee36e8@acm.org>
Date: Wed, 18 Nov 2026 16:06:36 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/22] nvmet: add context annotation for nvmet_ns::bdev
To: Nilay Shroff <nilay@linux.ibm.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org
References: <20261118073505.288910-1-nilay@linux.ibm.com>
 <20261118073505.288910-2-nilay@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261118073505.288910-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_160643_610412_C5B7541A 
X-CRM114-Status: GOOD (  10.22  )
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
> Some accesses to nvmet_ns::bdev in the I/O hotpath do not require
> holding nvmet_subsys::lock, as the namespace reference guarantees that
> the namespace remains valid and the field is not modified while I/O is
> in flight. However, the clang context analyzer cannot express this
> access pattern directly. So introduce nvmet_ns_bdev() as an inline
> helper annotated with __context_unsafe() to allow these accesses
> without requiring the subsystem lock. Convert the relevant accesses in
> the I/O hotpath and other request-processing paths to use this helper.

This is not what __context_unsafe() is intended for. Has it been
considered to introduce a token context lock and to annotate the
functions called with either the namespace reference held or with the
nvmet_subsys::lock held?

> Also pass subsys as an explicit argument to nvmet_p2pmem_ns_add_p2p()
> and nvmet_setup_p2p_ns_map(). This allows their __must_hold()
> annotations and lockdep assertions to reference subsys->lock directly,
> rather than accessing the same lock through ctrl->subsys->lock.

How many changes does this patch include? Should this patch perhaps be
split?

Thanks,

Bart.

