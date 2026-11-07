Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2289606A32D
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Nov 2026 01:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qu68u+QL;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=onuRhsc2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=liq9i1NHSAISsV3yGKXncG3NwcdaWrLis28fjxbXbCA=; b=qu68u+QLJogPxe
	5cWRAtL3/IOTlyG4QwHrmpiuSJ8SdTv+V9BBq5aPR8ghFVG4rbNX/Y6PxOMsoQdi6iXDdvBOAWUcT
	Hx/3SrU79BsWhZBkAlpKxg0AxYAOlZ74S8pC21GCa65zYgHeRCzk2CtNIO2XO0VVMSjtIOG1JwFO+
	e84gfpzw1yp8Q5lW2KWqr+TAQag7kGe8cBzrvJNpzAth2rzSDl70hFYLk7buiGoLbXFn+7X4bcrUR
	jiYXrxVHJxkyy3GfU2Uh4csCMyOhoVfXVUw3D9VzIfwm3ewfM0VGlB0WGeKAEOCol1sOQ3QgaNYm/
	tGh/BM1LKKcNNG9tgylw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPVSc-0000000E2Up-0lNM;
	Sat, 07 Nov 2026 01:43:14 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPVSZ-0000000E2UO-2xRJ
	for linux-nvme@lists.infradead.org;
	Sat, 07 Nov 2026 01:43:13 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-3b0960fdde9so612864a91.0
        for <linux-nvme@lists.infradead.org>; Fri, 06 Nov 2026 17:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794015788; x=1794620588; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=liq9i1NHSAISsV3yGKXncG3NwcdaWrLis28fjxbXbCA=;
        b=onuRhsc2MR5SiG/BWn/WyNWkLwPA0rX759zpdN67FKGKkF9BrhicS8YBgwJzKHAHv5
         XTNqdJnDVXZG1R298a3P4nc5GqF8ed/N9HY92suZtQTbWNTaWh2HFwAkIzbgdxjom45i
         oT/BCA3hZG59kqOUEmHfNHoaMuTDJjqXDVMie28NF9TtsCzbTpAYjyMkbGhDOeVWB6s4
         ZErrFhw1lDzl7KX7obCdVQ0QuFQ2O+y75Xcvr3f57DlFqi3HLSU2lweJcF2yNpFmhMxf
         Ab474iyd1iJCmi2zf3ch4Vf+Ta4V4fVOJ33p0gYuog7pxkD/1qhzPvGUNE1wLIxr/d2t
         VMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794015788; x=1794620588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=liq9i1NHSAISsV3yGKXncG3NwcdaWrLis28fjxbXbCA=;
        b=vFtYb3zimZst/l6CvRz5lvBMLGgs2Vd9dV94HhYvTRCwcV+6RfOJa+3dtVBqGkg5+H
         LWGBiSeznYBqMSh6UVEBHhfM3pM25/musc9SbG7vSk2a+AD66avMslmNpyI5b9b1CGRy
         PrfkkvnnzasqMFWFv7OrGzg/G20T5hXPbx7ZcydWtSLkFuE/n1gF+NNwWsEc3Gal8/xD
         GC7rXQ42OMIjWO+GOlrJoPZnRP9jdn4WlYCkJ+PD7MzPJJgg7nZEHzHUJtuw5omsGCIM
         vMv4u2ThcZLqskSEpw6n29CLn+cYRf0kECj5TXeqswtLzd3tLDX/ciAT+lDbWCCIid4Z
         gMOg==
X-Gm-Message-State: APuU4Z9CVvliji4Be6QtC1Q+TV6KrMjmVtGNsbSYGlAvRVtMe7PkoMq6
	YA5sqhO3ir+OmNUHN22vu1SBV4GYQVtWQomHLM7dENJQFCSOfFmRLbgI
X-Gm-Gg: AYBFou3d0ZnGxtCfZm8W+i/6IRGCq0k05vZNSxo/YM+noaJbxvXmGA8qwZIYQglbNoE
	XzofrOoKfNj6s3edwzfwWsNHFRZQKVlMKMD3u1Y2+wICm238fKJIbnyrALpExZ+pR+PBSO3q/2v
	LR+F40R5yIYCnTqu39I1NP6TCalk03cmn+UDUcruSzwiyGCOroL0HNkkMXR8aoqM1DlRdoFcwU7
	Yeh8AlQbuQ/bKsy1kytgT5b4lsyHhQaV1MmM4ASHOqyveolvw350PknIsnP8HxhNzWZrCWIFF11
	PZ+vVNYrRcTrnaU4UVs4r1CKWmmfBrkW93xTqeqvvMhZs1SpmujBedGGZTksmUthFD+VomVBQXF
	JUoLhuNenLYKXEkzAVHG8Q/1TGAMBaEnrU8GZxXLjLdFQcxv1+sGlZY4iT5R/GErFvUeoCHq3AY
	oszUYsKkZ3+Rw8xRujVUmMlNLBRDNmddTXOxWvGy2n7ESCiQEKCqoPTGsSJb3TK++dQPX9P6tCx
	ein4zpBm89YU5EGPPnERUGpDcP6gqanMJxQxEcQJuJHlNxJU9YZ9UvT/KfqukvwU/Vk5GN1ZyoW
	C1eZfuupAI0wNHQUUj9Ssdz3ecNnKO5kct7mIAVPU/QUlhEDeKGlg9yqu8oUSXZCigzOYCFzw4/
	FP2iZWaOtid0c
X-Received: by 2002:a17:90b:48cf:b0:3ab:f38:2b3c with SMTP id 98e67ed59e1d1-3b0db6f8c35mr3611174a91.28.1794015788435;
        Fri, 06 Nov 2026 17:43:08 -0800 (PST)
Received: from ChanningdeMacBook-Pro ([240b:253:9800:600:5d6b:2954:53b8:c089])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b105817ce1sm1130620a91.9.2026.11.06.17.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 17:43:07 -0800 (PST)
From: Chengyuan He <channing1ne@gmail.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: add NO_NS_DESC_LIST quirk for SSSTC CL1 SSDs
Date: Sat,  7 Nov 2026 10:43:05 +0900
Message-ID: <20261107014305.16442-1-channing1ne@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <au4BIz7NMY0eMWky@kbusch-mbp>
References: <au4BIz7NMY0eMWky@kbusch-mbp>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_174311_875404_697A9196 
X-CRM114-Status: GOOD (  10.84  )
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 09:32:35AM -0700, Keith Busch wrote:
> On Thu, Nov 05, 2026 at 10:45:26PM +0900, Chengyuan He wrote:
> > Signed-off-by: Chengyuan He <channing1ne@gmail.com>
>
> Your sign off email doesn't match the patch's author. Which one should
> be used?

Sorry about that, please use channing1ne@gmail.com. Both addresses
belong to the same Gmail account, which was renamed recently, and
Gmail's SMTP server rewrote the From: header to the old address.

If it's easier for you, I can resend the patch with an in-body From:
line instead.

Thanks,
Chengyuan

