Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09165606A323
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2026 17:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qLun87M4;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=1qOn6ozk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=TjLLKWezlphdx05aiYPQNldupdxEDr9A4yfwJ5GASzk=; b=qLun87M4QH5t35
	XXSuXRXQxP9itl5/lH/Qp2yNfQmV2nESfos96eUKtvP6KAGVPE3c+txVxuXhzwOrnNTZBEiPlUk2f
	KbJ4YzHr90uUoEJNEeHw6CPSsM8dzxk1rBPEga7dVJoOUXFN7NpgfSwl8cLa4M0sO0YAnhH1nuTg7
	lJ4zbIC1gtb71HMJL7gIRojmqp67mfTui1n8pZxIEIHQCbeQdCDM2sB+yA+F9FTazWDjyHu67i/sj
	Dkt8nKLBIlwT9iJJqkRLYBlT5Gzd8aYKNjjofGClrlO4P9oQupVu2ar6oHVy7xYNiXsjtN8xKAhQ2
	d9XjMyeOmdq2enV1DvZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRYiT-0000000Am5A-3wnJ;
	Thu, 12 Nov 2026 17:36:05 +0000
Received: from 013.lax.mailroute.net ([199.89.1.16])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRYi3-0000000Am2S-3G9v
	for linux-nvme@lists.infradead.org;
	Thu, 12 Nov 2026 17:35:42 +0000
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jQSGL3pVQzll9wV;
	Thu, 12 Nov 2026 17:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1794504935; x=1797096936; bh=TjLLKWezlphdx05aiYPQNldu
	pdxEDr9A4yfwJ5GASzk=; b=1qOn6ozkhjROkvEbQ2blZE+5WpHLo4arDDC2nCoz
	CGS/BCkQD7qHNw9Q2oVcpHnB0UFU4xC1xtmvF7X1oz+Hb993Xi+jCk5ZPozz+FZP
	PvaABWO0LLywMxCENywL6crbUhmDNhbirKXn0lnndHd6a7t2vPBn4nofBJYcYEs0
	fHCV6YxXL0CruKwvQ7oabVkmANd2NC+x357zVC3S8MOoh63sCwn41K2qqIJ34ryA
	JWLju7LsSO86c5xRr3DC+xfu7wae/0akEKKiBYWjPeMUUsOprvo5EsP57L32h5K/
	mnsg4PsKWGk1Yflzm8T2XG5a1xIcJRtmteir44j28CMZPw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 5yaIlXquluby; Thu, 12 Nov 2026 17:35:35 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2ed2:d:eaff:d4c2:ab89:6593] (unknown [104.135.182.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jQSGH2T7WzlfvpN;
	Thu, 12 Nov 2026 17:35:35 +0000 (UTC)
Message-ID: <3ed27af9-52d7-4090-b962-cbc54ff07185@acm.org>
Date: Thu, 12 Nov 2026 09:35:34 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/23] nvmet: add context annotation for nvmet_ns::bdev
To: Nilay Shroff <nilay@linux.ibm.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org
References: <20261109033102.982191-25-nilay@linux.ibm.com>
 <20261109033102.982191-26-nilay@linux.ibm.com>
 <8beba915-07a5-4eae-b8a4-3ec7330c90f7@acm.org>
 <e9f42390-9115-40b2-b0a5-df17c53ce38b@linux.ibm.com>
 <6708de12-ed0d-4101-9328-d08864e677a5@acm.org>
 <e31029f5-c022-4fc9-be94-d1faadfb327e@linux.ibm.com>
 <849733b4-9790-49fd-9585-25b137eeebf4@acm.org>
 <13905077-d09f-424e-b04b-cb1a961323c0@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <13905077-d09f-424e-b04b-cb1a961323c0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_093539_845339_60C5CBC8 
X-CRM114-Status: UNSURE (   9.37  )
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

On 11/12/26 1:04 AM, Nilay Shroff wrote:
> And yes, adding the lockdep assertion resolves the compilation error.
> As I see now (frankly I was not aware about this earlier), lockdep
> internally assumes the required capability, which allows Clang's context
> analyzer to satisfy the corresponding lock annotation.
> 
> So as you suggested, for complex call paths involving multiple locks,
> where the same lock may be accessed through different expressions, I'll
> use the appropriate lockdep_assert_held() assertions instead of explicitly
> adding __assume_ctx_lock() annotations as far as possible.

Thanks!

Something that you may want to know is that I'm proposing to remove 
__assume_ctx_lock() again from lockdep_assert_held() and to introduce
a new macro lockdep_assume_ctx_held(). So far no agreement has been
reached about these changes. See also "[PATCH v2 00/14] Stop
lockdep_assert_held*() from assuming lock ownership"
(https://lore.kernel.org/lkml/cover.1794250850.git.bvanassche@acm.org/).

Bart.

