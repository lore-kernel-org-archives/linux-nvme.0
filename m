Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB421C3DA7A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 17:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OVk1zQ/OEbMRFp/NCWXuyOatJombWw8MRS7/HS8mm9o=; b=1sC5e2E+LOhIE+13XpHdlv8m33
	hlWKEJUbyfHwtMMuROTCSgb21PA9dLshsGskrepPWgzrkwgeMDm+ZuiJ2E6VDK0fjCuijaiKxiavv
	fOn1ch+QQv6GEuMxK2IbhnRUMueuazQSIF+Wyz4d7rIgggXTYQTqpd6fdQX2gnESQ+Giqsyv8I59R
	CoddiD9t+CYfMw9tFSmTlZaxNmJ2ytEBqqubA3F/ZYu2n62tcvOtbJLDlXa7VJP799xb+5m/cxPez
	kEhzVBWm4O7qB7DjvvMobhyCjnLOLyvTan2BfXZypHhIIqFr4GsaVruXO9WXJZMjoRnp4VEH2nzwg
	75pFOvpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH2Q4-0000000G3l0-1NnU;
	Wed, 14 Oct 2026 17:05:36 +0000
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xH2Q1-0000000G3jh-3hv0
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 17:05:35 +0000
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-48c5358fc28so604922f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 14 Oct 2026 10:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791997532; x=1792602332; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OVk1zQ/OEbMRFp/NCWXuyOatJombWw8MRS7/HS8mm9o=;
        b=aQqZ98Q/wX0yV056LPmIRUl4Vb8npU4COJzRVixcrAVj65keX5i/v3PwCnHimUf/NE
         XTn52sWBOyRfjJMfSw2L86VEkoe1jqh7wDBL+tUYn5OvsELrNS+YERScGlPJr2gfeAht
         1/lNeTDD0Y+T1sWVhCy/RgmU7JXpAZkyDTdQt7EfmiKMi9921wH+26DjBrVQCDLGN6JL
         +AFCbY5QaRgI2cy3VKwF4z8VP24Zv4V9muOXAvQ0gZhUb0LrKuDEaQaYW+AGS1CL85rG
         TvOXzVtM3LfLgaEwN+PvhqesOHksk2wTZ5xYm9voW1Hn1LeY1oK4YrC8FR/Kh8qofPtZ
         8OfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791997532; x=1792602332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OVk1zQ/OEbMRFp/NCWXuyOatJombWw8MRS7/HS8mm9o=;
        b=KzVz55wMCCmYwHD3xpN3EG0gop6ux20FGWAgrH60V+zuwFDMwGnqXTvW+H7hpUXMkw
         P8M0vXFRkOA2hawc6KVCC9qW1piEHoJsFhSLMGILImmHM1L9r9UYP0KdhhUTNTmXbbCC
         wxDTRllxsPFjohvCPGdoEuYd9woiLnFoxadgOio+FZ4xlwBPd5SyOXuUYfjuAQ3M8Oaj
         BpOQbXFQv4gY8yMJZPCOFN/rA/vn4LAG1lZZ2oMfTtUDs/YKAySolRlSjYWtab9cayru
         xOuM5S9yiEpI3Usqm6Pxju2ngb6n9E6tgK2MdqsTSg87vNGBYHFEhScYyguvAMXCQ325
         B4nw==
X-Forwarded-Encrypted: i=1; AKwUvBwFAGlt+qtk6h3ZWjrx2I1LcHFO/2zu7ztW8yQVOhg7rujrPbliDvdlV9kKQji6a3U4JWMwOVotOscK@lists.infradead.org
X-Gm-Message-State: AFq9FYJRtg6J/R727N6B3VtEtfIektOR5QxQ1yLgUjWsbldlicP87RUk
	mbU51P4YmqbBmnc6ZAil5tLNW6TNXPlQq+z2QlootpWuYMGKhpVhfokX
X-Gm-Gg: AYBFou1G02Oy/i9LvTpQ2j9Rv8GCfgno4A0idq1UwEk2HAxLi8MIf+Rp/sxg+F8kZ4I
	+ADMRLqVviS9ITuSY9h1GtP95tK+0rJJ2WveEdOxbfVJ+z5bKVm7Akb+y5pPH846mnAGptC6gbf
	TW6tg0FJczkNMZswf8A6pztJPJ3O+QrVy1xGWOscIdlQv6QCoeHYkILIP4QNyooY/vF26zGOrD+
	6XGGYRPz63GZbPfRwI4QvLWDawo2ITcRstwPpIOXVJv3he5v8ObXl3rvu8CHklsoEbFoZ1JRXny
	gUv0F1+JJm/nX0bnbRLfooTy7r5zhD8zNV5jsYcLVOlrIoLJVXEIFBQVgV4EOfhEbVXbGEPEAyo
	Z+zBAs0xrsFQuRqoRiYaEvwd4yLGjmjxq1vd6lnxEfssTaQMCtpIfs4brxfb11606xlv0mRCInO
	dEKJUFwGQwPcNiQwTWzjSkwgxbkUBExKeeOBB/yGZFemxx4Kci9/8XFlXHynem9WPPzNCHzlbor
	EIS3VpkNhnWtsRas5Y3wEBWtoTiUgmnNfGLgkQ0JTD+opM=
X-Received: by 2002:a05:600c:19c8:b0:4a1:777b:8a12 with SMTP id 5b1f17b1804b1-4a18e4adcdbmr328508655e9.14.1791997531763;
        Wed, 14 Oct 2026 10:05:31 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.109.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd98637asm4863305e9.8.2026.10.14.10.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:05:31 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/5] nvmet: zns: don't leak stale memory in zone management receive
Date: Wed, 14 Oct 2026 19:05:23 +0200
Message-ID: <20261014170524.3151-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014130431.GA15622@lst.de>
References: <20261012141239.156408-1-parri.andrea@gmail.com> <20261012141239.156408-3-parri.andrea@gmail.com> <20261013142554.GC14759@lst.de> <20261014110001.95212-1-parri.andrea@gmail.com> <20261014130431.GA15622@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_100533_930349_C5D5BB32 
X-CRM114-Status: UNSURE (   9.32  )
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

On Wed, Oct 14, 2026 at 03:04:31PM +0200, Christoph Hellwig wrote:
> Just to make it clear, that's not to say we don't want these fixed,
> but they are considered robustness fixes and not security issues.

Thanks for clarifying.  The tests are now posted:

  https://lore.kernel.org/r/20261014170046.2516-1-parri.andrea@gmail.com

Andrea

