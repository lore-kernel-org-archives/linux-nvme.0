Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC504606A325
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 21:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qis9W5rZ;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=uw77WROk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=8lkpM+4IuVoIUlZESDw/+ZELoN1w1YsCuhLXteDcifc=; b=qis9W5rZ7YEXZa
	CBmGaTK01jFIZhWfhBVHNlfelK0FElbUcP0ePFEcEqvtQtcopFrjufdtW8SfDkS296odOD728YDOO
	UZzruzRq4LjU9Cr+JdJLlAkMfvoc2HqpPryOhAmXC3tXVFAtzSSrdciGs0pd9jIwg7G6ptmeYDe3o
	3BIojz2YWYLvlLEPG3HsQRs0HTdwr3yN3+s26QeV/3q1JR3tVXLD+5m4Auja3seTg3nmfN1GA9F1c
	Og8NKTB37kKDIDtBVwXWhRYz6cmL/M0XAxZw3rYuDeHM5jkhrDahml1jN9oHYiG82sUYiCaf3ZsxO
	QVdTeOGuQs+Bl+XbJv1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQXM8-00000001p98-3YXK;
	Mon, 09 Nov 2026 21:56:48 +0000
Received: from 013.lax.mailroute.net ([199.89.1.16])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQXM5-00000001p8I-3vAd
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 21:56:48 +0000
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jNkC149xRzlfvqJ;
	Mon,  9 Nov 2026 21:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1794261402; x=1796853403; bh=8lkpM+4IuVoIUlZESDw/+ZEL
	oN1w1YsCuhLXteDcifc=; b=uw77WROkmdn1Zwl6K/RQvHzoUHyifXUyAaQBhuYS
	YPK4V+OwuzxlYTY6+IP7REIctER76hm4t2YOxnTWPpBsUQhMCa4p5GRrxsgaJ3Fe
	9dcBp/rFmqA1kO+XlFlfp897ny/z/HSmWkEa5nSQ6X+MTy6q/QEsGTcBAZtKVuB/
	4XhZmIwvku4bBjjhrITu4JREDo5cUj0CRtV1Hcp1HhLLwQo9J+Jwy+116cgRR2V0
	VhACIHEeJXFYvbVunOXAbxX830odSEmOucIB/BNQaCaVTzkNswJO647cNNKkrqUv
	edGIRZyUBc+1VDY7iNk/TZeMPy/bympdIdOmxs8D2V6jMw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id MmWf3RZiCdxH; Mon,  9 Nov 2026 21:56:42 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jNkBy23fSzlfvqR;
	Mon,  9 Nov 2026 21:56:42 +0000 (UTC)
Message-ID: <a8268f53-bbe0-4648-93ca-fa71081137bc@acm.org>
Date: Mon, 9 Nov 2026 13:56:41 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/23] nvmet: add context annotation for nvmet_ns::nsid
To: Nilay Shroff <nilay@linux.ibm.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org
References: <20261109033102.982191-25-nilay@linux.ibm.com>
 <20261109033102.982191-31-nilay@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261109033102.982191-31-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_135645_988351_49449BF6 
X-CRM114-Status: UNSURE (   9.28  )
X-CRM114-Notice: Please train this message.
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/8/26 7:28 PM, Nilay Shroff wrote:
 > [ ... ]

1. Bisectability:
    This patch causes Clang analyzer errors in nvmet_format_ana_group(),
    nvmet_execute_identify_endgrp_list(), and 
nvmet_execute_identify_nslist(),
    which are only resolved in patch 07. Please reorder or squash patch 07.

2. Design:
    ns->nsid is set once during nvmet_ns_alloc() and is immutable throughout
    the lifetime of the namespace. It is never modified under 
subsys->lock or
    any other lock. Marking it __guarded_by(&subsys->lock) and creating
    nvmet_ns_nsid() to bypass the annotation throughout the driver adds
    unnecessary churn. Please drop the annotation on nsid.

 > @@ -746,6 +755,12 @@ struct nvmet_ns *nvmet_ns_alloc(struct 
nvmet_subsys *subsys, u32 nsid)
 >
 >  	init_completion(&ns->disable_done);
 >
 > +	__assume_ctx_lock(&ns->subsys->lock);
 >  	ns->nsid = nsid;
 >  	ns->subsys = subsys;

Here and elsewhere, lockdep_assert_held() should be used instead of
__assume_ctx_lock(). Additionally, the lock state should only be
verified after the ns->subsys assignment.

Thanks,

Bart.

