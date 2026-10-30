Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AC4606A324
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Oct 2026 00:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=oErXGCiL;
	dkim=pass (2048-bit key, unprotected) header.d=crusoe.ai header.i=@crusoe.ai header.a=rsa-sha256 header.s=google header.b=ZmgBrTnC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=KkjXI6XREDZgMovozjWwMnBiOd6uNUe+5PisGTE2NV0=; b=oErXGCiLBB9WRs
	q1OJcAJCFaHJmaRrTzi8BtxkMQho7R+3IO7/flIYdwWJBMCIkmxC547BKsUT667FMuH23P2pmhKVB
	wRdUsAG5XBu5vXvO7fcSiGVIdrJjCWQkbCLvriDxDfqK4ZstpBFnDE6gSYFiyHc96SfLuefxGRDxR
	SORbYb6LxIm5wHQG+N6myJFOou4bqx5IM3fE+GJYgVqoPiXw2DAGbSHw+DfJNoSS3rLe4w5S3JBFi
	89gPLIAjipSWZNpi7NwckrPgcqji+3qxlWqy64FH2l3YmvyS0dFUH6bH1MqeKQax7Ctg1mZeAkbCV
	Rg0rUH6vyUhV/l1nDkxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMaPg-0000000AZeA-1bIl;
	Fri, 30 Oct 2026 00:24:08 +0000
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMaPb-0000000AZdj-2I4z
	for linux-nvme@lists.infradead.org;
	Fri, 30 Oct 2026 00:24:05 +0000
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-36a1947498bso292785eec.1
        for <linux-nvme@lists.infradead.org>; Thu, 29 Oct 2026 17:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1793319842; x=1793924642; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KkjXI6XREDZgMovozjWwMnBiOd6uNUe+5PisGTE2NV0=;
        b=ZmgBrTnCbVjBtlvR/mwn7SEBQD+L3UH+0HSyGJoUL361sC5erxRClSbuMlKo1PTQui
         5BHaMjwnIcuoii5OiKOwTBztyqLNPXiyB0CXi22ya5nR3n3eMfW24FK3B9UnpJh0U8mY
         /aXF31PO6knAt886pamVP5/NId1OpnGkaM+2eKEdZ7P0nRXiGR5ilPXD3V3DUCizhprr
         FjpaR339Z1aYVUQvOFiKkw49MpJCcAN2Sf9seO7XELw3Svg+SmSOzbw85Cra4sM+YMIR
         DQBDr2XJM3yazQZEd03GuPC34GhHY2zGFDQxeb5GgjebVkocD7GlXw6uBpwlnq57Jey0
         VhnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793319842; x=1793924642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KkjXI6XREDZgMovozjWwMnBiOd6uNUe+5PisGTE2NV0=;
        b=CsIeUqMHk0Qgjwwqiaa5agZLbAfTD3sRi9p7f+v4DC+pF+biPLnhBtjW79JiOXoWsk
         QDP6aEXIM1puSd9Z7XvknIVmjrIz6BDg1EeF5AS3uCzT0DuBU4j/flF2I0ecceCAjhId
         DsRrjBtIEmWLX8sRnHqcawpw/+i+xId1b+TOGf5WE/giGC+It3sQW8ArUuwnYnLZHHD2
         YMRj4DdsDqbBwEpQBBf3sPNRqPJRSroT45pavIpmbo3jwA9ZIrSf5PsiYZa5JRGnbOKy
         iZqdkUea91adMCgMil1xEocpIYeO4vBIZMWtPz48eOzTEzyvJzaiukUMzs+3xQgK57+X
         OWeQ==
X-Gm-Message-State: AFq9FYJ7VuWIXmmLCLXFtsq8PIBzyB5HAo0NT14P/Fw2oiZDQgAj8WFk
	g7Oue6MJSE4xSfg3RjFQ1SejVDPErLLNQrKQr9a+iAaIyvy0FjjNI3RX8mmBBc6KuORxU4FxG0w
	287PyQbY=
