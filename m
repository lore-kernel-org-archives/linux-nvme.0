Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0323BCD8CB9
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 16:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E7qwsXUcQPu7hw7Z8iRm24KXzEKGp8hR4nmn0gcSu7g=; b=XsY1PFjIoGx3XpROifei4I8ZJ8
	K/B+Ximnpv7XnhMuvAkRQBS3rC15/s/qPqepHvQOmzE9iTJj1MlbqsAYqF1bhPVT5hEd/ibC6cm3e
	BEIDfhfhKGZZa9A86RIOGnB1HuLP75crE42hVB5Wlw3oqRieVwBLBXun20O1M3mVsLcwHIkHxNJNU
	5f1BId6lMfg9S2bRD7pwBMFN3mVqBcGb/zTrSa2vcu1vWR8OSq6YCaxyGNYHqdi5VpUpjnNJSCrNC
	JJAv/WuifwO+K/7Ne1usReMQNCtKSSqK82hHkV5Wqru3dihXwAWhND/R46vNMdR/BvzZf2FvF/kho
	NQQjjkdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXLpP-0000000876Y-2Ymg;
	Wed, 10 Jun 2026 16:30:55 +0000
Received: from 013.lax.mailroute.net ([199.89.1.16])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXLpN-0000000876F-4AXl
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 16:30:55 +0000
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gbB994gVqzlh2gF;
	Wed, 10 Jun 2026 16:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1781109049; x=1783701050; bh=E7qwsXUcQPu7hw7Z8iRm24KX
	zEKGp8hR4nmn0gcSu7g=; b=NFT2fZ9MxlaUOk1IaGSvtwM/FrMmUmM8+aD60fUM
	T1+dD/MKy220665obmDNlR2EM2/ymwVq7MPl83ViuyQdPULsYPuzKAAUsTfpL8KR
	OGQHUdFQXdxVeBjsa7tawRFouaGTH7PbcebZQj8rvu9bGTNlEKxRfrWzo8qG+rEr
	TZ/+yoCtmfsio21AVJ/gI+68pq3ilwVAAoDkRezQ7ugXJi/B7Mflkr038xRHNuAW
	F/8CoRf6TAaE/8XjNvSAayD5/F9PMU0CcOln3WDYLUZALey8X6btfJdS4Tf6gZCe
	kxMZP2YD/Teo/i9j8NG1Lm6kprnTUbBdF2BxeydeFopiEQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id pJH2jIy-c6AM; Wed, 10 Jun 2026 16:30:49 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gbB932jlDzlgyGc;
	Wed, 10 Jun 2026 16:30:47 +0000 (UTC)
Message-ID: <cf0ba660-a96d-4a79-9581-9339551db88e@acm.org>
Date: Wed, 10 Jun 2026 09:30:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/15] nvme: add Clang context annotations for
 nvme_subsystems_lock
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
 elver@google.com, gjoyce@linux.ibm.com
References: <20260610142743.115898-1-nilay@linux.ibm.com>
 <20260610142743.115898-10-nilay@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260610142743.115898-10-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_093054_053023_DEA2D456 
X-CRM114-Status: UNSURE (   7.88  )
X-CRM114-Notice: Please train this message.
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

On 6/10/26 7:27 AM, Nilay Shroff wrote:
> -	INIT_LIST_HEAD(&subsys->ctrls);
> +	/*
> +	 * Initializing subsys->ctrls list doesn't need to be protected
> +	 * using @nvme_subsystems_lock. So suppress the Clang's warning
> +	 * declaring context_unsafe.
> +	 */
> +	context_unsafe(INIT_LIST_HEAD(&subsys->ctrls));

Why context_unsafe() instead of scoped_guard(mutex_init, ...)?

Thanks,

Bart.

