Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DAE606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 21:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=c2Z9gZHV;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=Tvj5PS1O
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=DodFm50n9M2WAOSjPizOY8OuDySUPHXfRyzyu4/+scs=; b=c2Z9gZHVm7+RHk
	wVMZBjDAD1YK6wNGpL1PKBKZOfP0CUJDCMS/KZ8RPXgI4XwojuiZjZR+bbn1iF5KcBgmOgZbcX6QA
	5Rr+YC72OpfpIdalD0ChqlYwRCAmG2P976+h7nJ3fbQs5PsDHreOf2qiuW3Tmgqcv0uZV4e0GQ4Y2
	rO0S3HjvVU9GnOiW1/mlbgEOVnvAVtHbQqVL/iJ0idX65lVpEfNBJnDyGKeW+3zz+KaaT4FlH7Kaa
	a+Os7/AXgc0Qp4G5PbH8HOlHlKFF5fskMGi1hp7XJk56l9mXaV4AstlEK6POITjbsucI4UBfRiBxD
	SZpRhndDmmVBLVx6/UXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQXDT-00000001oQR-2Lpw;
	Mon, 09 Nov 2026 21:47:51 +0000
Received: from 013.lax.mailroute.net ([199.89.1.16])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQXDQ-00000001oPr-2GI6
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 21:47:49 +0000
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jNk0h26Gmzlfl5v;
	Mon,  9 Nov 2026 21:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1794260866; x=1796852867; bh=DodFm50n9M2WAOSjPizOY8Ou
	DySUPHXfRyzyu4/+scs=; b=Tvj5PS1OlNS7VTucoKPB3UHQtDj2el6M1HcabJzm
	3WGBMTGODqrdjeGC1Tj1nI+DfnqAS0wsjwHwrbBikfIipkiqcD+sAENYzR88uQtO
	ax6tMnbwnqmSmQUzRgKkvnCdeD03wX7a1Itpe4Z9FK5oOnPu584Ngl5HKfve6aRQ
	VvTqXdmRUXaG9BGaEHh4yiFYstjQqmvYhyFVt5AtaodnBLQHI5duTY1WSgrlt6xS
	l13MI9Ej01hlQP6ZljX+Q0oF84oUHHxDU3B8dYMo/FST5+KH0uMu06bkN/ptKvvP
	X5WWpeAKYZTZMszJaporDyVU4bUlJftnYx/gTWQD9+wrBA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Lamnow-rea2D; Mon,  9 Nov 2026 21:47:46 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jNk0d48qvzlfvqP;
	Mon,  9 Nov 2026 21:47:45 +0000 (UTC)
Message-ID: <50a22851-ce22-4c31-afdd-9fcd49854dbb@acm.org>
Date: Mon, 9 Nov 2026 13:47:44 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/23] nvmet: fix nvmet_ns::bdev access using
 nvmet_subsys::lock
To: Nilay Shroff <nilay@linux.ibm.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org
References: <20261109033102.982191-25-nilay@linux.ibm.com>
 <20261109033102.982191-27-nilay@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261109033102.982191-27-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_134748_589824_0207F55E 
X-CRM114-Status: UNSURE (   5.94  )
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
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/8/26 7:28 PM, Nilay Shroff wrote:
> +		__assume_ctx_lock(&ns->subsys->lock);

Please pass "subsys" as an additional argument to 
nvmet_get_smart_log_all() instead of using __assume_ctx_lock().

Thanks,

Bart.

