Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9983606A330
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 10:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=hRjyhrny;
	dkim=pass (2048-bit key) header.d=arkamax.eu header.i=@arkamax.eu header.a=rsa-sha256 header.s=mail1 header.b=DL4KBPCU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To
	:From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=zlkamX5Jctv2QPEDuxaMTq34VUUNBdtzDbfXWAEi37o=; b=hRjyhrny8WgArH
	SCB3+t3SlF3rAzX0VtTsaZ3hChp8PSdc/Mfs4KsgJwWmGhlPVD61wCJjzLvRM2WS00qOAFuLEOQK7
	NFJvPN5Wh43bOidVDHJXQjvJfbFf+bB7klq8R10UWKQ+mbtkEXMfziit8dzW0hVdrPmfimL0O8RqP
	XeoluTfTJt4FQuksZ/q0gLzsGPrSTIQAQbaHVuiwmH1BE1jGr3zxohxQLnnISn//4p7a+VgvLAZ6a
	7OqPA5OltcuQbRAvlFkxNJnGM88a0b3yzjiZXp/fhxuPrtVXjURWPHYnBKqLxIODkC6/9tRQtZr00
	mZYPHnfF3YPlg2iD3+9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUM1L-0000000EccQ-2Lae;
	Fri, 20 Nov 2026 10:39:07 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUM1I-0000000EcbQ-43V9
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 10:39:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=zlkamX5Jctv2QP
	EDuxaMTq34VUUNBdtzDbfXWAEi37o=; h=in-reply-to:references:cc:to:from:
	subject:date; d=arkamax.eu; b=DL4KBPCUkFcb3TR4cUmvv2Iy0VIf5v46WaNTNNPK
	hDP++nfFvvFweTRJnH7gase5TjG4AqFX4zEfuOuwO6JvrKiTd21NvXcsGiqTxLu2MU+QTW
	biFWOXNZJGeJc+HRAOxLFt3FSno0jKpRMV4ou/Jr/C1WP2fugZKad4+Hg8Ouh25smtOy0I
	ZSAguwkKOoHs67naxN1FSfWqwECkQhk/lzdRaYGuTCt14/3jCiVy8ZQIqOuHlsisgvjN6Z
	1ICHvacvzcbUH1rYOv8D8G2QZii0tVI3BYJvuyzaOAiVgLD0MT6PDF7Pl+lGKE9XskR3Nx
	NoBrnG8gBUkdPZgsOIXIEg==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 8a545b90 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Nov 2026 11:38:59 +0100 (CET)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Nov 2026 11:38:58 +0100
Message-Id: <DMZZ2434KSYI.25CV1W4LPLQ6@arkamax.eu>
Subject: Re: [PATCH v2] blk-mq: use a housekeeping CPU for passthrough
 requests on isolated hctxs
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Daniel Wagner" <dwagner@suse.de>, "Keith Busch" <kbusch@kernel.org>,
 "Jens Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>, "Sagi
 Grimberg" <sagi@grimberg.me>
Cc: "Ming Lei" <ming.lei@redhat.com>, "Surabhi Gogte"
 <sgogte@purestorage.com>, "Hannes Reinecke" <hare@kernel.org>, "Nilay
 Shroff" <nilay@linux.ibm.com>, "Frederic Weisbecker" <frederic@kernel.org>,
 "Aaron Tomlin" <atomlin@atomlin.com>, "Maurizio Lombardi"
 <mlombard@redhat.com>, "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20261103-nvme-fabrics-isolcpu-v2-1-95ec70d58254@suse.de>
 <a979c78b-40f9-4777-b76f-fb257120a93c@flourine.local>
In-Reply-To: <a979c78b-40f9-4777-b76f-fb257120a93c@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_023905_657528_D87C51C4 
X-CRM114-Status: UNSURE (   4.87  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.1 (-)
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 12, 2026 at 10:09 AM CET, Daniel Wagner wrote:
>
> Keith, Jens: any chance to get this one picked up?

Hello, gentle ping: any reason why this has not been picked up yet?

Thanks,
Maurizio


