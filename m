Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6164C606A32A
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 21:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Khd1gMyf;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=mp5Dod40
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=aEcJWzEy2nY2iv2BE/XMno+E1EBzjpFErSa9Be5PWHM=; b=Khd1gMyfTZCGOa
	r78uuIYGGL+PF9rOZ0WxRhHMXp2qyheXMrznlcex6EwluOE4CMPCPDul4qwwJ2Sd7Lx1X8zd3zRF1
	wAaXlP4LTdoVvIkISOe3Uq2KjKbqQoJOXAiCowOBTvS7WrAlBHv7KKFinW3GxnRf++crJniU7NHbB
	WVNVw3+dlzZHJzfvHFJ1z6lMn2SSjc2ZeHv60jaXtI4b2miwtJmyJ9xfi9hykg5ptkatO+MpYkm4Q
	t+RLC1qEGAXFUIBES1pyDoXHjgIabFb7FJ8V8qt6ObrycHAlHi+HK86QUvF4daZzG1ZNQM7uKfM2M
	kVZXt64sdgBPs6ZnYw/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQXIo-00000001osL-204V;
	Mon, 09 Nov 2026 21:53:22 +0000
Received: from 013.lax.mailroute.net ([199.89.1.16])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQXIl-00000001ori-0n5G
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 21:53:21 +0000
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jNk724RvmzlfvqS;
	Mon,  9 Nov 2026 21:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1794261195; x=1796853196; bh=aEcJWzEy2nY2iv2BE/XMno+E
	1EBzjpFErSa9Be5PWHM=; b=mp5Dod40+PsWnmGRbETu8F6SlktuWVBXkXPfYnP9
	UD2RVg1HyVJSQFXwjE2ogQht2fcqCbQdvVTUL1kfssvErWOXzF3++d6Dg9MYuGll
	E3FJU77r8vEukWHEZljd6Q2caohuDtzR/WXgCIikyBESHi6AmKctG/VYanOQFne9
	S6esgPsawn/Un7ddhPPFupOQMEeuKroyDIwEmC6H4CVyRrMrHxJDV3sUbFg9niuF
	Vk6VPnDTQgW+Ag0NfxCcVoC8upkx6C92vG2b7OhSu1JW1Dipr7tjjTz87+rVLqiP
	twZb0XblamNR231Z3+AZICM5uJYrbpoeZX+JhlcqIgEISw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id uSLrWjVWh4su; Mon,  9 Nov 2026 21:53:15 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jNk6z1vYbzlfvqJ;
	Mon,  9 Nov 2026 21:53:15 +0000 (UTC)
Message-ID: <3ae6e8db-ee33-40fc-baf4-2ec43a32eac7@acm.org>
Date: Mon, 9 Nov 2026 13:53:14 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/23] nvmet: add context annotation for nvmet_ns::file
To: Nilay Shroff <nilay@linux.ibm.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org
References: <20261109033102.982191-25-nilay@linux.ibm.com>
 <20261109033102.982191-28-nilay@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261109033102.982191-28-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_135320_137614_E7FD59BF 
X-CRM114-Status: GOOD (  12.71  )
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
 > @@ -258,6 +258,19 @@ static void nvmet_file_flush_work(struct 
work_struct *w)
 >  {
 >  	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
 >
 > +	/*
 > +	 * The flush work is scheduled from the I/O hotpath after acquiring
 > +	 * a reference to the namespace. This ensures that the namespace
 > +	 * cannot be modified while the I/O is in flight.
 > +	 *
 > +	 * nvmet_file_flush() requires callers to hold ns->subsys->lock.
 > +	 * Since we already hold a namespace reference, explicitly assert
 > +	 * the lock capability here to satisfy the context analyzer.
 > +	 *
 > +	 * Other callers of nvmet_file_flush() that do not hold a namespace
 > +	 * reference must acquire ns->subsys->lock before invoking it.
 > +	 */
 > +	__assume_ctx_lock(&req->ns->subsys->lock);
 >  	nvmet_req_complete(req, nvmet_file_flush(req));
 >  }

This assertion is incorrect. __assume_ctx_lock() informs the compiler
that a capability is held when it is actually held (e.g. through an alias).
Here, nvmet_file_flush_work() runs in a workqueue without holding
subsys->lock. If lockdep_assert_held() were used here, Lockdep would
trigger a warning.

nvmet_file_flush() should not be annotated with 
__must_hold(&req->ns->subsys->lock).

Thanks,

Bart.