X-Gm-Gg: AYBFou3Go6pRvPWTcZA4BUuQTDGGRUG5KqkA4HXNlO7bYVUS8lmlrnGZhR90yic4OEe
	Tr5jqQIET5TKNO2cOZBCFpIZRPwX+pcWfJa1cX+GWGXm1Rnt5syAUeZNq0Eu7NZedouiD9RIA/q
	sWl/XyOlKPKZlgXAJ1gbyHg3WkIhma0iafmWQWIpumRLwIb/0iw1l4/9+zxU2mmbdcKenbqluGt
	itxoryWT39DomuBDlTn10cJ6U4J5YemXv5b8hr+himTzh9t6UiY+ytyejfTzFABtFOQk1fHjNb3
	GRns63nB0Q8aXJL0A4HgwpGC8Kxji7UY0nFVdMyaFxxDfKQH2gvlx+idvfaeXuUFdcMEzQNIJTV
	iED+HMNY8DaW+ZkT0iY0XlaWoVwWMMSeL55z5WHogSFbAh7bji9L2VT/b3lrG3Be045knbwtjjf
	VonWl4UN9A5kUA7Qnj5ffJvYx5REURu60B1zFDxBZ08z4HkindVVTM5+shHHbYxGSPuxf+oSR59
	DICBnHOH2SyavZGdknFE49bV/9pTyW6+Upo8IoHuHuVH36OfBH5LlRAYioLrhJMagshnGX565wC
	50kGVq8SYVjkxhYvkhJclLdhihmb2ZPRkoE/q+AlMD1W+UPuaLD0RfPBjGXhSo0RZMmlvtjSo4J
	itFyI1QvVgRLsjyMZE4s3
X-Received: by 2002:a05:693c:83cf:10b0:36a:1427:3933 with SMTP id 5a478bee46e88-36a4236e7bemr1488656eec.16.1793319841432;
        Thu, 29 Oct 2026 17:24:01 -0700 (PDT)
Received: from MBP-Saravanan-D.civet-hops.ts.net ([67.208.231.220])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a77c0dsm2241458eec.26.2026.10.29.17.23.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 17:24:00 -0700 (PDT)
From: Saravanan D <saravanand@crusoe.ai>
To: linux-nvme@lists.infradead.org
Cc: Saravanan D <saravanand@crusoe.ai>,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk,
	nilay@linux.ibm.com,
	dwagner@suse.de,
	sgogte@purestorage.com,
	hare@kernel.org,
	hare@suse.de,
	linux-kernel@vger.kernel.org,
	iyamahata@crusoe.ai,
	kiyer@crusoe.ai,
	ganbalagane@crusoe.ai,
	sjpark@crusoe.ai,
	bchen@crusoe.ai,
	shinichiro.kawasaki@wdc.com
Subject: Re: [PATCH v6 0/2] nvme-tcp: allow setting per-queue io_cpu through sysfs
Date: Thu, 29 Oct 2026 17:23:40 -0700
Message-ID: <20261030002344.92839-1-saravanand@crusoe.ai>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261023230426.6425-1-saravanand@crusoe.ai>
References: <20261023230426.6425-1-saravanand@crusoe.ai>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_172403_942227_7688AA58 
X-CRM114-Status: UNSURE (   6.55  )
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
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A short status update on v6. The Sashiko review of v6 came back without
findings [1], and Shin'ichiro confirmed that the blktests case nvme/075
passes with the series applied [2]. The blktests patch linked v5 by
mistake, the version under review is this v6 thread.

[1] https://sashiko.dev/#/patchset/20261023230426.6425-1-saravanand%40crusoe.ai
[2] https://lore.kernel.org/linux-nvme/auMw5Gxg6toa8GD2@shinmob/

Thanks,
Saravanan D.

